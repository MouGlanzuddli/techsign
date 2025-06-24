package model;

import java.util.Date;

public class Candidate {
    private int id;
    private int userId;
    private String fullName;
    private String title; // Current job title
    private int experienceYears;
    private String skills;
    private String education;
    private String location;
    private String bio;
    private String resumeUrl;
    private boolean isSearchable; // Profile visibility
    private Date createdAt;
    private Date updatedAt;

    public Candidate() {}

    public Candidate(int id, int userId, String fullName, String title, int experienceYears,
                    String skills, String education, String location, String bio, 
                    String resumeUrl, boolean isSearchable, Date createdAt, Date updatedAt) {
        this.id = id;
        this.userId = userId;
        this.fullName = fullName;
        this.title = title;
        this.experienceYears = experienceYears;
        this.skills = skills;
        this.education = education;
        this.location = location;
        this.bio = bio;
        this.resumeUrl = resumeUrl;
        this.isSearchable = isSearchable;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getExperienceYears() { return experienceYears; }
    public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public String getEducation() { return education; }
    public void setEducation(String education) { this.education = education; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public String getResumeUrl() { return resumeUrl; }
    public void setResumeUrl(String resumeUrl) { this.resumeUrl = resumeUrl; }

    public boolean isSearchable() { return isSearchable; }
    public void setSearchable(boolean isSearchable) { this.isSearchable = isSearchable; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
} 