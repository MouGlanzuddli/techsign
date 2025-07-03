package controller;

import dal.JobPostingDao;
import dal.CompanyProfileDao;
import model.JobPosting;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/testJobDisplay")
public class TestJobDisplayServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        System.out.println("=== TestJobDisplayServlet START ===");
        System.out.println("👤 Current user: " + (currentUser != null ? currentUser.getFullName() + " (ID: " + currentUser.getId() + ")" : "null"));
        
        if (currentUser == null) {
            System.out.println("❌ No user in session, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }

        JobPostingDao jobDao = null;
        CompanyProfileDao companyDao = null;

        try {
            // Initialize DAOs
            jobDao = new JobPostingDao();
            companyDao = new CompanyProfileDao();
            
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

            // Get ALL job postings for this company
            List<JobPosting> allJobsList = jobDao.getJobPostingsByCompany(companyProfileId);
            System.out.println("📊 Total jobs in database: " + allJobsList.size());
            
            // Print all jobs for debugging
            for (JobPosting job : allJobsList) {
                System.out.println("  📝 Job: " + job.getId() + " - " + job.getTitle() + " (" + job.getStatus() + ") - Posted: " + job.getPostedAt());
                System.out.println("     Location: " + job.getLocation());
                System.out.println("     Job Type: " + job.getJobType());
                System.out.println("     Skills: " + job.getSkills());
                System.out.println("     Country: " + job.getCountry());
                System.out.println("     State/City: " + job.getStateCity());
            }

            // Set attributes for JSP
            request.setAttribute("jobList", allJobsList);
            request.setAttribute("currentUser", currentUser);
            request.setAttribute("companyName", companyName);
            request.setAttribute("totalJobs", allJobsList.size());

            System.out.println("🎯 Forwarding to test-jobs.jsp with " + allJobsList.size() + " jobs");

            // Forward to test JSP
            request.getRequestDispatcher("test-jobs.jsp").forward(request, response);

        } catch (SQLException e) {
            System.err.println("❌ SQL Exception in TestJobDisplayServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("❌ General Exception in TestJobDisplayServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            // Close DAO connections
            if (jobDao != null) jobDao.closeConnection();
            if (companyDao != null) companyDao.closeConnection();
        }
        
        System.out.println("=== TestJobDisplayServlet END ===");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 