package dal;

import model.Job;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class JobDao {
private final Connection connection;

public JobDao(Connection connection) {
    this.connection = connection;
}

// Thêm job mới với xử lý null safety
public boolean insertJob(Job job) throws SQLException {
    String sql = "INSERT INTO jobs (company_id, title, description, requirements, benefits, " +
                "job_type, job_level, salary_min, salary_max, location, category, " +
                "experience_required, application_deadline, status, is_featured, is_urgent, " +
                "created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        // Đảm bảo createdAt và updatedAt không null
        Date now = new Date();
        if (job.getCreatedAt() == null) {
            job.setCreatedAt(now);
        }
        if (job.getUpdatedAt() == null) {
            job.setUpdatedAt(now);
        }
        
        stmt.setInt(1, job.getCompanyId());
        stmt.setString(2, job.getTitle());
        stmt.setString(3, job.getDescription());
        stmt.setString(4, job.getRequirements());
        stmt.setString(5, job.getBenefits());
        stmt.setString(6, job.getJobType());
        stmt.setString(7, job.getJobLevel());
        stmt.setBigDecimal(8, job.getSalaryMin());
        stmt.setBigDecimal(9, job.getSalaryMax());
        stmt.setString(10, job.getLocation());
        stmt.setString(11, job.getCategory());
        stmt.setInt(12, job.getExperienceRequired());
        stmt.setTimestamp(13, job.getApplicationDeadline() != null ? 
            new Timestamp(job.getApplicationDeadline().getTime()) : null);
        stmt.setString(14, job.getStatus() != null ? job.getStatus() : "active");
        stmt.setBoolean(15, job.isFeatured());
        stmt.setBoolean(16, job.isUrgent());
        stmt.setTimestamp(17, new Timestamp(job.getCreatedAt().getTime()));
        stmt.setTimestamp(18, new Timestamp(job.getUpdatedAt().getTime()));
        
        int result = stmt.executeUpdate();
        if (result > 0) {
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                job.setId(rs.getInt(1));
            }
            return true;
        }
    }
    return false;
}

// Lấy tất cả jobs của một công ty
public List<Job> getJobsByCompanyId(int companyId) throws SQLException {
    String sql = "SELECT * FROM jobs WHERE company_id = ? ORDER BY created_at DESC";
    List<Job> jobs = new ArrayList<>();
    
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, companyId);
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            jobs.add(mapResultSetToJob(rs));
        }
    }
    return jobs;
}

// Lấy job theo ID
public Job getJobById(int id) throws SQLException {
    String sql = "SELECT * FROM jobs WHERE id = ?";
    
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            return mapResultSetToJob(rs);
        }
    }
    return null;
}

// Cập nhật job
public boolean updateJob(Job job) throws SQLException {
    String sql = "UPDATE jobs SET title = ?, description = ?, requirements = ?, benefits = ?, " +
                "job_type = ?, job_level = ?, salary_min = ?, salary_max = ?, location = ?, " +
                "category = ?, experience_required = ?, application_deadline = ?, status = ?, " +
                "is_featured = ?, is_urgent = ?, updated_at = ? WHERE id = ? AND company_id = ?";
    
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        // Đảm bảo updatedAt không null
        if (job.getUpdatedAt() == null) {
            job.setUpdatedAt(new Date());
        }
        
        stmt.setString(1, job.getTitle());
        stmt.setString(2, job.getDescription());
        stmt.setString(3, job.getRequirements());
        stmt.setString(4, job.getBenefits());
        stmt.setString(5, job.getJobType());
        stmt.setString(6, job.getJobLevel());
        stmt.setBigDecimal(7, job.getSalaryMin());
        stmt.setBigDecimal(8, job.getSalaryMax());
        stmt.setString(9, job.getLocation());
        stmt.setString(10, job.getCategory());
        stmt.setInt(11, job.getExperienceRequired());
        stmt.setTimestamp(12, job.getApplicationDeadline() != null ? 
            new Timestamp(job.getApplicationDeadline().getTime()) : null);
        stmt.setString(13, job.getStatus());
        stmt.setBoolean(14, job.isFeatured());
        stmt.setBoolean(15, job.isUrgent());
        stmt.setTimestamp(16, new Timestamp(job.getUpdatedAt().getTime()));
        stmt.setInt(17, job.getId());
        stmt.setInt(18, job.getCompanyId());
        
        return stmt.executeUpdate() > 0;
    }
}

// Xóa job
public boolean deleteJob(int id, int companyId) throws SQLException {
    String sql = "DELETE FROM jobs WHERE id = ? AND company_id = ?";
    
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, id);
        stmt.setInt(2, companyId);
        return stmt.executeUpdate() > 0;
    }
}

// Thay đổi trạng thái job
public boolean updateJobStatus(int id, int companyId, String status) throws SQLException {
    String sql = "UPDATE jobs SET status = ?, updated_at = ? WHERE id = ? AND company_id = ?";
    
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setString(1, status);
        stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
        stmt.setInt(3, id);
        stmt.setInt(4, companyId);
        return stmt.executeUpdate() > 0;
    }
}

// Lấy tất cả jobs active (cho trang chủ)
public List<Job> getAllActiveJobs() throws SQLException {
    String sql = "SELECT * FROM jobs WHERE status = 'active' ORDER BY created_at DESC";
    List<Job> jobs = new ArrayList<>();
    
    try (Statement stmt = connection.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {
        
        while (rs.next()) {
            jobs.add(mapResultSetToJob(rs));
        }
    }
    return jobs;
}

// Helper method để map ResultSet về Job object với null safety
private Job mapResultSetToJob(ResultSet rs) throws SQLException {
    Job job = new Job();
    job.setId(rs.getInt("id"));
    job.setCompanyId(rs.getInt("company_id"));
    job.setTitle(rs.getString("title"));
    job.setDescription(rs.getString("description"));
    job.setRequirements(rs.getString("requirements"));
    job.setBenefits(rs.getString("benefits"));
    job.setJobType(rs.getString("job_type"));
    job.setJobLevel(rs.getString("job_level"));
    job.setSalaryMin(rs.getBigDecimal("salary_min"));
    job.setSalaryMax(rs.getBigDecimal("salary_max"));
    job.setLocation(rs.getString("location"));
    job.setCategory(rs.getString("category"));
    job.setExperienceRequired(rs.getInt("experience_required"));
    
    Timestamp deadline = rs.getTimestamp("application_deadline");
    job.setApplicationDeadline(deadline != null ? new Date(deadline.getTime()) : null);
    
    job.setStatus(rs.getString("status"));
    job.setFeatured(rs.getBoolean("is_featured"));
    job.setUrgent(rs.getBoolean("is_urgent"));
    job.setViewsCount(rs.getInt("views_count"));
    job.setApplicationsCount(rs.getInt("applications_count"));
    
    Timestamp createdAt = rs.getTimestamp("created_at");
    job.setCreatedAt(createdAt != null ? new Date(createdAt.getTime()) : new Date());
    
    Timestamp updatedAt = rs.getTimestamp("updated_at");
    job.setUpdatedAt(updatedAt != null ? new Date(updatedAt.getTime()) : new Date());
    
    return job;
}
}
