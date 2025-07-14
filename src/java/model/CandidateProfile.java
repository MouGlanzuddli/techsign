package model;

import java.sql.Timestamp;

/**
 * CandidateProfile: Model đại diện cho bảng candidate_profiles
 * Lưu thông tin hồ sơ chi tiết của candidate
 */
public class CandidateProfile {
    private int id;
    private int userId;
    private String headline;
    private String summary;
    private int experienceYears;
    private String educationLevel;
    private String profilePictureUrl;
    private Float aiScore;
    private String aiFeedback;
    private Boolean isSearchable;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Thêm thông tin từ join tables
    private User user;

    // Constructors
    public CandidateProfile() {
    }

    public CandidateProfile(int userId) {
        this.userId = userId;
        this.experienceYears = 0;
        this.isSearchable = true;
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.updatedAt = new Timestamp(System.currentTimeMillis());
    }

    public CandidateProfile(int userId, String headline, String summary, int experienceYears, String educationLevel) {
        this.userId = userId;
        this.headline = headline;
        this.summary = summary;
        this.experienceYears = experienceYears;
        this.educationLevel = educationLevel;
        this.isSearchable = true;
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.updatedAt = new Timestamp(System.currentTimeMillis());
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getHeadline() {
        return headline;
    }

    public void setHeadline(String headline) {
        this.headline = headline;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public int getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(int experienceYears) {
        this.experienceYears = experienceYears;
    }

    public String getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(String educationLevel) {
        this.educationLevel = educationLevel;
    }

    public String getProfilePictureUrl() {
        return profilePictureUrl;
    }

    public void setProfilePictureUrl(String profilePictureUrl) {
        this.profilePictureUrl = profilePictureUrl;
    }

    public Float getAiScore() {
        return aiScore;
    }

    public void setAiScore(Float aiScore) {
        this.aiScore = aiScore;
    }

    public String getAiFeedback() {
        return aiFeedback;
    }

    public void setAiFeedback(String aiFeedback) {
        this.aiFeedback = aiFeedback;
    }

    public Boolean getIsSearchable() {
        return isSearchable;
    }

    public void setIsSearchable(Boolean isSearchable) {
        this.isSearchable = isSearchable;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "CandidateProfile{" +
                "id=" + id +
                ", userId=" + userId +
                ", headline='" + headline + '\'' +
                ", experienceYears=" + experienceYears +
                ", educationLevel='" + educationLevel + '\'' +
                ", isSearchable=" + isSearchable +
                '}';
    }
} 