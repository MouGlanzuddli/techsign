package dal;

import java.sql.Connection;     // ✅ JDBC Connection
import java.sql.Statement;      // ✅ JDBC Statement
import java.sql.ResultSet;      // ✅ Để xử lý kết quả truy vấn

public class LoginDao {
    private final Connection connection;

    public LoginDao(Connection connection) {
        this.connection = connection;
    }
    public int getLoginCount() throws Exception {
String sql = "SELECT COUNT(*) FROM login_history ;";
         try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public int getTodaysLoginCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM login_history WHERE CAST(login_time AS DATE) = CAST(GETDATE() AS DATE)";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public void logUserSession(int userId, String sessionToken) throws Exception {
        String sql = "INSERT INTO user_sessions (user_id, session_token, login_time, is_active) VALUES (?, ?, GETDATE(), 1)";
        try (java.sql.PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, sessionToken);
            stmt.executeUpdate();
        }
    }
} 