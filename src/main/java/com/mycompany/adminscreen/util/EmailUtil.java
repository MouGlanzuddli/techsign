package com.mycompany.adminscreen.util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
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

    public static void sendEmail(String to, String subject, String html) throws MessagingException {
        if (to == null || to.trim().isEmpty()) {
            throw new IllegalArgumentException("Recipient email address cannot be null or empty");
        }

        // Validate configuration
        if ("your_gmail@gmail.com".equals(SMTP_USERNAME) || "your_app_password".equals(SMTP_PASSWORD)) {
            throw new IllegalStateException("Email configuration not set up. Please update SMTP_USERNAME and SMTP_PASSWORD in EmailUtil.java");
        }

        System.out.println("=== EMAIL CONFIGURATION DEBUG ===");
        System.out.println("SMTP Host: " + SMTP_HOST);
        System.out.println("SMTP Port: " + SMTP_PORT);
        System.out.println("SMTP Username: " + SMTP_USERNAME);
        System.out.println("SMTP Password: " + (SMTP_PASSWORD != null ? "***configured***" : "NOT CONFIGURED"));
        System.out.println("Recipient: " + to);
        System.out.println("Subject: " + subject);
        System.out.println("================================");

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.ssl.trust", SMTP_HOST);
        
        // Add debug properties for troubleshooting
        props.put("mail.debug", "true");
        props.put("mail.debug.auth", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                System.out.println("Authenticating with SMTP server...");
                return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
            }
        });

        try {
            System.out.println("Creating email message...");
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(html, "text/html; charset=utf-8");
            
            System.out.println("Sending email...");
            Transport.send(message);
            System.out.println("✅ Email sent successfully to: " + to);
            
        } catch (MessagingException e) {
            System.err.println("❌ Failed to send email to " + to);
            System.err.println("Error type: " + e.getClass().getSimpleName());
            System.err.println("Error message: " + e.getMessage());
            
            // Provide specific error guidance
            if (e.getMessage().contains("Authentication failed")) {
                System.err.println("💡 TROUBLESHOOTING: Authentication failed. Check your Gmail username and app password.");
                System.err.println("   - Make sure you're using an App Password, not your regular Gmail password");
                System.err.println("   - Enable 2-factor authentication on your Gmail account");
                System.err.println("   - Generate an App Password: https://myaccount.google.com/apppasswords");
            } else if (e.getMessage().contains("Connection refused")) {
                System.err.println("💡 TROUBLESHOOTING: Connection refused. Check your internet connection and firewall settings.");
            } else if (e.getMessage().contains("Invalid Address")) {
                System.err.println("💡 TROUBLESHOOTING: Invalid email address format.");
            }
            
            throw e;
        }
    }
    
    /**
     * Test email configuration without sending an actual email
     */
    public static boolean testConfiguration() {
        try {
            if ("your_gmail@gmail.com".equals(SMTP_USERNAME) || "your_app_password".equals(SMTP_PASSWORD)) {
                System.err.println("❌ Email configuration not set up");
                return false;
            }
            
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.trust", SMTP_HOST);
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
                }
            });
            
            // Test connection
            Transport transport = session.getTransport("smtp");
            transport.connect(SMTP_HOST, SMTP_PORT, SMTP_USERNAME, SMTP_PASSWORD);
            transport.close();
            
            System.out.println("✅ Email configuration test successful");
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ Email configuration test failed: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get the current SMTP username
     */
    public static String getSmtpUsername() {
        return SMTP_USERNAME;
    }
    
    /**
     * Check if password is configured (not the default placeholder)
     */
    public static boolean isPasswordConfigured() {
        return !("your_app_password".equals(SMTP_PASSWORD) || SMTP_PASSWORD == null || SMTP_PASSWORD.trim().isEmpty());
    }
    
    /**
     * Update email configuration
     * Note: This is a simplified implementation. In a production environment,
     * you would want to store these in a configuration file or database.
     */
    public static boolean updateConfiguration(String username, String password) {
        try {
            // Validate input
            if (username == null || username.trim().isEmpty()) {
                System.err.println("❌ Username cannot be empty");
                return false;
            }
            
            if (password == null || password.trim().isEmpty()) {
                System.err.println("❌ Password cannot be empty");
                return false;
            }
            
            // Save configuration to file
            Properties props = new Properties();
            props.setProperty("smtp.username", username);
            props.setProperty("smtp.password", password);
            
            try (FileOutputStream fos = new FileOutputStream(CONFIG_FILE)) {
                props.store(fos, "Email Configuration - Updated on " + new java.util.Date());
                System.out.println("✅ Email configuration saved to file: " + CONFIG_FILE);
            }
            
            // Update current values
            SMTP_USERNAME = username;
            SMTP_PASSWORD = password;
            
            System.out.println("=== EMAIL CONFIGURATION UPDATE ===");
            System.out.println("New Username: " + username);
            System.out.println("New Password: " + (password != null ? "***configured***" : "NOT SET"));
            System.out.println("Configuration file: " + CONFIG_FILE);
            System.out.println("==================================");
            
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ Failed to update email configuration: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Reload configuration from file
     */
    public static void reloadConfiguration() {
        loadConfiguration();
    }
    
    /**
     * Get configuration file path
     */
    public static String getConfigFilePath() {
        return new File(CONFIG_FILE).getAbsolutePath();
    }
} 