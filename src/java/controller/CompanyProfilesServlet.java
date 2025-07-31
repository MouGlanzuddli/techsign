package controller;

import dal.CompanyDAO;
import model.User;
import model.Company;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "CompanyProfilesServlet", urlPatterns = {"/CompanyProfilesServlet"})
public class CompanyProfilesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
            CompanyDAO companyDAO = new CompanyDAO(conn);
            Company company = companyDAO.getCompanyByUserId(userId);

            if (company != null) {
                request.setAttribute("companyName", company.getCompanyName());
                request.setAttribute("website", company.getWebsite());
                request.setAttribute("address", company.getAddress());
                request.setAttribute("industryId", company.getIndustryId());
                request.setAttribute("description", company.getDescription());
                request.setAttribute("avatarUrl", company.getLogoUrl() != null ? company.getLogoUrl() : "assets/img/default-avatar.png");
                request.setAttribute("isSearchable", company.isSearchable());
            } else {
                request.setAttribute("companyName", "");
                request.setAttribute("website", "");
                request.setAttribute("address", "");
                request.setAttribute("industryId", "");
                request.setAttribute("description", "");
                request.setAttribute("avatarUrl", "assets/img/default-avatar.png");
                request.setAttribute("isSearchable", true);
            }
            request.setAttribute("email", user.getEmail());
            request.setAttribute("phone", user.getPhone());
            request.getRequestDispatcher("company-profiles.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("company-profiles.jsp").forward(request, response);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}