package controller;

import dal.DBContext;
import dal.CompanyDAO;
import model.Company;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "CompanyListServlet", urlPatterns = {"/CompanyListServlet", "/companies"})
public class CompanyListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            CompanyDAO companyDao = new CompanyDAO(conn);
            
            // Always get all searchable companies, sorted by featured and creation date
            List<Company> companies = companyDao.getAllSearchableCompanies();
            
            // Get statistics
            int totalCompanies = companyDao.getTotalCompaniesCount();
            int companiesCount = companies.size(); // Number of companies currently displayed

            // Set attributes for JSP
            request.setAttribute("companies", companies);
            request.setAttribute("totalCompanies", totalCompanies);
            request.setAttribute("companiesCount", companiesCount);
            
            // Set page title
            request.setAttribute("pageTitle", "All Companies");
            
            // Check for messages
            String message = request.getParameter("message");
            if ("success".equals(message)) {
                request.setAttribute("successMessage", "Operation successful!");
            } else if ("error".equals(message)) {
                request.setAttribute("errorMessage", "An error occurred!");
            }
            
            request.getRequestDispatcher("/company-list.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/company-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // For simplicity, POST requests will be handled by doGet
    }
}
