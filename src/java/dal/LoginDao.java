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
}
