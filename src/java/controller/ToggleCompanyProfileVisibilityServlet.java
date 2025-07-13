package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "ToggleCompanyProfileVisibility", urlPatterns = {"/ToggleCompanyProfileVisibility"})
public class ToggleCompanyProfileVisibilityServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 3) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();
        boolean isSearchable = request.getParameter("isSearchable") != null;
        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            dao.CompanyDAO companyDAO = new dao.CompanyDAO(conn);
            companyDAO.toggleProfileVisibility(userId, isSearchable);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        response.sendRedirect("UpdateCompanyProfile");
    }
} 