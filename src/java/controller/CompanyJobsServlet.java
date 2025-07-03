package controller;

import dal.JobPostingDao;
import dal.CompanyProfileDao;
import dal.JobAttachmentDao;
import model.JobPosting;
import model.JobAttachment;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

// FIX: Đảm bảo có @WebServlet annotation với đúng URL pattern
@WebServlet(name = "CompanyJobsServlet", urlPatterns = {"/CompanyJobsServlet", "/company-jobs", "/my-jobs"})
public class CompanyJobsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Debug logging
        System.out.println("=== CompanyJobsServlet START ===");
        System.out.println("📍 Request URI: " + request.getRequestURI());
        System.out.println("📍 Request URL: " + request.getRequestURL());
        System.out.println("📍 Context Path: " + request.getContextPath());
        System.out.println("📍 Servlet Path: " + request.getServletPath());
        System.out.println("👤 Current user: " + (currentUser != null ? currentUser.getFullName() + " (ID: " + currentUser.getId() + ")" : "null"));
        
        if (currentUser == null) {
            System.out.println("❌ No user in session, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }

        JobPostingDao jobDao = null;
        CompanyProfileDao companyDao = null;
        JobAttachmentDao attachmentDao = null;

        try {
            // Initialize DAOs
            jobDao = new JobPostingDao();
            companyDao = new CompanyProfileDao();
            attachmentDao = new JobAttachmentDao();
            
            // Get company profile ID
            int companyProfileId = companyDao.getCompanyProfileIdByUserId(currentUser.getId());
            System.out.println("🏢 Company profile ID: " + companyProfileId);
            
            if (companyProfileId == -1) {
                System.out.println("❌ No company profile found for user ID: " + currentUser.getId());
                request.setAttribute("error", "Company profile not found. Please complete your company profile first.");
                request.getRequestDispatcher("employer-profile.jsp").forward(request, response);
                return;
            }

            // Get company name for display
            String companyName = companyDao.getCompanyName(companyProfileId);
            System.out.println("🏢 Company name: " + companyName);

            // Get search and filter parameters
            String searchQuery = request.getParameter("search");
            String sortBy = request.getParameter("sort");
            String statusFilter = request.getParameter("status");
            
            System.out.println("🔍 Search: '" + searchQuery + "', Sort: '" + sortBy + "', Status: '" + statusFilter + "'");

            // Get ALL job postings for this company first
            List<JobPosting> allJobsList = jobDao.getJobPostingsByCompany(companyProfileId);
            System.out.println("📊 Total jobs in database: " + allJobsList.size());
            
            // Print all jobs for debugging
            for (JobPosting job : allJobsList) {
                System.out.println("  📝 Job: " + job.getId() + " - " + job.getTitle() + " (" + job.getStatus() + ") - Posted: " + job.getPostedAt());
            }

            // Apply filters
            List<JobPosting> filteredJobs = allJobsList;

            // Apply search filter
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                filteredJobs = filteredJobs.stream()
                    .filter(job -> job.getTitle().toLowerCase().contains(searchQuery.toLowerCase()) ||
                                 job.getDescription().toLowerCase().contains(searchQuery.toLowerCase()) ||
                                 (job.getSkills() != null && job.getSkills().toLowerCase().contains(searchQuery.toLowerCase())))
                    .collect(java.util.stream.Collectors.toList());
                System.out.println("🔍 After search filter: " + filteredJobs.size() + " jobs");
            }

            // Apply status filter
            if (statusFilter != null && !statusFilter.equals("all")) {
                switch (statusFilter) {
                    case "active":
                        filteredJobs = filteredJobs.stream()
                            .filter(job -> "open".equals(job.getStatus()) && 
                                         (job.getExpiresAt() == null || job.getExpiresAt().after(new java.util.Date())))
                            .collect(java.util.stream.Collectors.toList());
                        break;
                    case "expired":
                        filteredJobs = filteredJobs.stream()
                            .filter(job -> job.getExpiresAt() != null && job.getExpiresAt().before(new java.util.Date()))
                            .collect(java.util.stream.Collectors.toList());
                        break;
                    case "draft":
                        filteredJobs = filteredJobs.stream()
                            .filter(job -> "draft".equals(job.getStatus()))
                            .collect(java.util.stream.Collectors.toList());
                        break;
                }
                System.out.println("📊 After status filter (" + statusFilter + "): " + filteredJobs.size() + " jobs");
            }

            // Apply sorting
            if (sortBy != null && !sortBy.equals("0")) {
                switch (sortBy) {
                    case "1": // Featured
                        filteredJobs.sort((a, b) -> "3".equals(b.getJobFeeType()) ? 1 : -1);
                        break;
                    case "2": // Urgent
                        filteredJobs.sort((a, b) -> "3".equals(b.getJobFeeType()) ? 1 : -1);
                        break;
                    case "3": // Post Date
                        filteredJobs.sort((a, b) -> b.getPostedAt().compareTo(a.getPostedAt()));
                        break;
                    default:
                        // Default sorting by post date (newest first)
                        filteredJobs.sort((a, b) -> b.getPostedAt().compareTo(a.getPostedAt()));
                        break;
                }
                System.out.println("📊 Applied sorting: " + sortBy);
            } else {
                // Default sorting by post date (newest first)
                filteredJobs.sort((a, b) -> b.getPostedAt().compareTo(a.getPostedAt()));
            }

            // Prepare job data for JSP
            SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
            List<Map<String, Object>> jobDisplayList = new java.util.ArrayList<>();
            
            System.out.println("📋 Preparing " + filteredJobs.size() + " jobs for display:");
            
            for (JobPosting job : filteredJobs) {
                Map<String, Object> jobData = new HashMap<>();
                jobData.put("id", job.getId());
                jobData.put("title", job.getTitle());
                jobData.put("description", job.getDescription());
                jobData.put("companyName", companyName);
                jobData.put("location", job.getLocation() != null ? job.getLocation() : "Not specified");
                jobData.put("jobType", job.getJobType() != null ? job.getJobType() : "Full Time");
                jobData.put("status", getJobStatus(job));
                jobData.put("postedDate", dateFormat.format(job.getPostedAt()));
                jobData.put("expiryDate", job.getExpiresAt() != null ? dateFormat.format(job.getExpiresAt()) : "No expiry");
                
                // Get applicant count
                jobData.put("applicants", getApplicantCount(job.getId()));
                
                // Get company logo
                jobData.put("companyLogo", getCompanyLogo(companyProfileId, companyDao));
                
                // Get job attachments count
                try {
                    List<JobAttachment> attachments = attachmentDao.getAttachmentsByJobId(job.getId());
                    jobData.put("attachmentCount", attachments.size());
                } catch (Exception e) {
                    System.out.println("⚠️ Error getting attachments for job " + job.getId() + ": " + e.getMessage());
                    jobData.put("attachmentCount", 0);
                }
                
                jobDisplayList.add(jobData);
                
                System.out.println("  ✅ " + job.getTitle() + " (ID: " + job.getId() + ", Status: " + jobData.get("status") + ")");
            }

            // Calculate job counts for tabs
            Map<String, Integer> jobCounts = new HashMap<>();
            jobCounts.put("all", allJobsList.size());
            jobCounts.put("active", (int) allJobsList.stream()
                .filter(job -> "open".equals(job.getStatus()) && 
                             (job.getExpiresAt() == null || job.getExpiresAt().after(new java.util.Date())))
                .count());
            jobCounts.put("expired", (int) allJobsList.stream()
                .filter(job -> job.getExpiresAt() != null && job.getExpiresAt().before(new java.util.Date()))
                .count());
            jobCounts.put("draft", (int) allJobsList.stream()
                .filter(job -> "draft".equals(job.getStatus()))
                .count());

            System.out.println("📊 Job counts - All: " + jobCounts.get("all") + 
                             ", Active: " + jobCounts.get("active") + 
                             ", Expired: " + jobCounts.get("expired") + 
                             ", Draft: " + jobCounts.get("draft"));

            // Set attributes for JSP
            request.setAttribute("jobList", jobDisplayList);
            request.setAttribute("jobCounts", jobCounts);
            request.setAttribute("currentUser", currentUser);
            request.setAttribute("companyName", companyName);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("statusFilter", statusFilter);
            
            // Calculate days left for package (mock data)
            request.setAttribute("daysLeft", "15");

            System.out.println("🎯 Forwarding to company-jobs.jsp with " + jobDisplayList.size() + " jobs");

            // Forward to JSP
            request.getRequestDispatcher("company-jobs.jsp").forward(request, response);

        } catch (SQLException e) {
            System.err.println("❌ SQL Exception in CompanyJobsServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("❌ General Exception in CompanyJobsServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            // Close DAO connections
            if (jobDao != null) jobDao.closeConnection();
            if (companyDao != null) companyDao.closeConnection();
            if (attachmentDao != null) attachmentDao.closeConnection();
        }
        
        System.out.println("=== CompanyJobsServlet END ===");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }

    private String getJobStatus(JobPosting job) {
        if ("draft".equals(job.getStatus())) {
            return "Draft";
        }
        if (job.getExpiresAt() != null && job.getExpiresAt().before(new java.util.Date())) {
            return "Expired";
        }
        return "Active";
    }

    private int getApplicantCount(int jobId) {
        // TODO: Implement this method to get actual applicant count from applications table
        // For now, return a random number for demonstration
        return (int) (Math.random() * 20);
    }

    private String getCompanyLogo(int companyProfileId, CompanyProfileDao companyDao) {
        try {
            return companyDao.getCompanyLogo(companyProfileId);
        } catch (Exception e) {
            return "assets/img/l-1.png"; // Default logo
        }
    }
}
