package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Companies;
import connectDB.DBContext;

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
                    return c;
                }
            }
        }
        return null;
    }

}
