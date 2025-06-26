package model;

import java.util.Date;

public class Company {
    private int id;
    private int userId;
    private String companyName;
    private Integer industryId;
    private String address;
    private String description;
    private String website;
    private String logoUrl;
    private boolean isSearchable;
    private Date createdAt;
    private Date updatedAt;
    private String phone;

    public Company() {}

    public Company(int id, int userId, String companyName, Integer industryId, String address,
                  String description, String website, String logoUrl, boolean isSearchable, 
                  Date createdAt, Date updatedAt) {
        this.id = id;
        this.userId = userId;
        this.companyName = companyName;
        this.industryId = industryId;
        this.address = address;
        this.description = description;
        this.website = website;
        this.logoUrl = logoUrl;
        this.isSearchable = isSearchable;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public Integer getIndustryId() { return industryId; }
    public void setIndustryId(Integer industryId) { this.industryId = industryId; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }

    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }

    public boolean isSearchable() { return isSearchable; }
    public void setSearchable(boolean isSearchable) { this.isSearchable = isSearchable; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
} 