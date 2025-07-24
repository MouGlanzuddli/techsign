package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Companies;
import dal.DBContext;
import model.JobPosting;

public class CompaniesDAO {

    public List<Companies> getCompaniesWithPaging(String keyword, int offset, int limit) {
        List<Companies> list = new ArrayList<>();
        String sql = "SELECT * FROM company_profiles WHERE company_name LIKE ? ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, offset);
            ps.setInt(3, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Companies c = new Companies();
                    c.setId(rs.getInt("id"));
                    c.setUserId(rs.getInt("user_id"));
                    c.setIndustryID(rs.getInt("industry_id"));
                    c.setCompanyName(rs.getString("company_name"));
                    c.setWebsite(rs.getString("website"));
                    c.setDescription(rs.getString("description"));
                    c.setAddress(rs.getString("address"));
                    c.setPhone(rs.getString("phone"));
                    c.setLogoUrl(rs.getString("logo_url"));
                    c.setBannerUrl(rs.getString("banner_url"));
                    c.setIconUrl(rs.getString("icon_url"));
                    c.setFeatured(rs.getBoolean("is_featured"));
                    c.setSearchable(rs.getBoolean("is_searchable"));
                    c.setCreatedAt(rs.getTimestamp("created_at"));
                    c.setUpdatedAt(rs.getTimestamp("updated_at"));
                    list.add(c);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int getTotalCompanies(String keyword) {
        String sql = "SELECT COUNT(*) FROM company_profiles WHERE company_name LIKE ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    

    public Companies getCompanyById(int id) throws SQLException {
        String sql = "SELECT * FROM company_profiles WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Companies c = new Companies();
                    c.setId(rs.getInt("id"));
                    c.setUserId(rs.getInt("user_id"));
                    c.setIndustryID(rs.getInt("industry_id"));
                    c.setCompanyName(rs.getString("company_name"));
                    c.setWebsite(rs.getString("website"));
                    c.setDescription(rs.getString("description"));
                    c.setAddress(rs.getString("address"));
                    c.setPhone(rs.getString("phone"));
                    c.setEmail(rs.getString("email"));
                    c.setCompanybenefits(rs.getString("companiesbenefits"));
                    return c;
                }
            }
        }
        return null;
    }

    public List<JobPosting> getJobsByCompanyWithPaging(int companyId, int offset, int limit) {
        List<JobPosting> list = new ArrayList<>();
        String sql = "SELECT * FROM job_postings WHERE company_profile_id = ? "
                + "ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, companyId);
            ps.setInt(2, offset);
            ps.setInt(3, limit);

            try (ResultSet rs = ps.executeQuery()) {
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
                    list.add(job);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countJobsByCompany(int companyId) {
        String sql = "SELECT COUNT(*) FROM job_postings WHERE company_profile_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, companyId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
