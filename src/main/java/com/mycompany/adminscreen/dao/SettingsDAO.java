package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.Settings;
import java.sql.*;

public class SettingsDAO {
    private Connection getConnection() throws SQLException {
        // Update with your DB connection
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "user", "password");
    }

    public Settings loadSettings() {
        Settings s = new Settings();
        String sql = "SELECT key_name, value FROM system_settings";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String key = rs.getString("key_name");
                String value = rs.getString("value");
                switch (key) {
                    case "minPasswordLength": s.setMinPasswordLength(Integer.parseInt(value)); break;
                    case "passwordExpiryDays": s.setPasswordExpiryDays(Integer.parseInt(value)); break;
                    case "requireUppercase": s.setRequireUppercase(Boolean.parseBoolean(value)); break;
                    case "requireLowercase": s.setRequireLowercase(Boolean.parseBoolean(value)); break;
                    case "requireNumber": s.setRequireNumber(Boolean.parseBoolean(value)); break;
                    case "requireSpecial": s.setRequireSpecial(Boolean.parseBoolean(value)); break;
                    case "sessionTimeout": s.setSessionTimeout(Integer.parseInt(value)); break;
                    case "maxLoginAttempts": s.setMaxLoginAttempts(Integer.parseInt(value)); break;
                    case "lockoutDuration": s.setLockoutDuration(Integer.parseInt(value)); break;
                    case "enable2FA": s.setEnable2FA(Boolean.parseBoolean(value)); break;
                    case "appName": s.setAppName(value); break;
                    case "appLogo": s.setAppLogo(value); break;
                    case "appDescription": s.setAppDescription(value); break;
                    case "defaultLanguage": s.setDefaultLanguage(value); break;
                    case "defaultTimezone": s.setDefaultTimezone(value); break;
                    case "dateFormat": s.setDateFormat(value); break;
                    case "timeFormat": s.setTimeFormat(value); break;
                    case "smtpHost": s.setSmtpHost(value); break;
                    case "smtpPort": s.setSmtpPort(value); break;
                    case "smtpUsername": s.setSmtpUsername(value); break;
                    case "smtpPassword": s.setSmtpPassword(value); break;
                    case "smtpEncryption": s.setSmtpEncryption(value); break;
                    case "senderEmail": s.setSenderEmail(value); break;
                    case "senderName": s.setSenderName(value); break;
                    case "enableEmail": s.setEnableEmail(Boolean.parseBoolean(value)); break;
                    case "enableSMS": s.setEnableSMS(Boolean.parseBoolean(value)); break;
                    case "auditLogRetention": s.setAuditLogRetention(Integer.parseInt(value)); break;
                    case "maxFileSize": s.setMaxFileSize(Integer.parseInt(value)); break;
                    case "backupFrequency": s.setBackupFrequency(value); break;
                    case "enableAudit": s.setEnableAudit(Boolean.parseBoolean(value)); break;
                    case "enableAutoBackup": s.setEnableAutoBackup(Boolean.parseBoolean(value)); break;
                    case "maintenanceMode": s.setMaintenanceMode(Boolean.parseBoolean(value)); break;
                    case "maintenanceMessage": s.setMaintenanceMessage(value); break;
                    case "maintenanceStart": s.setMaintenanceStart(value); break;
                    case "maintenanceEnd": s.setMaintenanceEnd(value); break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return s;
    }

    public void saveSettings(Settings s) {
        String sql = "REPLACE INTO system_settings (key_name, value) VALUES (?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            // Save each field
            save(ps, "minPasswordLength", String.valueOf(s.getMinPasswordLength()));
            save(ps, "passwordExpiryDays", String.valueOf(s.getPasswordExpiryDays()));
            save(ps, "requireUppercase", String.valueOf(s.isRequireUppercase()));
            save(ps, "requireLowercase", String.valueOf(s.isRequireLowercase()));
            save(ps, "requireNumber", String.valueOf(s.isRequireNumber()));
            save(ps, "requireSpecial", String.valueOf(s.isRequireSpecial()));
            save(ps, "sessionTimeout", String.valueOf(s.getSessionTimeout()));
            save(ps, "maxLoginAttempts", String.valueOf(s.getMaxLoginAttempts()));
            save(ps, "lockoutDuration", String.valueOf(s.getLockoutDuration()));
            save(ps, "enable2FA", String.valueOf(s.isEnable2FA()));
            save(ps, "appName", s.getAppName());
            save(ps, "appLogo", s.getAppLogo());
            save(ps, "appDescription", s.getAppDescription());
            save(ps, "defaultLanguage", s.getDefaultLanguage());
            save(ps, "defaultTimezone", s.getDefaultTimezone());
            save(ps, "dateFormat", s.getDateFormat());
            save(ps, "timeFormat", s.getTimeFormat());
            save(ps, "smtpHost", s.getSmtpHost());
            save(ps, "smtpPort", s.getSmtpPort());
            save(ps, "smtpUsername", s.getSmtpUsername());
            save(ps, "smtpPassword", s.getSmtpPassword());
            save(ps, "smtpEncryption", s.getSmtpEncryption());
            save(ps, "senderEmail", s.getSenderEmail());
            save(ps, "senderName", s.getSenderName());
            save(ps, "enableEmail", String.valueOf(s.isEnableEmail()));
            save(ps, "enableSMS", String.valueOf(s.isEnableSMS()));
            save(ps, "auditLogRetention", String.valueOf(s.getAuditLogRetention()));
            save(ps, "maxFileSize", String.valueOf(s.getMaxFileSize()));
            save(ps, "backupFrequency", s.getBackupFrequency());
            save(ps, "enableAudit", String.valueOf(s.isEnableAudit()));
            save(ps, "enableAutoBackup", String.valueOf(s.isEnableAutoBackup()));
            save(ps, "maintenanceMode", String.valueOf(s.isMaintenanceMode()));
            save(ps, "maintenanceMessage", s.getMaintenanceMessage());
            save(ps, "maintenanceStart", s.getMaintenanceStart());
            save(ps, "maintenanceEnd", s.getMaintenanceEnd());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void save(PreparedStatement ps, String key, String value) throws SQLException {
        ps.setString(1, key);
        ps.setString(2, value);
        ps.executeUpdate();
    }
} 