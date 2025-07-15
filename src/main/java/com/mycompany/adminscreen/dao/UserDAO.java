package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.User;
import com.mycompany.adminscreen.util.DBConnection;

import java.sql.*;
import java.util.*;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    // Thêm user mới
    @SuppressWarnings("empty-statement")
    public boolean insertUser(User user) throws SQLException {
        String sql = "INSERT INTO users (role_id, email, phone, password_hash, full_name, "
                + "is_email_verified, is_phone_verified, avatar_url, status, created_at, updated_at, security_question, security_answer_hash) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getRoleId());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getPasswordHash());
            stmt.setString(5, user.getFullName());
            stmt.setBoolean(6, user.isEmailVerified());
            stmt.setBoolean(7, user.isPhoneVerified());
            stmt.setString(8, user.getAvatarUrl());
            stmt.setString(9, user.getStatus());
            stmt.setTimestamp(10, new Timestamp(user.getCreatedAt().getTime()));
            stmt.setTimestamp(11, new Timestamp(user.getUpdatedAt().getTime()));
            stmt.setString(12, user.getSecurityQuestion());
            stmt.setString(13, user.getSecurityAnswerHash());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public User login(String email, String rawPassword) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedHashedPassword = rs.getString("password_hash");
                if (BCrypt.checkpw(rawPassword, storedHashedPassword)) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy user theo ID
    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy tất cả users với tìm kiếm và lọc
    public List<User> getUsers(String search, String role) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT u.*, r.name AS role_name FROM users u JOIN roles r ON u.role_id = r.id WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.full_name LIKE ? OR u.email LIKE ?)");
            String q = "%" + search.trim() + "%";
            params.add(q);
            params.add(q);
        }
        if (role != null && !role.trim().isEmpty()) {
            try {
                int roleId = Integer.parseInt(role.trim());
                sql.append(" AND u.role_id = ?");
                params.add(roleId);
            } catch (NumberFormatException e) {
                // Ignore invalid role filter
            }
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    ps.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(i + 1, (Integer) param);
                }
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cập nhật user
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET role_id = ?, email = ?, phone = ?, password_hash = ?, "
                + "full_name = ?, is_email_verified = ?, is_phone_verified = ?, avatar_url = ?, "
                + "status = ?, updated_at = ?, security_question = ?, security_answer_hash = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getRoleId());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getPasswordHash());
            stmt.setString(5, user.getFullName());
            stmt.setBoolean(6, user.isEmailVerified());
            stmt.setBoolean(7, user.isPhoneVerified());
            stmt.setString(8, user.getAvatarUrl());
            stmt.setString(9, user.getStatus());
            stmt.setTimestamp(10, new Timestamp(user.getUpdatedAt().getTime()));
            stmt.setString(11, user.getSecurityQuestion());
            stmt.setString(12, user.getSecurityAnswerHash());
            stmt.setInt(13, user.getId());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa user
    public boolean deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method để map ResultSet về User object
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setRoleId(rs.getInt("role_id"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFullName(rs.getString("full_name"));
        user.setEmailVerified(rs.getBoolean("is_email_verified"));
        user.setPhoneVerified(rs.getBoolean("is_phone_verified"));
        user.setAvatarUrl(rs.getString("avatar_url"));
        user.setStatus(rs.getString("status"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        try { user.setRoleName(rs.getString("role_name")); } catch (SQLException ignore) {}
        return user;
    }

    public boolean checkUserExists(int id) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkEmailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getTotalUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Existing methods for token-based verification
    public void addUserWithToken(User user, String token, Timestamp expiresAt) {
        String userSql = "INSERT INTO users (role_id, email, phone, password_hash, full_name, status) VALUES (?, ?, ?, ?, ?, 'pending')";
        String tokenSql = "INSERT INTO user_verification_tokens (user_id, token, expires_at) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            PreparedStatement ps = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, user.getRoleId());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPasswordHash());
            ps.setString(5, user.getFullName());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int userId = 0;
            if (rs.next()) userId = rs.getInt(1);
            PreparedStatement ps2 = conn.prepareStatement(tokenSql);
            ps2.setInt(1, userId);
            ps2.setString(2, token);
            ps2.setTimestamp(3, expiresAt);
            ps2.executeUpdate();
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Optional<Integer> getUserIdByToken(String token) {
        String sql = "SELECT user_id, expires_at FROM user_verification_tokens WHERE token=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Timestamp expiresAt = rs.getTimestamp("expires_at");
                if (expiresAt.after(new Timestamp(System.currentTimeMillis()))) {
                    return Optional.of(rs.getInt("user_id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public void verifyUserById(int userId, String token) {
        String updateUser = "UPDATE users SET is_email_verified=1, status='active' WHERE id=?";
        String deleteToken = "DELETE FROM user_verification_tokens WHERE token=?";
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(updateUser);
            ps.setInt(1, userId);
            ps.executeUpdate();
            PreparedStatement ps2 = conn.prepareStatement(deleteToken);
            ps2.setString(1, token);
            ps2.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean updateUserStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ?, updated_at = GETDATE() WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean setUserOnline(int userId) {
        return updateUserStatus(userId, "online");
    }

    public int getTotalUserCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
} 