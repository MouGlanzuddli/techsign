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

    // Model nội bộ cho log hoạt động
    public static class AuditLog {
        public int id;
        public Integer userId;
        public String actionType;
        public String entityType;
        public int entityId;
        public String oldValue;
        public String newValue;
        public String ipAddress;
        public java.sql.Timestamp timestamp;
        public String severity;
    }

    // Lấy danh sách hoạt động gần đây
    public java.util.List<AuditLog> getRecentLogs(int limit) throws Exception {
        String sql = "SELECT TOP " + limit + " * FROM audit_logs ORDER BY timestamp DESC, id DESC";
        java.util.List<AuditLog> logs = new java.util.ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                AuditLog log = new AuditLog();
                log.id = rs.getInt("id");
                log.userId = (Integer)rs.getObject("user_id");
                log.actionType = rs.getString("action_type");
                log.entityType = rs.getString("entity_type");
                log.entityId = rs.getInt("entity_id");
                log.oldValue = rs.getString("old_value");
                log.newValue = rs.getString("new_value");
                log.ipAddress = rs.getString("ip_address");
                log.timestamp = rs.getTimestamp("timestamp");
                log.severity = rs.getString("severity");
                logs.add(log);
            }
        }
        return logs;
    }
}
