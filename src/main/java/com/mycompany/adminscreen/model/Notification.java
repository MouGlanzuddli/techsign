package com.mycompany.adminscreen.model;

import java.sql.Timestamp;

public class Notification {
    private int id;
    private String title;
    private String message;
    private String type; // system, maintenance, security, update
    private boolean autoDismiss;
    private int durationMs;
    private Timestamp createdAt;
    private boolean pinned;

    public Notification() {}

    public Notification(String title, String message, String type, boolean autoDismiss, int durationMs, boolean pinned) {
        this.title = title;
        this.message = message;
        this.type = type;
        this.autoDismiss = autoDismiss;
        this.durationMs = durationMs;
        this.pinned = pinned;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public boolean isAutoDismiss() { return autoDismiss; }
    public void setAutoDismiss(boolean autoDismiss) { this.autoDismiss = autoDismiss; }
    public int getDurationMs() { return durationMs; }
    public void setDurationMs(int durationMs) { this.durationMs = durationMs; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public boolean isPinned() { return pinned; }
    public void setPinned(boolean pinned) { this.pinned = pinned; }
} 