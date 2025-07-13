package model;

import java.util.Date;

public class Candidate {
    private int id;
    private int userId;
    private String fullName;
    private String jobTitle; // Current job title
    private int experienceYears;
    private String educationLevel;
    private String address;
    private boolean isSearchable; // Profile visibility
    private Date createdAt;
    private Date updatedAt;
    private String email;

    public Candidate() {}

    public Candidate(int id, int userId, String fullName, String jobTitle, int experienceYears,
                    String educationLevel, String address, 
                    boolean isSearchable, Date createdAt, Date updatedAt) {
        this.id = id;
        this.userId = userId;
        this.fullName = fullName;
        this.jobTitle = jobTitle;
        this.experienceYears = experienceYears;
        this.educationLevel = educationLevel;
        this.address = address;
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

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public int getExperienceYears() { return experienceYears; }
    public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }

    public String getEducationLevel() { return educationLevel; }
    public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }


    public boolean isSearchable() { return isSearchable; }
    public void setSearchable(boolean isSearchable) { this.isSearchable = isSearchable; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
} 