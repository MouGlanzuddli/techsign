package dal;

import model.EmailOtp;
import java.sql.*;
import java.util.Date;

public class EmailOtpDao {
    private final Connection connection;
    
    public EmailOtpDao(Connection connection) {
        this.connection = connection;
    }
    
    // Tạo OTP mới
    public boolean insertOtp(EmailOtp otp) throws SQLException {
        String sql = "INSERT INTO email_otp (user_id, otp_code, action_type, attempts, expires_at, is_used, ip_address, device_info, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, otp.getUserId());
            stmt.setString(2, otp.getOtpCode());
            stmt.setString(3, otp.getActionType());
            stmt.setInt(4, otp.getAttempts());
            stmt.setTimestamp(5, new Timestamp(otp.getExpiresAt().getTime()));
            stmt.setBoolean(6, otp.isUsed());
            stmt.setString(7, otp.getIpAddress());
            stmt.setString(8, otp.getDeviceInfo());
            stmt.setTimestamp(9, new Timestamp(otp.getCreatedAt().getTime()));
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Lấy OTP mới nhất theo user_id và action_type
    public EmailOtp getLatestOtpByUserAndAction(int userId, String actionType) throws SQLException {
        String sql = "SELECT TOP 1 * FROM email_otp WHERE user_id = ? AND action_type = ? ORDER BY created_at DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, actionType);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToOtp(rs);
            }
        }
        return null;
    }
    
    // Xác thực OTP
    public boolean verifyOtp(int userId, String otpCode, String actionType) throws SQLException {
        String sql = "SELECT * FROM email_otp WHERE user_id = ? AND otp_code = ? AND action_type = ? AND is_used = 0 AND expires_at > GETDATE()";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, otpCode);
            stmt.setString(3, actionType);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Đánh dấu OTP đã được sử dụng
                markOtpAsUsed(rs.getInt("id"));
                return true;
            }
        }
        return false;
    }
    
    // Tăng số lần thử
    public void incrementAttempts(int otpId) throws SQLException {
        String sql = "UPDATE email_otp SET attempts = attempts + 1 WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, otpId);
            stmt.executeUpdate();
        }
    }
    
    // Đánh dấu OTP đã sử dụng
    private void markOtpAsUsed(int otpId) throws SQLException {
        String sql = "UPDATE email_otp SET is_used = 1 WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, otpId);
            stmt.executeUpdate();
        }
    }
    
    // Kiểm tra số lần thử
    public int getAttemptCount(int userId, String actionType) throws SQLException {
        String sql = "SELECT TOP 1 attempts FROM email_otp WHERE user_id = ? AND action_type = ? ORDER BY created_at DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, actionType);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("attempts");
            }
        }
        return 0;
    }
    
    // Xóa OTP cũ (cleanup)
    public void deleteExpiredOtps() throws SQLException {
        String sql = "DELETE FROM email_otp WHERE expires_at < GETDATE() OR is_used = 1";
        try (Statement stmt = connection.createStatement()) {
            stmt.executeUpdate(sql);
        }
    }
    
    // Helper method
    private EmailOtp mapResultSetToOtp(ResultSet rs) throws SQLException {
        EmailOtp otp = new EmailOtp();
        otp.setId(rs.getInt("id"));
        otp.setUserId(rs.getInt("user_id"));
        otp.setOtpCode(rs.getString("otp_code"));
        otp.setActionType(rs.getString("action_type"));
        otp.setAttempts(rs.getInt("attempts"));
        otp.setExpiresAt(rs.getTimestamp("expires_at"));
        otp.setUsed(rs.getBoolean("is_used"));
        otp.setIpAddress(rs.getString("ip_address"));
        otp.setDeviceInfo(rs.getString("device_info"));
        otp.setCreatedAt(rs.getTimestamp("created_at"));
        return otp;
    }
}
