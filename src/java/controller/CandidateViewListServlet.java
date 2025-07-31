package controller;

import dal.DBContext;
import dal.JobViewDao;
import dal.UserDao;
import model.JobView;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "CandidateViewListServlet", urlPatterns = {"/CandidateViewListServlet", "/candidate-view-list"})
public class CandidateViewListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra user đã đăng nhập chưa
        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect("LoginServlet?error=login_required");
            return;
        }
        
        // Kiểm tra user có phải là employer không (role_id = 1 hoặc 2)
        if (currentUser.getRoleId() != 1 && currentUser.getRoleId() != 2) { 
            response.sendRedirect("index.jsp?error=access_denied");
            return;
        }
        
        try {
            // Kết nối database
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            JobViewDao jobViewDao = new JobViewDao(conn);
            
            // Lấy tham số từ request
            String limitStr = request.getParameter("limit");
            int limit = 50; // Mặc định 50 records
            if (limitStr != null && !limitStr.trim().isEmpty()) {
                try {
                    limit = Integer.parseInt(limitStr);
                } catch (NumberFormatException e) {
                    // Sử dụng giá trị mặc định
                }
            }
            
            // Lấy danh sách candidates đã xem job postings của company
            List<JobView> viewedCandidates = jobViewDao.getCandidatesViewedCompanyJobs(currentUser.getId(), limit);
            
            // Lấy thống kê views theo ngày (7 ngày gần nhất)
            List<Object[]> viewsStatistics = jobViewDao.getViewsStatisticsByDate(currentUser.getId(), 7);
            
            // Set attributes
            request.setAttribute("viewedCandidates", viewedCandidates);
            request.setAttribute("viewsStatistics", viewsStatistics);
            request.setAttribute("totalCandidates", viewedCandidates.size());
            
            // Forward đến JSP
            request.getRequestDispatcher("/company-candidate-list.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=db_error&message=" + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=general_error&message=" + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect về GET method
        doGet(request, response);
    }
} 