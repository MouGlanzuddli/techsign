package model;

import java.util.Date;

public class Message {
    private int id;
    private int conversationId;
    private int senderId;
    private String content;
    private Date sentAt;
    private boolean isRead;

    // Transient field for display purposes
    private User sender;

    public Message() {
        this.sentAt = new Date();
        this.isRead = false;
    }

    public Message(int conversationId, int senderId, String content) {
        this();
        this.conversationId = conversationId;
        this.senderId = senderId;
        this.content = content;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getConversationId() { return conversationId; }
    public void setConversationId(int conversationId) { this.conversationId = conversationId; }

    public int getSenderId() { return senderId; }
    public void setSenderId(int senderId) { this.senderId = senderId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getSentAt() { return sentAt; }
    public void setSentAt(Date sentAt) { this.sentAt = sentAt; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }

    public User getSender() { return sender; }
    public void setSender(User sender) { this.sender = sender; }
}
