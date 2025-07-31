package controller;

import dal.DBContext;
import dal.ApplicationDAO;
import dal.JobDao;
import dal.UserDao;
import model.Application;
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
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "MyApplicationsServlet", urlPatterns = {"/MyApplicationsServlet"})
public class MyApplicationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập và role candidate
        if (user == null || user.getRoleId() != 2) { // role_id = 2 là candidate
            response.sendRedirect("login.jsp?error=access_denied");
            return;
        }
        
        try {
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            
            ApplicationDAO applicationDao = new ApplicationDAO(conn);
            JobDao jobDao = new JobDao(conn);
            UserDao userDao = new UserDao(conn);
            
            // Lấy tất cả applications của candidate
            List<Application> applications = applicationDao.getApplicationsByCandidateId(user.getId());
            
            // Lấy thông tin jobs và companies
            Map<Integer, Job> jobMap = new HashMap<>();
            Map<Integer, User> companyMap = new HashMap<>();
            
            for (Application app : applications) {
                if (!jobMap.containsKey(app.getJobId())) {
                    Job job = jobDao.getJobById(app.getJobId());
                    jobMap.put(app.getJobId(), job);
                    
                    // Lấy thông tin company
                    if (job != null && !companyMap.containsKey(job.getCompanyId())) {
                        User company = userDao.getUserById(job.getCompanyId());
                        companyMap.put(job.getCompanyId(), company);
                    }
                }
            }
            
            // Tính toán thống kê
            int totalApplications = applications.size();
            int pendingApplications = 0;
            int approvedApplications = 0;
            int rejectedApplications = 0;
            int reviewingApplications = 0;
            
            for (Application app : applications) {
                switch (app.getStatus()) {
                    case "pending": pendingApplications++; break;
                    case "approved": approvedApplications++; break;
                    case "rejected": rejectedApplications++; break;
                    case "reviewing": reviewingApplications++; break;
                }
            }
            
            // Set attributes
            request.setAttribute("applications", applications);
            request.setAttribute("jobMap", jobMap);
            request.setAttribute("companyMap", companyMap);
            request.setAttribute("totalApplications", totalApplications);
            request.setAttribute("pendingApplications", pendingApplications);
            request.setAttribute("approvedApplications", approvedApplications);
            request.setAttribute("rejectedApplications", rejectedApplications);
            request.setAttribute("reviewingApplications", reviewingApplications);
            
            request.getRequestDispatcher("/my-applications.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
