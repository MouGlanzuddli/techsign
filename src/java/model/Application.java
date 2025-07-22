package model;

import java.sql.Timestamp;
import java.util.Date;

public class Application {

    private int id; // ID của ứng tuyển từ bảng applications
    private int jobId; // job_posting_id từ bảng applications
    private String jobTitle; // title từ bảng job_postings
    private String jobType; // job_type từ bảng job_postings
    private String companyName; // company_name từ bảng company_profiles
    private String location; // location từ bảng job_postings
    private Timestamp postedAt; // posted_at từ bảng job_postings
    private Timestamp appliedAt; // applied_at từ bảng applications
    private String status; // status từ bảng applications
    private String logoUrl; // logo_url từ bảng company_profiles
    private int candidateId;
    private String coverLetter;
    private String cvFileName;
    private Date updatedAt;

    public Application() {
    }
    public Application(int jobId, int candidateId, String coverLetter, String cvFileName,
            String status, Timestamp appliedAt, Date updatedAt) {
        this.jobId = jobId;
        this.candidateId = candidateId;
        this.coverLetter = coverLetter;
        this.cvFileName = cvFileName;
        this.status = status;
        this.appliedAt = appliedAt;
        this.updatedAt = updatedAt;
    }
    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }

    public String getCvFileName() {
        return cvFileName;
    }

    public void setCvFileName(String cvFileName) {
        this.cvFileName = cvFileName;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
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

    public Timestamp getPostedAt() {
        return postedAt;
    }

    public void setPostedAt(Timestamp postedAt) {
        this.postedAt = postedAt;
    }

    public Timestamp getAppliedAt() {
        return appliedAt;
    }

    public void setAppliedAt(Timestamp appliedAt) {
        this.appliedAt = appliedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

}
    