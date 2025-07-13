package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import model.User;
import model.Company;
import dao.CompanyDAO;

@WebServlet(name = "CompanyHome", urlPatterns = {"/CompanyHome"})
public class CompanyHomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 3) {
            response.sendRedirect("login.jsp");
            return;
        }

        boolean isSearchable = true;
        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            CompanyDAO companyDAO = new CompanyDAO(conn);
            Company company = companyDAO.getCompanyByUserId(user.getId());
            if (company != null) {
                isSearchable = company.isSearchable();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        request.setAttribute("isSearchable", isSearchable);
        request.getRequestDispatcher("companyHome.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 