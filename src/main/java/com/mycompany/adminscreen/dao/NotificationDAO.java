package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.Notification;
import java.sql.*;
import java.util.*;

public class NotificationDAO {
    private Connection getConnection() throws SQLException {
        // Adjust this to your connection pool or DataSource
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "user", "password");
    }

    public List<Notification> getAll() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM system_notifications WHERE pinned = FALSE ORDER BY created_at DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Notification> getPinned() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM system_notifications WHERE pinned = TRUE ORDER BY created_at DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(Notification n) {
        String sql = "INSERT INTO system_notifications (title, message, type, auto_dismiss, duration_ms, pinned) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getMessage());
            ps.setString(3, n.getType());
            ps.setBoolean(4, n.isAutoDismiss());
            ps.setInt(5, n.getDurationMs());
            ps.setBoolean(6, n.isPinned());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void pinNotification(int id) {
        String sql = "UPDATE system_notifications SET pinned = TRUE WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unpinNotification(int id) {
        String sql = "UPDATE system_notifications SET pinned = FALSE WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Map<String, Integer> getStats() {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT COUNT(*) AS total, " +
                "SUM(CASE WHEN type IN ('security','maintenance') THEN 1 ELSE 0 END) AS important, " +
                "SUM(CASE WHEN created_at >= NOW() - INTERVAL 1 DAY THEN 1 ELSE 0 END) AS new, " +
                "SUM(CASE WHEN pinned = TRUE THEN 1 ELSE 0 END) AS pinned " +
                "FROM system_notifications";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.put("total", rs.getInt("total"));
                stats.put("important", rs.getInt("important"));
                stats.put("new", rs.getInt("new"));
                stats.put("pinned", rs.getInt("pinned"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    private Notification mapRow(ResultSet rs) throws SQLException {
        Notification n = new Notification();
        n.setId(rs.getInt("id"));
        n.setTitle(rs.getString("title"));
        n.setMessage(rs.getString("message"));
        n.setType(rs.getString("type"));
        n.setAutoDismiss(rs.getBoolean("auto_dismiss"));
        n.setDurationMs(rs.getInt("duration_ms"));
        n.setCreatedAt(rs.getTimestamp("created_at"));
        n.setPinned(rs.getBoolean("pinned"));
        return n;
    }
} 