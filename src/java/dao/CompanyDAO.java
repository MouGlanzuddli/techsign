package dao;

import model.Company;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAO {
    private final Connection conn;

    public CompanyDAO(Connection conn) {
        this.conn = conn;
    }

    // Tạo profile company mới
    public boolean createCompany(Company company) throws SQLException {
        String sql = "INSERT INTO company_profiles (user_id, company_name, industry_id, address, description, " +
                     "website, logo_url, phone, is_searchable, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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

    // Lấy company theo user_id
    public Company getCompanyByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM company_profiles WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCompany(rs);
                }
            }
        }
        return null;
    }

    // Lấy company theo ID
    public Company getCompanyById(int id) throws SQLException {
        String sql = "SELECT * FROM company_profiles WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCompany(rs);
                }
            }
        }
        return null;
    }

    // Cập nhật profile company
    public boolean updateCompany(Company company) throws SQLException {
        String sql = "UPDATE company_profiles SET company_name = ?, industry_id = ?, address = ?, " +
                     "description = ?, website = ?, logo_url = ?, phone = ?, is_searchable = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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

    // Cập nhật profile company (phiên bản đơn giản)
    public boolean updateCompanyProfile(int userId, String companyName, String industry, 
                                      String address, String description, String website, 
                                      String logoUrl) throws SQLException {
        String sql = "UPDATE company_profiles SET company_name = ?, industry_id = ?, address = ?, " +
                     "description = ?, website = ?, logo_url = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, companyName);
            stmt.setObject(2, industry, java.sql.Types.INTEGER);
            stmt.setString(3, address);
            stmt.setString(4, description);
            stmt.setString(5, website);
            stmt.setString(6, logoUrl);
            stmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(8, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Toggle profile visibility
    public boolean toggleProfileVisibility(int userId, boolean isSearchable) throws SQLException {
        String sql = "UPDATE company_profiles SET is_searchable = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, isSearchable);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(3, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Lấy danh sách tất cả companies (chỉ những profile visible)
    public List<Company> getAllCompanies() throws SQLException {
        List<Company> companies = new ArrayList<>();
        String sql = "SELECT * FROM company_profiles WHERE is_searchable = 1";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                companies.add(mapResultSetToCompany(rs));
            }
        }
        return companies;
    }

    // Lấy danh sách tất cả companies (bao gồm cả hidden)
    public List<Company> getAllCompaniesIncludingHidden() throws SQLException {
        List<Company> companies = new ArrayList<>();
        String sql = "SELECT * FROM company_profiles";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                companies.add(mapResultSetToCompany(rs));
            }
        }
        return companies;
    }

    // Tìm kiếm companies theo filter (chỉ những profile visible)
    public List<Company> searchCompanies(String industry, String location) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM company_profiles WHERE is_searchable = 1");
        List<Object> params = new ArrayList<>();
        
        if (industry != null && !industry.trim().isEmpty()) {
            sql.append(" AND industry_id = ?");
            params.add(industry);
        }
        
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND address LIKE ?");
            params.add("%" + location + "%");
        }
        
        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                List<Company> companies = new ArrayList<>();
                while (rs.next()) {
                    companies.add(mapResultSetToCompany(rs));
                }
                return companies;
            }
        }
    }

    // Xóa company
    public boolean deleteCompany(int userId) throws SQLException {
        String sql = "DELETE FROM company_profiles WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Helper: Map từ ResultSet sang Company object
    private Company mapResultSetToCompany(ResultSet rs) throws SQLException {
        Company company = new Company();
        company.setId(rs.getInt("id"));
        company.setUserId(rs.getInt("user_id"));
        company.setCompanyName(rs.getString("company_name"));
        company.setIndustryId((Integer)rs.getObject("industry_id"));
        company.setAddress(rs.getString("address"));
        company.setDescription(rs.getString("description"));
        company.setWebsite(rs.getString("website"));
        company.setLogoUrl(rs.getString("logo_url"));
        company.setPhone(rs.getString("phone"));
        company.setSearchable(rs.getBoolean("is_searchable"));
        company.setCreatedAt(rs.getTimestamp("created_at"));
        company.setUpdatedAt(rs.getTimestamp("updated_at"));
        return company;
    }
} 