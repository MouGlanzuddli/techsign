package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import dao.DBConnection;
import com.google.gson.Gson;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AlertServlet")
public class AlertServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("dismiss".equals(action)) {
            handleDismiss(request, response);
        } else {
            // Default: get alerts data
            handleGetAlerts(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void handleGetAlerts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBConnection.getConnection()) {
            // Get alerts from multiple sources
            List<Map<String, Object>> alerts = new ArrayList<>();
            
            // Get session alerts (suspicious sessions)
            String sessionSql = "SELECT us.id, us.user_id, u.full_name, us.ip_address, us.device_info, " +
                              "us.login_time, us.last_activity, us.status FROM user_sessions us " +
                              "LEFT JOIN users u ON us.user_id = u.id " +
                              "WHERE us.status = 'suspicious' OR us.last_activity < DATEADD(minute, -30, GETDATE())";
            
            try (PreparedStatement stmt = conn.prepareStatement(sessionSql)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Map<String, Object> alert = new HashMap<>();
                    alert.put("id", rs.getInt("id"));
                    alert.put("type", "session");
                    alert.put("userId", rs.getInt("user_id"));
                    alert.put("userName", rs.getString("full_name"));
                    alert.put("ipAddress", rs.getString("ip_address"));
                    alert.put("deviceInfo", rs.getString("device_info"));
                    alert.put("loginTime", rs.getTimestamp("login_time"));
                    alert.put("lastActivity", rs.getTimestamp("last_activity"));
                    alert.put("status", rs.getString("status"));
                    alert.put("severity", "medium");
                    alerts.add(alert);
                }
            }
            
            // Get system log alerts
            String systemLogSql = "SELECT sl.id, sl.user_id, u.full_name, sl.action, sl.details, " +
                                "sl.timestamp, sl.severity FROM system_logs sl " +
                                "LEFT JOIN users u ON sl.user_id = u.id " +
                                "WHERE sl.severity IN ('high', 'critical') " +
                                "ORDER BY sl.timestamp DESC";
            
            try (PreparedStatement stmt = conn.prepareStatement(systemLogSql)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Map<String, Object> alert = new HashMap<>();
                    alert.put("id", rs.getInt("id"));
                    alert.put("type", "system_log");
                    alert.put("userId", rs.getInt("user_id"));
                    alert.put("userName", rs.getString("full_name"));
                    alert.put("action", rs.getString("action"));
                    alert.put("details", rs.getString("details"));
                    alert.put("timestamp", rs.getTimestamp("timestamp"));
                    alert.put("severity", rs.getString("severity"));
                    alerts.add(alert);
                }
            }
            
            // Get audit log alerts
            String auditLogSql = "SELECT al.id, al.user_id, u.full_name, al.action_type, al.entity_type, " +
                               "al.entity_id, al.old_value, al.new_value, al.ip_address, al.timestamp " +
                               "FROM audit_logs al " +
                               "LEFT JOIN users u ON al.user_id = u.id " +
                               "WHERE al.action_type IN ('delete', 'unauthorized_access', 'suspicious_activity') " +
                               "ORDER BY al.timestamp DESC";
            
            try (PreparedStatement stmt = conn.prepareStatement(auditLogSql)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Map<String, Object> alert = new HashMap<>();
                    alert.put("id", rs.getInt("id"));
                    alert.put("type", "audit_log");
                    alert.put("userId", rs.getInt("user_id"));
                    alert.put("userName", rs.getString("full_name"));
                    alert.put("actionType", rs.getString("action_type"));
                    alert.put("entityType", rs.getString("entity_type"));
                    alert.put("entityId", rs.getInt("entity_id"));
                    alert.put("oldValue", rs.getString("old_value"));
                    alert.put("newValue", rs.getString("new_value"));
                    alert.put("ipAddress", rs.getString("ip_address"));
                    alert.put("timestamp", rs.getTimestamp("timestamp"));
                    alert.put("severity", "high");
                    alerts.add(alert);
                }
            }
            
            // Return JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("data", alerts);
            
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(result));
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Database error\"}");
        }
    }
    
    private void handleDismiss(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Missing alert ID\"}");
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            int alertId = Integer.parseInt(idStr);
            
            // Update the alert status to dismissed
            String updateSql = "UPDATE user_sessions SET status = 'dismissed' WHERE id = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                stmt.setInt(1, alertId);
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    response.getWriter().write("{\"success\":true,\"message\":\"Alert dismissed successfully\"}");
                } else {
                    response.getWriter().write("{\"success\":false,\"message\":\"Alert not found or already dismissed\"}");
                }
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Database error\"}");
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\":false,\"message\":\"Invalid alert ID\"}");
        }
    }
} 