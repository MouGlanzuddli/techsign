package model;

import java.util.Date;

public class CompanyProfile {
    private int id;
    private int userId;
    private int industryId;
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
    private Date createdAt;
    private Date updatedAt;

    // Constructors
    public CompanyProfile() {}

    public CompanyProfile(int id, int userId, int industryId, String companyName, 
                         String website, String description, String address, String phone,
                         String logoUrl, String bannerUrl, String iconUrl, 
                         boolean isFeatured, boolean isSearchable, 
                         Date createdAt, Date updatedAt) {
        this.id = id;
        this.userId = userId;
        this.industryId = industryId;
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
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getIndustryId() { return industryId; }
    public void setIndustryId(int industryId) { this.industryId = industryId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }

    public String getBannerUrl() { return bannerUrl; }
    public void setBannerUrl(String bannerUrl) { this.bannerUrl = bannerUrl; }

    public String getIconUrl() { return iconUrl; }
    public void setIconUrl(String iconUrl) { this.iconUrl = iconUrl; }

    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }

    public boolean isSearchable() { return isSearchable; }
    public void setSearchable(boolean searchable) { isSearchable = searchable; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
