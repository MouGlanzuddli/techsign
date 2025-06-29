package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserDao {

    private final Connection connection;

    public UserDao(Connection connection) {
        this.connection = connection;
    }

    // Thêm user mới
    public boolean insertUser(User user) throws SQLException {
        String sql = "INSERT INTO users (role_id, email, phone, password_hash, full_name, "
                + "is_email_verified, is_phone_verified, avatar_url, status, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
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
            return stmt.executeUpdate() > 0;
        }
    }

    public User login(String email, String rawPassword) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedHashedPassword = rs.getString("password_hash");
                // So sánh mật khẩu người dùng nhập với hash trong DB
                if (BCrypt.checkpw(rawPassword, storedHashedPassword)) {
                    return new User(
                            rs.getInt("id"),
                            rs.getInt("role_id"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            storedHashedPassword,
                            rs.getString("full_name"),
                            rs.getBoolean("is_email_verified"),
                            rs.getBoolean("is_phone_verified"),
                            rs.getString("avatar_url"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"),
                            rs.getTimestamp("updated_at")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Login error: " + e.getMessage());
        }
        return null; // Trả về null nếu không tìm thấy hoặc mật khẩu sai
    }

    // Lấy user theo ID
    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        }
        return null;
    }

    // Lấy tất cả users
    public List<User> getAllUsers() throws SQLException {
        String sql = "SELECT * FROM users";
        List<User> users = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        }
        return users;
    }

    // Cập nhật user
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET role_id = ?, email = ?, phone = ?, password_hash = ?, "
                + "full_name = ?, is_email_verified = ?, is_phone_verified = ?, avatar_url = ?, "
                + "status = ?, updated_at = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
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
            stmt.setInt(11, user.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    // Xóa user
    public boolean deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
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
        return user;
    }

    public boolean checkUserExists(int id) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Nếu có bản ghi, trả về true
        }
    }

    public boolean checkEmailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }
    public User getUserByEmail(String email) {
    String sql = "SELECT * FROM Users WHERE email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setEmail(rs.getString("email"));
            u.setFullName(rs.getString("full_name"));
            u.setRoleId(rs.getInt("role_id"));
            u.setAvatarUrl(rs.getString("avatar_url"));
            u.setStatus(rs.getString("status"));
            // ... các trường khác
            return u;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

    public int getTotalUsers() throws SQLException {
    String sql = "SELECT COUNT(*) FROM users";
    try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
        if (rs.next()) {
            return rs.getInt(1);
        }
    }
    return 0;
}

    
}
