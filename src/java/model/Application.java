5package model;

import java.util.Date;

public class Application {
    private int id;
    private int jobPostingId;
    private int candidateProfileId;
    private int candidateCvId;
    private String coverLetter;
    private String status;
    private Date appliedAt;
    private Date updatedAt;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getJobPostingId() { return jobPostingId; }
    public void setJobPostingId(int jobPostingId) { this.jobPostingId = jobPostingId; }
    public int getCandidateProfileId() { return candidateProfileId; }
    public void setCandidateProfileId(int candidateProfileId) { this.candidateProfileId = candidateProfileId; }
    public int getCandidateCvId() { return candidateCvId; }
    public void setCandidateCvId(int candidateCvId) { this.candidateCvId = candidateCvId; }
    public String getCoverLetter() { return coverLetter; }
    public void setCoverLetter(String coverLetter) { this.coverLetter = coverLetter; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getAppliedAt() { return appliedAt; }
    public void setAppliedAt(Date appliedAt) { this.appliedAt = appliedAt; }
    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
} 