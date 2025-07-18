package dal;

import java.sql.*;
import java.util.*;
import dal.DBContext;

public class StatisticsDAO {
    private Connection connection;
    
    public StatisticsDAO() throws SQLException {
        this.connection = new DBContext().getConnection();
    }
    
    // ✅ MAIN METHOD - Lấy TẤT CẢ statistics từ real database
    public Map<String, Object> getAllStatistics() {
        Map<String, Object> allStats = new HashMap<>();
        
        try {
            // ✅ 1. ACCOUNT STATISTICS
            allStats.put("totalUsers", getTotalUsers());
            allStats.put("candidates", getUsersByRole(2)); // role_id = 2 (Candidate)
            allStats.put("employers", getUsersByRole(3));  // role_id = 3 (Employer)
            allStats.put("admins", getUsersByRole(1));     // role_id = 1 (Admin)
            allStats.put("activeUsers", getActiveUsers());
            allStats.put("inactiveUsers", getInactiveUsers());
            
            // ✅ 2. ACCESS STATISTICS
            allStats.put("totalVisits", getTotalVisits());
            allStats.put("todayVisits", getTodayVisits());
            allStats.put("activeUsersWeek", getActiveUsersThisWeek());
            allStats.put("avgSessionMinutes", getAvgSessionMinutes());
            
            // ✅ 3. ACTIVITY REPORTS
            allStats.put("totalActivities", getTotalActivities());
            allStats.put("newActivities", getNewActivitiesToday());
            allStats.put("activeParticipants", getActiveParticipants());
            allStats.put("activeParticipantsPrev7Days", getActiveParticipantsPrev7Days());
            
            // ✅ 4. APPLICATION ANALYSIS
            allStats.put("totalApplications", getTotalApplications());
            allStats.put("approvedApplications", getApplicationsByStatus("approved"));
            allStats.put("pendingApplications", getApplicationsByStatus("pending"));
            allStats.put("rejectedApplications", getApplicationsByStatus("rejected"));
            
            // ✅ 5. SECURITY & SYSTEM
            allStats.put("securityAlerts", getSecurityAlerts());
            allStats.put("systemWarnings", getSystemWarnings());
            allStats.put("criticalIssues", getCriticalIssues());
            
            // ✅ 6. DỮ LIỆU THẬT CHO THỐNG KÊ MỚI
            allStats.put("newUsersLast30Days", getNewUsersLast30Days());
            allStats.put("monthlyUserGrowth", getMonthlyUserGrowth());
            
            // ✅ 7. THỐNG KÊ TRUY CẬP
            allStats.put("totalVisitsPrevMonth", getTotalVisitsPrevMonth());
            allStats.put("todayVisitsPrevDay", getTodayVisitsPrevDay());
            allStats.put("avgSessionMinutesPrev7Days", getAvgSessionMinutesPrev7Days());
            allStats.put("activeUsersWeekPrev7Days", getActiveUsersWeekPrev7Days());
            
            // ✅ 8. NEW ACTIVITIES
            allStats.put("totalActivitiesPrev30Days", getTotalActivitiesPrev30Days());
            allStats.put("newActivitiesPrevDay", getNewActivitiesPrevDay());
            allStats.put("avgDailyActivitiesPrev30Days", getAvgDailyActivitiesPrev30Days());
            
        } catch (SQLException e) {
            System.err.println("❌ Error in getAllStatistics: " + e.getMessage());
            e.printStackTrace();
            setDefaultValues(allStats);
        }
        
        return allStats;
    }
    
    // ✅ USER STATISTICS
    private int getTotalUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting total users: " + e.getMessage());
            return 0;
        }
    }
    
    private int getUsersByRole(int roleId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roleId);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting users by role " + roleId + ": " + e.getMessage());
            return 0;
        }
    }
    
    private int getActiveUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE status = 'active'";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting active users: " + e.getMessage());
            return 0;
        }
    }
    
    private int getInactiveUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE status != 'active' OR status IS NULL";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting inactive users: " + e.getMessage());
            return 0;
        }
    }
    
    // ✅ ACCESS STATISTICS
    private int getTotalVisits() throws SQLException {
        String sql = "SELECT COUNT(*) FROM user_sessions";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting total visits: " + e.getMessage());
            return 0;
        }
    }
    
    public int getTodayVisits() throws SQLException {
        String sql = "SELECT COUNT(*) FROM user_sessions WHERE CAST(login_time AS DATE) = CAST(GETDATE() AS DATE)";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting today visits: " + e.getMessage());
            return 0;
        }
    }
    
    private int getActiveUsersThisWeek() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT user_id) FROM user_sessions WHERE login_time >= DATEADD(day, -7, GETDATE())";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting active users this week: " + e.getMessage());
            return 0;
        }
    }
    
    // ✅ ACTIVITY REPORTS
    private int getTotalActivities() throws SQLException {
        String sql = "SELECT COUNT(*) FROM audit_logs WHERE timestamp >= DATEADD(day, -30, GETDATE())";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting total activities: " + e.getMessage());
            return 0;
        }
    }
    
    private int getNewActivitiesToday() throws SQLException {
        String sql = "SELECT COUNT(*) FROM audit_logs WHERE CAST(timestamp AS DATE) = CAST(GETDATE() AS DATE)";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting new activities today: " + e.getMessage());
            return 0;
        }
    }
    
    private int getActiveParticipants() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT user_id) FROM audit_logs WHERE timestamp >= DATEADD(day, -7, GETDATE()) AND user_id IS NOT NULL";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting active participants: " + e.getMessage());
            return 0;
        }
    }
    
    // ✅ APPLICATION ANALYSIS
    private int getTotalApplications() throws SQLException {
        String sql = "SELECT COUNT(*) FROM applications";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting total applications: " + e.getMessage());
            return 0;
        }
    }
    
    private int getApplicationsByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM applications WHERE status = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting applications by status " + status + ": " + e.getMessage());
            return 0;
        }
    }
    
    // ✅ SECURITY & SYSTEM
    private int getSecurityAlerts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM audit_logs WHERE severity IN ('WARNING', 'ERROR', 'CRITICAL')";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting security alerts: " + e.getMessage());
            return 0;
        }
    }
    
    private int getSystemWarnings() throws SQLException {
        String sql = "SELECT COUNT(*) FROM audit_logs WHERE severity = 'WARNING'";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting system warnings: " + e.getMessage());
            return 0;
        }
    }
    
    private int getCriticalIssues() throws SQLException {
        String sql = "SELECT COUNT(*) FROM audit_logs WHERE severity = 'CRITICAL'";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting critical issues: " + e.getMessage());
            return 0;
        }
    }
    
    // ✅ THỐNG KÊ MỚI: Lấy người dùng mới trong 30 ngày
    public int getNewUsersLast30Days() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE created_at >= DATEADD(day, -30, GETDATE())";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getNewUsersPrevious30Days() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE created_at >= DATEADD(day, -60, GETDATE()) AND created_at < DATEADD(day, -30, GETDATE())";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ✅ THỐNG KÊ MỚI: Lấy tăng trưởng người dùng 6 tháng gần nhất
    public Map<String, Integer> getMonthlyUserGrowth() throws SQLException {
        return getMonthlyGrowthByRole(null);
    }

    public Map<String, Integer> getMonthlyCandidateGrowth() throws SQLException {
        // role_id = 3 là của 'candidate'
        return getMonthlyGrowthByRole(3);
    }

    public Map<String, Integer> getMonthlyEmployerGrowth() throws SQLException {
        // role_id = 2 là của 'employer'
        return getMonthlyGrowthByRole(2);
    }

    private Map<String, Integer> getMonthlyGrowthByRole(Integer roleId) throws SQLException {
        Map<String, Integer> monthlyGrowth = new LinkedHashMap<>();
        String sql = "SELECT FORMAT(created_at, 'yyyy-MM') AS month, COUNT(id) AS new_users "
                   + "FROM users "
                   + "WHERE created_at >= DATEADD(month, -6, GETDATE()) ";

        if (roleId != null) {
            sql += "AND role_id = ? ";
        }

        sql += "GROUP BY FORMAT(created_at, 'yyyy-MM') ORDER BY month";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            if (roleId != null) {
                st.setInt(1, roleId);
            }
            
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                monthlyGrowth.put(rs.getString("month"), rs.getInt("new_users"));
            }
        }
        return monthlyGrowth;
    }
    
    // ✅ DEFAULT VALUES ON ERROR
    private void setDefaultValues(Map<String, Object> stats) {
        System.out.println("⚠️ Setting default values due to database error");
        stats.put("totalUsers", 0);
        stats.put("candidates", 0);
        stats.put("employers", 0);
        stats.put("admins", 0);
        stats.put("activeUsers", 0);
        stats.put("inactiveUsers", 0);
        stats.put("totalVisits", 0);
        stats.put("todayVisits", 0);
        stats.put("activeUsersWeek", 0);
        stats.put("avgSessionMinutes", 0);
        stats.put("totalActivities", 0);
        stats.put("newActivities", 0);
        stats.put("activeParticipants", 0);
        stats.put("totalApplications", 0);
        stats.put("approvedApplications", 0);
        stats.put("pendingApplications", 0);
        stats.put("rejectedApplications", 0);
        stats.put("securityAlerts", 0);
        stats.put("systemWarnings", 0);
        stats.put("criticalIssues", 0);
        stats.put("newUsersLast30Days", 0);
        stats.put("monthlyUserGrowth", new HashMap<>());
    }
    
    public void close() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Map<Integer, Integer> getHourlyVisitsToday() throws SQLException {
        Map<Integer, Integer> hourlyVisits = new HashMap<>();
        for (int i = 0; i < 24; i++) {
            hourlyVisits.put(i, 0);
        }
        
        String sql = "SELECT DATEPART(hour, login_time) as hour, COUNT(*) as visit_count " +
                     "FROM user_sessions " +
                     "WHERE CAST(login_time AS DATE) = CAST(GETDATE() AS DATE) " +
                     "GROUP BY DATEPART(hour, login_time)";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                hourlyVisits.put(rs.getInt("hour"), rs.getInt("visit_count"));
            }
        } catch (SQLException e) {
            System.err.println("❌ Error getting hourly visits: " + e.getMessage());
        }
        return hourlyVisits;
    }

    // ✅ TÍNH THỜI GIAN TRUNG BÌNH PHIÊN TRUY CẬP TRONG 7 NGÀY GẦN NHẤT
    public int getAvgSessionMinutes() throws SQLException {
        String sql = "SELECT AVG(DATEDIFF(SECOND, login_time, logout_time)) AS avg_session_seconds FROM user_sessions WHERE logout_time IS NOT NULL AND login_time >= DATEADD(day, -7, GETDATE())";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                int avgSeconds = rs.getInt("avg_session_seconds");
                return avgSeconds > 0 ? avgSeconds / 60 : 0; // Trả về số phút trung bình
            }
        }
        return 0;
    }

    // Tổng lượt truy cập tháng trước
    private int getTotalVisitsPrevMonth() throws SQLException {
        String sql = "SELECT COUNT(*) FROM user_sessions WHERE MONTH(login_time) = MONTH(DATEADD(month, -1, GETDATE())) AND YEAR(login_time) = YEAR(DATEADD(month, -1, GETDATE()))";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
    // Lượt truy cập hôm qua
    public int getTodayVisitsPrevDay() throws SQLException {
        String sql = "SELECT COUNT(*) FROM user_sessions WHERE CAST(login_time AS DATE) = CAST(DATEADD(day, -1, GETDATE()) AS DATE)";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
    // Thời gian trung bình mỗi phiên 7 ngày trước
    private int getAvgSessionMinutesPrev7Days() throws SQLException {
        String sql = "SELECT AVG(DATEDIFF(SECOND, login_time, logout_time)) AS avg_session_seconds FROM user_sessions WHERE logout_time IS NOT NULL AND login_time >= DATEADD(day, -14, GETDATE()) AND login_time < DATEADD(day, -7, GETDATE())";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                int avgSeconds = rs.getInt("avg_session_seconds");
                return avgSeconds > 0 ? avgSeconds / 60 : 0;
            }
        }
        return 0;
    }
    // Số người truy cập 7 ngày trước
    private int getActiveUsersWeekPrev7Days() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT user_id) FROM user_sessions WHERE login_time >= DATEADD(day, -14, GETDATE()) AND login_time < DATEADD(day, -7, GETDATE())";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /**
     * Lấy số lượt truy cập mỗi ngày trong 7 ngày gần nhất (bao gồm hôm nay)
     * @return Map<String, Integer> với key là yyyy-MM-dd, value là số lượt truy cập
     */
    public Map<String, Integer> getDailyVisitsLast7Days() throws SQLException {
        Map<String, Integer> dailyVisits = new LinkedHashMap<>();
        // Khởi tạo 7 ngày gần nhất (kể cả hôm nay)
        for (int i = 6; i >= 0; i--) {
            java.time.LocalDate date = java.time.LocalDate.now().minusDays(i);
            dailyVisits.put(date.toString(), 0);
        }
        String sql = "SELECT CONVERT(varchar, login_time, 23) as day, COUNT(*) as visit_count " +
                     "FROM user_sessions " +
                     "WHERE login_time >= CAST(DATEADD(day, -6, GETDATE()) AS DATE) " +
                     "GROUP BY CONVERT(varchar, login_time, 23)";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                String day = rs.getString("day");
                int count = rs.getInt("visit_count");
                if (dailyVisits.containsKey(day)) {
                    dailyVisits.put(day, count);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error getting daily visits last 7 days: " + e.getMessage());
        }
        return dailyVisits;
    }

    /**
     * Lấy số lượt truy cập mỗi ngày trong 30 ngày gần nhất (bao gồm hôm nay)
     * @return Map<String, Integer> với key là yyyy-MM-dd, value là số lượt truy cập
     */
    public Map<String, Integer> getDailyVisitsLast30Days() throws SQLException {
        Map<String, Integer> dailyVisits = new LinkedHashMap<>();
        for (int i = 29; i >= 0; i--) {
            java.time.LocalDate date = java.time.LocalDate.now().minusDays(i);
            dailyVisits.put(date.toString(), 0);
        }
        String sql = "SELECT CONVERT(varchar, login_time, 23) as day, COUNT(*) as visit_count " +
                     "FROM user_sessions " +
                     "WHERE login_time >= CAST(DATEADD(day, -29, GETDATE()) AS DATE) " +
                     "GROUP BY CONVERT(varchar, login_time, 23)";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                String day = rs.getString("day");
                int count = rs.getInt("visit_count");
                if (dailyVisits.containsKey(day)) {
                    dailyVisits.put(day, count);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error getting daily visits last 30 days: " + e.getMessage());
        }
        return dailyVisits;
    }

    private int getActiveParticipantsPrev7Days() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT user_id) FROM audit_logs WHERE timestamp >= DATEADD(day, -14, GETDATE()) AND timestamp < DATEADD(day, -7, GETDATE()) AND user_id IS NOT NULL";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting active participants prev 7 days: " + e.getMessage());
            return 0;
        }
    }

    private int getTotalActivitiesPrev30Days() throws SQLException {
        String sql = "SELECT COUNT(*) FROM audit_logs WHERE timestamp >= DATEADD(day, -60, GETDATE()) AND timestamp < DATEADD(day, -30, GETDATE())";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting total activities prev 30 days: " + e.getMessage());
            return 0;
        }
    }
    private int getNewActivitiesPrevDay() throws SQLException {
        String sql = "SELECT COUNT(*) FROM audit_logs WHERE CAST(timestamp AS DATE) = CAST(DATEADD(day, -1, GETDATE()) AS DATE)";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting new activities prev day: " + e.getMessage());
            return 0;
        }
    }
    private double getAvgDailyActivitiesPrev30Days() throws SQLException {
        int total = getTotalActivitiesPrev30Days();
        return total / 30.0;
    }

    public Map<String, Integer> getActivityCountsByDate(String startDate, String endDate) throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        // Tạo danh sách ngày liên tục
        java.time.LocalDate start = java.time.LocalDate.parse(startDate);
        java.time.LocalDate end = java.time.LocalDate.parse(endDate);
        for (java.time.LocalDate d = start; !d.isAfter(end); d = d.plusDays(1)) {
            result.put(d.toString(), 0);
        }
        String sql = "SELECT CONVERT(varchar, timestamp, 23) as day, COUNT(*) as cnt " +
                     "FROM audit_logs WHERE timestamp >= ? AND timestamp <= ? GROUP BY CONVERT(varchar, timestamp, 23)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String day = rs.getString("day");
                int cnt = rs.getInt("cnt");
                if (result.containsKey(day)) {
                    result.put(day, cnt);
                }
            }
        }
        return result;
    }

    // Lấy số tài khoản mới theo từng ngày trong khoảng
    public Map<String, Integer> getNewAccountsByDay(String startDate, String endDate) throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        java.time.LocalDate start = java.time.LocalDate.parse(startDate);
        java.time.LocalDate end = java.time.LocalDate.parse(endDate);
        for (java.time.LocalDate d = start; !d.isAfter(end); d = d.plusDays(1)) {
            result.put(d.toString(), 0);
        }
        String sql = "SELECT CONVERT(varchar, created_at, 23) as day, COUNT(*) as cnt " +
                     "FROM users WHERE created_at >= ? AND created_at <= ? GROUP BY CONVERT(varchar, created_at, 23)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String day = rs.getString("day");
                int cnt = rs.getInt("cnt");
                if (result.containsKey(day)) {
                    result.put(day, cnt);
                }
            }
        }
        return result;
    }
}
