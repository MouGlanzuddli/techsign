package dal;
 
import model.Company;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class CompanyDAO {
    private final Connection connection;

    public CompanyDAO(Connection connection) {
        this.connection = connection;
    }
    public List<Company> getCompaniesWithPaging(String keyword, int offset, int limit) {
        List<Company> list = new ArrayList<>();
        String sql = "SELECT * FROM company_profiles WHERE company_name LIKE ? ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, offset);
            ps.setInt(3, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Company c = new Company();
                    c.setId(rs.getInt("id"));
                    c.setUserId(rs.getInt("user_id"));
                    c.setIndustryId(rs.getInt("industry_id"));
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
    // Toggle profile visibility
    public boolean toggleProfileVisibility(int userId, boolean isSearchable) throws SQLException {
        String sql = "UPDATE company_profiles SET is_searchable = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBoolean(1, isSearchable);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(3, userId);
            return stmt.executeUpdate() > 0;
        }
    }
    // Cập nhật profile company
    public boolean updateCompany(Company company) throws SQLException {
        String sql = "UPDATE company_profiles SET company_name = ?, industry_id = ?, address = ?, " +
                     "description = ?, website = ?, logo_url = ?, phone = ?, is_searchable = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, company.getCompanyName());
            stmt.setObject(2, company.getIndustryId(), java.sql.Types.INTEGER);
            stmt.setString(3, company.getAddress());
            stmt.setString(4, company.getDescription());
            stmt.setString(5, company.getWebsite());
            stmt.setString(6, company.getLogoUrl());
            stmt.setString(7, company.getPhone());
            stmt.setBoolean(8, company.isSearchable());
            stmt.setTimestamp(9, new Timestamp(company.getUpdatedAt().getTime()));
            stmt.setInt(10, company.getUserId());
            return stmt.executeUpdate() > 0;
        }
    }
    // Tạo profile company mới
    public boolean createCompany(Company company) throws SQLException {
        String sql = "INSERT INTO company_profiles (user_id, company_name, industry_id, address, description, " +
                     "website, logo_url, phone, is_searchable, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, company.getUserId());
            stmt.setString(2, company.getCompanyName());
            stmt.setObject(3, company.getIndustryId(), java.sql.Types.INTEGER);
            stmt.setString(4, company.getAddress());
            stmt.setString(5, company.getDescription());
            stmt.setString(6, company.getWebsite());
            stmt.setString(7, company.getLogoUrl());
            stmt.setString(8, company.getPhone());
            stmt.setBoolean(9, company.isSearchable());
            stmt.setTimestamp(10, new Timestamp(company.getCreatedAt().getTime()));
            stmt.setTimestamp(11, new Timestamp(company.getUpdatedAt().getTime()));
            return stmt.executeUpdate() > 0;
        }
    }

    // Lấy tất cả công ty có thể tìm kiếm được
    public List<Company> getAllSearchableCompanies() throws SQLException {
        String sql = "SELECT cp.*, u.full_name, i.name AS industry_name, " +
                    "(SELECT COUNT(*) FROM job_postings j WHERE j.company_profile_id = cp.user_id AND j.status = 'active') as open_jobs " +
                    "FROM company_profiles cp " +
                    "JOIN users u ON cp.user_id = u.id " +
                    "LEFT JOIN industries i ON cp.industry_id = i.id " +
                    "WHERE cp.is_searchable = 1 AND u.status = 'active' " +
                    "ORDER BY cp.is_featured DESC, cp.created_at DESC"; // Sort by featured first, then newest
        
        List<Company> companies = new ArrayList<>();
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
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
        sql.append("(SELECT COUNT(*) FROM job_postings j WHERE j.company_profile_id = cp.user_id AND j.status = 'active') as open_jobs ");
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
        String sql = "SELECT cp.*, u.full_name, i.name AS industry_name, " + // Added i.name AS industry_name
                    "(SELECT COUNT(*) FROM job_postings j WHERE j.company_profile_id = cp.user_id AND j.status = 'active') as open_jobs " +
                    "FROM company_profiles cp " +
                    "JOIN users u ON cp.user_id = u.id " +
                    "LEFT JOIN industries i ON cp.industry_id = i.id " + // Added JOIN for industries
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
        String sql = "SELECT cp.*, u.full_name, i.name AS industry_name, " + // Added i.name AS industry_name
                    "(SELECT COUNT(*) FROM job_postings j WHERE j.company_profile_id = cp.user_id AND j.status = 'active') as open_jobs " +
                    "FROM company_profiles cp " +
                    "JOIN users u ON cp.user_id = u.id " +
                    "LEFT JOIN industries i ON cp.industry_id = i.id " + // Added JOIN for industries
                    "WHERE cp.user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToCompany(rs);
            }
        }
        return null;
    }

    // Lấy danh sách ngành nghề
    public List<String> getAllIndustries() throws SQLException {
        String sql = "SELECT DISTINCT i.name FROM industries i " +
                    "ORDER BY i.name";
        
        List<String> industries = new ArrayList<>();
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
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
        String sql = "SELECT DISTINCT address FROM company_profiles " +
                    "WHERE address IS NOT NULL " +
                    "ORDER BY address";
        
        List<String> locations = new ArrayList<>();
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
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
        String sql = "SELECT COUNT(*) FROM company_profiles cp " +
                    "JOIN users u ON cp.user_id = u.id " +
                    "WHERE cp.is_searchable = 1 AND u.status = 'active'";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Thêm công ty mới
    public boolean insertCompany(Company company) throws SQLException {
        String sql = "INSERT INTO company_profiles (user_id, industry_id, company_name, website, " +
                    "description, address, phone, logo_url, banner_url, icon_url, is_featured, " +
                    "is_searchable, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
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
    // Xóa company
    public boolean deleteCompany(int userId) throws SQLException {
        String sql = "DELETE FROM company_profiles WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }
    

    
}
