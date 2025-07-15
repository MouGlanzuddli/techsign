package com.mycompany.adminscreen.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class JobPosting {
    private int id;
    private int companyProfileId;
    private String title;
    private String description;
    private String location;
    private BigDecimal salaryMin;
    private BigDecimal salaryMax;
    private String jobType;
    private String benefits;
    private String status; // 'pending', 'approved', 'rejected', 'open', 'closed'
    private LocalDateTime postedAt;
    private LocalDateTime expiresAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Additional fields for admin view
    private String companyName;
    private List<String> categories;
    private String categoryNames; // For display purposes
    
    // Constructor
    public JobPosting() {}
    
    public JobPosting(int id, String title, String description, String location, 
                     BigDecimal salaryMin, BigDecimal salaryMax, String jobType, 
                     String benefits, String status, LocalDateTime postedAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.location = location;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.jobType = jobType;
        this.benefits = benefits;
        this.status = status;
        this.postedAt = postedAt;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getCompanyProfileId() { return companyProfileId; }
    public void setCompanyProfileId(int companyProfileId) { this.companyProfileId = companyProfileId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public BigDecimal getSalaryMin() { return salaryMin; }
    public void setSalaryMin(BigDecimal salaryMin) { this.salaryMin = salaryMin; }
    
    public BigDecimal getSalaryMax() { return salaryMax; }
    public void setSalaryMax(BigDecimal salaryMax) { this.salaryMax = salaryMax; }
    
    public String getJobType() { return jobType; }
    public void setJobType(String jobType) { this.jobType = jobType; }
    
    public String getBenefits() { return benefits; }
    public void setBenefits(String benefits) { this.benefits = benefits; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public LocalDateTime getPostedAt() { return postedAt; }
    public void setPostedAt(LocalDateTime postedAt) { this.postedAt = postedAt; }
    
    public LocalDateTime getExpiresAt() { return expiresAt; }
    public void setExpiresAt(LocalDateTime expiresAt) { this.expiresAt = expiresAt; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    
    public List<String> getCategories() { return categories; }
    public void setCategories(List<String> categories) { this.categories = categories; }
    
    public String getCategoryNames() { return categoryNames; }
    public void setCategoryNames(String categoryNames) { this.categoryNames = categoryNames; }
    
    // Helper methods
    public String getFormattedSalary() {
        if (salaryMin != null && salaryMax != null) {
            return String.format("%.0f - %.0f triệu VND", salaryMin, salaryMax);
        } else if (salaryMin != null) {
            return String.format("Từ %.0f triệu VND", salaryMin);
        } else if (salaryMax != null) {
            return String.format("Đến %.0f triệu VND", salaryMax);
        }
        return "Thương lượng";
    }
    
    public String getStatusText() {
        switch (status) {
            case "pending": return "Chờ duyệt";
            case "approved": return "Đã duyệt";
            case "rejected": return "Từ chối";
            case "open": return "Đang mở";
            case "closed": return "Đã đóng";
            default: return status;
        }
    }
    
    public String getStatusClass() {
        switch (status) {
            case "pending": return "status-pending";
            case "approved": return "status-approved";
            case "rejected": return "status-rejected";
            case "open": return "status-open";
            case "closed": return "status-closed";
            default: return "status-unknown";
        }
    }
    
    @Override
    public String toString() {
        return "JobPosting{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", status='" + status + '\'' +
                ", postedAt=" + postedAt +
                '}';
    }
} 