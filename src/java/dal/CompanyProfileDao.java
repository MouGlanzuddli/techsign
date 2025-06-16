package dal;

import model.CompanyProfile;
import java.sql.*;

public class CompanyProfileDao {
    private final Connection connection;

    public CompanyProfileDao(Connection connection) {
        this.connection = connection;
    }

    public CompanyProfile getCompanyByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM company_profiles WHERE user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToCompanyProfile(rs);
            }
        }
        
        return null;
    }

    public CompanyProfile getCompanyById(int id) throws SQLException {
        String sql = "SELECT * FROM company_profiles WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToCompanyProfile(rs);
            }
        }
        
        return null;
    }

    private CompanyProfile mapResultSetToCompanyProfile(ResultSet rs) throws SQLException {
        CompanyProfile company = new CompanyProfile();
        company.setId(rs.getInt("id"));
        company.setUserId(rs.getInt("user_id"));
        company.setIndustryId(rs.getInt("industry_id"));
        company.setCompanyName(rs.getString("company_name"));
        company.setWebsite(rs.getString("website"));
        company.setDescription(rs.getString("description"));
        company.setAddress(rs.getString("address"));
        company.setPhone(rs.getString("phone"));
        company.setLogoUrl(rs.getString("logo_url"));
        company.setBannerUrl(rs.getString("banner_url"));
        company.setIconUrl(rs.getString("icon_url"));
        company.setFeatured(rs.getBoolean("is_featured"));
        company.setSearchable(rs.getBoolean("is_searchable"));
        company.setCreatedAt(rs.getTimestamp("created_at"));
        company.setUpdatedAt(rs.getTimestamp("updated_at"));
        return company;
    }
}
