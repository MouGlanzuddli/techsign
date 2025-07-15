package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.LoginHistory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LoginHistoryDAO{
    private final Connection conn;

    public LoginHistoryDAO(Connection conn) {
        this.conn = conn;
    }

    public void add(LoginHistory history) throws Exception {
        String sql = "INSERT INTO login_history (user_id, login_time, ip_address, device_info) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, history.getUserId());
            ps.setTimestamp(2, new Timestamp(history.getLoginTime().getTime()));
            ps.setString(3, history.getIpAddress());
            ps.setString(4, history.getDeviceInfo());
            ps.executeUpdate();
        }
    }

    public List<LoginHistory> getByUserId(int userId) throws Exception {
        String sql = "SELECT * FROM login_history WHERE user_id = ? ORDER BY login_time DESC";
        List<LoginHistory> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    public List<LoginHistory> getAll() throws Exception {
        String sql = "SELECT * FROM login_history ORDER BY login_time DESC";
        List<LoginHistory> list = new ArrayList<>();
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    private LoginHistory mapRow(ResultSet rs) throws SQLException {
        LoginHistory lh = new LoginHistory();
        lh.setId(rs.getInt("id"));
        lh.setUserId(rs.getInt("user_id"));
        lh.setLoginTime(rs.getTimestamp("login_time"));
        lh.setIpAddress(rs.getString("ip_address"));
        lh.setDeviceInfo(rs.getString("device_info"));
        return lh;
    }
}