package dal;

import model.JobView;
import model.User;
import model.CandidateProfile;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * JobViewDao: Data Access Object cho bảng job_views
 * Quản lý việc lưu và truy xuất thông tin candidate views
 */
public class JobViewDao {
    private Connection connection;

    public JobViewDao(Connection connection) {
        this.connection = connection;
    }

    /**
     * Lưu thông tin khi candidate xem job posting
     */
    public boolean saveJobView(JobView jobView) {
        String sql = "INSERT INTO job_views (job_posting_id, candidate_user_id, viewed_at, ip_address, user_agent, session_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobView.getJobPostingId());
            stmt.setInt(2, jobView.getCandidateUserId());
            stmt.setTimestamp(3, jobView.getViewedAt());
            stmt.setString(4, jobView.getIpAddress());
            stmt.setString(5, jobView.getUserAgent());
            stmt.setString(6, jobView.getSessionId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error saving job view: " + e.getMessage());
            return false;
        }
    }

    /**
     * Kiểm tra xem candidate đã xem job này chưa (trong 24h gần nhất)
     */
    public boolean hasViewedRecently(int jobPostingId, int candidateUserId) {
        String sql = "SELECT COUNT(*) FROM job_views " +
                     "WHERE job_posting_id = ? AND candidate_user_id = ? " +
                     "AND viewed_at >= DATEADD(hour, -24, GETDATE())";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobPostingId);
            stmt.setInt(2, candidateUserId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking recent view: " + e.getMessage());
        }
        return false;
    }

    /**
     * Lấy danh sách candidates đã xem job postings của company
     */
    public List<JobView> getCandidatesViewedCompanyJobs(int companyUserId, int limit) {
        String sql = "SELECT DISTINCT jv.*, u.*, cp.* " +
                     "FROM job_views jv " +
                     "INNER JOIN job_postings jp ON jv.job_posting_id = jp.id " +
                     "INNER JOIN users u ON jv.candidate_user_id = u.id " +
                     "LEFT JOIN candidate_profiles cp ON u.id = cp.user_id " +
                     "WHERE jp.company_profile_id IN (SELECT id FROM company_profiles WHERE user_id = ?) " +
                     "AND u.role_id = 2 " + // Chỉ lấy candidates (role_id = 2)
                     "ORDER BY jv.viewed_at DESC " +
                     (limit > 0 ? "OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY" : "");
        
        List<JobView> jobViews = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, companyUserId);
            if (limit > 0) {
                stmt.setInt(2, limit);
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                JobView jobView = mapResultSetToJobView(rs);
                jobViews.add(jobView);
            }
        } catch (SQLException e) {
            System.err.println("Error getting candidates viewed company jobs: " + e.getMessage());
        }
        
        return jobViews;
    }

    /**
     * Lấy danh sách candidates đã xem một job posting cụ thể
     */
    public List<JobView> getCandidatesViewedJob(int jobPostingId, int limit) {
        String sql = "SELECT jv.*, u.*, cp.* " +
                     "FROM job_views jv " +
                     "INNER JOIN users u ON jv.candidate_user_id = u.id " +
                     "LEFT JOIN candidate_profiles cp ON u.id = cp.user_id " +
                     "WHERE jv.job_posting_id = ? " +
                     "AND u.role_id = 2 " + // Chỉ lấy candidates
                     "ORDER BY jv.viewed_at DESC " +
                     (limit > 0 ? "OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY" : "");
        
        List<JobView> jobViews = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobPostingId);
            if (limit > 0) {
                stmt.setInt(2, limit);
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                JobView jobView = mapResultSetToJobView(rs);
                jobViews.add(jobView);
            }
        } catch (SQLException e) {
            System.err.println("Error getting candidates viewed job: " + e.getMessage());
        }
        
        return jobViews;
    }

    /**
     * Lấy thống kê views theo ngày cho company
     */
    public List<Object[]> getViewsStatisticsByDate(int companyUserId, int days) {
        String sql = "SELECT CAST(jv.viewed_at AS DATE) as view_date, COUNT(*) as view_count " +
                     "FROM job_views jv " +
                     "INNER JOIN job_postings jp ON jv.job_posting_id = jp.id " +
                     "WHERE jp.company_profile_id IN (SELECT id FROM company_profiles WHERE user_id = ?) " +
                     "AND jv.viewed_at >= DATEADD(day, -?, GETDATE()) " +
                     "GROUP BY CAST(jv.viewed_at AS DATE) " +
                     "ORDER BY view_date DESC";
        
        List<Object[]> statistics = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, companyUserId);
            stmt.setInt(2, days);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Object[] stat = new Object[2];
                stat[0] = rs.getDate("view_date");
                stat[1] = rs.getInt("view_count");
                statistics.add(stat);
            }
        } catch (SQLException e) {
            System.err.println("Error getting views statistics: " + e.getMessage());
        }
        
        return statistics;
    }

    /**
     * Map ResultSet thành JobView object
     */
    private JobView mapResultSetToJobView(ResultSet rs) throws SQLException {
        JobView jobView = new JobView();
        jobView.setId(rs.getInt("id"));
        jobView.setJobPostingId(rs.getInt("job_posting_id"));
        jobView.setCandidateUserId(rs.getInt("candidate_user_id"));
        jobView.setViewedAt(rs.getTimestamp("viewed_at"));
        jobView.setIpAddress(rs.getString("ip_address"));
        jobView.setUserAgent(rs.getString("user_agent"));
        jobView.setSessionId(rs.getString("session_id"));

        // Map User information
        User user = new User();
        user.setId(rs.getInt("candidate_user_id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setRoleId(rs.getInt("role_id"));
        user.setStatus(rs.getString("status"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        jobView.setCandidateUser(user);

        // Map CandidateProfile information (nếu có)
        if (rs.getObject("cp.id") != null) {
            CandidateProfile profile = new CandidateProfile();
            profile.setId(rs.getInt("cp.id"));
            profile.setUserId(rs.getInt("cp.user_id"));
            profile.setHeadline(rs.getString("cp.headline"));
            profile.setSummary(rs.getString("cp.summary"));
            profile.setExperienceYears(rs.getInt("cp.experience_years"));
            profile.setEducationLevel(rs.getString("cp.education_level"));
            profile.setProfilePictureUrl(rs.getString("cp.profile_picture_url"));
            profile.setAiScore(rs.getFloat("cp.ai_score"));
            profile.setAiFeedback(rs.getString("cp.ai_feedback"));
            profile.setIsSearchable(rs.getBoolean("cp.is_searchable"));
            profile.setCreatedAt(rs.getTimestamp("cp.created_at"));
            profile.setUpdatedAt(rs.getTimestamp("cp.updated_at"));
            jobView.setCandidateProfile(profile);
        }

        return jobView;
    }
} 