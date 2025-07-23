package dao;

import model.Message;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDao {
    private final Connection connection;

    public MessageDao(Connection connection) {
        this.connection = connection;
    }

    // Lưu tin nhắn mới
    public boolean insertMessage(Message message) throws SQLException {
        String sql = "INSERT INTO messages (sender_id, receiver_id, content, message_type, file_url, sent_at, is_read) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, message.getSenderId());
            stmt.setInt(2, message.getReceiverId());
            stmt.setString(3, message.getContent());
            stmt.setString(4, message.getMessageType());
            stmt.setString(5, message.getFileUrl());
            stmt.setTimestamp(6, new Timestamp(message.getSentAt().getTime()));
            stmt.setBoolean(7, message.isRead());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    message.setId(rs.getInt(1));
                }
                return true;
            }
        }
        return false;
    }

    // Lấy lịch sử chat giữa 2 users
    public List<Message> getChatHistory(int userId1, int userId2) throws SQLException {
        String sql = "SELECT * FROM messages " +
                    "WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) " +
                    "ORDER BY sent_at ASC";
        List<Message> messages = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId1);
            stmt.setInt(2, userId2);
            stmt.setInt(3, userId2);
            stmt.setInt(4, userId1);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                messages.add(mapResultSetToMessage(rs));
            }
        }
        return messages;
    }

    // Lấy tin nhắn chưa đọc của user
    public List<Message> getUnreadMessages(int userId) throws SQLException {
        String sql = "SELECT * FROM messages WHERE receiver_id = ? AND is_read = 0 ORDER BY sent_at DESC";
        List<Message> messages = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                messages.add(mapResultSetToMessage(rs));
            }
        }
        return messages;
    }

    // Đánh dấu tin nhắn đã đọc
    public boolean markAsRead(int messageId) throws SQLException {
        String sql = "UPDATE messages SET is_read = 1 WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, messageId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Đánh dấu tất cả tin nhắn từ sender đã đọc
    public boolean markAllAsRead(int receiverId, int senderId) throws SQLException {
        String sql = "UPDATE messages SET is_read = 1 WHERE receiver_id = ? AND sender_id = ? AND is_read = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, receiverId);
            stmt.setInt(2, senderId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Lấy tin nhắn cuối cùng giữa 2 users
    public Message getLastMessage(int userId1, int userId2) throws SQLException {
        String sql = "SELECT TOP 1 * FROM messages " +
                    "WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) " +
                    "ORDER BY sent_at DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId1);
            stmt.setInt(2, userId2);
            stmt.setInt(3, userId2);
            stmt.setInt(4, userId1);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToMessage(rs);
            }
        }
        return null;
    }

    // Helper method để map ResultSet về Message object
    private Message mapResultSetToMessage(ResultSet rs) throws SQLException {
        Message message = new Message();
        message.setId(rs.getInt("id"));
        message.setSenderId(rs.getInt("sender_id"));
        message.setReceiverId(rs.getInt("receiver_id"));
        message.setContent(rs.getString("content"));
        message.setMessageType(rs.getString("message_type"));
        message.setFileUrl(rs.getString("file_url"));
        message.setSentAt(rs.getTimestamp("sent_at"));
        message.setRead(rs.getBoolean("is_read"));
        return message;
    }
} 