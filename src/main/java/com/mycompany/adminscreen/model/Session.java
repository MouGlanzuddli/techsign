package com.mycompany.adminscreen.model;

import java.sql.Timestamp;

public class Session {
    private int id;
    private int userId;
    private String sessionToken;
    private String ipAddress;
    private String deviceInfo;
    private Timestamp loginTime;
    private Timestamp lastActiveTime;
    private Timestamp logoutTime;
    private boolean isActive;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getSessionToken() { return sessionToken; }
    public void setSessionToken(String sessionToken) { this.sessionToken = sessionToken; }
    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
    public String getDeviceInfo() { return deviceInfo; }
    public void setDeviceInfo(String deviceInfo) { this.deviceInfo = deviceInfo; }
    public Timestamp getLoginTime() { return loginTime; }
    public void setLoginTime(Timestamp loginTime) { this.loginTime = loginTime; }
    public Timestamp getLastActiveTime() { return lastActiveTime; }
    public void setLastActiveTime(Timestamp lastActiveTime) { this.lastActiveTime = lastActiveTime; }
    public Timestamp getLogoutTime() { return logoutTime; }
    public void setLogoutTime(Timestamp logoutTime) { this.logoutTime = logoutTime; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
} 