package dal;

import model.JobPosting;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobPostingDao {
    private final Connection connection;

    public JobPostingDao(Connection connection) {
        this.connection = connection;
    }

    public boolean insertJobPosting(JobPosting job) throws SQLException {
        String sql = "INSERT INTO job_postings (company_profile_id, title, description, location, " +
                    "salary_min, salary_max, job_type, benefits, status, posted_at, expires_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, job.getCompanyProfileId());
            stmt.setString(2, job.getTitle());
            stmt.setString(3, job.getDescription());
            stmt.setString(4, job.getLocation());
            
            if (job.getSalaryMin() != null) {
                stmt.setBigDecimal(5, job.getSalaryMin());
            } else {
                stmt.setNull(5, Types.DECIMAL);
            }
            
            if (job.getSalaryMax() != null) {
                stmt.setBigDecimal(6, job.getSalaryMax());
            } else {
                stmt.setNull(6, Types.DECIMAL);
            }
            
            stmt.setString(7, job.getJobType());
            stmt.setString(8, job.getBenefits());
            stmt.setString(9, job.getStatus());
            stmt.setTimestamp(10, new Timestamp(job.getPostedAt().getTime()));
            
            if (job.getExpiresAt() != null) {
                stmt.setTimestamp(11, new Timestamp(job.getExpiresAt().getTime()));
            } else {
                stmt.setNull(11, Types.TIMESTAMP);
            }
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    job.setId(rs.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    public boolean addJobSkills(int jobId, String[] skills) throws SQLException {
        // First, get or create skills
        String getSkillSql = "SELECT id FROM skills WHERE name = ?";
        String insertSkillSql = "INSERT INTO skills (name) VALUES (?)";
        String linkSkillSql = "INSERT INTO job_required_skills (job_posting_id, skill_id) VALUES (?, ?)";
        
        try {
            for (String skillName : skills) {
                skillName = skillName.trim();
                if (skillName.isEmpty()) continue;
                
                int skillId = 0;
                
                // Check if skill exists
                try (PreparedStatement getStmt = connection.prepareStatement(getSkillSql)) {
                    getStmt.setString(1, skillName);
                    ResultSet rs = getStmt.executeQuery();
                    
                    if (rs.next()) {
                        skillId = rs.getInt("id");
                    } else {
                        // Create new skill
                        try (PreparedStatement insertStmt = connection.prepareStatement(insertSkillSql, Statement.RETURN_GENERATED_KEYS)) {
                            insertStmt.setString(1, skillName);
                            insertStmt.executeUpdate();
                            
                            ResultSet generatedKeys = insertStmt.getGeneratedKeys();
                            if (generatedKeys.next()) {
                                skillId = generatedKeys.getInt(1);
                            }
                        }
                    }
                }
                
                // Link skill to job
                if (skillId > 0) {
                    try (PreparedStatement linkStmt = connection.prepareStatement(linkSkillSql)) {
                        linkStmt.setInt(1, jobId);
                        linkStmt.setInt(2, skillId);
                        linkStmt.executeUpdate();
                    } catch (SQLException e) {
                        // Ignore duplicate key errors
                        if (!e.getMessage().contains("duplicate") && !e.getMessage().contains("UNIQUE")) {
                            throw e;
                        }
                    }
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addJobCategory(int jobId, int categoryId) throws SQLException {
        String sql = "INSERT INTO job_posting_categories (job_posting_id, category_id) VALUES (?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobId);
            stmt.setInt(2, categoryId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            // Ignore duplicate key errors
            if (e.getMessage().contains("duplicate") || e.getMessage().contains("UNIQUE")) {
                return true;
            }
            throw e;
        }
    }

    public List<JobPosting> getJobsByCompany(int companyProfileId) throws SQLException {
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

    public JobPosting getJobById(int jobId) throws SQLException {
        String sql = "SELECT * FROM job_postings WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToJobPosting(rs);
            }
        }
        
        return null;
    }

    public boolean updateJobStatus(int jobId, String status) throws SQLException {
        String sql = "UPDATE job_postings SET status = ? WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, jobId);
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
        return job;
    }
}
