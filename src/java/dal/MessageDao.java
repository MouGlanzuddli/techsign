package dal;

import model.Message;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class MessageDao {
    private final Connection connection;

    public MessageDao(Connection connection) {
        this.connection = connection;
    }

    // Add a new message to a conversation
    public boolean addMessage(Message message) throws SQLException {
        String sql = "INSERT INTO messages (conversation_id, sender_id, content, sent_at, is_read) VALUES (?, ?, ?, GETDATE(), ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, message.getConversationId());
            stmt.setInt(2, message.getSenderId());
            stmt.setString(3, message.getContent());
            stmt.setBoolean(4, message.isRead()); // Initially, sender's copy is read, recipient's is unread (handled by markAsRead)
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        message.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    // Get all messages for a specific conversation
    public List<Message> getMessagesByConversationId(int conversationId) throws SQLException {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM messages WHERE conversation_id = ? ORDER BY sent_at ASC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, conversationId);
            ResultSet rs = stmt.executeQuery();
            
            UserDao userDao = new UserDao(connection); // To fetch sender details

            while (rs.next()) {
                Message msg = mapResultSetToMessage(rs);
                msg.setSender(userDao.getUserById(msg.getSenderId())); // Set sender user object
                messages.add(msg);
            }
        }
        return messages;
    }

    // Mark messages as read for a specific conversation and recipient
    public boolean markMessagesAsRead(int conversationId, int recipientId) throws SQLException {
        // Mark messages sent by the OTHER participant as read for the current recipient
        String sql = "UPDATE messages SET is_read = 1 WHERE conversation_id = ? AND sender_id != ? AND is_read = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, conversationId);
            stmt.setInt(2, recipientId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Get unread messages count for a specific conversation and recipient
    public int getUnreadMessagesCount(int conversationId, int recipientId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM messages WHERE conversation_id = ? AND sender_id != ? AND is_read = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, conversationId);
            stmt.setInt(2, recipientId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Helper method to map ResultSet to Message object
    private Message mapResultSetToMessage(ResultSet rs) throws SQLException {
        Message msg = new Message();
        msg.setId(rs.getInt("id"));
        msg.setConversationId(rs.getInt("conversation_id"));
        msg.setSenderId(rs.getInt("sender_id"));
        msg.setContent(rs.getString("content"));
        msg.setSentAt(rs.getTimestamp("sent_at"));
        msg.setRead(rs.getBoolean("is_read"));
        return msg;
    }
}
