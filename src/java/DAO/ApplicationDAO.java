/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import connectDB.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Application;
import java.sql.*;

/**
 *
 * @author Thien An
 */
public class ApplicationDAO {

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
}
