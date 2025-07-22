package dal;

import java.sql.*;
import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Companies;

public class favouriteCompanyDAO {

    public List<Companies> getFavouriteCompaniesByUserId(int userId, String keyword, int offset, int limit) {
        List<Companies> list = new ArrayList<>();
        String sql = "SELECT cp.* FROM user_favourite uf "
                + "JOIN company_profiles cp ON uf.entity_id = cp.id "
                + "WHERE uf.user_id = ? AND cp.company_name LIKE ? "
                + "ORDER BY cp.id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, "%" + keyword + "%");
            ps.setInt(3, offset);
            ps.setInt(4, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Companies c = new Companies();
                c.setId(rs.getInt("id"));
                c.setUserId(rs.getInt("user_id"));
                c.setCompanyName(rs.getString("company_name"));
                c.setAddress(rs.getString("address"));
                c.setWebsite(rs.getString("website"));
                c.setDescription(rs.getString("description"));
                c.setIndustryID(rs.getInt("industry_id"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countFavouriteCompaniesByUserId(int userId, String keyword) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM user_favourite uf "
                + "JOIN company_profiles cp ON uf.entity_id = cp.id "
                + "WHERE uf.user_id = ? AND cp.company_name LIKE ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}
