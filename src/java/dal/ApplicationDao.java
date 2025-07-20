package dal;

import model.Application;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class ApplicationDao {
    private final Connection connection;

    public ApplicationDao(Connection connection) {
        this.connection = connection;
    }

    // Thêm application mới
    public boolean insertApplication(Application application) throws SQLException {
        String sql = "INSERT INTO applications (job_posting_id, candidate_profile_id, cover_letter, " +
                    "cv_file_name, status, applied_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, application.getJobId());
            stmt.setInt(2, application.getCandidateId());
            stmt.setString(3, application.getCoverLetter());
            stmt.setString(4, application.getCvFileName());
            stmt.setString(5, application.getStatus());
            stmt.setTimestamp(6, new Timestamp(application.getAppliedAt().getTime()));
            stmt.setTimestamp(7, new Timestamp(application.getUpdatedAt().getTime()));
            
            return stmt.executeUpdate() > 0;
        }
    }

    // Kiểm tra đã ứng tuyển chưa
    public boolean hasApplied(int candidateId, int jobId) throws SQLException {
        String sql = "SELECT 1 FROM applications WHERE candidate_profile_id = ? AND job_posting_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, candidateId);
            stmt.setInt(2, jobId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    // Lấy applications theo job
    public List<Application> getApplicationsByJobId(int jobId) throws SQLException {
        String sql = "SELECT * FROM applications WHERE job_posting_id = ? ORDER BY applied_at DESC";
        List<Application> applications = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                applications.add(mapResultSetToApplication(rs));
            }
        }
        return applications;
    }

    // Lấy applications theo employer (company)
    public List<Application> getApplicationsByEmployerId(int employerId) throws SQLException {
        String sql = "SELECT a.* FROM applications a " +
                    "JOIN job_postings jp ON a.job_posting_id = jp.id " +
                    "JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
                    "WHERE cp.user_id = ? ORDER BY a.applied_at DESC";
        List<Application> applications = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                applications.add(mapResultSetToApplication(rs));
            }
        }
        return applications;
    }

    // Lấy recent applications theo employer
    public List<Application> getRecentApplicationsByEmployerId(int employerId, int limit) throws SQLException {
        String sql = "SELECT TOP (?) a.* FROM applications a " +
                    "JOIN job_postings jp ON a.job_posting_id = jp.id " +
                    "JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
                    "WHERE cp.user_id = ? ORDER BY a.applied_at DESC";
        List<Application> applications = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, employerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                applications.add(mapResultSetToApplication(rs));
            }
        }
        return applications;
    }

    // Lấy total applications theo employer
    public int getTotalApplicationsByEmployerId(int employerId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM applications a " +
                    "JOIN job_postings jp ON a.job_posting_id = jp.id " +
                    "JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
                    "WHERE cp.user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Lấy applications theo candidate
    public List<Application> getApplicationsByCandidateId(int candidateId) throws SQLException {
        String sql = "SELECT * FROM applications WHERE candidate_profile_id = ? ORDER BY applied_at DESC";
        List<Application> applications = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, candidateId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                applications.add(mapResultSetToApplication(rs));
            }
        }
        return applications;
    }

    // Cập nhật trạng thái application
    public boolean updateApplicationStatus(int applicationId, String status) throws SQLException {
        String sql = "UPDATE applications SET status = ?, updated_at = ? WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(3, applicationId);
            
            return stmt.executeUpdate() > 0;
        }
    }

    // Kiểm tra employer có thể truy cập CV không
    public boolean canEmployerAccessCV(int employerId, int applicationId) throws SQLException {
        String sql = "SELECT 1 FROM applications a " +
                    "JOIN job_postings jp ON a.job_posting_id = jp.id " +
                    "JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
                    "WHERE a.id = ? AND cp.user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, applicationId);
            stmt.setInt(2, employerId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    // Kiểm tra candidate có thể truy cập CV không
    public boolean canCandidateAccessCV(int candidateId, int applicationId) throws SQLException {
        String sql = "SELECT 1 FROM applications WHERE id = ? AND candidate_profile_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, applicationId);
            stmt.setInt(2, candidateId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    // Lấy application theo ID
    public Application getApplicationById(int applicationId) throws SQLException {
        String sql = "SELECT * FROM applications WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, applicationId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToApplication(rs);
            }
        }
        return null;
    }

    // Đếm số applications theo status cho employer
    public int countApplicationsByStatus(int employerId, String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM applications a " +
                    "JOIN job_postings jp ON a.job_posting_id = jp.id " +
                    "JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
                    "WHERE cp.user_id = ? AND a.status = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Helper method
    private Application mapResultSetToApplication(ResultSet rs) throws SQLException {
        Application application = new Application();
        application.setId(rs.getInt("id"));
        application.setJobId(rs.getInt("job_posting_id"));
        application.setCandidateId(rs.getInt("candidate_profile_id"));
        application.setCoverLetter(rs.getString("cover_letter"));
        application.setCvFileName(rs.getString("cv_file_name"));
        application.setStatus(rs.getString("status"));
        
        Timestamp appliedAt = rs.getTimestamp("applied_at");
        application.setAppliedAt(appliedAt != null ? new Date(appliedAt.getTime()) : new Date());
        
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        application.setUpdatedAt(updatedAt != null ? new Date(updatedAt.getTime()) : new Date());
        
        return application;
    }
}
