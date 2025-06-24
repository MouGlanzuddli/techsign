package util;

import dal.DBContext;
import dal.SmtpConfigDao;
import model.SmtpConfig;
import javax.mail.*;
import javax.mail.internet.*;
import java.sql.Connection;
import java.util.Properties;

public class EmailService {
    
    public static boolean sendOtpEmail(String toEmail, String otpCode) {
        System.out.println("=== BẮT ĐẦU GỬI EMAIL OTP ===");
        System.out.println("Email nhận: " + toEmail);
        System.out.println("Mã OTP: " + otpCode);
        
        try (Connection conn = new DBContext().getConnection()) {
            SmtpConfigDao smtpDao = new SmtpConfigDao(conn);
            SmtpConfig smtpConfig = smtpDao.getActiveSmtpConfig();
            
            if (smtpConfig == null) {
                System.err.println("❌ KHÔNG TÌM THẤY CẤU HÌNH SMTP ACTIVE");
                // Fallback to default Gmail config for testing
                return sendWithDefaultConfig(toEmail, otpCode);
            }
            
            System.out.println("✅ Tìm thấy cấu hình SMTP:");
            System.out.println("- Host: " + smtpConfig.getSmtpHost());
            System.out.println("- Port: " + smtpConfig.getSmtpPort());
            System.out.println("- Username: " + smtpConfig.getSmtpUsername());
            System.out.println("- From Email: " + smtpConfig.getFromEmail());
            System.out.println("- Auth: " + smtpConfig.isSmtpAuth());
            System.out.println("- STARTTLS: " + smtpConfig.isSmtpStarttls());
            
            Properties props = new Properties();
            props.put("mail.smtp.auth", String.valueOf(smtpConfig.isSmtpAuth()));
            props.put("mail.smtp.starttls.enable", String.valueOf(smtpConfig.isSmtpStarttls()));
            props.put("mail.smtp.host", smtpConfig.getSmtpHost());
            props.put("mail.smtp.port", smtpConfig.getSmtpPort());
            props.put("mail.debug", "true"); // Enable debug mode
            
            System.out.println("🔧 Tạo session...");
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    System.out.println("🔑 Xác thực với username: " + smtpConfig.getSmtpUsername());
                    return new PasswordAuthentication(smtpConfig.getSmtpUsername(), smtpConfig.getSmtpPassword());
                }
            });
            
            session.setDebug(true); // Enable session debug
            
            System.out.println("📧 Tạo message...");
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(smtpConfig.getFromEmail(), smtpConfig.getFromName()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("TechSign - Mã xác thực email");
            
            String htmlContent = buildEmailTemplate(otpCode);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            System.out.println("🚀 Gửi email...");
            Transport.send(message);
            System.out.println("✅ GỬI EMAIL THÀNH CÔNG!");
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ LỖI KHI GỬI EMAIL:");
            e.printStackTrace();
            
            // Print detailed error information
            if (e instanceof AuthenticationFailedException) {
                System.err.println("🔑 LỖI XÁC THỰC - Kiểm tra username/password");
            } else if (e instanceof MessagingException) {
                System.err.println("📧 LỖI MESSAGING: " + e.getMessage());
            }
            
            return false;
        }
    }
    
    // Fallback method with hardcoded Gmail config for testing
    private static boolean sendWithDefaultConfig(String toEmail, String otpCode) {
        System.out.println("🔄 SỬ DỤNG CẤU HÌNH MẶC ĐỊNH (GMAIL)");
        
        // THAY ĐỔI THÔNG TIN NÀY BẰNG EMAIL GMAIL CỦA BẠN
        final String GMAIL_USERNAME = "hhqan61@gmail.com"; // ⚠️ THAY ĐỔI
        final String GMAIL_APP_PASSWORD = "uztjygdbmvlvojmu"; // ⚠️ THAY ĐỔI
        
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
            
            session.setDebug(true);
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(GMAIL_USERNAME, "TechSign"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("TechSign - Mã xác thực email");
            
            String htmlContent = buildEmailTemplate(otpCode);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            System.out.println("✅ GỬI EMAIL THÀNH CÔNG VỚI CẤU HÌNH MẶC ĐỊNH!");
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ LỖI VỚI CẤU HÌNH MẶC ĐỊNH:");
            e.printStackTrace();
            return false;
        }
    }
    
    private static String buildEmailTemplate(String otpCode) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }" +
                ".container { max-width: 600px; margin: 0 auto; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }" +
                ".header { text-align: center; margin-bottom: 30px; }" +
                ".logo { color: #17ac6a; font-size: 24px; font-weight: bold; }" +
                ".otp-code { background-color: #17ac6a; color: white; font-size: 32px; font-weight: bold; padding: 15px 30px; border-radius: 8px; text-align: center; margin: 20px 0; letter-spacing: 5px; }" +
                ".footer { text-align: center; margin-top: 30px; color: #666; font-size: 14px; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<div class='logo'>TechSign</div>" +
                "<h2>Xác thực địa chỉ email</h2>" +
                "</div>" +
                "<p>Xin chào,</p>" +
                "<p>Bạn đã yêu cầu xác thực địa chỉ email cho tài khoản TechSign. Vui lòng sử dụng mã OTP dưới đây:</p>" +
                "<div class='otp-code'>" + otpCode + "</div>" +
                "<p><strong>Lưu ý:</strong></p>" +
                "<ul>" +
                "<li>Mã OTP có hiệu lực trong 10 phút</li>" +
                "<li>Không chia sẻ mã này với bất kỳ ai</li>" +
                "<li>Nếu bạn không yêu cầu xác thực này, vui lòng bỏ qua email</li>" +
                "</ul>" +
                "<div class='footer'>" +
                "<p>Trân trọng,<br>Đội ngũ TechSign</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
}