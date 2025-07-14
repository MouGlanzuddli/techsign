package dal;

import model.Conversation;
import model.Message;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class ConversationDao {
    private final Connection connection;

    public ConversationDao(Connection connection) {
        this.connection = connection;
    }

    // Create a new conversation or get an existing one
    public Conversation getOrCreateConversation(int userId1, int userId2) throws SQLException {
        // Ensure participant1_id is always the smaller ID
        int p1Id = Math.min(userId1, userId2);
        int p2Id = Math.max(userId1, userId2);

        String selectSql = "SELECT * FROM conversations WHERE participant1_id = ? AND participant2_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(selectSql)) {
            stmt.setInt(1, p1Id);
            stmt.setInt(2, p2Id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToConversation(rs);
            }
        }

        // If not found, create a new conversation
        String insertSql = "INSERT INTO conversations (participant1_id, participant2_id, created_at, updated_at) VALUES (?, ?, GETDATE(), GETDATE())";
        try (PreparedStatement stmt = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, p1Id);
            stmt.setInt(2, p2Id);
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        Conversation newConv = new Conversation();
                        newConv.setId(generatedKeys.getInt(1));
                        newConv.setParticipant1Id(p1Id);
                        newConv.setParticipant2Id(p2Id);
                        newConv.setCreatedAt(new Date());
                        newConv.setUpdatedAt(new Date());
                        return newConv;
                    }
                }
            }
        }
        return null; // Should not happen if insert is successful
    }

    // Get a conversation by its ID
    public Conversation getConversationById(int conversationId) throws SQLException {
        String sql = "SELECT * FROM conversations WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, conversationId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToConversation(rs);
            }
        }
        return null;
    }

    // Get all conversations for a specific user
    public List<Conversation> getConversationsByUserId(int userId) throws SQLException {
        List<Conversation> conversations = new ArrayList<>();
        String sql = "SELECT c.*, " +
                     "CASE WHEN c.participant1_id = ? THEN p2.full_name ELSE p1.full_name END AS other_participant_name, " +
                     "CASE WHEN c.participant1_id = ? THEN p2.id ELSE p1.id END AS other_participant_id, " +
                     "m.content AS last_message_content, m.sent_at AS last_message_sent_at, m.sender_id AS last_message_sender_id " +
                     "FROM conversations c " +
                     "JOIN users p1 ON c.participant1_id = p1.id " +
                     "JOIN users p2 ON c.participant2_id = p2.id " +
                     "LEFT JOIN messages m ON c.last_message_id = m.id " +
                     "WHERE c.participant1_id = ? OR c.participant2_id = ? " +
                     "ORDER BY c.updated_at DESC";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            stmt.setInt(3, userId);
            stmt.setInt(4, userId);
            ResultSet rs = stmt.executeQuery();
            
            UserDao userDao = new UserDao(connection); // To fetch full user objects
            MessageDao messageDao = new MessageDao(connection); // To fetch full message objects

            while (rs.next()) {
                Conversation conv = mapResultSetToConversation(rs);
                
                // Populate transient fields
                int otherParticipantId = rs.getInt("other_participant_id");
                User otherParticipant = userDao.getUserById(otherParticipantId);
                
                if (conv.getParticipant1Id() == userId) {
                    conv.setParticipant1(userDao.getUserById(userId));
                    conv.setParticipant2(otherParticipant);
                } else {
                    conv.setParticipant1(otherParticipant);
                    conv.setParticipant2(userDao.getUserById(userId));
                }

                // Set last message details if available
                if (rs.getObject("last_message_id") != null) {
                    Message lastMsg = new Message();
                    lastMsg.setId(rs.getInt("last_message_id"));
                    lastMsg.setContent(rs.getString("last_message_content"));
                    lastMsg.setSentAt(rs.getTimestamp("last_message_sent_at"));
                    lastMsg.setSenderId(rs.getInt("last_message_sender_id"));
                    lastMsg.setSender(userDao.getUserById(lastMsg.getSenderId())); // Set sender user object
                    conv.setLastMessage(lastMsg);
                }
                
                // Calculate unread count for the current user
                conv.setUnreadCount(messageDao.getUnreadMessagesCount(conv.getId(), userId));
                
                conversations.add(conv);
            }
        }
        return conversations;
    }

    // Update the last message ID and updated_at timestamp for a conversation
    public boolean updateLastMessage(int conversationId, int messageId) throws SQLException {
        String sql = "UPDATE conversations SET last_message_id = ?, updated_at = GETDATE() WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, messageId);
            stmt.setInt(2, conversationId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Helper method to map ResultSet to Conversation object
    private Conversation mapResultSetToConversation(ResultSet rs) throws SQLException {
        Conversation conv = new Conversation();
        conv.setId(rs.getInt("id"));
        conv.setParticipant1Id(rs.getInt("participant1_id"));
        conv.setParticipant2Id(rs.getInt("participant2_id"));
        conv.setLastMessageId(rs.getInt("last_message_id"));
        conv.setCreatedAt(rs.getTimestamp("created_at"));
        conv.setUpdatedAt(rs.getTimestamp("updated_at"));
        return conv;
    }
}
