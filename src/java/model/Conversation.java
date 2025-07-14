package model;

import java.util.Date;

public class Conversation {
    private int id;
    private int participant1Id;
    private int participant2Id;
    private int lastMessageId; // ID of the last message in this conversation
    private Date createdAt;
    private Date updatedAt;

    // Transient fields for display purposes
    private User participant1;
    private User participant2;
    private Message lastMessage;
    private int unreadCount; // Number of unread messages for the current user

    public Conversation() {
        Date now = new Date();
        this.createdAt = now;
        this.updatedAt = now;
    }

    public Conversation(int participant1Id, int participant2Id) {
        this();
        this.participant1Id = participant1Id;
        this.participant2Id = participant2Id;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getParticipant1Id() { return participant1Id; }
    public void setParticipant1Id(int participant1Id) { this.participant1Id = participant1Id; }

    public int getParticipant2Id() { return participant2Id; }
    public void setParticipant2Id(int participant2Id) { this.participant2Id = participant2Id; }

    public int getLastMessageId() { return lastMessageId; }
    public void setLastMessageId(int lastMessageId) { this.lastMessageId = lastMessageId; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public User getParticipant1() { return participant1; }
    public void setParticipant1(User participant1) { this.participant1 = participant1; }

    public User getParticipant2() { return participant2; }
    public void setParticipant2(User participant2) { this.participant2 = participant2; }

    public Message getLastMessage() { return lastMessage; }
    public void setLastMessage(Message lastMessage) { this.lastMessage = lastMessage; }

    public int getUnreadCount() { return unreadCount; }
    public void setUnreadCount(int unreadCount) { this.unreadCount = unreadCount; }
}
