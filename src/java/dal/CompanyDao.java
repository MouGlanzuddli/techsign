package dal;

import model.Company;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class CompanyDao {

    private final Connection connection;

    public CompanyDao(Connection connection) {
        this.connection = connection;
    }

    // Lấy tất cả công ty có thể tìm kiếm được
    public List<Company> getAllSearchableCompanies() throws SQLException {
        String sql = "SELECT cp.*, u.full_name, i.name AS industry_name, "
                + "(SELECT COUNT(*) FROM job_postings j WHERE j.company_profile_id = cp.user_id AND j.status = 'active') as open_jobs "
                + "FROM company_profiles cp "
                + "JOIN users u ON cp.user_id = u.id "
                + "LEFT JOIN industries i ON cp.industry_id = i.id "
                + "WHERE cp.is_searchable = 1 AND u.status = 'active' "
                + "ORDER BY cp.is_featured DESC, cp.created_at DESC"; // Sort by featured first, then newest

        List<Company> companies = new ArrayList<>();

        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                companies.add(mapResultSetToCompany(rs));
            }
        }
        return companies;
    }

    // Tìm kiếm công ty với các bộ lọc
    public List<Company> searchCompanies(String searchKeyword, String industry,
            String location, String companySize,
            String companyType, String sortBy) throws SQLException {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT cp.*, u.full_name, i.name AS industry_name, "); // Added i.name AS industry_name
        sql.append("(SELECT COUNT(*) FROM jobs j WHERE j.company_id = cp.user_id AND j.status = 'active') as open_jobs ");
        sql.append("FROM company_profiles cp ");
        sql.append("JOIN users u ON cp.user_id = u.id ");
        sql.append("LEFT JOIN industries i ON cp.industry_id = i.id "); // Added JOIN for industries
        sql.append("WHERE cp.is_searchable = 1 AND u.status = 'active' ");

        List<Object> parameters = new ArrayList<>();

        // Tìm kiếm theo từ khóa
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append("AND (cp.company_name LIKE ? OR cp.description LIKE ?) ");
            String keyword = "%" + searchKeyword.trim() + "%";
            parameters.add(keyword);
            parameters.add(keyword);
        }

        // Lọc theo ngành nghề
        if (industry != null && !industry.trim().isEmpty()) {
            sql.append("AND i.name = ? "); // Filter by industry name
            parameters.add(industry);
        }

        // Lọc theo địa điểm
        if (location != null && !location.trim().isEmpty()) {
            sql.append("AND cp.address LIKE ? ");
            parameters.add("%" + location + "%");
        }

        // TODO: Add filters for companySize and companyType if corresponding columns exist in DB
        // Sắp xếp
        if ("name".equals(sortBy)) {
            sql.append("ORDER BY cp.company_name ASC");
        } else if ("featured".equals(sortBy)) {
            sql.append("ORDER BY cp.is_featured DESC, cp.created_at DESC");
        } else {
            sql.append("ORDER BY cp.created_at DESC");
        }

        List<Company> companies = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                companies.add(mapResultSetToCompany(rs));
            }
        }
        return companies;
    }

    // Lấy công ty theo ID
    public Company getCompanyById(int id) throws SQLException {
        String sql = "SELECT cp.*, u.full_name, i.name AS industry_name, "
                + // Added i.name AS industry_name
                "(SELECT COUNT(*) FROM jobs j WHERE j.company_id = cp.user_id AND j.status = 'active') as open_jobs "
                + "FROM company_profiles cp "
                + "JOIN users u ON cp.user_id = u.id "
                + "LEFT JOIN industries i ON cp.industry_id = i.id "
                + // Added JOIN for industries
                "WHERE cp.id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToCompany(rs);
            }
        }
        return null;
    }

    // Lấy công ty theo user ID
    public Company getCompanyByUserId(int userId) throws SQLException {
        String sql = "SELECT cp.*, u.full_name, i.name AS industry_name, "
                + "(SELECT COUNT(*) FROM job_postings j WHERE j.company_profile_id = cp.user_id AND j.status = 'active') AS open_jobs "
                + "FROM company_profiles cp "
                + "JOIN users u ON cp.user_id = u.id "
                + "LEFT JOIN industries i ON cp.industry_id = i.id "
                + "WHERE cp.user_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCompany(rs);
                }
            }
        }
        return null;
    }

    // Lấy danh sách ngành nghề
    public List<String> getAllIndustries() throws SQLException {
        String sql = "SELECT DISTINCT i.name FROM industries i "
                + "ORDER BY i.name";

        List<String> industries = new ArrayList<>();

        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String industry = rs.getString("name");
                if (industry != null && !industry.trim().isEmpty()) {
                    industries.add(industry);
                }
            }
        }
        return industries;
    }

    // Lấy danh sách địa điểm
    public List<String> getAllLocations() throws SQLException {
        String sql = "SELECT DISTINCT address FROM company_profiles "
                + "WHERE address IS NOT NULL "
                + "ORDER BY address";

        List<String> locations = new ArrayList<>();

        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String location = rs.getString("address");
                if (location != null && !location.trim().isEmpty()) {
                    locations.add(location);
                }
            }
        }
        return locations;
    }

    // Đếm tổng số công ty
    public int getTotalCompaniesCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM company_profiles cp "
                + "JOIN users u ON cp.user_id = u.id "
                + "WHERE cp.is_searchable = 1 AND u.status = 'active'";

        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Thêm công ty mới
    public boolean insertCompany(Company company) throws SQLException {
        String sql = "INSERT INTO company_profiles (user_id, industry_id, company_name, website, "
                + "description, address, phone, logo_url, banner_url, icon_url, is_featured, "
                + "is_searchable, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            Date now = new Date();
            if (company.getCreatedAt() == null) {
                company.setCreatedAt(now);
            }
            if (company.getUpdatedAt() == null) {
                company.setUpdatedAt(now);
            }

            stmt.setInt(1, company.getUserId());
            if (company.getIndustryId() > 0) {
                stmt.setInt(2, company.getIndustryId());
            } else {
                stmt.setNull(2, java.sql.Types.INTEGER);
            }
            stmt.setString(3, company.getCompanyName());
            stmt.setString(4, company.getWebsite());
            stmt.setString(5, company.getDescription());
            stmt.setString(6, company.getAddress());
            stmt.setString(7, company.getPhone());
            stmt.setString(8, company.getLogoUrl());
            stmt.setString(9, company.getBannerUrl());
            stmt.setString(10, company.getIconUrl());
            stmt.setBoolean(11, company.isFeatured());
            stmt.setBoolean(12, company.isSearchable());
            stmt.setTimestamp(13, new Timestamp(company.getCreatedAt().getTime()));
            stmt.setTimestamp(14, new Timestamp(company.getUpdatedAt().getTime()));

            int result = stmt.executeUpdate();
            if (result > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    company.setId(rs.getInt(1));
                }
                return true;
            }
        }
        return false;
    }

    // Helper method để map ResultSet về Company object
    private Company mapResultSetToCompany(ResultSet rs) throws SQLException {
        Company company = new Company();
        company.setId(rs.getInt("id"));
        company.setUserId(rs.getInt("user_id"));
        company.setIndustryId(rs.getInt("industry_id")); // Get industry_id
        company.setCompanyName(rs.getString("company_name"));
        company.setIndustry(rs.getString("industry_name")); // Changed to industry_name alias
        company.setDescription(rs.getString("description"));
        company.setAddress(rs.getString("address"));
        company.setPhone(rs.getString("phone"));
        company.setWebsite(rs.getString("website"));
        company.setLogoUrl(rs.getString("logo_url"));
        company.setBannerUrl(rs.getString("banner_url"));
        company.setIconUrl(rs.getString("icon_url"));
        company.setFeatured(rs.getBoolean("is_featured"));
        company.setSearchable(rs.getBoolean("is_searchable"));
        company.setOpenJobs(rs.getInt("open_jobs"));
        company.setUserFullName(rs.getString("full_name")); // Get user's full name

        Timestamp createdAt = rs.getTimestamp("created_at");
        company.setCreatedAt(createdAt != null ? new Date(createdAt.getTime()) : new Date());
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        company.setUpdatedAt(updatedAt != null ? new Date(updatedAt.getTime()) : new Date());

        return company;
    }

}
