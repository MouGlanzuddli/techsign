package com.mycompany.adminscreen.model;

import java.sql.Timestamp;

public class RoleAssignmentRequest {
    private int id;
    private int userId;
    private int requestedRoleId;
    private int requestedByAdminId;
    private String status; // "pending", "accepted", "rejected"
    private String token;
    private Timestamp expiresAt;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Additional fields for convenience
    private String userEmail;
    private String userFullName;
    private String requestedRoleName;
    private String adminName;

    public RoleAssignmentRequest() {}

    public RoleAssignmentRequest(int userId, int requestedRoleId, int requestedByAdminId, String token, Timestamp expiresAt) {
        this.userId = userId;
        this.requestedRoleId = requestedRoleId;
        this.requestedByAdminId = requestedByAdminId;
        this.status = "pending";
        this.token = token;
        this.expiresAt = expiresAt;
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.updatedAt = new Timestamp(System.currentTimeMillis());
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getRequestedRoleId() { return requestedRoleId; }
    public void setRequestedRoleId(int requestedRoleId) { this.requestedRoleId = requestedRoleId; }
    
    public int getRequestedByAdminId() { return requestedByAdminId; }
    public void setRequestedByAdminId(int requestedByAdminId) { this.requestedByAdminId = requestedByAdminId; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }
    
    public Timestamp getExpiresAt() { return expiresAt; }
    public void setExpiresAt(Timestamp expiresAt) { this.expiresAt = expiresAt; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    // Convenience getters and setters
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    
    public String getUserFullName() { return userFullName; }
    public void setUserFullName(String userFullName) { this.userFullName = userFullName; }
    
    public String getRequestedRoleName() { return requestedRoleName; }
    public void setRequestedRoleName(String requestedRoleName) { this.requestedRoleName = requestedRoleName; }
    
    public String getAdminName() { return adminName; }
    public void setAdminName(String adminName) { this.adminName = adminName; }
} 