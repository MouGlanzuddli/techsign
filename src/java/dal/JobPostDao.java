/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;     // ✅ JDBC Connection
import java.sql.Statement;      // ✅ JDBC Statement
import java.sql.ResultSet;      // ✅ Để xử lý kết quả truy vấn
import java.sql.SQLException;   // ✅ Bắt lỗi khi thao tác DB

public class JobPostDao {
    private final Connection connection;

    public JobPostDao(Connection connection) {
        this.connection = connection;
    }

    public int getTotalJobPosts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings"; // table của bạn
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int getActiveJobPosts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings WHERE status = 'open' AND (expires_at IS NULL OR expires_at > GETDATE())";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int getExpiredJobPosts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings WHERE status = 'closed' OR expires_at < GETDATE()";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public double getAverageApplicationsPerJob() throws SQLException {
        String sql = "SELECT AVG(CAST(app_count AS FLOAT)) FROM (SELECT COUNT(*) as app_count FROM applications GROUP BY job_posting_id) as avg_apps";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        return 0.0;
    }

    public double getAverageJobViews() throws SQLException {
        String sql = "SELECT AVG(CAST(views AS FLOAT)) FROM job_postings WHERE views IS NOT NULL";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        return 0.0;
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
}

