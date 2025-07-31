package controller;

import dao.LoginHistoryDAO;

import model.LoginHistory;
import service.LoginHistoryService;
import dao.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException; // Import SQLException
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        
        // New action for search and filter
        if ("searchAndFilter".equals(action)) {
            handleSearchAndFilter(req, resp);
            return;
        }
        
        // New action for getting filter options
        if ("getFilterOptions".equals(action)) {
            handleGetFilterOptions(req, resp);
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

    private void handleSearchAndFilter(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            LoginHistoryDAO loginHistoryDAO = new LoginHistoryDAO(conn);

            // Get filter parameters
            String searchTerm = req.getParameter("searchTerm");
            String userId = req.getParameter("userId");
            String dateFrom = req.getParameter("dateFrom");
            String dateTo = req.getParameter("dateTo");
            String ipAddress = req.getParameter("ipAddress");
            String deviceInfo = req.getParameter("deviceInfo");
            
            // Check if this is an export request
            String export = req.getParameter("export");
            if ("true".equals(export)) {
                handleExport(req, resp, loginHistoryDAO, searchTerm, userId, dateFrom, dateTo, ipAddress, deviceInfo);
                return;
            }
            
            // Pagination parameters
            int page = 1;
            int pageSize = 50;
            try {
                page = Integer.parseInt(req.getParameter("page"));
                pageSize = Integer.parseInt(req.getParameter("pageSize"));
            } catch (NumberFormatException e) {
                // Use defaults
            }
            
            int offset = (page - 1) * pageSize;
            
            // Get filtered data
            List<LoginHistory> history = loginHistoryDAO.searchAndFilter(
                searchTerm, userId, dateFrom, dateTo, ipAddress, deviceInfo, pageSize, offset
            );
            
            // Get total count for pagination
            int totalCount = loginHistoryDAO.getTotalCount(
                searchTerm, userId, dateFrom, dateTo, ipAddress, deviceInfo
            );
            
            // Convert to JSON response
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,");
            json.append("\"loginHistory\":[");
            
            for (int i = 0; i < history.size(); i++) {
                LoginHistory lh = history.get(i);
                json.append("{");
                json.append("\"id\":").append(lh.getId()).append(",");
                json.append("\"userId\":").append(lh.getUserId()).append(",");
                json.append("\"userName\":\"").append(lh.getUserName() != null ? lh.getUserName() : "").append("\",");
                json.append("\"userEmail\":\"").append(lh.getUserEmail() != null ? lh.getUserEmail() : "").append("\",");
                json.append("\"loginTime\":\"").append(lh.getLoginTime()).append("\",");
                json.append("\"ipAddress\":\"").append(lh.getIpAddress() != null ? lh.getIpAddress() : "").append("\",");
                json.append("\"deviceInfo\":\"").append(lh.getDeviceInfo() != null ? lh.getDeviceInfo() : "").append("\"");
                json.append("}");
                if (i < history.size() - 1) {
                    json.append(",");
                }
            }
            
            json.append("],");
            json.append("\"totalCount\":").append(totalCount).append(",");
            json.append("\"currentPage\":").append(page).append(",");
            json.append("\"pageSize\":").append(pageSize).append(",");
            json.append("\"totalPages\":").append((int) Math.ceil((double) totalCount / pageSize));
            json.append("}");
            
            resp.getWriter().write(json.toString());
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Database error occurred while searching login history: " + e.getMessage());
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

    private void handleExport(HttpServletRequest req, HttpServletResponse resp, 
                             LoginHistoryDAO loginHistoryDAO, String searchTerm, String userId, 
                             String dateFrom, String dateTo, String ipAddress, String deviceInfo) 
            throws Exception {
        
        // Get all filtered data (no pagination for export)
        List<LoginHistory> history = loginHistoryDAO.searchAndFilter(
            searchTerm, userId, dateFrom, dateTo, ipAddress, deviceInfo, 0, 0
        );
        
        // Set response headers for CSV download
        resp.setContentType("text/csv;charset=UTF-8");
        resp.setHeader("Content-Disposition", "attachment; filename=\"access_history.csv\"");
        resp.setHeader("Content-Transfer-Encoding", "binary");
        
        // Write CSV header
        resp.getWriter().write("ID,User ID,User Name,User Email,Login Time,IP Address,Device Info\n");
        
        // Write CSV data
        for (LoginHistory lh : history) {
            StringBuilder csvLine = new StringBuilder();
            csvLine.append(lh.getId()).append(",");
            csvLine.append(lh.getUserId()).append(",");
            csvLine.append("\"").append(lh.getUserName() != null ? lh.getUserName().replace("\"", "\"\"") : "").append("\",");
            csvLine.append("\"").append(lh.getUserEmail() != null ? lh.getUserEmail().replace("\"", "\"\"") : "").append("\",");
            csvLine.append("\"").append(lh.getLoginTime()).append("\",");
            csvLine.append("\"").append(lh.getIpAddress() != null ? lh.getIpAddress().replace("\"", "\"\"") : "").append("\",");
            csvLine.append("\"").append(lh.getDeviceInfo() != null ? lh.getDeviceInfo().replace("\"", "\"\"") : "").append("\"");
            csvLine.append("\n");
            
            resp.getWriter().write(csvLine.toString());
        }
        
        resp.getWriter().flush();
    }

    private void handleGetFilterOptions(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            LoginHistoryDAO loginHistoryDAO = new LoginHistoryDAO(conn);

            // Get filter options
            List<String> users = loginHistoryDAO.getUniqueUsers();
            List<String> ipAddresses = loginHistoryDAO.getUniqueIPAddresses();
            
            // Convert to JSON response
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,");
            json.append("\"users\":[");
            
            for (int i = 0; i < users.size(); i++) {
                json.append("\"").append(users.get(i).replace("\"", "\\\"")).append("\"");
                if (i < users.size() - 1) {
                    json.append(",");
                }
            }
            
            json.append("],");
            json.append("\"ipAddresses\":[");
            
            for (int i = 0; i < ipAddresses.size(); i++) {
                json.append("\"").append(ipAddresses.get(i).replace("\"", "\\\"")).append("\"");
                if (i < ipAddresses.size() - 1) {
                    json.append(",");
                }
            }
            
            json.append("]}");
            
            resp.getWriter().write(json.toString());
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Database error occurred while getting filter options: " + e.getMessage());
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