package dal;

import model.Candidate;
import java.sql.*;

public class CandidateDAO {
    private final Connection conn;

    public CandidateDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean createCandidate(Candidate candidate) throws SQLException {
        String sql = "INSERT INTO candidate_profiles (user_id, full_name, job_title, experience_years, education_level, address, email, is_searchable, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidate.getUserId());
            stmt.setString(2, candidate.getFullName());
            stmt.setString(3, candidate.getJobTitle());
            stmt.setInt(4, candidate.getExperienceYears());
            stmt.setString(5, candidate.getEducationLevel());
            stmt.setString(6, candidate.getAddress());
            stmt.setString(7, candidate.getEmail());
            stmt.setBoolean(8, candidate.isSearchable());
            stmt.setTimestamp(9, new Timestamp(candidate.getCreatedAt().getTime()));
            stmt.setTimestamp(10, new Timestamp(candidate.getUpdatedAt().getTime()));
            return stmt.executeUpdate() > 0;
        }
    }

    public Candidate getCandidateByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM candidate_profiles WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCandidate(rs);
                }
            }
        }
        return null;
    }

    public boolean updateCandidate(Candidate candidate) throws SQLException {
        String sql = "UPDATE candidate_profiles SET full_name = ?, job_title = ?, experience_years = ?, education_level = ?, address = ?, email = ?, is_searchable = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, candidate.getFullName());
            stmt.setString(2, candidate.getJobTitle());
            stmt.setInt(3, candidate.getExperienceYears());
            stmt.setString(4, candidate.getEducationLevel());
            stmt.setString(5, candidate.getAddress());
            stmt.setString(6, candidate.getEmail());
            stmt.setBoolean(7, candidate.isSearchable());
            stmt.setTimestamp(8, new Timestamp(candidate.getUpdatedAt().getTime()));
            stmt.setInt(9, candidate.getUserId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteCandidate(int userId) throws SQLException {
        String sql = "DELETE FROM candidate_profiles WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean toggleProfileVisibility(int userId, boolean isSearchable) throws SQLException {
        String sql = "UPDATE candidate_profiles SET is_searchable = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, isSearchable);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(3, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    private Candidate mapResultSetToCandidate(ResultSet rs) throws SQLException {
        Candidate candidate = new Candidate();
        candidate.setId(rs.getInt("id"));
        candidate.setUserId(rs.getInt("user_id"));
        candidate.setFullName(rs.getString("full_name"));
        candidate.setJobTitle(rs.getString("job_title"));
        candidate.setExperienceYears(rs.getInt("experience_years"));
        candidate.setEducationLevel(rs.getString("education_level"));
        candidate.setAddress(rs.getString("address"));
        candidate.setEmail(rs.getString("email"));
        candidate.setSearchable(rs.getBoolean("is_searchable"));
        candidate.setCreatedAt(rs.getTimestamp("created_at"));
        candidate.setUpdatedAt(rs.getTimestamp("updated_at"));
        return candidate;
    }
} 