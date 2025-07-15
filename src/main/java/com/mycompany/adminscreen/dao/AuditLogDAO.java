package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.AuditLog;
import com.mycompany.adminscreen.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AuditLogDAO {
    public static void save(AuditLog log) {
        String sql = "INSERT INTO audit_logs (user_id, action_type, entity_type, entity_id, old_value, new_value, ip_address, timestamp) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, log.getUserId());
            stmt.setString(2, log.getActionType());
            stmt.setString(3, log.getEntityType());
            stmt.setInt(4, log.getEntityId());
            stmt.setString(5, log.getOldValue());
            stmt.setString(6, log.getNewValue());
            stmt.setString(7, log.getIpAddress());
            stmt.setTimestamp(8, log.getTimestamp());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<AuditLog> getLogsByUser(int userId) {
        List<AuditLog> logs = new ArrayList<>();
        String sql = "SELECT * FROM audit_logs WHERE user_id = ? ORDER BY timestamp DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                AuditLog log = new AuditLog();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("user_id"));
                log.setActionType(rs.getString("action_type"));
                log.setEntityType(rs.getString("entity_type"));
                log.setEntityId(rs.getInt("entity_id"));
                log.setOldValue(rs.getString("old_value"));
                log.setNewValue(rs.getString("new_value"));
                log.setIpAddress(rs.getString("ip_address"));
                log.setTimestamp(rs.getTimestamp("timestamp"));
                logs.add(log);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }
} 