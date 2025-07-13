package controller;

import dal.DBContext;
import dal.JobDao;
import dal.UserDao;
import model.Job;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "JobDetailServlet", urlPatterns = {"/JobDetailServlet", "/job-detail"})
public class JobDetailServlet extends HttpServlet {

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    String jobIdStr = request.getParameter("id");
    
    if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
        response.sendRedirect("JobListServlet?error=invalid_job_id");
        return;
    }
    
    try {
        int jobId = Integer.parseInt(jobIdStr);
        
        // Kết nối database
        DBContext dbContext = new DBContext();
        Connection conn = dbContext.getConnection();
        JobDao jobDao = new JobDao(conn);
        UserDao userDao = new UserDao(conn);
        
        // Lấy thông tin job
        Job job = jobDao.getJobById(jobId);
        
        if (job == null) {
            response.sendRedirect("JobListServlet?error=job_not_found");
            return;
        }
        
        // Kiểm tra job có active không
        if (!"active".equals(job.getStatus())) {
            response.sendRedirect("JobListServlet?error=job_not_available");
            return;
        }
        
        // Lấy thông tin company
        User company = null;
        try {
            company = userDao.getUserById(job.getCompanyId());
        } catch (SQLException e) {
            System.out.println("Error getting company info: " + e.getMessage());
        }
        
        // Tăng view count
        jobDao.incrementViewCount(jobId);
        
        // Lấy các job liên quan (cùng category hoặc cùng company)
        java.util.List<Job> relatedJobs = jobDao.getRelatedJobs(jobId, job.getCategory(), job.getCompanyId(), 5);
        
        // Set attributes
        request.setAttribute("job", job);
        request.setAttribute("company", company);
        request.setAttribute("relatedJobs", relatedJobs);
        
        // Forward đến JSP
        request.getRequestDispatcher("/job-detail.jsp").forward(request, response);
        
    } catch (NumberFormatException e) {
        response.sendRedirect("JobListServlet?error=invalid_job_id");
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}
}
