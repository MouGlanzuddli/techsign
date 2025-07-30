package model;

import java.util.Date;

/**
 * Message model để lưu trữ tin nhắn chat
 */
public class Message {
    private int id;
    private int senderId;
    private int receiverId;
    private String content;
    private String messageType; // 'text', 'file', 'image'
    private String fileUrl;
    private Date sentAt;
    private boolean isRead;

    // Constructors
    public Message() {}

    public Message(int senderId, int receiverId, String content, String messageType) {
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.content = content;
        this.messageType = messageType;
        this.sentAt = new Date();
        this.isRead = false;
    }

    public Message(int senderId, int receiverId, String content, String messageType, String fileUrl) {
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.content = content;
        this.messageType = messageType;
        this.fileUrl = fileUrl;
        this.sentAt = new Date();
        this.isRead = false;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getSenderId() { return senderId; }
    public void setSenderId(int senderId) { this.senderId = senderId; }

    public int getReceiverId() { return receiverId; }
    public void setReceiverId(int receiverId) { this.receiverId = receiverId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getMessageType() { return messageType; }
    public void setMessageType(String messageType) { this.messageType = messageType; }

    public String getFileUrl() { return fileUrl; }
    public void setFileUrl(String fileUrl) { this.fileUrl = fileUrl; }

    public Date getSentAt() { return sentAt; }
    public void setSentAt(Date sentAt) { this.sentAt = sentAt; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }

    // Helper methods
    public boolean isTextMessage() {
        return "text".equals(messageType);
    }

    public boolean isFileMessage() {
        return "file".equals(messageType);
    }

    public boolean isImageMessage() {
        return "image".equals(messageType);
    }
} 