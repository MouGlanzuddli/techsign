
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBContext {

    // Thông tin cấu hình kết nối
    private static final String URL = "jdbc:sqlserver://KHANHDUONG\\KHDUONG:1433;databaseName=TechSignDB;encrypt=false";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "123";

    // Load driver khi lớp được nạp
    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException ex) {
            System.err.println("Lỗi: Không tìm thấy JDBC Driver SQL Server.");
            ex.printStackTrace();
        }
    }

    /**
     * Phương thức lấy kết nối đến cơ sở dữ liệu SQL Server.
     *
     * @return Connection nếu thành công, null nếu thất bại
     */
    public Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("Không tìm thấy driver JDBC: " + e.getMessage());
            throw new SQLException("Lỗi tải driver SQL Server", e);
        }
        return conn;
    }
}