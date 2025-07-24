package model;

import java.sql.Timestamp;
import java.util.Date;

public class JobPosting {

    private int id;
    private int companyProfileId;
    private String title;
    private String description;
    private String location;
    private String salary;
    private double salary_min;
    private double salary_max;
    private String jobType;
    private String benefits;
    private String status;
    private java.sql.Timestamp postedAt;
    private java.sql.Timestamp expiresAt;
    private String contracttype;
    private String placeofwork;
    private String requirements;
    private String jobLevel;
    private String category;
    private int experienceRequired;
    private Date applicationDeadline;
    private boolean isFeatured;
    private boolean isUrgent;
    private int viewsCount;
    private int applicationsCount;
    private Date createdAt;
    private Date updatedAt;
    private String responsibility;
    private boolean isNewJob;

    public boolean isNewJob() {
        return isNewJob;
    }

    public void setIsNewJob(boolean isNewJob) {
        this.isNewJob = isNewJob;
    }

    public String getResponsibility() {
        return responsibility;
    }

    public void setResponsibility(String responsibility) {
        this.responsibility = responsibility;
    }
    
    public double getSalary_min() {
        return salary_min;
    }

    public void setSalary_min(double salary_min) {
        this.salary_min = salary_min;
    }

    public double getSalary_max() {
        return salary_max;
    }

    public void setSalary_max(double salary_max) {
        this.salary_max = salary_max;
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }

    public String getRequirements() {
        return requirements;
    }

    public void setRequirements(String requirements) {
        this.requirements = requirements;
    }

    public String getJobLevel() {
        return jobLevel;
    }

    public void setJobLevel(String jobLevel) {
        this.jobLevel = jobLevel;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getExperienceRequired() {
        return experienceRequired;
    }

    public void setExperienceRequired(int experienceRequired) {
        this.experienceRequired = experienceRequired;
    }

    public Date getApplicationDeadline() {
        return applicationDeadline;
    }

    public void setApplicationDeadline(Date applicationDeadline) {
        this.applicationDeadline = applicationDeadline;
    }

    public boolean isIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public boolean isIsUrgent() {
        return isUrgent;
    }

    public void setIsUrgent(boolean isUrgent) {
        this.isUrgent = isUrgent;
    }

    public int getViewsCount() {
        return viewsCount;
    }

    public void setViewsCount(int viewsCount) {
        this.viewsCount = viewsCount;
    }

    public int getApplicationsCount() {
        return applicationsCount;
    }

    public void setApplicationsCount(int applicationsCount) {
        this.applicationsCount = applicationsCount;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    // Getters và Setters
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getBenefits() {
        return benefits;
    }

    public void setBenefits(String benefits) {
        this.benefits = benefits;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public java.sql.Timestamp getPostedAt() {
        return postedAt;
    }

    public void setPostedAt(java.sql.Timestamp postedAt) {
        this.postedAt = postedAt;
    }

    public int getCompanyProfileId() {
        return companyProfileId;
    }

    public void setCompanyProfileId(int companyProfileId) {
        this.companyProfileId = companyProfileId;
    }

    public Timestamp getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(Timestamp expiresAt) {
        this.expiresAt = expiresAt;
    }

    public String getContractType() {
        return contracttype;
    }

    public void setContractType(String contracttype) {
        this.contracttype = contracttype;
    }

    public String getContracttype() {
        return contracttype;
    }

    public void setContracttype(String contracttype) {
        this.contracttype = contracttype;
    }

    public String getPlaceofwork() {
        return placeofwork;
    }

    public void setPlaceofwork(String placeofwork) {
        this.placeofwork = placeofwork;
    }

}
