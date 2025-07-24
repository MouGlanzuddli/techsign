package dal;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.JobPosting;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

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
            job.setSalary(rs.getString("salary"));
            job.setJobType(rs.getString("job_type"));
            job.setBenefits(rs.getString("benefits"));
            job.setStatus(rs.getString("status"));
            job.setPostedAt(rs.getTimestamp("posted_at"));
            job.setExpiresAt(rs.getTimestamp("expires_at"));
            job.setContractType(rs.getString("contract_type"));
            job.setPlaceofwork(rs.getString("place_of_work"));
            job.setRequirements(rs.getString("requirements"));
            job.setJobLevel(rs.getString("job_level"));
            job.setCategory(rs.getString("category"));
            job.setExperienceRequired(rs.getInt("experience_required"));
            job.setApplicationDeadline(rs.getDate("application_deadline"));
            job.setIsFeatured(rs.getBoolean("is_featured"));
            job.setIsUrgent(rs.getBoolean("is_urgent"));
            job.setViewsCount(rs.getInt("views_count"));
            job.setApplicationsCount(rs.getInt("applications_count"));
            job.setCreatedAt(rs.getDate("created_at"));
            job.setUpdatedAt(rs.getDate("updated_at"));
            job.setResponsibility(rs.getString("responsibility"));
            ;
        }

        rs.close();
        ps.close();
        conn.close();

        return job;
    }

    public List<JobPosting> filterJobs(
            String[] placeOfWork, String[] contractTypes,
            String[] employmentTypes, Double salaryMin, Double salaryMax,
            String[] jobtype, String keyword
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
            sql.append(")");
        }

        if (salaryMin != null) {
            sql.append(" AND ( (salary_min IS NOT NULL AND salary_min >= ?) OR salary_min IS NULL ) ");
            params.add(salaryMin);
        }

        if (salaryMax != null) {
            sql.append(" AND ( (salary_max IS NOT NULL AND salary_max <= ?) OR salary_max IS NULL ) ");
            params.add(salaryMax);
        }

        if (jobtype != null && jobtype.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < jobtype.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("job_type LIKE ?");
                params.add("%" + jobtype[i] + "%");
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
                jp.setSalary_min(rs.getDouble("salary_min"));
                jp.setSalary_max(rs.getDouble("salary_max"));
                jp.setSalary(rs.getString("salary"));
                list.add(jp);
            }
        }
        return list;
    }

    public List<JobPosting> getAllJobPostings() throws SQLException {
        List<JobPosting> list = new ArrayList<>();
        Connection conn = new DBContext().getConnection();
        String sql = "SELECT * FROM job_postings ORDER BY posted_at DESC";
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
        String sql = "SELECT DISTINCT job_type FROM job_postings WHERE job_type IS NOT NULL AND job_type <> '' ORDER BY job_type";
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
                job.setSalary(rs.getString("salary"));
                job.setJobType(rs.getString("job_type"));
                job.setBenefits(rs.getString("benefits"));
                job.setStatus(rs.getString("status"));
                job.setPostedAt(rs.getTimestamp("posted_at"));
                job.setExpiresAt(rs.getTimestamp("expires_at"));

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
        job.setSalary(rs.getString("salary"));
        job.setSalary_min(rs.getDouble("salary_min"));
        job.setSalary_max(rs.getDouble("salary_max"));
        job.setJobType(rs.getString("job_type"));
        job.setJobLevel(rs.getString("job_level"));
        job.setBenefits(rs.getString("benefits"));
        job.setStatus(rs.getString("status"));
        job.setPostedAt(rs.getTimestamp("posted_at"));
        job.setExpiresAt(rs.getTimestamp("expires_at"));
        job.setContractType(rs.getString("contract_type"));
        job.setPlaceofwork(rs.getString("place_of_work"));

        java.sql.Timestamp postedAt = rs.getTimestamp("posted_at");
        boolean isNew = false;
        if (postedAt != null) {
            isNew = postedAt.toLocalDateTime().isAfter(LocalDateTime.now().minusDays(7));
        }
        job.setIsNewJob(isNew);

        return job;
    }

    public List<String> getAllJobCategoriesDes() throws SQLException {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM job_postings WHERE category IS NOT NULL AND category <> '' ORDER BY category";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        }
        return categories;
    }

    public List<String> getAllCities() throws SQLException {
        List<String> cities = new ArrayList<>();
        String sql = "SELECT DISTINCT location FROM job_postings WHERE location IS NOT NULL AND location <> '' ORDER BY location";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                cities.add(rs.getString("location"));
            }
        }
        return cities;
    }
   
}
