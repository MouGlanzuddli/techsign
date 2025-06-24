package dao;

import model.Candidate;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidateDAO {
    private final Connection conn;

    public CandidateDAO(Connection conn) {
        this.conn = conn;
    }

    // Tạo profile candidate mới
    public boolean createCandidate(Candidate candidate) throws SQLException {
        String sql = "INSERT INTO candidate_profiles (user_id, full_name, title, experience_years, skills, " +
                     "education, location, bio, resume_url, is_searchable, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, candidate.getUserId());
            stmt.setString(2, candidate.getFullName());
            stmt.setString(3, candidate.getTitle());
            stmt.setInt(4, candidate.getExperienceYears());
            stmt.setString(5, candidate.getSkills());
            stmt.setString(6, candidate.getEducation());
            stmt.setString(7, candidate.getLocation());
            stmt.setString(8, candidate.getBio());
            stmt.setString(9, candidate.getResumeUrl());
            stmt.setBoolean(10, candidate.isSearchable());
            stmt.setTimestamp(11, new Timestamp(candidate.getCreatedAt().getTime()));
            stmt.setTimestamp(12, new Timestamp(candidate.getUpdatedAt().getTime()));
            return stmt.executeUpdate() > 0;
        }
    }

    // Lấy candidate theo user_id
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

    // Lấy candidate theo ID
    public Candidate getCandidateById(int id) throws SQLException {
        String sql = "SELECT * FROM candidate_profiles WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCandidate(rs);
                }
            }
        }
        return null;
    }

    // Cập nhật profile candidate
    public boolean updateCandidate(Candidate candidate) throws SQLException {
        String sql = "UPDATE candidate_profiles SET full_name = ?, title = ?, experience_years = ?, " +
                     "skills = ?, education = ?, location = ?, bio = ?, resume_url = ?, " +
                     "is_searchable = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, candidate.getFullName());
            stmt.setString(2, candidate.getTitle());
            stmt.setInt(3, candidate.getExperienceYears());
            stmt.setString(4, candidate.getSkills());
            stmt.setString(5, candidate.getEducation());
            stmt.setString(6, candidate.getLocation());
            stmt.setString(7, candidate.getBio());
            stmt.setString(8, candidate.getResumeUrl());
            stmt.setBoolean(9, candidate.isSearchable());
            stmt.setTimestamp(10, new Timestamp(candidate.getUpdatedAt().getTime()));
            stmt.setInt(11, candidate.getUserId());
            return stmt.executeUpdate() > 0;
        }
    }

    // Cập nhật profile candidate (phiên bản đơn giản)
    public boolean updateCandidateProfile(int userId, String fullName, String title, 
                                        int experienceYears, String skills, String education, 
                                        String location, String bio, String resumeUrl) throws SQLException {
        String sql = "UPDATE candidate_profiles SET full_name = ?, title = ?, experience_years = ?, " +
                     "skills = ?, education = ?, location = ?, bio = ?, resume_url = ?, updated_at = ? " +
                     "WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, fullName);
            stmt.setString(2, title);
            stmt.setInt(3, experienceYears);
            stmt.setString(4, skills);
            stmt.setString(5, education);
            stmt.setString(6, location);
            stmt.setString(7, bio);
            stmt.setString(8, resumeUrl);
            stmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(10, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Toggle profile visibility
    public boolean toggleProfileVisibility(int userId, boolean isSearchable) throws SQLException {
        String sql = "UPDATE candidate_profiles SET is_searchable = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, isSearchable);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(3, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Lấy danh sách tất cả candidates (chỉ những profile visible)
    public List<Candidate> getAllCandidates() throws SQLException {
        List<Candidate> candidates = new ArrayList<>();
        String sql = "SELECT * FROM candidate_profiles WHERE is_searchable = 1";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                candidates.add(mapResultSetToCandidate(rs));
            }
        }
        return candidates;
    }

    // Lấy danh sách tất cả candidates (bao gồm cả hidden)
    public List<Candidate> getAllCandidatesIncludingHidden() throws SQLException {
        List<Candidate> candidates = new ArrayList<>();
        String sql = "SELECT * FROM candidate_profiles";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                candidates.add(mapResultSetToCandidate(rs));
            }
        }
        return candidates;
    }

    // Tìm kiếm candidates theo filter (chỉ những profile visible)
    public List<Candidate> searchCandidates(String location, String skills, Integer minExperience) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM candidate_profiles WHERE is_searchable = 1");
        List<Object> params = new ArrayList<>();
        
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND location LIKE ?");
            params.add("%" + location + "%");
        }
        
        if (skills != null && !skills.trim().isEmpty()) {
            sql.append(" AND skills LIKE ?");
            params.add("%" + skills + "%");
        }
        
        if (minExperience != null) {
            sql.append(" AND experience_years >= ?");
            params.add(minExperience);
        }
        
        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                List<Candidate> candidates = new ArrayList<>();
                while (rs.next()) {
                    candidates.add(mapResultSetToCandidate(rs));
                }
                return candidates;
            }
        }
    }

    // Xóa candidate
    public boolean deleteCandidate(int userId) throws SQLException {
        String sql = "DELETE FROM candidate_profiles WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Helper: Map từ ResultSet sang Candidate object
    private Candidate mapResultSetToCandidate(ResultSet rs) throws SQLException {
        Candidate candidate = new Candidate();
        candidate.setId(rs.getInt("id"));
        candidate.setUserId(rs.getInt("user_id"));
        candidate.setFullName(rs.getString("full_name"));
        candidate.setTitle(rs.getString("title"));
        candidate.setExperienceYears(rs.getInt("experience_years"));
        candidate.setSkills(rs.getString("skills"));
        candidate.setEducation(rs.getString("education"));
        candidate.setLocation(rs.getString("location"));
        candidate.setBio(rs.getString("bio"));
        candidate.setResumeUrl(rs.getString("resume_url"));
        candidate.setSearchable(rs.getBoolean("is_searchable"));
        candidate.setCreatedAt(rs.getTimestamp("created_at"));
        candidate.setUpdatedAt(rs.getTimestamp("updated_at"));
        return candidate;
    }
} 