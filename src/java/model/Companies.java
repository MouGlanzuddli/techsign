package model;

import java.sql.Timestamp;

public class Companies {

    private int id;
    private int userId;
    private int industryID;
    private String companyName;
    private String website;
    private String description;
    private String address;
    private String phone;
    private String logoUrl;
    private String bannerUrl;
    private String iconUrl;
    private boolean isFeatured;
    private boolean isSearchable;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private int jobCount;
    private String email;
    private String companybenefits;

    public Companies() {
    }

    public Companies(int id, int userId, int industryID, String companyName, String website, String description, String address, String phone, String logoUrl, String bannerUrl, String iconUrl, boolean isFeatured, boolean isSearchable, Timestamp createdAt, Timestamp updatedAt, int jobCount, String email, String companybenefits) {
        this.id = id;
        this.userId = userId;
        this.industryID = industryID;
        this.companyName = companyName;
        this.website = website;
        this.description = description;
        this.address = address;
        this.phone = phone;
        this.logoUrl = logoUrl;
        this.bannerUrl = bannerUrl;
        this.iconUrl = iconUrl;
        this.isFeatured = isFeatured;
        this.isSearchable = isSearchable;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.jobCount = jobCount;
        this.email = email;
        this.companybenefits = companybenefits;
    }

    public String getCompanybenefits() {
        return companybenefits;
    }

    public void setCompanybenefits(String companybenefits) {
        this.companybenefits = companybenefits;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public boolean isIsSearchable() {
        return isSearchable;
    }

    public void setIsSearchable(boolean isSearchable) {
        this.isSearchable = isSearchable;
    }

    public int getJobCount() {
        return jobCount;
    }

    public void setJobCount(int jobCount) {
        this.jobCount = jobCount;
    }

    public int getIndustryID() {
        return industryID;
    }

    public void setIndustryID(int industryID) {
        this.industryID = industryID;
    }

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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    public String getBannerUrl() {
        return bannerUrl;
    }

    public void setBannerUrl(String bannerUrl) {
        this.bannerUrl = bannerUrl;
    }

    public String getIconUrl() {
        return iconUrl;
    }

    public void setIconUrl(String iconUrl) {
        this.iconUrl = iconUrl;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public boolean isSearchable() {
        return isSearchable;
    }

    public void setSearchable(boolean isSearchable) {
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

}
