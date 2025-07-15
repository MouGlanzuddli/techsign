package DAO;

import connectDB.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.Bookmarks;

public class BookmarkDAO {
  

    public List<Bookmarks> searchSavedJobs(int userId, String keyword, String description, String location, int page, int pageSize) throws SQLException {
        List<Bookmarks> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT b.*, jp.title, jp.location, jp.job_type, jp.description, jp.status, jp.posted_at, cp.company_name "
                + "FROM bookmarks b "
                + "JOIN job_postings jp ON b.job_postings_id = jp.id "
                + "JOIN company_profiles cp ON jp.company_profile_id = cp.id "
                + "WHERE b.user_id = ? "
                + "AND jp.title LIKE ? "
                + "AND jp.description LIKE ? "
                + "AND jp.location LIKE ?");
        List<Object> params = new ArrayList<>();
        params.add(userId);
        params.add(keyword != null && !keyword.trim().isEmpty() ? "%" + keyword + "%" : "%");
        params.add(description != null && !description.trim().isEmpty() ? "%" + description + "%" : "%");
        params.add(location != null && !location.trim().isEmpty() ? "%" + location + "%" : "%");

        sql.append(" ORDER BY b.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (Connection conn = new DBContext().getConnection();PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                if (params.get(i) instanceof Integer) {
                    ps.setInt(i + 1, (Integer) params.get(i));
                } else {
                    ps.setString(i + 1, (String) params.get(i));
                }
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Bookmarks b = new Bookmarks();
                    b.setId(rs.getInt("id"));
                    b.setUserId(rs.getInt("user_id"));
                    b.setSaveJobs(rs.getString("save_jobs"));
                    b.setJobPostingsId(rs.getInt("job_postings_id"));
                    b.setCreatedAt(rs.getTimestamp("created_at"));
                    b.setTitle(rs.getString("title"));
                    b.setLocation(rs.getString("location"));
                    b.setJobType(rs.getString("job_type"));
                    b.setDescription(rs.getString("description"));
                    b.setStatus(rs.getString("status"));
                    b.setPostedAt(rs.getTimestamp("posted_at"));
                    list.add(b);
                }
            }
        }
        return list;
    }

    public int getTotalSavedJobs(int userId, String keyword, String description, String location) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM bookmarks b JOIN job_postings jp ON b.job_postings_id = jp.id WHERE b.user_id = ?");
        List<Object> params = new ArrayList<>();
        params.add(userId); // Tham số 1: userId

        // Chỉ thêm điều kiện và tham số khi có giá trị hợp lệ
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND jp.title LIKE ?");
            params.add("%" + keyword + "%");
        } else {
            sql.append(" AND jp.title LIKE ?");
            params.add("%"); // Mặc định nếu không có keyword
        }
        if (description != null && !description.trim().isEmpty()) {
            sql.append(" AND jp.description LIKE ?");
            params.add("%" + description + "%");
        } else {
            sql.append(" AND jp.description LIKE ?");
            params.add("%"); // Mặc định nếu không có description
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND jp.location LIKE ?");
            params.add("%" + location + "%");
        } else {
            sql.append(" AND jp.location LIKE ?");
            params.add("%"); // Mặc định nếu không có location
        }

        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                if (params.get(i) instanceof Integer) {
                    ps.setInt(i + 1, (Integer) params.get(i));
                } else {
                    ps.setString(i + 1, (String) params.get(i));
                }
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public boolean hasSaved(int userId, int jobId) {
    String sql = "SELECT COUNT(*) FROM bookmarks WHERE user_id = ? AND job_postings_id = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setInt(2, jobId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
}
