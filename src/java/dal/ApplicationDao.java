package dal;

import model.Application;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDao {
    private final Connection connection;

    public ApplicationDao(Connection connection) {
        this.connection = connection;
    }

    public ApplicationDao() throws SQLException {
        DBContext dbContext = new DBContext();
        this.connection = dbContext.getConnection();
    }

    public List<Application> getApplicationsByJobId(int jobId) throws SQLException {
        String sql = "SELECT * FROM applications WHERE job_posting_id = ? ORDER BY applied_at DESC";
        List<Application> list = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setJobPostingId(rs.getInt("job_posting_id"));
                app.setCandidateProfileId(rs.getInt("candidate_profile_id"));
                app.setCandidateCvId(rs.getInt("candidate_cv_id"));
                app.setCoverLetter(rs.getString("cover_letter"));
                app.setStatus(rs.getString("status"));
                app.setAppliedAt(rs.getTimestamp("applied_at"));
                app.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(app);
            }
        }
        return list;
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