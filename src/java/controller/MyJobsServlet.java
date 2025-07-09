package controller;

import dal.DBContext;
import dal.JobDao;
import model.Job;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "MyJobsServlet", urlPatterns = {"/MyJobsServlet"})
public class MyJobsServlet extends HttpServlet {

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // Kiểm tra đăng nhập và role
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    
    if (user == null || user.getRoleId() != 3) { // 3 = Employer role
        response.sendRedirect("login.jsp?error=access_denied");
        return;
    }

    try {
        // Lấy danh sách jobs của công ty
        DBContext dbContext = new DBContext();
        Connection conn = dbContext.getConnection();
        JobDao jobDao = new JobDao(conn);
        
        List<Job> jobs = jobDao.getJobsByCompanyId(user.getId());
        
        // Tính toán thống kê
        int totalJobs = jobs.size();
        int activeJobs = (int) jobs.stream().filter(job -> "active".equals(job.getStatus())).count();
        int totalApplications = jobs.stream().mapToInt(Job::getApplicationsCount).sum();
        int totalViews = jobs.stream().mapToInt(Job::getViewsCount).sum();
        
        // Set attributes
        request.setAttribute("jobs", jobs);
        request.setAttribute("totalJobs", totalJobs);
        request.setAttribute("activeJobs", activeJobs);
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("totalViews", totalViews);
        
        // Kiểm tra success message
        String success = request.getParameter("success");
        if ("job_posted".equals(success)) {
            request.setAttribute("successMessage", "Đăng tin tuyển dụng thành công!");
        }
        
        request.getRequestDispatcher("/company-my-jobs.jsp").forward(request, response);
        
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
        request.getRequestDispatcher("/company-my-jobs.jsp").forward(request, response);
    }
}

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // Kiểm tra đăng nhập và role
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    
    if (user == null || user.getRoleId() != 3) {
        response.sendRedirect("login.jsp?error=access_denied");
        return;
    }

    String action = request.getParameter("action");
    String jobIdStr = request.getParameter("jobId");
    
    if (action == null || jobIdStr == null) {
        response.sendRedirect("MyJobsServlet?error=invalid_request");
        return;
    }

    try {
        int jobId = Integer.parseInt(jobIdStr);
        DBContext dbContext = new DBContext();
        Connection conn = dbContext.getConnection();
        JobDao jobDao = new JobDao(conn);
        
        boolean success = false;
        String message = "";
        
        switch (action) {
            case "activate":
                success = jobDao.updateJobStatus(jobId, user.getId(), "active");
                message = success ? "Kích hoạt tin tuyển dụng thành công!" : "Có lỗi xảy ra khi kích hoạt tin.";
                break;
            case "deactivate":
                success = jobDao.updateJobStatus(jobId, user.getId(), "inactive");
                message = success ? "Tạm dừng tin tuyển dụng thành công!" : "Có lỗi xảy ra khi tạm dừng tin.";
                break;
            case "delete":
                success = jobDao.deleteJob(jobId, user.getId());
                message = success ? "Xóa tin tuyển dụng thành công!" : "Có lỗi xảy ra khi xóa tin.";
                break;
            default:
                message = "Hành động không hợp lệ.";
        }
        
        if (success) {
            response.sendRedirect("MyJobsServlet?success=" + action);
        } else {
            response.sendRedirect("MyJobsServlet?error=" + action);
        }
        
    } catch (NumberFormatException e) {
        response.sendRedirect("MyJobsServlet?error=invalid_job_id");
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("MyJobsServlet?error=database_error");
    }
}
}
