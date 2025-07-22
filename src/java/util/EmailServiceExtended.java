package util;

import dao.DBContext;
import dao.SmtpConfigDao;
import model.SmtpConfig;
import javax.mail.*;
import javax.mail.internet.*;
import java.sql.Connection;
import java.util.Properties;

public class EmailServiceExtended extends EmailService {
    
    public static boolean sendPasswordResetOtpEmail(String toEmail, String otpCode, String fullName) {
        System.out.println("=== BẮT ĐẦU GỬI EMAIL RESET PASSWORD ===");
        System.out.println("Email nhận: " + toEmail);
        System.out.println("Mã OTP: " + otpCode);
        System.out.println("Tên người dùng: " + fullName);
        
        try (Connection conn = new DBContext().getConnection()) {
            SmtpConfigDao smtpDao = new SmtpConfigDao(conn);
            SmtpConfig smtpConfig = smtpDao.getActiveSmtpConfig();
            
            if (smtpConfig == null) {
                System.err.println("❌ KHÔNG TÌM THẤY CẤU HÌNH SMTP ACTIVE");
                return sendPasswordResetWithDefaultConfig(toEmail, otpCode, fullName);
            }
            
            System.out.println("✅ Tìm thấy cấu hình SMTP");
            
            Properties props = new Properties();
            props.put("mail.smtp.auth", String.valueOf(smtpConfig.isSmtpAuth()));
            props.put("mail.smtp.starttls.enable", String.valueOf(smtpConfig.isSmtpStarttls()));
            props.put("mail.smtp.host", smtpConfig.getSmtpHost());
            props.put("mail.smtp.port", smtpConfig.getSmtpPort());
            props.put("mail.debug", "true");
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(smtpConfig.getSmtpUsername(), smtpConfig.getSmtpPassword());
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(smtpConfig.getFromEmail(), smtpConfig.getFromName()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("TechSign - Đặt lại mật khẩu");
            
            String htmlContent = buildPasswordResetEmailTemplate(otpCode, fullName);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            System.out.println("✅ GỬI EMAIL RESET PASSWORD THÀNH CÔNG!");
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ LỖI KHI GỬI EMAIL RESET PASSWORD:");
            e.printStackTrace();
            return false;
        }
    }
    
    private static boolean sendPasswordResetWithDefaultConfig(String toEmail, String otpCode, String fullName) {
        System.out.println("🔄 SỬ DỤNG CẤU HÌNH MẶC ĐỊNH CHO RESET PASSWORD");
        
        final String GMAIL_USERNAME = "hhqan61@gmail.com";
        final String GMAIL_APP_PASSWORD = "uztjygdbmvlvojmu";
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.debug", "true");
        
        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(GMAIL_USERNAME, GMAIL_APP_PASSWORD);
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(GMAIL_USERNAME, "TechSign"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("TechSign - Đặt lại mật khẩu");
            
            String htmlContent = buildPasswordResetEmailTemplate(otpCode, fullName);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            System.out.println("✅ GỬI EMAIL RESET PASSWORD THÀNH CÔNG VỚI CẤU HÌNH MẶC ĐỊNH!");
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ LỖI VỚI CẤU HÌNH MẶC ĐỊNH RESET PASSWORD:");
            e.printStackTrace();
            return false;
        }
    }
    
    private static String buildPasswordResetEmailTemplate(String otpCode, String fullName) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }" +
                ".container { max-width: 600px; margin: 0 auto; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }" +
                ".header { text-align: center; margin-bottom: 30px; }" +
                ".logo { color: #17ac6a; font-size: 24px; font-weight: bold; }" +
                ".otp-code { background-color: #dc3545; color: white; font-size: 32px; font-weight: bold; padding: 15px 30px; border-radius: 8px; text-align: center; margin: 20px 0; letter-spacing: 5px; }" +
                ".warning { background-color: #fff3cd; border: 1px solid #ffeaa7; color: #856404; padding: 15px; border-radius: 8px; margin: 20px 0; }" +
                ".footer { text-align: center; margin-top: 30px; color: #666; font-size: 14px; }" +
                ".security-tips { background-color: #f8f9fa; padding: 15px; border-radius: 8px; margin: 20px 0; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<div class='logo'>TechSign</div>" +
                "<h2>🔐 Đặt lại mật khẩu</h2>" +
                "</div>" +
                "<p>Xin chào <strong>" + (fullName != null ? fullName : "bạn") + "</strong>,</p>" +
                "<p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản TechSign của bạn. Vui lòng sử dụng mã OTP dưới đây để tiếp tục:</p>" +
                "<div class='otp-code'>" + otpCode + "</div>" +
                "<div class='warning'>" +
                "<strong>⚠️ Cảnh báo bảo mật:</strong><br>" +
                "Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này và kiểm tra bảo mật tài khoản." +
                "</div>" +
                "<div class='security-tips'>" +
                "<h4>📋 Lưu ý quan trọng:</h4>" +
                "<ul>" +
                "<li>Mã OTP có hiệu lực trong <strong>10 phút</strong></li>" +
                "<li>Không chia sẻ mã này với bất kỳ ai</li>" +
                "<li>Chỉ sử dụng mã này trên trang web chính thức của TechSign</li>" +
                "<li>Sau khi đặt lại mật khẩu, hãy đăng xuất khỏi tất cả thiết bị khác</li>" +
                "</ul>" +
                "</div>" +
                "<p><strong>Mẹo bảo mật:</strong> Hãy chọn mật khẩu mạnh bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.</p>" +
                "<div class='footer'>" +
                "<p>Nếu bạn cần hỗ trợ, vui lòng liên hệ với chúng tôi.</p>" +
                "<p>Trân trọng,<br>Đội ngũ TechSign</p>" +
                "<hr>" +
                "<p style='font-size: 12px; color: #999;'>Email này được gửi tự động, vui lòng không trả lời.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
}