package DAO;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.JobPosting;
import connectDB.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JobPostingDAO {

    public List<JobPosting> searchJobs(String keyword, String description, String city, String sortBy) throws SQLException {
        List<JobPosting> list = new ArrayList<>();
        String sql = "SELECT DISTINCT jp.* FROM job_postings jp "
                + "LEFT JOIN job_required_skills jrs ON jp.id = jrs.job_posting_id "
                + "LEFT JOIN skills s ON jrs.skill_id = s.id "
                + "WHERE 1=1 ";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND (jp.title LIKE ? OR jp.description LIKE ? OR s.name LIKE ?) ";
        }

        if (description != null && !description.trim().isEmpty()) {
            sql += "AND jp.description LIKE ? ";
        }

        if (city != null && !city.trim().isEmpty()) {
            sql += "AND jp.location = ? ";
        }
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql.toString());
        int paramIndex = 1;

        if (keyword != null && !keyword.trim().isEmpty()) {
            String kw = "%" + keyword.trim() + "%";
            ps.setString(paramIndex++, kw);
            ps.setString(paramIndex++, kw);
            ps.setString(paramIndex++, kw);
        }

        if (description != null && !description.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + description.trim() + "%");
        }

        if (city != null && !city.trim().isEmpty()) {
            ps.setString(paramIndex++, city.trim());
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            JobPosting job = mapResultSetToJobPosting(rs);
            list.add(job);
        }
        rs.close();
        ps.close();
        return list;
    }

    public JobPosting getJobById(int id) throws Exception {
        Connection conn = new DBContext().getConnection();
        String sql = "SELECT * FROM job_postings WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        JobPosting job = null;

        if (rs.next()) {
            job = new JobPosting();
            job.setId(rs.getInt("id"));
            job.setCompanyProfileId(rs.getInt("company_profile_id"));
            job.setTitle(rs.getString("title"));
            job.setDescription(rs.getString("description"));
            job.setLocation(rs.getString("location"));
            job.setSalaryMin(rs.getDouble("salary_min"));
            job.setSalaryMax(rs.getDouble("salary_max"));
            job.setJobType(rs.getString("job_type"));
            job.setBenefits(rs.getString("benefits"));
            job.setStatus(rs.getString("status")); 
            job.setPostedAt(rs.getTimestamp("posted_at"));
            job.setExpiresAt(rs.getTimestamp("expires_at"));
            job.setContractType(rs.getString("contract_type"));
            job.setPlaceofwork(rs.getString("place_of_work"));
        }

        rs.close();
        ps.close();
        conn.close();

        return job;
    }

    // Gợi ý kỹ năng cho thanh input (autocomplete)
    public List<String> suggestSkills(String keyword) {
        List<String> suggestions = new ArrayList<>();
        String sql = "SELECT DISTINCT name FROM skills WHERE name LIKE ? ORDER BY name ASC";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                suggestions.add(rs.getString("name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return suggestions;
    }

    public List<JobPosting> filterJobs(
            String[] placeOfWork, String[] contractTypes,
            String[] employmentTypes, String salaryRange,
            String[] categories, String keyword
    ) throws SQLException {
        List<JobPosting> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT DISTINCT jp.* FROM job_postings jp "
                + "LEFT JOIN job_required_skills jrs ON jp.id = jrs.job_posting_id "
                + "LEFT JOIN skills s ON jrs.skill_id = s.id "
                + "WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (placeOfWork != null && placeOfWork.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < placeOfWork.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("place_of_work = ?");
                params.add(placeOfWork[i]);
            }
            sql.append(") ");
        }

        if (contractTypes != null && contractTypes.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < contractTypes.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("contract_type = ?");
                params.add(contractTypes[i]);
            }
            sql.append(") ");
        }

        if (employmentTypes != null && employmentTypes.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < employmentTypes.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("job_type = ?");
                params.add(employmentTypes[i]);
            }
            sql.append(") ");
        }

        if (salaryRange != null && salaryRange.contains("-")) {
            String[] parts = salaryRange.split("-");
            sql.append(" AND salary_min >= ? AND salary_max <= ? ");
            params.add(Integer.parseInt(parts[0]));
            params.add(Integer.parseInt(parts[1]));
        }

        if (categories != null && categories.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < categories.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("description LIKE ?");
                params.add("%" + categories[i] + "%");
            }
            sql.append(") ");
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            String kw = "%" + keyword + "%";
            sql.append(" AND (title LIKE ? OR description LIKE ? OR s.name LIKE ?) ");
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }

        sql.append(" ORDER BY posted_at DESC ");

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPosting jp = new JobPosting();
                jp.setId(rs.getInt("id"));
                jp.setTitle(rs.getString("title"));
                jp.setDescription(rs.getString("description"));
                jp.setPlaceofwork(rs.getString("place_of_work"));
                jp.setContractType(rs.getString("contract_type"));
                jp.setJobType(rs.getString("job_type"));
                jp.setSalaryMin(rs.getInt("salary_min"));
                jp.setSalaryMax(rs.getInt("salary_max"));
                list.add(jp);
            }
        }
        return list;
    }

    public List<JobPosting> getAllJobPostings() throws SQLException {
        List<JobPosting> list = new ArrayList<>();
        Connection conn = new DBContext().getConnection();
        String sql = "SELECT * FROM job_postings";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            JobPosting job = mapResultSetToJobPosting(rs);
            list.add(job);
        }
        rs.close();
        ps.close();
        return list;
    }

    public List<String> getAllCategories() throws SQLException {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT job_type FROM job_postings";
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(rs.getString(1));
        }
        rs.close();
        ps.close();
        return list;
    }

    private void appendPlaceholders(StringBuilder sb, int count) {
        for (int i = 0; i < count; i++) {
            sb.append("?");
            if (i < count - 1) {
                sb.append(",");
            }
        }
    }

    public List<JobPosting> getSavedJobsByUser(int userId) {
        List<JobPosting> savedJobs = new ArrayList<>();

        String sql = "SELECT jp.* FROM bookmarks b "
                + "JOIN job_postings jp ON b.job_postings_id = jp.id "
                + "WHERE b.user_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JobPosting job = new JobPosting();
                job.setId(rs.getInt("id"));
                job.setCompanyProfileId(rs.getInt("company_profile_id"));
                job.setTitle(rs.getString("title"));
                job.setDescription(rs.getString("description"));
                job.setLocation(rs.getString("location"));
                job.setSalaryMin(rs.getDouble("salary_min"));
                job.setSalaryMax(rs.getDouble("salary_max"));
                job.setJobType(rs.getString("job_type"));
                job.setBenefits(rs.getString("benefits"));
                job.setStatus(rs.getString("status"));
                job.setPostedAt(rs.getTimestamp("posted_at"));
                job.setExpiresAt(rs.getTimestamp("expires_at"));
                job.setCompanyName(rs.getString("company_name"));
                job.setContractType(rs.getString("contract_type"));
                job.setPlaceofwork(rs.getString("place_of_work"));
                savedJobs.add(job);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return savedJobs;
    }

    private JobPosting mapResultSetToJobPosting(ResultSet rs) throws SQLException {
        JobPosting job = new JobPosting();
        job.setId(rs.getInt("id"));
        job.setCompanyProfileId(rs.getInt("company_profile_id"));
        job.setTitle(rs.getString("title"));
        job.setDescription(rs.getString("description"));
        job.setLocation(rs.getString("location"));
        job.setSalaryMin(rs.getDouble("salary_min"));
        job.setSalaryMax(rs.getDouble("salary_max"));
        job.setJobType(rs.getString("job_type"));
        job.setBenefits(rs.getString("benefits"));
        job.setStatus(rs.getString("status"));
        job.setPostedAt(rs.getTimestamp("posted_at"));
        job.setExpiresAt(rs.getTimestamp("expires_at"));
        job.setContractType(rs.getString("contract_type"));
        job.setPlaceofwork(rs.getString("place_of_work"));
        return job;
    }

}
