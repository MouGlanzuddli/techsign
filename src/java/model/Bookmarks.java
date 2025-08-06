package model;
import java.sql.Timestamp;

public class Bookmarks {
    private int id;
    private int userId;
    private String saveJobs;
    private int jobPostingsId;
    private Timestamp createdAt;

    private String title;
    private String companyName;
    private String location;
    private String jobType;
    private String description;
    private String status;
    private Timestamp postedAt;

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

    public String getSaveJobs() {
        return saveJobs;
    }

    public void setSaveJobs(String saveJobs) {
        this.saveJobs = saveJobs;
    }

    public int getJobPostingsId() {
        return jobPostingsId;
    }

    public void setJobPostingsId(int jobPostingsId) {
        this.jobPostingsId = jobPostingsId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getPostedAt() {
        return postedAt;
    }

    public void setPostedAt(Timestamp postedAt) {
        this.postedAt = postedAt;
    }
}