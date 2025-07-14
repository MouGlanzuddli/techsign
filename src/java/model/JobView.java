package model;

import java.sql.Timestamp;

/**
 * JobView: Model đại diện cho bảng job_views
 * Lưu thông tin khi candidate xem job posting
 */
public class JobView {
    private int id;
    private int jobPostingId;
    private int candidateUserId;
    private Timestamp viewedAt;
    private String ipAddress;
    private String userAgent;
    private String sessionId;
    
    // Thêm thông tin từ join tables
    private User candidateUser;
    private Job jobPosting;
    private CandidateProfile candidateProfile;

    // Constructors
    public JobView() {
    }

    public JobView(int jobPostingId, int candidateUserId) {
        this.jobPostingId = jobPostingId;
        this.candidateUserId = candidateUserId;
        this.viewedAt = new Timestamp(System.currentTimeMillis());
    }

    public JobView(int jobPostingId, int candidateUserId, String ipAddress, String userAgent, String sessionId) {
        this.jobPostingId = jobPostingId;
        this.candidateUserId = candidateUserId;
        this.ipAddress = ipAddress;
        this.userAgent = userAgent;
        this.sessionId = sessionId;
        this.viewedAt = new Timestamp(System.currentTimeMillis());
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getJobPostingId() {
        return jobPostingId;
    }

    public void setJobPostingId(int jobPostingId) {
        this.jobPostingId = jobPostingId;
    }

    public int getCandidateUserId() {
        return candidateUserId;
    }

    public void setCandidateUserId(int candidateUserId) {
        this.candidateUserId = candidateUserId;
    }

    public Timestamp getViewedAt() {
        return viewedAt;
    }

    public void setViewedAt(Timestamp viewedAt) {
        this.viewedAt = viewedAt;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public User getCandidateUser() {
        return candidateUser;
    }

    public void setCandidateUser(User candidateUser) {
        this.candidateUser = candidateUser;
    }

    public Job getJobPosting() {
        return jobPosting;
    }

    public void setJobPosting(Job jobPosting) {
        this.jobPosting = jobPosting;
    }

    public CandidateProfile getCandidateProfile() {
        return candidateProfile;
    }

    public void setCandidateProfile(CandidateProfile candidateProfile) {
        this.candidateProfile = candidateProfile;
    }

    @Override
    public String toString() {
        return "JobView{" +
                "id=" + id +
                ", jobPostingId=" + jobPostingId +
                ", candidateUserId=" + candidateUserId +
                ", viewedAt=" + viewedAt +
                ", ipAddress='" + ipAddress + '\'' +
                '}';
    }
} 