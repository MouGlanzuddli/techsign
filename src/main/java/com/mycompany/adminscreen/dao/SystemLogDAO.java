package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.SystemLog;
import com.mycompany.adminscreen.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SystemLogDAO {
    public List<SystemLog> getLogsByUser(int userId) {
        List<SystemLog> logs = new ArrayList<>();
        String sql = "SELECT * FROM system_logs WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                SystemLog log = new SystemLog();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("user_id"));
                log.setAction(rs.getString("action"));
                log.setDescription(rs.getString("description"));
                log.setCreatedAt(rs.getTimestamp("created_at"));
                logs.add(log);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }
} 