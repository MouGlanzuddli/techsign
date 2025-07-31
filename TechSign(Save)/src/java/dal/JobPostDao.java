/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;     // ✅ JDBC Connection
import java.sql.Statement;      // ✅ JDBC Statement
import java.sql.ResultSet;      // ✅ Để xử lý kết quả truy vấn
import java.sql.SQLException;   // ✅ Bắt lỗi khi thao tác DB
import model.JobPost;
import java.util.List;
import java.util.ArrayList;

public class JobPostDao {
    private final Connection connection;

    public JobPostDao(Connection connection) {
        this.connection = connection;
    }

    // Helper: Lọc theo tháng/năm
    private String getMonthFilter(String dateCol, int monthOffset) {
        // monthOffset = 0: tháng này, -1: tháng trước
        return "MONTH(" + dateCol + ") = MONTH(DATEADD(month, " + monthOffset + ", GETDATE())) " +
               "AND YEAR(" + dateCol + ") = YEAR(DATEADD(month, " + monthOffset + ", GETDATE()))";
    }

    // Helper: Lọc theo tháng/năm cho bảng applications
    private String getMonthFilterApplications(String dateCol, int monthOffset) {
        return "MONTH(" + dateCol + ") = MONTH(DATEADD(month, " + monthOffset + ", GETDATE())) " +
               "AND YEAR(" + dateCol + ") = YEAR(DATEADD(month, " + monthOffset + ", GETDATE()))";
    }

    // Tổng số tin trong tháng (monthOffset=0: tháng này, -1: tháng trước)
    public int getTotalJobPosts(int monthOffset) throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings WHERE " + getMonthFilter("posted_at", monthOffset);
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Số tin hoạt động trong tháng
    public int getActiveJobPosts(int monthOffset) throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings WHERE status = 'active' AND (expires_at IS NULL OR expires_at > GETDATE()) AND " + getMonthFilter("posted_at", monthOffset);
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Số tin hết hạn trong tháng
    public int getExpiredJobPosts(int monthOffset) throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings WHERE (status = 'closed' OR expires_at < GETDATE()) AND " + getMonthFilter("posted_at", monthOffset);
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Lượt xem TB trong tháng (làm tròn)
    public int getAverageJobViews(int monthOffset) throws SQLException {
        String sql = "SELECT ROUND(AVG(CAST(views AS FLOAT)), 0) FROM job_postings WHERE views IS NOT NULL AND " + getMonthFilter("posted_at", monthOffset);
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Ứng viên TB/tin trong tháng (làm tròn)
    public int getAverageApplicationsPerJob(int monthOffset) throws SQLException {
        // Chỉ tính các job_postings trong tháng đó
        String sql = "SELECT ROUND(AVG(app_count), 0) FROM ( " +
                "SELECT COUNT(a.id) as app_count FROM job_postings jp " +
                "LEFT JOIN applications a ON a.job_posting_id = jp.id " +
                "WHERE " + getMonthFilter("jp.posted_at", monthOffset) + " GROUP BY jp.id ) t";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Số tin hoạt động tổng (không lọc theo tháng)
    public int getActiveJobPostsTotal() throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings WHERE status = 'active' AND (expires_at IS NULL OR expires_at > GETDATE())";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Tổng số đơn ứng tuyển trong tháng
    public int getTotalApplications(int monthOffset) throws SQLException {
        String sql = "SELECT COUNT(*) FROM applications WHERE " + getMonthFilterApplications("applied_at", monthOffset);
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Số đơn approved trong tháng
    public int getApprovedApplications(int monthOffset) throws SQLException {
        String sql = "SELECT COUNT(*) FROM applications WHERE status = 'approved' AND " + getMonthFilterApplications("applied_at", monthOffset);
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Số đơn rejected trong tháng
    public int getRejectedApplications(int monthOffset) throws SQLException {
        String sql = "SELECT COUNT(*) FROM applications WHERE status = 'rejected' AND " + getMonthFilterApplications("applied_at", monthOffset);
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Số đơn ứng tuyển đang chờ xử lý trong tháng
    public int getPendingApplications(int monthOffset) throws SQLException {
        String sql = "SELECT COUNT(*) FROM applications WHERE status = 'pending' AND " + getMonthFilterApplications("applied_at", monthOffset);
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public java.util.List<java.util.Map<String, Object>> getNewJobPostsByDate(String from, String to) throws SQLException {
        String sql = "SELECT CAST(posted_at AS DATE) as date, COUNT(*) as count FROM job_postings WHERE posted_at >= ? AND posted_at <= ? GROUP BY CAST(posted_at AS DATE) ORDER BY date";
        java.util.List<java.util.Map<String, Object>> result = new java.util.ArrayList<>();
        try (var ps = connection.prepareStatement(sql)) {
            ps.setString(1, from);
            ps.setString(2, to);
            try (var rs = ps.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, Object> row = new java.util.HashMap<>();
                    row.put("date", rs.getString("date"));
                    row.put("count", rs.getInt("count"));
                    result.add(row);
                }
            }
        }
        return result;
    }

    // Top 10 tin hoạt động trong tháng có lượt xem nhiều nhất
    public List<JobPost> getTop10MostViewedActivePostsThisMonth() throws SQLException {
        String sql = "SELECT TOP 10 id, title, views FROM job_postings " +
                "WHERE status = 'active' AND (expires_at IS NULL OR expires_at > GETDATE()) " +
                "AND MONTH(posted_at) = MONTH(GETDATE()) AND YEAR(posted_at) = YEAR(GETDATE()) " +
                "ORDER BY views DESC, id ASC";
        List<JobPost> list = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                JobPost jp = new JobPost();
                jp.setId(rs.getInt("id"));
                jp.setTitle(rs.getString("title"));
                jp.setViews(rs.getInt("views"));
                jp.setApplyCount(0); // chưa cần
                list.add(jp);
            }
        }
        return list;
    }

    // Top 10 tin hoạt động trong tháng có nhiều lượt ứng tuyển nhất
    public List<JobPost> getTop10MostAppliedActivePostsThisMonth() throws SQLException {
        String sql = "SELECT TOP 10 jp.id, jp.title, jp.views, COUNT(a.id) AS apply_count " +
                "FROM job_postings jp " +
                "LEFT JOIN applications a ON a.job_posting_id = jp.id " +
                "WHERE jp.status = 'active' AND (jp.expires_at IS NULL OR jp.expires_at > GETDATE()) " +
                "AND MONTH(jp.posted_at) = MONTH(GETDATE()) AND YEAR(jp.posted_at) = YEAR(GETDATE()) " +
                "GROUP BY jp.id, jp.title, jp.views " +
                "ORDER BY apply_count DESC, jp.id ASC";
        List<JobPost> list = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                JobPost jp = new JobPost();
                jp.setId(rs.getInt("id"));
                jp.setTitle(rs.getString("title"));
                jp.setViews(rs.getInt("views"));
                jp.setApplyCount(rs.getInt("apply_count"));
                list.add(jp);
            }
        }
        return list;
    }
}

