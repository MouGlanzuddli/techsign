/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */

    public class User {
    private int id;
    private int roleId;
    private String email;
    private String phone;
    private String passwordHash;
    private String fullName;
    private boolean isEmailVerified;
    private boolean isPhoneVerified;
    private String avatarUrl;
    private String status;
    private Date createdAt;
    private Date updatedAt;

    // Constructors
    public User() {}

    public User(int id, int roleId, String email, String phone, String passwordHash,
                String fullName, boolean isEmailVerified, boolean isPhoneVerified,
                String avatarUrl, String status, Date createdAt, Date updatedAt) {
        this.id = id;
        this.roleId = roleId;
        this.email = email;
        this.phone = phone;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.isEmailVerified = isEmailVerified;
        this.isPhoneVerified = isPhoneVerified;
        this.avatarUrl = avatarUrl;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public boolean isEmailVerified() { return isEmailVerified; }
    public void setEmailVerified(boolean emailVerified) { isEmailVerified = emailVerified; }

    public boolean isPhoneVerified() { return isPhoneVerified; }
    public void setPhoneVerified(boolean phoneVerified) { isPhoneVerified = phoneVerified; }

    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}

