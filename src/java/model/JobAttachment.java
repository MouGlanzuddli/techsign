package model;

import java.util.Date;

public class JobAttachment {
    private int id;
    private int jobPostingId;
    private String fileName;
    private String fileUrl;
    private String fileType;
    private long fileSize;
    private Date uploadedAt;

    // Constructors
    public JobAttachment() {}

    public JobAttachment(int jobPostingId, String fileName, String fileUrl, String fileType, long fileSize) {
        this.jobPostingId = jobPostingId;
        this.fileName = fileName;
        this.fileUrl = fileUrl;
        this.fileType = fileType;
        this.fileSize = fileSize;
        this.uploadedAt = new Date();
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getJobPostingId() { return jobPostingId; }
    public void setJobPostingId(int jobPostingId) { this.jobPostingId = jobPostingId; }

    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }

    public String getFileUrl() { return fileUrl; }
    public void setFileUrl(String fileUrl) { this.fileUrl = fileUrl; }

    public String getFileType() { return fileType; }
    public void setFileType(String fileType) { this.fileType = fileType; }

    public long getFileSize() { return fileSize; }
    public void setFileSize(long fileSize) { this.fileSize = fileSize; }

    public Date getUploadedAt() { return uploadedAt; }
    public void setUploadedAt(Date uploadedAt) { this.uploadedAt = uploadedAt; }
}
