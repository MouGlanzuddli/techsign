package dal;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.JobPosting;

public class JobPostingDao {
    private final Connection connection;

    public JobPostingDao(Connection connection) {
        this.connection = connection;
    }

    // Thêm constructor mới để tương thích với DBContext
    public JobPostingDao() throws SQLException {
        DBContext dbContext = new DBContext();
        this.connection = dbContext.getConnection();
    }

    public int insertJobPosting(JobPosting job) throws SQLException {
        String sql = "INSERT INTO job_postings (company_profile_id, title, description, location, "
                + "salary_min, salary_max, job_type, benefits, status, posted_at, expires_at, "
                + "job_category, job_level, experience, qualification, gender, job_fee_type, "
                + "permanent_address, temporary_address, country, state_city, zip_code, video_url, "
                + "latitude, longitude, skills) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            int paramIndex = 1;
            stmt.setInt(paramIndex++, job.getCompanyProfileId());
            stmt.setString(paramIndex++, job.getTitle());
            stmt.setString(paramIndex++, job.getDescription());
            stmt.setString(paramIndex++, job.getLocation());
            stmt.setBigDecimal(paramIndex++, job.getSalaryMin());
            stmt.setBigDecimal(paramIndex++, job.getSalaryMax());
            stmt.setString(paramIndex++, job.getJobType());
            stmt.setString(paramIndex++, job.getBenefits());
            stmt.setString(paramIndex++, job.getStatus());
            stmt.setTimestamp(paramIndex++, new Timestamp(job.getPostedAt().getTime()));
            if (job.getExpiresAt() != null) {
                stmt.setTimestamp(paramIndex++, new Timestamp(job.getExpiresAt().getTime()));
            } else {
                stmt.setNull(paramIndex++, Types.TIMESTAMP);
            }
            
            // Các trường mới
            stmt.setString(paramIndex++, job.getJobCategory());
            stmt.setString(paramIndex++, job.getJobLevel());
            stmt.setString(paramIndex++, job.getExperience());
            stmt.setString(paramIndex++, job.getQualification());
            stmt.setString(paramIndex++, job.getGender());
            stmt.setString(paramIndex++, job.getJobFeeType());
            stmt.setString(paramIndex++, job.getPermanentAddress());
            stmt.setString(paramIndex++, job.getTemporaryAddress());
            stmt.setString(paramIndex++, job.getCountry());
            stmt.setString(paramIndex++, job.getStateCity());
            stmt.setString(paramIndex++, job.getZipCode());
            stmt.setString(paramIndex++, job.getVideoUrl());
            stmt.setString(paramIndex++, job.getLatitude());
            stmt.setString(paramIndex++, job.getLongitude());
            stmt.setString(paramIndex++, job.getSkills());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        }
        return -1;
    }

    public JobPosting getJobPostingById(int id) throws SQLException {
        String sql = "SELECT * FROM job_postings WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToJobPosting(rs);
            }
        }
        return null;
    }

    public List<JobPosting> getJobPostingsByCompany(int companyProfileId) throws SQLException {
        String sql = "SELECT * FROM job_postings WHERE company_profile_id = ? ORDER BY posted_at DESC";
        List<JobPosting> jobs = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, companyProfileId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                jobs.add(mapResultSetToJobPosting(rs));
            }
        }
        return jobs;
    }

    // Add method to get jobs with additional filtering
    public List<JobPosting> getJobPostingsByCompanyWithFilter(int companyProfileId, String status, String searchQuery) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM job_postings WHERE company_profile_id = ?");

        if (status != null && !status.equals("all")) {
            switch (status) {
                case "active":
                    sql.append(" AND status = 'open' AND (expires_at IS NULL OR expires_at > GETDATE())");
                    break;
                case "expired":
                    sql.append(" AND expires_at IS NOT NULL AND expires_at < GETDATE()");
                    break;
                case "draft":
                    sql.append(" AND status = 'draft'");
                    break;
            }
        }

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR description LIKE ? OR skills LIKE ?)");
        }

        sql.append(" ORDER BY posted_at DESC");

        List<JobPosting> jobs = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            stmt.setInt(paramIndex++, companyProfileId);

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String searchPattern = "%" + searchQuery + "%";
                stmt.setString(paramIndex++, searchPattern);
                stmt.setString(paramIndex++, searchPattern);
                stmt.setString(paramIndex++, searchPattern);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                jobs.add(mapResultSetToJobPosting(rs));
            }
        }
        return jobs;
    }

    public boolean updateJobPosting(JobPosting job) throws SQLException {
        String sql = "UPDATE job_postings SET title = ?, description = ?, location = ?, "
                + "salary_min = ?, salary_max = ?, job_type = ?, benefits = ?, status = ?, "
                + "expires_at = ?, job_category = ?, job_level = ?, experience = ?, "
                + "qualification = ?, gender = ?, job_fee_type = ?, permanent_address = ?, "
                + "temporary_address = ?, country = ?, state_city = ?, zip_code = ?, "
                + "video_url = ?, latitude = ?, longitude = ?, skills = ? WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            stmt.setString(paramIndex++, job.getTitle());
            stmt.setString(paramIndex++, job.getDescription());
            stmt.setString(paramIndex++, job.getLocation());
            stmt.setBigDecimal(paramIndex++, job.getSalaryMin());
            stmt.setBigDecimal(paramIndex++, job.getSalaryMax());
            stmt.setString(paramIndex++, job.getJobType());
            stmt.setString(paramIndex++, job.getBenefits());
            stmt.setString(paramIndex++, job.getStatus());
            if (job.getExpiresAt() != null) {
                stmt.setTimestamp(paramIndex++, new Timestamp(job.getExpiresAt().getTime()));
            } else {
                stmt.setNull(paramIndex++, Types.TIMESTAMP);
            }
            
            // Các trường mới
            stmt.setString(paramIndex++, job.getJobCategory());
            stmt.setString(paramIndex++, job.getJobLevel());
            stmt.setString(paramIndex++, job.getExperience());
            stmt.setString(paramIndex++, job.getQualification());
            stmt.setString(paramIndex++, job.getGender());
            stmt.setString(paramIndex++, job.getJobFeeType());
            stmt.setString(paramIndex++, job.getPermanentAddress());
            stmt.setString(paramIndex++, job.getTemporaryAddress());
            stmt.setString(paramIndex++, job.getCountry());
            stmt.setString(paramIndex++, job.getStateCity());
            stmt.setString(paramIndex++, job.getZipCode());
            stmt.setString(paramIndex++, job.getVideoUrl());
            stmt.setString(paramIndex++, job.getLatitude());
            stmt.setString(paramIndex++, job.getLongitude());
            stmt.setString(paramIndex++, job.getSkills());
            stmt.setInt(paramIndex++, job.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteJobPosting(int id) throws SQLException {
        String sql = "DELETE FROM job_postings WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private JobPosting mapResultSetToJobPosting(ResultSet rs) throws SQLException {
        JobPosting job = new JobPosting();
        job.setId(rs.getInt("id"));
        job.setCompanyProfileId(rs.getInt("company_profile_id"));
        job.setTitle(rs.getString("title"));
        job.setDescription(rs.getString("description"));
        job.setLocation(rs.getString("location"));
        job.setSalaryMin(rs.getBigDecimal("salary_min"));
        job.setSalaryMax(rs.getBigDecimal("salary_max"));
        job.setJobType(rs.getString("job_type"));
        job.setBenefits(rs.getString("benefits"));
        job.setStatus(rs.getString("status"));
        job.setPostedAt(rs.getTimestamp("posted_at"));
        job.setExpiresAt(rs.getTimestamp("expires_at"));
        
        // Các trường mới
        job.setJobCategory(rs.getString("job_category"));
        job.setJobLevel(rs.getString("job_level"));
        job.setExperience(rs.getString("experience"));
        job.setQualification(rs.getString("qualification"));
        job.setGender(rs.getString("gender"));
        job.setJobFeeType(rs.getString("job_fee_type"));
        job.setPermanentAddress(rs.getString("permanent_address"));
        job.setTemporaryAddress(rs.getString("temporary_address"));
        job.setCountry(rs.getString("country"));
        job.setStateCity(rs.getString("state_city"));
        job.setZipCode(rs.getString("zip_code"));
        job.setVideoUrl(rs.getString("video_url"));
        job.setLatitude(rs.getString("latitude"));
        job.setLongitude(rs.getString("longitude"));
        job.setSkills(rs.getString("skills"));
        
        return job;
    }

    // Thêm method để đóng connection
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
