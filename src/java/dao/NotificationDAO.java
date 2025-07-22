package dao;

import model.Notification;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class NotificationDAO {

    public List<Notification> getAll() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE is_pinned = 0 ORDER BY created_at DESC";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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
        String sql = "SELECT * FROM notifications WHERE is_pinned = 1 ORDER BY created_at DESC";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(Notification n) {
        String sql = "INSERT INTO notifications (title, message, type, is_pinned, is_important, auto_dismiss, duration_ms, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getMessage());
            ps.setString(3, n.getType());
            ps.setBoolean(4, n.isPinned());
            ps.setBoolean(5, n.isImportant());
            ps.setBoolean(6, n.isAutoDismiss());
            ps.setInt(7, n.getDurationMs());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM notifications WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Notification n) {
        String sql = "UPDATE notifications SET title = ?, message = ?, type = ?, auto_dismiss = ?, duration_ms = ?, is_pinned = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getMessage());
            ps.setString(3, n.getType());
            ps.setBoolean(4, n.isAutoDismiss());
            ps.setInt(5, n.getDurationMs());
            ps.setBoolean(6, n.isPinned());
            ps.setInt(7, n.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void pinNotification(int id) {
        String sql = "UPDATE notifications SET is_pinned = 1 WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unpinNotification(int id) {
        String sql = "UPDATE notifications SET is_pinned = 0 WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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
                "SUM(CASE WHEN created_at >= GETDATE() - 1 THEN 1 ELSE 0 END) AS new, " +
                "SUM(CASE WHEN is_pinned = 1 THEN 1 ELSE 0 END) AS pinned " +
                "FROM notifications";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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
        n.setPinned(rs.getBoolean("is_pinned"));
        n.setImportant(rs.getBoolean("is_important"));
        n.setAutoDismiss(rs.getBoolean("auto_dismiss"));
        n.setDurationMs(rs.getInt("duration_ms"));
        n.setCreatedAt(rs.getTimestamp("created_at"));
        return n;
    }
} 