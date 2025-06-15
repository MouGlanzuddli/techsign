
package DAO;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.JobPosting;
import connectDB.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JobPostingDAO {

    public List<JobPosting> searchJobs(String keyword, String category, String city, String sortBy) {
    List<JobPosting> result = new ArrayList<>();

    StringBuilder sql = new StringBuilder(
        "SELECT jp.*, cp.company_name " +
        "FROM job_postings jp JOIN company_profiles cp ON jp.company_profile_id = cp.id WHERE 1=1"
    );

    List<Object> params = new ArrayList<>();

    // Tìm theo từ khóa
    if (keyword != null && !keyword.isEmpty()) {
        sql.append(" AND (jp.title LIKE ? OR jp.description LIKE ?)");
        String kw = "%" + keyword + "%";
        params.add(kw); params.add(kw);
    }

    // Lọc theo danh mục
    if (category != null && !category.isEmpty()) {
        sql.append(" AND jp.category = ?");
        params.add(category);
    }

    // Lọc theo thành phố
    if (city != null && !city.isEmpty()) {
        sql.append(" AND jp.location LIKE ?");
        params.add("%" + city + "%");
    }

    // Sort
    sql.append(" ORDER BY jp.posted_at DESC");

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            JobPosting job = new JobPosting();
            job.setId(rs.getInt("id"));
            job.setTitle(rs.getString("title"));
            job.setLocation(rs.getString("location"));
            job.setDescription(rs.getString("description"));
            job.setSalaryMin(rs.getDouble("salary_min"));
            job.setSalaryMax(rs.getDouble("salary_max"));
            job.setJobType(rs.getString("job_type"));
            job.setStatus(rs.getString("status"));
            job.setPostedAt(rs.getTimestamp("posted_at"));
            job.setCompanyName(rs.getString("company_name"));
            
            result.add(job);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return result;
}

    public JobPosting getJobById(int id) {
    JobPosting job = null;
    
    String sql = "SELECT jp.*, cp.company_name " +
                 "FROM job_postings jp " +
                 "JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
                 "WHERE jp.id = ?";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            job = new JobPosting();
            job.setId(rs.getInt("id"));
            job.setTitle(rs.getString("title"));
            job.setDescription(rs.getString("description"));
            job.setLocation(rs.getString("location"));
            job.setSalaryMin(rs.getDouble("salary_min"));
            job.setSalaryMax(rs.getDouble("salary_max"));
            job.setJobType(rs.getString("job_type"));
            job.setBenefits(rs.getString("benefits"));
            job.setStatus(rs.getString("status"));
            job.setPostedAt(rs.getTimestamp("posted_at"));
            job.setCompanyName(rs.getString("company_name"));

            // Nếu bạn thêm trường skills trong job_postings
            try {
//                job.setSkills(rs.getString("skills"));
            } catch (Exception e) {
                // Bỏ qua nếu không có cột skills
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return job;
}
}