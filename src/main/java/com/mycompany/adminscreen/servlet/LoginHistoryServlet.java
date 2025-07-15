package com.mycompany.adminscreen.servlet;

import com.mycompany.adminscreen.dao.LoginHistoryDAO;
import com.mycompany.adminscreen.model.LoginHistory;
import com.mycompany.adminscreen.service.LoginHistoryService;
import com.mycompany.adminscreen.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException; // Import SQLException
import java.util.List;

@WebServlet("/loginHistory")
public class LoginHistoryServlet extends HttpServlet {

    // Remove the 'service' field. We'll create it per request.
    // private LoginHistoryService service;

    @Override
    public void init() throws ServletException {
        // You can use init() to perform initial setup or just to log that the servlet is initializing.
        // It's good practice to ensure DB driver loads here, but don't hold onto the connection.
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("LoginHistoryServlet initialized. SQL Server JDBC driver loaded.");
        } catch (ClassNotFoundException e) {
            System.err.println("ERROR: SQL Server JDBC driver not found!");
            throw new ServletException("Failed to load JDBC driver.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        
        // If action is getData, return JSON response
        if ("getData".equals(action)) {
            handleGetData(req, resp);
            return;
        }

        Connection conn = null; // Declare connection here so it's accessible in finally block
        try {
            // 1. Get a FRESH connection for THIS request
            conn = DBConnection.getConnection();

            // 2. Create DAO and Service instances with THIS new connection
            LoginHistoryDAO loginHistoryDAO = new LoginHistoryDAO(conn);
            LoginHistoryService service = new LoginHistoryService(loginHistoryDAO);

            String userIdParam = req.getParameter("userId");
            List<LoginHistory> history;

            // Added checks for userIdParam being null or empty to prevent NumberFormatException
            if (userIdParam != null && !userIdParam.trim().isEmpty()) {
                try {
                    int userId = Integer.parseInt(userIdParam);
                    history = service.getByUser(userId);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid userId parameter: '" + userIdParam + "'. Fetching all login history instead.");
                    // Optionally, add an error message to the request to display on the JSP
                    req.setAttribute("errorMessage", "Invalid User ID provided. Displaying all login history.");
                    history = service.getAll(); // Fallback to fetching all if ID is invalid
                }
            } else {
                history = service.getAll();
            }

            req.setAttribute("loginHistory", history);
            req.getRequestDispatcher("/views/sections/user-management.jsp").forward(req, resp);

        } catch (SQLException | ClassNotFoundException e) {
            // Catch specific database-related exceptions
            System.err.println("Database error occurred while fetching login history: " + e.getMessage());
            e.printStackTrace();
            // Forward to an error page or display an error message on the current page
            req.setAttribute("errorMessage", "Failed to load login history due to a database error.");
            req.getRequestDispatcher("/error_page.jsp").forward(req, resp); // Or forward back to user-management.jsp
        } catch (Exception e) {
            // Catch any other unexpected exceptions
            System.err.println("An unexpected error occurred in LoginHistoryServlet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("An unexpected error occurred during login history retrieval.", e);
        } finally {
            // 3. IMPORTANT: Close the connection in the finally block
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Error closing database connection: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        }
    }

    private void handleGetData(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            LoginHistoryDAO loginHistoryDAO = new LoginHistoryDAO(conn);
            LoginHistoryService service = new LoginHistoryService(loginHistoryDAO);

            List<LoginHistory> history = service.getAll();
            
            // Convert to JSON response
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,\"loginHistory\":[");
            
            for (int i = 0; i < history.size(); i++) {
                LoginHistory lh = history.get(i);
                json.append("{");
                json.append("\"id\":").append(lh.getId()).append(",");
                json.append("\"userId\":").append(lh.getUserId()).append(",");
                json.append("\"loginTime\":\"").append(lh.getLoginTime()).append("\",");
                json.append("\"ipAddress\":\"").append(lh.getIpAddress() != null ? lh.getIpAddress() : "").append("\",");
                json.append("\"deviceInfo\":\"").append(lh.getDeviceInfo() != null ? lh.getDeviceInfo() : "").append("\"");
                json.append("}");
                if (i < history.size() - 1) {
                    json.append(",");
                }
            }
            
            json.append("]}");
            
            resp.getWriter().write(json.toString());
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Database error occurred while fetching login history: " + e.getMessage());
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\":false,\"message\":\"Database error occurred\"}");
        } catch (Exception e) {
            System.err.println("An unexpected error occurred in LoginHistoryServlet: " + e.getMessage());
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\":false,\"message\":\"An unexpected error occurred\"}");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Error closing database connection: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void destroy() {
        // No need to close the connection here anymore, as it's closed per request.
        System.out.println("LoginHistoryServlet destroyed.");
    }
}