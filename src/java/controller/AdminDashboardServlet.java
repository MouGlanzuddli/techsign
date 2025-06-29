package controller;

import dal.AuditDao;
import dal.DBContext;
import dal.JobPostDao;
import dal.UserDao;
import dal.LoginDao;
import dal.StatisticsDAO;
import java.io.IOException;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminHome")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String requestType = request.getHeader("X-Requested-With"); // Kiểm tra yêu cầu AJAX

        try (Connection conn = DBContext.getConnection()) {
            UserDao userDao = new UserDao(conn);
            JobPostDao jobPostDao = new JobPostDao(conn);
            AuditDao alert = new AuditDao(conn);
            StatisticsDAO statisticsDAO = new StatisticsDAO();

            int totalUsers = userDao.getTotalUsers();
            int totalJobPosts = jobPostDao.getTotalJobPosts();
            int securityAlerts = alert.getAlert();
            int totalVisits = statisticsDAO.getTodayVisits();

            if ("XMLHttpRequest".equals(requestType)) {
    response.setContentType("application/json");
    response.getWriter().write("{\"totalUsers\":" + totalUsers +
                                ",\"totalJobPosts\":" + totalJobPosts +
                                ",\"securityAlerts\":" + securityAlerts +
                                ",\"totalVisits\":" + totalVisits + "}");
} else {
    // Chuyển đến JSP nếu không phải AJAX
    request.setAttribute("totalUsers", totalUsers);
    request.setAttribute("totalJobPosts", totalJobPosts);
    request.setAttribute("securityAlerts", securityAlerts);
    request.setAttribute("totalVisitsToday", totalVisits);
    request.getRequestDispatcher("/adminHome.jsp").forward(request, response);
}

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Internal Server Error");
        }
    }
}

