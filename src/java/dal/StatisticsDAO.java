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
            allStats.put("avgSessionMinutes", 12); // Sample - có thể tính từ login_history
            allStats.put("bounceRate", 23.5);      // Sample - cần thêm tracking
            
            // ✅ 3. ACTIVITY REPORTS
            allStats.put("totalActivities", getTotalActivities());
            allStats.put("newActivities", getNewActivitiesToday());
            allStats.put("activeParticipants", getActiveParticipants());
            
            // ✅ 4. JOB POSTING REPORTS
            allStats.put("totalJobPosts", getTotalJobPosts());
            allStats.put("activeJobPosts", getActiveJobPosts());
            allStats.put("expiredJobPosts", getExpiredJobPosts());
            allStats.put("avgJobViews", 0); // Cần thêm view tracking
            allStats.put("avgApplications", getAverageApplicationsPerJob());
            
            // ✅ 5. APPLICATION ANALYSIS
            allStats.put("totalApplications", getTotalApplications());
            allStats.put("approvedApplications", getApplicationsByStatus("approved"));
            allStats.put("pendingApplications", getApplicationsByStatus("pending"));
            allStats.put("rejectedApplications", getApplicationsByStatus("rejected"));
            
            // ✅ 6. SECURITY & SYSTEM
            allStats.put("securityAlerts", getSecurityAlerts());
            allStats.put("systemWarnings", getSystemWarnings());
            allStats.put("criticalIssues", getCriticalIssues());
            
            // ✅ 7. DỮ LIỆU THẬT CHO THỐNG KÊ MỚI
            allStats.put("newUsersLast30Days", getNewUsersLast30Days());
            allStats.put("monthlyUserGrowth", getMonthlyUserGrowth());
            
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
        String sql = "SELECT COUNT(*) FROM login_history";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting total visits: " + e.getMessage());
            return 0;
        }
    }
    
    private int getTodayVisits() throws SQLException {
        String sql = "SELECT COUNT(*) FROM login_history WHERE CAST(login_time AS DATE) = CAST(GETDATE() AS DATE)";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting today visits: " + e.getMessage());
            return 0;
        }
    }
    
    private int getActiveUsersThisWeek() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT user_id) FROM login_history WHERE login_time >= DATEADD(day, -7, GETDATE())";
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
    
    // ✅ JOB POSTING REPORTS
    private int getTotalJobPosts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting total job posts: " + e.getMessage());
            return 0;
        }
    }
    
    private int getActiveJobPosts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings WHERE status = 'open' AND (expires_at IS NULL OR expires_at > GETDATE())";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting active job posts: " + e.getMessage());
            return 0;
        }
    }
    
    private int getExpiredJobPosts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings WHERE status = 'closed' OR expires_at < GETDATE()";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting expired job posts: " + e.getMessage());
            return 0;
        }
    }
    
    private double getAverageApplicationsPerJob() throws SQLException {
        String sql = "SELECT AVG(CAST(app_count AS FLOAT)) FROM (SELECT COUNT(*) as app_count FROM applications GROUP BY job_posting_id) as avg_apps";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getDouble(1) : 0.0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting average applications per job: " + e.getMessage());
            return 0.0;
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
    private int getNewUsersLast30Days() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE created_at >= DATEADD(day, -30, GETDATE())";
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("❌ Error getting new users in last 30 days: " + e.getMessage());
            return 0;
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
        stats.put("bounceRate", 0);
        stats.put("totalActivities", 0);
        stats.put("newActivities", 0);
        stats.put("activeParticipants", 0);
        stats.put("totalJobPosts", 0);
        stats.put("activeJobPosts", 0);
        stats.put("expiredJobPosts", 0);
        stats.put("avgJobViews", 0);
        stats.put("avgApplications", 0);
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
}
