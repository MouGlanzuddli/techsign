package controller;

import dal.JobPostingDao;
import dal.JobAttachmentDao;
import dal.CompanyProfileDao;
import dal.DBContext;
import model.JobPosting;
import model.JobAttachment;
import model.User;
import util.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/submitJob")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class SubmitJobServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Debug logging
        System.out.println("=== SubmitJobServlet START ===");
        System.out.println("👤 Current user: " + (currentUser != null ? currentUser.getFullName() : "null"));
        
        if (currentUser == null) {
            System.out.println("❌ No user in session, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }

        // Initialize DAOs
        JobPostingDao jobDao = null;
        JobAttachmentDao attachmentDao = null;
        CompanyProfileDao companyDao = null;

        try {
            // Create DAO instances with DBContext
            jobDao = new JobPostingDao();
            attachmentDao = new JobAttachmentDao();
            companyDao = new CompanyProfileDao();
            
            // Get company profile ID for current user
            int companyProfileId = companyDao.getCompanyProfileIdByUserId(currentUser.getId());
            System.out.println("🏢 Company profile ID: " + companyProfileId);
            
            if (companyProfileId == -1) {
                System.out.println("❌ No company profile found for user ID: " + currentUser.getId());
                request.setAttribute("error", "Company profile not found. Please complete your company profile first.");
                request.getRequestDispatcher("company-submit-job.jsp").forward(request, response);
                return;
            }

            // Check if this is a draft save or auto-save
            boolean isDraft = "true".equals(request.getParameter("isDraft"));
            boolean isAutoSave = "true".equals(request.getParameter("autoSave"));
            
            System.out.println("📝 isDraft: " + isDraft + ", isAutoSave: " + isAutoSave);

            // Get form parameters
            String jobTitle = request.getParameter("jobTitle");
            String jobDescription = request.getParameter("jobDescription");
            String skills = request.getParameter("skills");
            String location = request.getParameter("permanentAddress");
            
            System.out.println("📋 Job title: " + jobTitle);
            System.out.println("📋 Job location: " + location);
            System.out.println("📋 Job skills: " + skills);
            
            // Validate required fields
            if (jobTitle == null || jobTitle.trim().isEmpty()) {
                request.setAttribute("error", "Job title is required.");
                request.getRequestDispatcher("company-submit-job.jsp").forward(request, response);
                return;
            }
            
            if (jobDescription == null || jobDescription.trim().isEmpty()) {
                request.setAttribute("error", "Job description is required.");
                request.getRequestDispatcher("company-submit-job.jsp").forward(request, response);
                return;
            }

            if (skills == null || skills.trim().isEmpty()) {
                request.setAttribute("error", "Skills are required.");
                request.getRequestDispatcher("company-submit-job.jsp").forward(request, response);
                return;
            }

            if (location == null || location.trim().isEmpty()) {
                request.setAttribute("error", "Job location is required.");
                request.getRequestDispatcher("company-submit-job.jsp").forward(request, response);
                return;
            }

            // Create JobPosting object
            JobPosting job = new JobPosting();
            job.setCompanyProfileId(companyProfileId);
            job.setTitle(jobTitle.trim());
            job.setDescription(jobDescription.trim());
            job.setLocation(location.trim());
            job.setSkills(skills.trim());
            
            // Handle salary
            String minSalaryStr = request.getParameter("minSalary");
            String maxSalaryStr = request.getParameter("maxSalary");
            if (minSalaryStr != null && !minSalaryStr.trim().isEmpty()) {
                try {
                    job.setSalaryMin(new BigDecimal(minSalaryStr));
                } catch (NumberFormatException e) {
                    System.out.println("⚠️ Invalid min salary format: " + minSalaryStr);
                }
            }
            if (maxSalaryStr != null && !maxSalaryStr.trim().isEmpty()) {
                try {
                    job.setSalaryMax(new BigDecimal(maxSalaryStr));
                } catch (NumberFormatException e) {
                    System.out.println("⚠️ Invalid max salary format: " + maxSalaryStr);
                }
            }

            // Map form values to job type
            job.setJobType(mapJobType(request.getParameter("jobType")));
            
            // Set additional fields
            job.setJobCategory(request.getParameter("jobCategory"));
            job.setJobLevel(request.getParameter("jobLevel"));
            job.setExperience(request.getParameter("experience"));
            job.setQualification(request.getParameter("qualification"));
            job.setGender(request.getParameter("gender"));
            job.setJobFeeType(request.getParameter("jobFeeType"));
            job.setPermanentAddress(request.getParameter("permanentAddress"));
            job.setTemporaryAddress(request.getParameter("temporaryAddress"));
            job.setCountry(request.getParameter("country"));
            job.setStateCity(request.getParameter("stateCity"));
            job.setZipCode(request.getParameter("zipCode"));
            job.setVideoUrl(request.getParameter("videoUrl"));
            job.setLatitude(request.getParameter("latitude"));
            job.setLongitude(request.getParameter("longitude"));

            // Set status based on whether it's a draft
            job.setStatus(isDraft || isAutoSave ? "draft" : "open");
            System.out.println("📊 Job status: " + job.getStatus());

            // Handle expiry date
            String expiryDateStr = request.getParameter("jobExpiredDate");
            if (expiryDateStr != null && !expiryDateStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    job.setExpiresAt(sdf.parse(expiryDateStr));
                    System.out.println("📅 Expiry date set: " + job.getExpiresAt());
                } catch (ParseException e) {
                    System.err.println("❌ Error parsing expiry date: " + e.getMessage());
                }
            }

            // Set posted date
            job.setPostedAt(new Date());
            System.out.println("📅 Posted date: " + job.getPostedAt());

            // Insert job posting
            System.out.println("💾 Attempting to insert job posting...");
            int jobId = jobDao.insertJobPosting(job);
            System.out.println("💾 Job insertion result - Job ID: " + jobId);
            
            if (jobId > 0) {
                System.out.println("✅ Job posted successfully with ID: " + jobId);
                System.out.println("✅ Job title: " + job.getTitle());
                System.out.println("✅ Company profile ID: " + job.getCompanyProfileId());
                System.out.println("✅ Job status: " + job.getStatus());
                
                // Handle company logo upload (only for non-auto-save)
                if (!isAutoSave) {
                    Part companyLogoPart = request.getPart("companyLogo");
                    if (companyLogoPart != null && companyLogoPart.getSize() > 0) {
                        try {
                            String logoPath = FileUploadUtil.saveCompanyLogo(companyLogoPart, 
                                    getServletContext().getRealPath(""));
                            if (logoPath != null) {
                                // Update company profile with new logo
                                companyDao.updateCompanyLogo(companyProfileId, logoPath);
                                System.out.println("🖼️ Company logo updated: " + logoPath);
                            }
                        } catch (IOException e) {
                            System.err.println("❌ Error uploading company logo: " + e.getMessage());
                        }
                    }

                    // Handle job attachments
                    for (Part part : request.getParts()) {
                        if ("jobAttachments".equals(part.getName()) && part.getSize() > 0) {
                            try {
                                String attachmentPath = FileUploadUtil.saveJobAttachment(part, 
                                        getServletContext().getRealPath(""));
                                if (attachmentPath != null) {
                                    JobAttachment attachment = new JobAttachment(
                                        jobId,
                                        getFileName(part),
                                        attachmentPath,
                                        part.getContentType(),
                                        part.getSize()
                                    );
                                    attachmentDao.insertJobAttachment(attachment);
                                    System.out.println("📎 Job attachment saved: " + attachmentPath);
                                }
                            } catch (IOException e) {
                                System.err.println("❌ Error uploading job attachment: " + e.getMessage());
                            }
                        }
                    }
                }

                // Handle different response types
                if (isAutoSave) {
                    // Return JSON response for auto-save
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": true, \"message\": \"Auto-saved successfully\"}");
                } else if (isDraft) {
                    // Return JSON response for draft save
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": true, \"message\": \"Draft saved successfully\"}");
                } else {
                    // Success - redirect to My Jobs page (company-jobs.jsp)
                    session.setAttribute("successMessage", "Job '" + job.getTitle() + "' posted successfully!");
                    System.out.println("🔄 Redirecting to CompanyJobsServlet to show in My Jobs");
                    response.sendRedirect(request.getContextPath() + "/CompanyJobsServlet");
                    return;
                }
            } else {
                System.out.println("❌ Failed to insert job posting");
                if (isAutoSave || isDraft) {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to save job\"}");
                } else {
                    request.setAttribute("error", "Failed to post job. Please try again.");
                    request.getRequestDispatcher("company-submit-job.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ SQL Exception in SubmitJobServlet: " + e.getMessage());
            e.printStackTrace();
            String errorMessage = "Database error occurred while posting the job: " + e.getMessage();
            
            if ("true".equals(request.getParameter("isDraft")) || "true".equals(request.getParameter("autoSave"))) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"" + errorMessage + "\"}");
            } else {
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("company-submit-job.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("❌ General Exception in SubmitJobServlet: " + e.getMessage());
            e.printStackTrace();
            String errorMessage = "An error occurred while posting the job: " + e.getMessage();
            
            if ("true".equals(request.getParameter("isDraft")) || "true".equals(request.getParameter("autoSave"))) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"" + errorMessage + "\"}");
            } else {
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("company-submit-job.jsp").forward(request, response);
            }
        } finally {
            // Close all DAO connections
            if (jobDao != null) {
                jobDao.closeConnection();
            }
            if (attachmentDao != null) {
                attachmentDao.closeConnection();
            }
            if (companyDao != null) {
                companyDao.closeConnection();
            }
        }
        
        System.out.println("=== SubmitJobServlet END ===");
    }

    private String mapJobType(String jobTypeId) {
        if (jobTypeId == null) return "Full Time";
        
        switch (jobTypeId) {
            case "1": return "Full Time";
            case "2": return "Part Time";
            case "3": return "Freelance";
            case "4": return "Internship";
            case "5": return "Contract";
            default: return "Full Time";
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown";
    }
}
