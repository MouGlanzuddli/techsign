/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.User;
import model.Company;
import dal.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "CompanyDashboardServlet", urlPatterns = {"/CompanyDashboardServlet"})
public class CompanyDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 3) { // 3: company
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = user.getId();
        Connection conn = null;
        
        try {
            conn = new dal.DBContext().getConnection();
            dal.CompanyDAO companyDAO = new dal.CompanyDAO(conn);
            Company company = companyDAO.getCompanyByUserId(userId);
            
            // Set default attributes from User
            request.setAttribute("fullName", user.getFullName());
            request.setAttribute("avatarUrl", user.getAvatarUrl() != null ? user.getAvatarUrl() : "assets/img/default-avatar.png");
            request.setAttribute("phone", user.getPhone());
            request.setAttribute("email", user.getEmail());
            
            if (company != null) {
                // Override with Company-specific attributes if available
                request.setAttribute("companyName", company.getCompanyName());
                if (company.getLogoUrl() != null && !company.getLogoUrl().isEmpty()) {
                    request.setAttribute("avatarUrl", company.getLogoUrl());
                }
                request.setAttribute("industry", company.getIndustry());
                request.setAttribute("address", company.getAddress());
                request.setAttribute("website", company.getWebsite());
                request.setAttribute("isSearchable", company.isSearchable());
                request.setAttribute("openJobs", company.getOpenJobs());
                request.setAttribute("description", company.getDescription());
                request.setAttribute("jobTitle", company.getIndustry());  // Set jobTitle to industry for display in sidebar
                
                // If company name is available, use it as fullName
                if (company.getCompanyName() != null && !company.getCompanyName().isEmpty()) {
                    request.setAttribute("fullName", company.getCompanyName());
                }
            } else {
                // Set empty defaults for company attributes
                request.setAttribute("companyName", "");
                request.setAttribute("industry", "");
                request.setAttribute("address", "");
                request.setAttribute("website", "");
                request.setAttribute("isSearchable", false);
                request.setAttribute("openJobs", 0);
                request.setAttribute("description", "");
                request.setAttribute("jobTitle", "");
            }
            
            request.getRequestDispatcher("company-dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
