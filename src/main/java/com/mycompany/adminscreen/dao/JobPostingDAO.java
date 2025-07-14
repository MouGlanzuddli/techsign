package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.JobPosting;
import com.mycompany.adminscreen.model.Category;
import com.mycompany.adminscreen.util.DBConnection;
import java.math.BigDecimal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobPostingDAO {

    public List<JobPosting> getAllJobPostingsForAdmin() {
        List<JobPosting> jobPostings = new ArrayList<>();
        String sql =
            "SELECT " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)) AS description, " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)) AS benefits, " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name, " +
            "STRING_AGG(c.name, ', ') AS category_names " +
            "FROM job_postings jp " +
            "LEFT JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
            "LEFT JOIN job_posting_categories jpc ON jp.id = jpc.job_posting_id " +
            "LEFT JOIN categories c ON jpc.category_id = c.id " +
            "GROUP BY " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)), " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)), " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name " +
            "ORDER BY jp.posted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                JobPosting jobPosting = mapResultSetToJobPosting(rs);
                jobPostings.add(jobPosting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobPostings;
    }

    public List<JobPosting> getJobPostingsByStatus(String status) {
        List<JobPosting> jobPostings = new ArrayList<>();
        String sql =
            "SELECT " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)) AS description, " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)) AS benefits, " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name, " +
            "STRING_AGG(c.name, ', ') as category_names " +
            "FROM job_postings jp " +
            "LEFT JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
            "LEFT JOIN job_posting_categories jpc ON jp.id = jpc.job_posting_id " +
            "LEFT JOIN categories c ON jpc.category_id = c.id " +
            "WHERE jp.status = ? " +
            "GROUP BY " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)), " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)), " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name " +
            "ORDER BY jp.posted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting jobPosting = mapResultSetToJobPosting(rs);
                jobPostings.add(jobPosting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobPostings;
    }

    public JobPosting getJobPostingById(int id) {
        String sql =
            "SELECT " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)) AS description, " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)) AS benefits, " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name, " +
            "STRING_AGG(c.name, ', ') as category_names " +
            "FROM job_postings jp " +
            "LEFT JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
            "LEFT JOIN job_posting_categories jpc ON jp.id = jpc.job_posting_id " +
            "LEFT JOIN categories c ON jpc.category_id = c.id " +
            "WHERE jp.id = ? " +
            "GROUP BY " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)), " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)), " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToJobPosting(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean updateJobPostingStatus(int id, String status) {
        String sql = "UPDATE job_postings SET status = ?, updated_at = GETDATE() WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, id);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteJobPosting(int id) {
        String deleteCategoriesSql = "DELETE FROM job_posting_categories WHERE job_posting_id = ?";
        String deleteJobSql = "DELETE FROM job_postings WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try {
                PreparedStatement stmt1 = conn.prepareStatement(deleteCategoriesSql);
                stmt1.setInt(1, id);
                stmt1.executeUpdate();

                PreparedStatement stmt2 = conn.prepareStatement(deleteJobSql);
                stmt2.setInt(1, id);
                int rowsAffected = stmt2.executeUpdate();

                conn.commit();
                return rowsAffected > 0;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT id, name, description, icon_url, created_at, updated_at FROM categories ORDER BY name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setIconUrl(rs.getString("icon_url"));

                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) category.setCreatedAt(createdAt.toLocalDateTime());

                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) category.setUpdatedAt(updatedAt.toLocalDateTime());

                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public List<JobPosting> getJobPostingsByCategory(String categoryName) {
        List<JobPosting> jobPostings = new ArrayList<>();
        String sql =
            "SELECT " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)) AS description, " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)) AS benefits, " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name, " +
            "STRING_AGG(c.name, ', ') as category_names " +
            "FROM job_postings jp " +
            "LEFT JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
            "LEFT JOIN job_posting_categories jpc ON jp.id = jpc.job_posting_id " +
            "LEFT JOIN categories c ON jpc.category_id = c.id " +
            "WHERE c.name = ? " +
            "GROUP BY " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)), " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)), " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name " +
            "ORDER BY jp.posted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, categoryName);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting jobPosting = mapResultSetToJobPosting(rs);
                jobPostings.add(jobPosting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobPostings;
    }

    public List<JobPosting> searchJobPostings(String searchTerm) {
        List<JobPosting> jobPostings = new ArrayList<>();
        String sql =
            "SELECT " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)) AS description, " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)) AS benefits, " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name, " +
            "STRING_AGG(c.name, ', ') as category_names " +
            "FROM job_postings jp " +
            "LEFT JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
            "LEFT JOIN job_posting_categories jpc ON jp.id = jpc.job_posting_id " +
            "LEFT JOIN categories c ON jpc.category_id = c.id " +
            "WHERE jp.title LIKE ? OR jp.description LIKE ? " +
            "GROUP BY " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)), " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)), " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name " +
            "ORDER BY jp.posted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting jobPosting = mapResultSetToJobPosting(rs);
                jobPostings.add(jobPosting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobPostings;
    }

    public JobPostingStats getJobPostingStats() {
        String sql =
            "SELECT " +
            "COUNT(*) as total, " +
            "SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending, " +
            "SUM(CASE WHEN status = 'approved' THEN 1 ELSE 0 END) as approved, " +
            "SUM(CASE WHEN status = 'rejected' THEN 1 ELSE 0 END) as rejected, " +
            "SUM(CASE WHEN status = 'open' THEN 1 ELSE 0 END) as open, " +
            "SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END) as closed " +
            "FROM job_postings";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return new JobPostingStats(
                    rs.getInt("total"),
                    rs.getInt("pending"),
                    rs.getInt("approved"),
                    rs.getInt("rejected"),
                    rs.getInt("open"),
                    rs.getInt("closed")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return new JobPostingStats(0, 0, 0, 0, 0, 0);
    }

    private JobPosting mapResultSetToJobPosting(ResultSet rs) throws SQLException {
        JobPosting jobPosting = new JobPosting();

        jobPosting.setId(rs.getInt("id"));
        jobPosting.setCompanyProfileId(rs.getInt("company_profile_id"));
        jobPosting.setTitle(rs.getString("title"));
        jobPosting.setDescription(rs.getString("description"));
        jobPosting.setLocation(rs.getString("location"));

        jobPosting.setSalaryMin(rs.getBigDecimal("salary_min"));
        jobPosting.setSalaryMax(rs.getBigDecimal("salary_max"));
        jobPosting.setJobType(rs.getString("job_type"));
        jobPosting.setBenefits(rs.getString("benefits"));
        jobPosting.setStatus(rs.getString("status"));

        Timestamp ts = rs.getTimestamp("posted_at");
        if (ts != null) jobPosting.setPostedAt(ts.toLocalDateTime());

        ts = rs.getTimestamp("expires_at");
        if (ts != null) jobPosting.setExpiresAt(ts.toLocalDateTime());

        jobPosting.setCompanyName(rs.getString("company_name"));
        jobPosting.setCategoryNames(rs.getString("category_names"));

        return jobPosting;
    }

    public List<JobPosting> getJobsByCompany(int companyId) {
        List<JobPosting> jobPostings = new ArrayList<>();
        String sql =
            "SELECT " +
            "jp.id, " +
            "jp.company_profile_id, " +
            "jp.title, " +
            "CAST(jp.description AS NVARCHAR(MAX)) AS description, " +
            "jp.location, " +
            "jp.salary_min, " +
            "jp.salary_max, " +
            "jp.job_type, " +
            "CAST(jp.benefits AS NVARCHAR(MAX)) AS benefits, " +
            "jp.status, " +
            "jp.posted_at, " +
            "jp.expires_at, " +
            "cp.company_name " +
            "FROM job_postings jp " +
            "LEFT JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
            "WHERE jp.company_profile_id = ? " +
            "ORDER BY jp.posted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, companyId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting jobPosting = mapResultSetToJobPosting(rs);
                jobPostings.add(jobPosting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobPostings;
    }

    public static class JobPostingStats {
        private int total, pending, approved, rejected, open, closed;

        public JobPostingStats(int total, int pending, int approved, int rejected, int open, int closed) {
            this.total = total;
            this.pending = pending;
            this.approved = approved;
            this.rejected = rejected;
            this.open = open;
            this.closed = closed;
        }

        public int getTotal() { return total; }
        public int getPending() { return pending; }
        public int getApproved() { return approved; }
        public int getRejected() { return rejected; }
        public int getOpen() { return open; }
        public int getClosed() { return closed; }
    }
}
