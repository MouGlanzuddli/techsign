package dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.LoginHistory;

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

    // New method for search and filter functionality
    public List<LoginHistory> searchAndFilter(String searchTerm, String userId, String dateFrom, String dateTo, String ipAddress, String deviceInfo, int limit, int offset) throws Exception {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT lh.*, u.full_name, u.email FROM login_history lh ");
        sql.append("LEFT JOIN users u ON lh.user_id = u.id ");
        sql.append("WHERE 1=1 ");
        
        List<Object> parameters = new ArrayList<>();
        int paramIndex = 1;
        
        // Search term (searches in user name, email, IP address, device info)
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ? OR lh.ip_address LIKE ? OR lh.device_info LIKE ?) ");
            String searchPattern = "%" + searchTerm.trim() + "%";
            parameters.add(searchPattern);
            parameters.add(searchPattern);
            parameters.add(searchPattern);
            parameters.add(searchPattern);
        }
        
        // User ID filter
        if (userId != null && !userId.trim().isEmpty()) {
            try {
                int userIdInt = Integer.parseInt(userId.trim());
                sql.append("AND lh.user_id = ? ");
                parameters.add(userIdInt);
            } catch (NumberFormatException e) {
                // Invalid user ID, ignore this filter
            }
        }
        
        // Date range filter
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append("AND lh.login_time >= ? ");
            parameters.add(dateFrom.trim());
        }
        
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append("AND lh.login_time <= ? ");
            parameters.add(dateTo.trim() + " 23:59:59");
        }
        
        // IP address filter
        if (ipAddress != null && !ipAddress.trim().isEmpty()) {
            sql.append("AND lh.ip_address LIKE ? ");
            parameters.add("%" + ipAddress.trim() + "%");
        }
        
        // Device info filter
        if (deviceInfo != null && !deviceInfo.trim().isEmpty()) {
            sql.append("AND lh.device_info LIKE ? ");
            parameters.add("%" + deviceInfo.trim() + "%");
        }
        
        sql.append("ORDER BY lh.login_time DESC ");
        
        // Add limit and offset for pagination
        if (limit > 0) {
            sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            parameters.add(offset);
            parameters.add(limit);
        }
        
        List<LoginHistory> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LoginHistory history = mapRow(rs);
                    // Add user info if available
                    if (rs.getString("full_name") != null) {
                        history.setUserName(rs.getString("full_name"));
                        history.setUserEmail(rs.getString("email"));
                    }
                    list.add(history);
                }
            }
        }
        return list;
    }

    // Get total count for pagination
    public int getTotalCount(String searchTerm, String userId, String dateFrom, String dateTo, String ipAddress, String deviceInfo) throws Exception {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM login_history lh ");
        sql.append("LEFT JOIN users u ON lh.user_id = u.id ");
        sql.append("WHERE 1=1 ");
        
        List<Object> parameters = new ArrayList<>();
        
        // Search term
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ? OR lh.ip_address LIKE ? OR lh.device_info LIKE ?) ");
            String searchPattern = "%" + searchTerm.trim() + "%";
            parameters.add(searchPattern);
            parameters.add(searchPattern);
            parameters.add(searchPattern);
            parameters.add(searchPattern);
        }
        
        // User ID filter
        if (userId != null && !userId.trim().isEmpty()) {
            try {
                int userIdInt = Integer.parseInt(userId.trim());
                sql.append("AND lh.user_id = ? ");
                parameters.add(userIdInt);
            } catch (NumberFormatException e) {
                // Invalid user ID, ignore this filter
            }
        }
        
        // Date range filter
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append("AND lh.login_time >= ? ");
            parameters.add(dateFrom.trim());
        }
        
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append("AND lh.login_time <= ? ");
            parameters.add(dateTo.trim() + " 23:59:59");
        }
        
        // IP address filter
        if (ipAddress != null && !ipAddress.trim().isEmpty()) {
            sql.append("AND lh.ip_address LIKE ? ");
            parameters.add("%" + ipAddress.trim() + "%");
        }
        
        // Device info filter
        if (deviceInfo != null && !deviceInfo.trim().isEmpty()) {
            sql.append("AND lh.device_info LIKE ? ");
            parameters.add("%" + deviceInfo.trim() + "%");
        }
        
        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Get unique users for filter dropdown
    public List<String> getUniqueUsers() throws Exception {
        String sql = "SELECT DISTINCT u.id, u.full_name, u.email FROM login_history lh " +
                    "LEFT JOIN users u ON lh.user_id = u.id " +
                    "WHERE u.full_name IS NOT NULL " +
                    "ORDER BY u.full_name";
        
        List<String> users = new ArrayList<>();
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                String userInfo = rs.getInt("id") + " - " + rs.getString("full_name") + " (" + rs.getString("email") + ")";
                users.add(userInfo);
            }
        }
        return users;
    }

    // Get unique IP addresses for filter dropdown
    public List<String> getUniqueIPAddresses() throws Exception {
        String sql = "SELECT DISTINCT ip_address FROM login_history WHERE ip_address IS NOT NULL AND ip_address != '' ORDER BY ip_address";
        
        List<String> ipAddresses = new ArrayList<>();
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                ipAddresses.add(rs.getString("ip_address"));
            }
        }
        return ipAddresses;
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