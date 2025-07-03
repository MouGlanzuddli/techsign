package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.JobAttachment;

public class JobAttachmentDao {
    private final Connection connection;

    public JobAttachmentDao(Connection connection) {
        this.connection = connection;
    }

    public JobAttachmentDao() throws SQLException {
        DBContext dbContext = new DBContext();
        this.connection = dbContext.getConnection();
    }

    public boolean insertJobAttachment(JobAttachment attachment) throws SQLException {
        String sql = "INSERT INTO job_attachments (job_posting_id, file_name, file_url, file_type, file_size, uploaded_at) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, attachment.getJobPostingId());
            stmt.setString(2, attachment.getFileName());
            stmt.setString(3, attachment.getFileUrl());
            stmt.setString(4, attachment.getFileType());
            stmt.setLong(5, attachment.getFileSize());
            stmt.setTimestamp(6, new Timestamp(attachment.getUploadedAt().getTime()));
            
            return stmt.executeUpdate() > 0;
        }
    }

    public List<JobAttachment> getAttachmentsByJobId(int jobPostingId) throws SQLException {
        String sql = "SELECT * FROM job_attachments WHERE job_posting_id = ?";
        List<JobAttachment> attachments = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobPostingId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                attachments.add(mapResultSetToJobAttachment(rs));
            }
        }
        return attachments;
    }

    public boolean deleteAttachment(int id) throws SQLException {
        String sql = "DELETE FROM job_attachments WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private JobAttachment mapResultSetToJobAttachment(ResultSet rs) throws SQLException {
        JobAttachment attachment = new JobAttachment();
        attachment.setId(rs.getInt("id"));
        attachment.setJobPostingId(rs.getInt("job_posting_id"));
        attachment.setFileName(rs.getString("file_name"));
        attachment.setFileUrl(rs.getString("file_url"));
        attachment.setFileType(rs.getString("file_type"));
        attachment.setFileSize(rs.getLong("file_size"));
        attachment.setUploadedAt(rs.getTimestamp("uploaded_at"));
        return attachment;
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
