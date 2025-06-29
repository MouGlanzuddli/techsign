/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;     // ✅ JDBC Connection
import java.sql.Statement;      // ✅ JDBC Statement
import java.sql.ResultSet;      // ✅ Để xử lý kết quả truy vấn
public class AuditDao {
    private final Connection connection;

    public AuditDao(Connection connection) {
        this.connection = connection;
    }
    public int getAlert() throws Exception {
        String sql = "SELECT COUNT(*) FROM audit_logs WHERE severity IN ('WARNING', 'CRITICAL');;";
         try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
