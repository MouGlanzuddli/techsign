
package model;

import java.sql.Timestamp;

public class JobPosting {
    
    private int id;
    private int companyProfileId;
    private String title;
    private String description;
    private String location;
    private double salaryMin;
    private double salaryMax;
    private String jobType;
    private String benefits;
    private String status;
    private java.sql.Timestamp postedAt;
    private java.sql.Timestamp expiresAt;
    private String companyName;   
    private String contracttype;
    private String placeofwork;
    private String skills;
    
    
    // Getters và Setters
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

    public double getSalaryMin() {
        return salaryMin;
    }

    public void setSalaryMin(double salaryMin) {
        this.salaryMin = salaryMin;
    }

    public double getSalaryMax() {
        return salaryMax;
    }

    public void setSalaryMax(double salaryMax) {
        this.salaryMax = salaryMax;
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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
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
