package controller;

import dal.DBContext;
import dal.JobPostingDao;
import dal.CompanyProfileDao;
import model.JobPosting;
import model.CompanyProfile;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/PostJobServlet")
public class PostJobServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (user.getRoleId() != 3) {
            request.setAttribute("errorMessage", "Access denied. Only employers can post jobs.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("post-job.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleId() != 3) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection connection = new DBContext().getConnection()) {

            CompanyProfileDao companyDao = new CompanyProfileDao(connection);
            CompanyProfile company = companyDao.getCompanyByUserId(user.getId());

            if (company == null) {
                request.setAttribute("errorMessage", "Please complete your company profile first.");
                request.getRequestDispatcher("post-job.jsp").forward(request, response);
                return;
            }

            JobPosting job = new JobPosting();
            job.setCompanyProfileId(company.getId());
            job.setTitle(request.getParameter("title"));
            job.setDescription(request.getParameter("description"));
            job.setLocation(request.getParameter("location"));
            job.setJobType(request.getParameter("jobType"));
            job.setBenefits(request.getParameter("benefits"));
            job.setStatus("open");

            String salaryMinStr = request.getParameter("salaryMin");
            String salaryMaxStr = request.getParameter("salaryMax");

            if (salaryMinStr != null && !salaryMinStr.isBlank()) {
                job.setSalaryMin(new BigDecimal(salaryMinStr));
            }

            if (salaryMaxStr != null && !salaryMaxStr.isBlank()) {
                job.setSalaryMax(new BigDecimal(salaryMaxStr));
            }

            String expiresAtStr = request.getParameter("expiresAt");
            if (expiresAtStr != null && !expiresAtStr.isBlank()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date expiresAt = sdf.parse(expiresAtStr);
                    job.setExpiresAt(expiresAt);
                } catch (ParseException e) {
                    job.setExpiresAt(new Date(System.currentTimeMillis() + (30L * 24 * 60 * 60 * 1000)));
                }
            } else {
                job.setExpiresAt(new Date(System.currentTimeMillis() + (30L * 24 * 60 * 60 * 1000)));
            }

            job.setPostedAt(new Date());

            String isFeatured = request.getParameter("isFeatured");
            job.setFeatured("on".equalsIgnoreCase(isFeatured));

            JobPostingDao jobDao = new JobPostingDao(connection);
            boolean success = jobDao.insertJobPosting(job);

            if (success) {
                String skillsStr = request.getParameter("skills");
                if (skillsStr != null && !skillsStr.isBlank()) {
                    String[] skills = skillsStr.split(",");
                    jobDao.addJobSkills(job.getId(), skills);
                }

                String categoryIdStr = request.getParameter("categoryId");
                if (categoryIdStr != null && !categoryIdStr.isBlank()) {
                    int categoryId = Integer.parseInt(categoryIdStr);
                    jobDao.addJobCategory(job.getId(), categoryId);
                }

                session.removeAttribute("jobDraft");

                request.setAttribute("successMessage", "Job posted successfully! It will be reviewed and published shortly.");
                request.setAttribute("jobId", job.getId());

                logJobPostingAction(user.getId(), job.getId(), "Job Posted", connection);

            } else {
                request.setAttribute("errorMessage", "Failed to post job. Please try again.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred.");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unexpected error occurred.");
        }

        request.getRequestDispatcher("post-job.jsp").forward(request, response);
    }

    private void logJobPostingAction(int userId, int jobId, String action, Connection connection) {
        try (PreparedStatement stmt = connection.prepareStatement(
                "INSERT INTO system_logs (user_id, action, description, created_at) VALUES (?, ?, ?, ?)")) {
            stmt.setInt(1, userId);
            stmt.setString(2, action);
            stmt.setString(3, "Job ID: " + jobId + " - " + action);
            stmt.setTimestamp(4, new java.sql.Timestamp(System.currentTimeMillis()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
