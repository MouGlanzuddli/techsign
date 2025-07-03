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
    
    // Additional fields from your form
    private String jobCategory;
    private String jobLevel;
    private String experience;
    private String qualification;
    private String gender;
    private String jobFeeType;
    private String skills;
    private String permanentAddress;
    private String temporaryAddress;
    private String country;
    private String stateCity;
    private String zipCode;
    private String videoUrl;
    private String latitude;
    private String longitude;

    // Constructors
    public JobPosting() {}

    public JobPosting(int companyProfileId, String title, String description, String location,
                     BigDecimal salaryMin, BigDecimal salaryMax, String jobType, String benefits) {
        this.companyProfileId = companyProfileId;
        this.title = title;
        this.description = description;
        this.location = location;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.jobType = jobType;
        this.benefits = benefits;
        this.status = "open";
        this.postedAt = new Date();
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

    public String getJobCategory() { return jobCategory; }
    public void setJobCategory(String jobCategory) { this.jobCategory = jobCategory; }

    public String getJobLevel() { return jobLevel; }
    public void setJobLevel(String jobLevel) { this.jobLevel = jobLevel; }

    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }

    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getJobFeeType() { return jobFeeType; }
    public void setJobFeeType(String jobFeeType) { this.jobFeeType = jobFeeType; }

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public String getPermanentAddress() { return permanentAddress; }
    public void setPermanentAddress(String permanentAddress) { this.permanentAddress = permanentAddress; }

    public String getTemporaryAddress() { return temporaryAddress; }
    public void setTemporaryAddress(String temporaryAddress) { this.temporaryAddress = temporaryAddress; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getStateCity() { return stateCity; }
    public void setStateCity(String stateCity) { this.stateCity = stateCity; }

    public String getZipCode() { return zipCode; }
    public void setZipCode(String zipCode) { this.zipCode = zipCode; }

    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }

    public String getLatitude() { return latitude; }
    public void setLatitude(String latitude) { this.latitude = latitude; }

    public String getLongitude() { return longitude; }
    public void setLongitude(String longitude) { this.longitude = longitude; }
}
