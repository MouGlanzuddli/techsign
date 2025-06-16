package model;

import java.math.BigDecimal;
import java.util.Date;

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
    private String status;
    private Date postedAt;
    private Date expiresAt;
    private boolean isFeatured;

    // Constructors
    public JobPosting() {}

    public JobPosting(int id, int companyProfileId, String title, String description, 
                     String location, BigDecimal salaryMin, BigDecimal salaryMax, 
                     String jobType, String benefits, String status, 
                     Date postedAt, Date expiresAt) {
        this.id = id;
        this.companyProfileId = companyProfileId;
        this.title = title;
        this.description = description;
        this.location = location;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.jobType = jobType;
        this.benefits = benefits;
        this.status = status;
        this.postedAt = postedAt;
        this.expiresAt = expiresAt;
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

    public Date getPostedAt() { return postedAt; }
    public void setPostedAt(Date postedAt) { this.postedAt = postedAt; }

    public Date getExpiresAt() { return expiresAt; }
    public void setExpiresAt(Date expiresAt) { this.expiresAt = expiresAt; }

    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }
}
