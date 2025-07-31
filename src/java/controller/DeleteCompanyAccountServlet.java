package controller;

import dal.CompanyDAO;
import dal.UserDao;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "DeleteCompanyAccountServlet", urlPatterns = {"/DeleteCompanyAccount"})
public class DeleteCompanyAccountServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRoleId() != 3) { // 3: company
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();
        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            conn.setAutoCommit(false);

            // 1. Xóa job_applications liên quan đến các job của company này
            String getJobIdsSql = "SELECT id FROM job_postings WHERE company_profile_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(getJobIdsSql)) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    int jobId = rs.getInt("id");
                    String deleteApplicationsSql = "DELETE FROM job_applications WHERE job_id = ?";
                    try (PreparedStatement deleteStmt = conn.prepareStatement(deleteApplicationsSql)) {
                        deleteStmt.setInt(1, jobId);
                        deleteStmt.executeUpdate();
                    }
                }
            }

            // 2. Xóa tất cả job_postings của company này
            String deleteJobsSql = "DELETE FROM job_postings WHERE company_profile_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteJobsSql)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            // 3. Xóa company profile
            CompanyDAO companyDAO = new CompanyDAO(conn);
            companyDAO.deleteCompany(userId);

            // 4. Xóa tất cả session liên quan đến user này
            String deleteSessionsSql = "DELETE FROM user_sessions WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteSessionsSql)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            // 5. Xóa user
            UserDao userDAO = new UserDao(conn);
            userDAO.deleteUser(userId);

            conn.commit();
            session.invalidate();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xóa tài khoản: " + e.getMessage());
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}