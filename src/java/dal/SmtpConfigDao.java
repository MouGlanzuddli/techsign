package dal;

import model.SmtpConfig;
import java.sql.*;
import java.util.Date;

public class SmtpConfigDao {
    private final Connection connection;
    
    public SmtpConfigDao(Connection connection) {
        this.connection = connection;
    }
    
    // Lấy cấu hình SMTP đang active
    public SmtpConfig getActiveSmtpConfig() throws SQLException {
        String sql = "SELECT TOP 1 * FROM smtp_config WHERE is_active = 1 ORDER BY created_at DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToSmtpConfig(rs);
            }
        }
        return null;
    }
    
    // Lưu hoặc cập nhật cấu hình SMTP
    public boolean saveSmtpConfig(SmtpConfig config) throws SQLException {
        // Đầu tiên, deactivate tất cả config cũ
        deactivateAllConfigs();
        
        String sql = "INSERT INTO smtp_config (smtp_host, smtp_port, smtp_username, smtp_password, smtp_auth, smtp_starttls, from_email, from_name, is_active, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, config.getSmtpHost());
            stmt.setString(2, config.getSmtpPort());
            stmt.setString(3, config.getSmtpUsername());
            stmt.setString(4, config.getSmtpPassword());
            stmt.setBoolean(5, config.isSmtpAuth());
            stmt.setBoolean(6, config.isSmtpStarttls());
            stmt.setString(7, config.getFromEmail());
            stmt.setString(8, config.getFromName());
            stmt.setBoolean(9, true); // Luôn set active cho config mới
            Date now = new Date();
            stmt.setTimestamp(10, new Timestamp(now.getTime()));
            stmt.setTimestamp(11, new Timestamp(now.getTime()));
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Deactivate tất cả config
    private void deactivateAllConfigs() throws SQLException {
        String sql = "UPDATE smtp_config SET is_active = 0";
        try (Statement stmt = connection.createStatement()) {
            stmt.executeUpdate(sql);
        }
    }
    
    // Test kết nối SMTP
    public boolean testSmtpConnection(SmtpConfig config) {
        try {
            java.util.Properties props = new java.util.Properties();
            props.put("mail.smtp.auth", String.valueOf(config.isSmtpAuth()));
            props.put("mail.smtp.starttls.enable", String.valueOf(config.isSmtpStarttls()));
            props.put("mail.smtp.host", config.getSmtpHost());
            props.put("mail.smtp.port", config.getSmtpPort());
            
            javax.mail.Session session = javax.mail.Session.getInstance(props, new javax.mail.Authenticator() {
                @Override
                protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new javax.mail.PasswordAuthentication(config.getSmtpUsername(), config.getSmtpPassword());
                }
            });
            
            // Thử kết nối
            javax.mail.Transport transport = session.getTransport("smtp");
            transport.connect(config.getSmtpHost(), Integer.parseInt(config.getSmtpPort()), 
                            config.getSmtpUsername(), config.getSmtpPassword());
            transport.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method
    private SmtpConfig mapResultSetToSmtpConfig(ResultSet rs) throws SQLException {
        SmtpConfig config = new SmtpConfig();
        config.setId(rs.getInt("id"));
        config.setSmtpHost(rs.getString("smtp_host"));
        config.setSmtpPort(rs.getString("smtp_port"));
        config.setSmtpUsername(rs.getString("smtp_username"));
        config.setSmtpPassword(rs.getString("smtp_password"));
        config.setSmtpAuth(rs.getBoolean("smtp_auth"));
        config.setSmtpStarttls(rs.getBoolean("smtp_starttls"));
        config.setFromEmail(rs.getString("from_email"));
        config.setFromName(rs.getString("from_name"));
        config.setActive(rs.getBoolean("is_active"));
        config.setCreatedAt(rs.getTimestamp("created_at"));
        config.setUpdatedAt(rs.getTimestamp("updated_at"));
        return config;
    }
}
