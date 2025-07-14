package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.Session;
import com.mycompany.adminscreen.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SessionDAO {
    public List<Session> getSessionsByUser(int userId) {
        List<Session> sessions = new ArrayList<>();
        String sql = "SELECT * FROM sessions WHERE user_id = ? ORDER BY login_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Session session = new Session();
                session.setId(rs.getInt("id"));
                session.setUserId(rs.getInt("user_id"));
                session.setSessionToken(rs.getString("session_token"));
                session.setIpAddress(rs.getString("ip_address"));
                session.setDeviceInfo(rs.getString("device_info"));
                session.setLoginTime(rs.getTimestamp("login_time"));
                session.setLastActiveTime(rs.getTimestamp("last_active_time"));
                session.setLogoutTime(rs.getTimestamp("logout_time"));
                session.setActive(rs.getBoolean("is_active"));
                sessions.add(session);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sessions;
    }

    public boolean forceLogout(int sessionId) {
        String sql = "UPDATE sessions SET is_active = 0, logout_time = GETDATE() WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, sessionId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateLastActive(int sessionId) {
        String sql = "UPDATE sessions SET last_active_time = GETDATE() WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, sessionId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 