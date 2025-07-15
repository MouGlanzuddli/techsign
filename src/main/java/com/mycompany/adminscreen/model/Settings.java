package com.mycompany.adminscreen.model;

public class Settings {
    // Security
    private int minPasswordLength;
    private int passwordExpiryDays;
    private boolean requireUppercase;
    private boolean requireLowercase;
    private boolean requireNumber;
    private boolean requireSpecial;
    private int sessionTimeout;
    private int maxLoginAttempts;
    private int lockoutDuration;
    private boolean enable2FA;
    // App
    private String appName;
    private String appLogo;
    private String appDescription;
    private String defaultLanguage;
    private String defaultTimezone;
    private String dateFormat;
    private String timeFormat;
    // Email
    private String smtpHost;
    private String smtpPort;
    private String smtpUsername;
    private String smtpPassword;
    private String smtpEncryption;
    private String senderEmail;
    private String senderName;
    private boolean enableEmail;
    private boolean enableSMS;
    // Data
    private int auditLogRetention;
    private int maxFileSize;
    private String backupFrequency;
    private boolean enableAudit;
    private boolean enableAutoBackup;
    // Maintenance
    private boolean maintenanceMode;
    private String maintenanceMessage;
    private String maintenanceStart;
    private String maintenanceEnd;

    // Getters and setters for all fields
    public int getMinPasswordLength() { return minPasswordLength; }
    public void setMinPasswordLength(int minPasswordLength) { this.minPasswordLength = minPasswordLength; }
    public int getPasswordExpiryDays() { return passwordExpiryDays; }
    public void setPasswordExpiryDays(int passwordExpiryDays) { this.passwordExpiryDays = passwordExpiryDays; }
    public boolean isRequireUppercase() { return requireUppercase; }
    public void setRequireUppercase(boolean requireUppercase) { this.requireUppercase = requireUppercase; }
    public boolean isRequireLowercase() { return requireLowercase; }
    public void setRequireLowercase(boolean requireLowercase) { this.requireLowercase = requireLowercase; }
    public boolean isRequireNumber() { return requireNumber; }
    public void setRequireNumber(boolean requireNumber) { this.requireNumber = requireNumber; }
    public boolean isRequireSpecial() { return requireSpecial; }
    public void setRequireSpecial(boolean requireSpecial) { this.requireSpecial = requireSpecial; }
    public int getSessionTimeout() { return sessionTimeout; }
    public void setSessionTimeout(int sessionTimeout) { this.sessionTimeout = sessionTimeout; }
    public int getMaxLoginAttempts() { return maxLoginAttempts; }
    public void setMaxLoginAttempts(int maxLoginAttempts) { this.maxLoginAttempts = maxLoginAttempts; }
    public int getLockoutDuration() { return lockoutDuration; }
    public void setLockoutDuration(int lockoutDuration) { this.lockoutDuration = lockoutDuration; }
    public boolean isEnable2FA() { return enable2FA; }
    public void setEnable2FA(boolean enable2fa) { this.enable2FA = enable2fa; }
    public String getAppName() { return appName; }
    public void setAppName(String appName) { this.appName = appName; }
    public String getAppLogo() { return appLogo; }
    public void setAppLogo(String appLogo) { this.appLogo = appLogo; }
    public String getAppDescription() { return appDescription; }
    public void setAppDescription(String appDescription) { this.appDescription = appDescription; }
    public String getDefaultLanguage() { return defaultLanguage; }
    public void setDefaultLanguage(String defaultLanguage) { this.defaultLanguage = defaultLanguage; }
    public String getDefaultTimezone() { return defaultTimezone; }
    public void setDefaultTimezone(String defaultTimezone) { this.defaultTimezone = defaultTimezone; }
    public String getDateFormat() { return dateFormat; }
    public void setDateFormat(String dateFormat) { this.dateFormat = dateFormat; }
    public String getTimeFormat() { return timeFormat; }
    public void setTimeFormat(String timeFormat) { this.timeFormat = timeFormat; }
    public String getSmtpHost() { return smtpHost; }
    public void setSmtpHost(String smtpHost) { this.smtpHost = smtpHost; }
    public String getSmtpPort() { return smtpPort; }
    public void setSmtpPort(String smtpPort) { this.smtpPort = smtpPort; }
    public String getSmtpUsername() { return smtpUsername; }
    public void setSmtpUsername(String smtpUsername) { this.smtpUsername = smtpUsername; }
    public String getSmtpPassword() { return smtpPassword; }
    public void setSmtpPassword(String smtpPassword) { this.smtpPassword = smtpPassword; }
    public String getSmtpEncryption() { return smtpEncryption; }
    public void setSmtpEncryption(String smtpEncryption) { this.smtpEncryption = smtpEncryption; }
    public String getSenderEmail() { return senderEmail; }
    public void setSenderEmail(String senderEmail) { this.senderEmail = senderEmail; }
    public String getSenderName() { return senderName; }
    public void setSenderName(String senderName) { this.senderName = senderName; }
    public boolean isEnableEmail() { return enableEmail; }
    public void setEnableEmail(boolean enableEmail) { this.enableEmail = enableEmail; }
    public boolean isEnableSMS() { return enableSMS; }
    public void setEnableSMS(boolean enableSMS) { this.enableSMS = enableSMS; }
    public int getAuditLogRetention() { return auditLogRetention; }
    public void setAuditLogRetention(int auditLogRetention) { this.auditLogRetention = auditLogRetention; }
    public int getMaxFileSize() { return maxFileSize; }
    public void setMaxFileSize(int maxFileSize) { this.maxFileSize = maxFileSize; }
    public String getBackupFrequency() { return backupFrequency; }
    public void setBackupFrequency(String backupFrequency) { this.backupFrequency = backupFrequency; }
    public boolean isEnableAudit() { return enableAudit; }
    public void setEnableAudit(boolean enableAudit) { this.enableAudit = enableAudit; }
    public boolean isEnableAutoBackup() { return enableAutoBackup; }
    public void setEnableAutoBackup(boolean enableAutoBackup) { this.enableAutoBackup = enableAutoBackup; }
    public boolean isMaintenanceMode() { return maintenanceMode; }
    public void setMaintenanceMode(boolean maintenanceMode) { this.maintenanceMode = maintenanceMode; }
    public String getMaintenanceMessage() { return maintenanceMessage; }
    public void setMaintenanceMessage(String maintenanceMessage) { this.maintenanceMessage = maintenanceMessage; }
    public String getMaintenanceStart() { return maintenanceStart; }
    public void setMaintenanceStart(String maintenanceStart) { this.maintenanceStart = maintenanceStart; }
    public String getMaintenanceEnd() { return maintenanceEnd; }
    public void setMaintenanceEnd(String maintenanceEnd) { this.maintenanceEnd = maintenanceEnd; }
} 