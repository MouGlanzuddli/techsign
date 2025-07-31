package util;

// import jakarta.mail.*;
// import jakarta.mail.internet.*;
import java.util.Properties;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class EmailUtil {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;
    private static String SMTP_USERNAME = "vonguyenbaochau@gmail.com"; // Will be loaded from config
    private static String SMTP_PASSWORD = "onzt tqlw ckrx vwrt"; // Will be loaded from config
    private static final String CONFIG_FILE = "email-config.properties";
    
    static {
        loadConfiguration();
    }
    
    private static void loadConfiguration() {
        try {
            File configFile = new File(CONFIG_FILE);
            if (configFile.exists()) {
                Properties props = new Properties();
                try (FileInputStream fis = new FileInputStream(configFile)) {
                    props.load(fis);
                    SMTP_USERNAME = props.getProperty("smtp.username", SMTP_USERNAME);
                    SMTP_PASSWORD = props.getProperty("smtp.password", SMTP_PASSWORD);
                }
                System.out.println("✅ Email configuration loaded from file");
            } else {
                System.out.println("⚠️  No email configuration file found, using default values");
            }
        } catch (IOException e) {
            System.err.println("❌ Error loading email configuration: " + e.getMessage());
        }
    }

    public static void sendEmail(String to, String subject, String html) {
        // Temporarily disabled - Jakarta Mail dependency issue
        System.out.println("Email sending temporarily disabled - " + to + ": " + subject);
    }

    public static boolean testConfiguration() {
        // Temporarily disabled - Jakarta Mail dependency issue
        System.out.println("Email configuration test temporarily disabled");
        return false;
    }

    public static String getSmtpUsername() {
        return SMTP_USERNAME;
    }

    public static boolean isPasswordConfigured() {
        return SMTP_PASSWORD != null && !SMTP_PASSWORD.isEmpty() && 
               !"your_app_password".equals(SMTP_PASSWORD);
    }

    public static boolean updateConfiguration(String username, String password) {
        try {
            Properties props = new Properties();
            props.setProperty("smtp.username", username);
            props.setProperty("smtp.password", password);
            
            File configFile = new File(CONFIG_FILE);
            try (FileOutputStream fos = new FileOutputStream(configFile)) {
                props.store(fos, "Email Configuration");
            }
            
            // Reload configuration
            reloadConfiguration();
            return true;
        } catch (IOException e) {
            System.err.println("Error updating email configuration: " + e.getMessage());
            return false;
        }
    }

    public static void reloadConfiguration() {
        loadConfiguration();
    }

    public static String getConfigFilePath() {
        return CONFIG_FILE;
    }

    public static void sendPostApprovalEmail(String toEmail, String postTitle, String viewUrl) {
        // Temporarily disabled - Jakarta Mail dependency issue
        System.out.println("Post approval email temporarily disabled - " + toEmail + ": " + postTitle);
    }

    public static void sendPostRejectionEmail(String toEmail, String postTitle, String reason, String editUrl) {
        // Temporarily disabled - Jakarta Mail dependency issue
        System.out.println("Post rejection email temporarily disabled - " + toEmail + ": " + postTitle);
    }
} 