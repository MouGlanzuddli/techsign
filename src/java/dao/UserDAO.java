package dao;

import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {
    private final Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // Đăng ký tài khoản mới
    public boolean register(User user) throws SQLException {
        String sql = "INSERT INTO users (role_id, username, password_hash, email, phone, full_name, " +
                     "is_email_verified, is_phone_verified, avatar_url, status, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getRoleId());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getFullName());
            stmt.setBoolean(7, user.isEmailVerified());
            stmt.setBoolean(8, user.isPhoneVerified());
            stmt.setString(9, user.getAvatarUrl());
            stmt.setString(10, user.getStatus());
            stmt.setTimestamp(11, new Timestamp(user.getCreatedAt().getTime()));
            stmt.setTimestamp(12, new Timestamp(user.getUpdatedAt().getTime()));
            return stmt.executeUpdate() > 0;
        }
    }

    // Đăng nhập (so sánh password hash ở bên ngoài hoặc có thể kết hợp BCrypt)
    public User login(String username, String rawPassword) throws SQLException {
    String sql = "SELECT * FROM users WHERE username = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, username);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                String hashed = rs.getString("password_hash");
                if (BCrypt.checkpw(rawPassword, hashed)) {
                    return mapResultSetToUser(rs);
                }
            }
        }
    }
    return null;
}

    // Kiểm tra username đã tồn tại
    public boolean isUsernameExists(String username) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Kiểm tra email đã tồn tại
    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Lấy danh sách toàn bộ user
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        }
        return users;
    }

    // Cập nhật thông tin user
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET role_id = ?, username = ?, password_hash = ?, email = ?, phone = ?, full_name = ?, " +
                     "is_email_verified = ?, is_phone_verified = ?, avatar_url = ?, status = ?, updated_at = ? " +
                     "WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getRoleId());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getFullName());
            stmt.setBoolean(7, user.isEmailVerified());
            stmt.setBoolean(8, user.isPhoneVerified());
            stmt.setString(9, user.getAvatarUrl());
            stmt.setString(10, user.getStatus());
            stmt.setTimestamp(11, new Timestamp(user.getUpdatedAt().getTime()));
            stmt.setInt(12, user.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    // Xóa user theo ID
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Cập nhật profile cơ bản (email, phone, address, avatar)
    public boolean updateProfile(int userId, String email, String phone, String address, String avatarUrl) throws SQLException {
        String sql = "UPDATE users SET email = ?, phone = ?, full_name = ?, avatar_url = ?, updated_at = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, phone);
            stmt.setString(3, address); // Sử dụng address cho full_name tạm thời
            stmt.setString(4, avatarUrl);
            stmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(6, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Lấy user theo ID
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }

    // Helper: Map từ ResultSet sang User object
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setRoleId(rs.getInt("role_id"));
        user.setUsername(rs.getString("username"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setFullName(rs.getString("full_name"));
        user.setEmailVerified(rs.getBoolean("is_email_verified"));
        user.setPhoneVerified(rs.getBoolean("is_phone_verified"));
        user.setAvatarUrl(rs.getString("avatar_url"));
        user.setStatus(rs.getString("status"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        return user;
    }
}
