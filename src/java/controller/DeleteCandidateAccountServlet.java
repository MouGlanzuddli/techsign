package controller;

import dao.CandidateDAO;
import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "DeleteCandidateAccountServlet", urlPatterns = {"/DeleteCandidateAccount"})
public class DeleteCandidateAccountServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRoleId() != 2) { // 2: candidate
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();
        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            CandidateDAO candidateDAO = new CandidateDAO(conn);
            UserDAO userDAO = new UserDAO(conn);
            // Xóa candidate profile
            candidateDAO.deleteCandidate(userId);
            // Xóa user
            userDAO.deleteUser(userId);
            // Xóa session
            session.invalidate();
            // Chuyển về trang chủ
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xóa tài khoản");
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