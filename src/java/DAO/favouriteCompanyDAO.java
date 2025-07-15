
package DAO;
import java.sql.*;
import connectDB.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Companies;

public class favouriteCompanyDAO {
    public List<Companies> getFavouriteCompaniesByUserId(int userId) {
        List<Companies> list = new ArrayList<>();
        String sql = "SELECT cp.* FROM user_favourite uf " +
                     "JOIN company_profiles cp ON uf.entity_id = cp.id " +
                     "WHERE uf.user_id = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
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
}
