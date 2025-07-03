package util;

import dal.DBContext;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Utility class để quản lý connection pool và các thao tác database chung
 */
public class ConnectionManager {
    
    private static DBContext dbContext = new DBContext();
    
    /**
     * Lấy connection từ DBContext
     */
    public static Connection getConnection() throws SQLException {
        return dbContext.getConnection();
    }
    
    /**
     * Đóng connection an toàn
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
    
    /**
     * Test connection
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Connection test failed: " + e.getMessage());
            return false;
        }
    }
}
