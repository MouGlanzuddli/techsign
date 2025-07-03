package controller;

import dal.JobPostingDao;
import dal.JobAttachmentDao;
import dal.CompanyProfileDao;
import model.User;
import util.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeleteJobServlet")
public class DeleteJobServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String jobIdStr = request.getParameter("id");
        if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Invalid job ID.");
            response.sendRedirect("CompanyJobsServlet");
            return;
        }

        JobPostingDao jobDao = null;
        JobAttachmentDao attachmentDao = null;
        CompanyProfileDao companyDao = null;

        try {
            int jobId = Integer.parseInt(jobIdStr);
            
            // Initialize DAOs
            jobDao = new JobPostingDao();
            attachmentDao = new JobAttachmentDao();
            companyDao = new CompanyProfileDao();
            
            // Verify that this job belongs to the current user's company
            int companyProfileId = companyDao.getCompanyProfileIdByUserId(currentUser.getId());
            if (companyProfileId == -1) {
                session.setAttribute("errorMessage", "Company profile not found.");
                response.sendRedirect("CompanyJobsServlet");
                return;
            }

            // Get job to verify ownership
            var job = jobDao.getJobPostingById(jobId);
            if (job == null || job.getCompanyProfileId() != companyProfileId) {
                session.setAttribute("errorMessage", "Job not found or you don't have permission to delete it.");
                response.sendRedirect("CompanyJobsServlet");
                return;
            }

            // Delete job attachments and files
            var attachments = attachmentDao.getAttachmentsByJobId(jobId);
            for (var attachment : attachments) {
                // Delete physical file
                FileUploadUtil.deleteFile(attachment.getFileUrl(), getServletContext().getRealPath(""));
                // Delete from database
                attachmentDao.deleteAttachment(attachment.getId());
            }

            // Delete job posting
            boolean deleted = jobDao.deleteJobPosting(jobId);
            
            if (deleted) {
                session.setAttribute("successMessage", "Job deleted successfully.");
            } else {
                session.setAttribute("errorMessage", "Failed to delete job. Please try again.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid job ID format.");
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database error occurred while deleting job.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred while deleting job.");
        } finally {
            // Close DAO connections
            if (jobDao != null) jobDao.closeConnection();
            if (attachmentDao != null) attachmentDao.closeConnection();
            if (companyDao != null) companyDao.closeConnection();
        }

        response.sendRedirect("CompanyJobsServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
