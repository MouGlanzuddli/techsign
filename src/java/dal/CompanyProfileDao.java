package dal;

import java.sql.*;
import model.User;

public class CompanyProfileDao {
    private final Connection connection;

    public CompanyProfileDao(Connection connection) {
        this.connection = connection;
    }

    public CompanyProfileDao() throws SQLException {
        DBContext dbContext = new DBContext();
        this.connection = dbContext.getConnection();
    }

    public int getCompanyProfileIdByUserId(int userId) throws SQLException {
        String sql = "SELECT id FROM company_profiles WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        }
        return -1; // Not found
    }

    public boolean updateCompanyLogo(int companyProfileId, String logoUrl) throws SQLException {
        String sql = "UPDATE company_profiles SET logo_url = ?, updated_at = GETDATE() WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, logoUrl);
            stmt.setInt(2, companyProfileId);
            return stmt.executeUpdate() > 0;
        }
    }

    public String getCompanyName(int companyProfileId) throws SQLException {
        String sql = "SELECT company_name FROM company_profiles WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, companyProfileId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("company_name");
            }
        }
        return null;
    }

    // Add method to get company logo
    public String getCompanyLogo(int companyProfileId) throws SQLException {
        String sql = "SELECT logo_url FROM company_profiles WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, companyProfileId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String logoUrl = rs.getString("logo_url");
                return logoUrl != null ? logoUrl : "assets/img/l-1.png";
            }
        }
        return "assets/img/l-1.png"; // Default logo
    }

    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
    