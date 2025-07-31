package dal;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Application;
import java.sql.*;

public class ApplicationDAO {
    private final Connection connection;

    public ApplicationDAO(Connection connection) {
        this.connection = connection;
    }
    public List<Application> searchAppliedJobs(int candidateProfileId, String keyword, String jobType, String city) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.id, a.job_posting_id, a.status, a.applied_at, "
                + "j.title, j.job_type, j.location, j.posted_at, "
                + "c.company_name, c.logo_url "
                + "FROM applications a "
                + "JOIN job_postings j ON a.job_posting_id = j.id "
                + "JOIN company_profiles c ON j.company_profile_id = c.id "
                + "WHERE a.candidate_profile_id = ? "
                + "AND a.status IN ('pending', 'approved') "
                + "AND j.title LIKE ? "
                + "AND j.job_type LIKE ? "
                + "AND j.location LIKE ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, candidateProfileId);
            stmt.setString(2, "%" + (keyword != null ? keyword : "") + "%");
            stmt.setString(3, "%" + (jobType != null ? jobType : "") + "%");
            stmt.setString(4, "%" + (city != null ? city : "") + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setJobId(rs.getInt("job_posting_id"));
                app.setJobTitle(rs.getString("title"));
                app.setJobType(rs.getString("job_type"));
                app.setCompanyName(rs.getString("company_name"));
                app.setLocation(rs.getString("location"));
                app.setPostedAt(rs.getTimestamp("posted_at"));
                app.setAppliedAt(rs.getTimestamp("applied_at"));
                app.setStatus(rs.getString("status"));
                app.setLogoUrl(rs.getString("logo_url"));
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteApplicationById(int appId) {
        String sql = "DELETE FROM applications WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, appId);
            int affected = stmt.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteBookmark(int userId, int jobId) {
        String sql = "DELETE FROM bookmarks WHERE user_id = ? AND job_posting_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, jobId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean hasApplied(int profileId, int jobId) {
        try (Connection conn = new DBContext().getConnection()) {
            String sql = "SELECT id FROM applications WHERE candidate_profile_id = ? AND job_posting_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, profileId);
            ps.setInt(2, jobId);
            ResultSet rs = ps.executeQuery();
            boolean exists = rs.next();
            rs.close();
            ps.close();
            return exists;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<Application> getAppliedJobsWithPagination(int candidateProfileId, int page, int limit) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.id, a.job_posting_id, a.status, a.applied_at, "
                + "j.title, j.job_type, j.location, j.posted_at, "
                + "c.company_name, c.logo_url "
                + "FROM applications a "
                + "JOIN job_postings j ON a.job_posting_id = j.id "
                + "JOIN company_profiles c ON j.company_profile_id = c.id "
                + "WHERE a.candidate_profile_id = ? AND a.status IN ('pending', 'approved', 'Not Approved') "
                + "ORDER BY a.applied_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidateProfileId);
            stmt.setInt(2, (page - 1) * limit);
            stmt.setInt(3, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setJobId(rs.getInt("job_posting_id"));
                app.setJobTitle(rs.getString("title"));
                app.setJobType(rs.getString("job_type"));
                app.setCompanyName(rs.getString("company_name"));
                app.setLocation(rs.getString("location"));
                app.setPostedAt(rs.getTimestamp("posted_at"));
                app.setAppliedAt(rs.getTimestamp("applied_at"));
                app.setStatus(rs.getString("status"));
                app.setLogoUrl(rs.getString("logo_url"));
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countTotalAppliedJobs(int candidateProfileId) {
        String sql = "SELECT COUNT(*) FROM applications WHERE candidate_profile_id = ? AND status IN ('pending', 'approved')";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidateProfileId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Thêm application mới
    public boolean insertApplication(Application application) throws SQLException {
        String sql = "INSERT INTO applications (job_posting_id, candidate_profile_id, cover_letter, "
                + "cv_file_name, status, applied_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)";

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
        String sql = "SELECT a.* FROM applications a "
                + "JOIN job_postings jp ON a.job_posting_id = jp.id "
                + "JOIN company_profiles cp ON jp.company_profile_id = cp.id "
                + "WHERE cp.user_id = ? ORDER BY a.applied_at DESC";
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
        String sql = "SELECT TOP (?) a.* FROM applications a "
                + "JOIN job_postings jp ON a.job_posting_id = jp.id "
                + "JOIN company_profiles cp ON jp.company_profile_id = cp.id "
                + "WHERE cp.user_id = ? ORDER BY a.applied_at DESC";
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
        String sql = "SELECT COUNT(*) FROM applications a "
                + "JOIN job_postings jp ON a.job_posting_id = jp.id "
                + "JOIN company_profiles cp ON jp.company_profile_id = cp.id "
                + "WHERE cp.user_id = ?";

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
        String sql = "SELECT 1 FROM applications a "
                + "JOIN job_postings jp ON a.job_posting_id = jp.id "
                + "JOIN company_profiles cp ON jp.company_profile_id = cp.id "
                + "WHERE a.id = ? AND cp.user_id = ?";

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
        String sql = "SELECT COUNT(*) FROM applications a "
                + "JOIN job_postings jp ON a.job_posting_id = jp.id "
                + "JOIN company_profiles cp ON jp.company_profile_id = cp.id "
                + "WHERE cp.user_id = ? AND a.status = ?";

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
        application.setAppliedAt(appliedAt);

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        application.setUpdatedAt(updatedAt != null ? new java.util.Date(updatedAt.getTime()) : new java.util.Date());

        // Bổ sung các trường từ bảng job_postings hoặc company_profiles nếu có
        try {
            application.setJobTitle(rs.getString("title")); // alias nếu có
            application.setJobType(rs.getString("job_type"));
            application.setCompanyName(rs.getString("company_name"));
            application.setLocation(rs.getString("location"));
            application.setPostedAt(rs.getTimestamp("posted_at"));
            application.setLogoUrl(rs.getString("logo_url"));
        } catch (SQLException ignored) {
            // Trong trường hợp các cột này không có trong ResultSet
        }

        return application;
    }
}


