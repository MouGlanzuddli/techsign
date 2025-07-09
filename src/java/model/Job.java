package model;

import java.math.BigDecimal;
import java.util.Date;

public class Job {
private int id;
private int companyId;
private String title;
private String description;
private String requirements;
private String benefits;
private String jobType;
private String jobLevel;
private BigDecimal salaryMin;
private BigDecimal salaryMax;
private String location;
private String category;
private int experienceRequired;
private Date applicationDeadline;
private String status;
private boolean isFeatured;
private boolean isUrgent;
private int viewsCount;
private int applicationsCount;
private Date createdAt;
private Date updatedAt;

// Constructors
public Job() {
    // Khởi tạo giá trị mặc định để tránh null
    Date now = new Date();
    this.createdAt = now;
    this.updatedAt = now;
    this.status = "active";
    this.isFeatured = false;
    this.isUrgent = false;
    this.viewsCount = 0;
    this.applicationsCount = 0;
    this.experienceRequired = 0;
}

public Job(int companyId, String title, String description, String requirements,
           String benefits, String jobType, String jobLevel, BigDecimal salaryMin,
           BigDecimal salaryMax, String location, String category, 
           int experienceRequired, Date applicationDeadline) {
    this(); // Gọi constructor mặc định
    this.companyId = companyId;
    this.title = title;
    this.description = description;
    this.requirements = requirements;
    this.benefits = benefits;
    this.jobType = jobType;
    this.jobLevel = jobLevel;
    this.salaryMin = salaryMin;
    this.salaryMax = salaryMax;
    this.location = location;
    this.category = category;
    this.experienceRequired = experienceRequired;
    this.applicationDeadline = applicationDeadline;
}

// Getters and Setters
public int getId() { return id; }
public void setId(int id) { this.id = id; }

public int getCompanyId() { return companyId; }
public void setCompanyId(int companyId) { this.companyId = companyId; }

public String getTitle() { return title; }
public void setTitle(String title) { this.title = title; }

public String getDescription() { return description; }
public void setDescription(String description) { this.description = description; }

public String getRequirements() { return requirements; }
public void setRequirements(String requirements) { this.requirements = requirements; }

public String getBenefits() { return benefits; }
public void setBenefits(String benefits) { this.benefits = benefits; }

public String getJobType() { return jobType; }
public void setJobType(String jobType) { this.jobType = jobType; }

public String getJobLevel() { return jobLevel; }
public void setJobLevel(String jobLevel) { this.jobLevel = jobLevel; }

public BigDecimal getSalaryMin() { return salaryMin; }
public void setSalaryMin(BigDecimal salaryMin) { this.salaryMin = salaryMin; }

public BigDecimal getSalaryMax() { return salaryMax; }
public void setSalaryMax(BigDecimal salaryMax) { this.salaryMax = salaryMax; }

public String getLocation() { return location; }
public void setLocation(String location) { this.location = location; }

public String getCategory() { return category; }
public void setCategory(String category) { this.category = category; }

public int getExperienceRequired() { return experienceRequired; }
public void setExperienceRequired(int experienceRequired) { this.experienceRequired = experienceRequired; }

public Date getApplicationDeadline() { return applicationDeadline; }
public void setApplicationDeadline(Date applicationDeadline) { this.applicationDeadline = applicationDeadline; }

public String getStatus() { return status; }
public void setStatus(String status) { this.status = status; }

public boolean isFeatured() { return isFeatured; }
public void setFeatured(boolean featured) { isFeatured = featured; }

public boolean isUrgent() { return isUrgent; }
public void setUrgent(boolean urgent) { isUrgent = urgent; }

public int getViewsCount() { return viewsCount; }
public void setViewsCount(int viewsCount) { this.viewsCount = viewsCount; }

public int getApplicationsCount() { return applicationsCount; }
public void setApplicationsCount(int applicationsCount) { this.applicationsCount = applicationsCount; }

public Date getCreatedAt() { return createdAt; }
public void setCreatedAt(Date createdAt) { 
    this.createdAt = createdAt != null ? createdAt : new Date(); 
}

public Date getUpdatedAt() { return updatedAt; }
public void setUpdatedAt(Date updatedAt) { 
    this.updatedAt = updatedAt != null ? updatedAt : new Date(); 
}
}
