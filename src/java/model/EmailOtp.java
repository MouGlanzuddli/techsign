package model;

import java.util.Date;

public class EmailOtp {
    private int id;
    private int userId;
    private String otpCode;
    private String actionType;
    private int attempts;
    private Date expiresAt;
    private boolean isUsed;
    private String ipAddress;
    private String deviceInfo;
    private Date createdAt;
    
    public EmailOtp() {}
    
    public EmailOtp(int userId, String otpCode, String actionType, Date expiresAt, String ipAddress, String deviceInfo) {
        this.userId = userId;
        this.otpCode = otpCode;
        this.actionType = actionType;
        this.attempts = 0;
        this.expiresAt = expiresAt;
        this.isUsed = false;
        this.ipAddress = ipAddress;
        this.deviceInfo = deviceInfo;
        this.createdAt = new Date();
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getOtpCode() { return otpCode; }
    public void setOtpCode(String otpCode) { this.otpCode = otpCode; }
    
    public String getActionType() { return actionType; }
    public void setActionType(String actionType) { this.actionType = actionType; }
    
    public int getAttempts() { return attempts; }
    public void setAttempts(int attempts) { this.attempts = attempts; }
    
    public Date getExpiresAt() { return expiresAt; }
    public void setExpiresAt(Date expiresAt) { this.expiresAt = expiresAt; }
    
    public boolean isUsed() { return isUsed; }
    public void setUsed(boolean used) { isUsed = used; }
    
    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
    
    public String getDeviceInfo() { return deviceInfo; }
    public void setDeviceInfo(String deviceInfo) { this.deviceInfo = deviceInfo; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public boolean isExpired() {
        return new Date().after(this.expiresAt);
    }
}
