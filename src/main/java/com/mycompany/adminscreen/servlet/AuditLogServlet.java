package com.mycompany.adminscreen.servlet;

import com.mycompany.adminscreen.dao.AuditLogDAO;
import com.mycompany.adminscreen.model.AuditLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/AuditLogServlet")
public class AuditLogServlet extends HttpServlet {
    private AuditLogDAO auditLogDAO = new AuditLogDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if ("listByUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            List<AuditLog> logs = auditLogDAO.getLogsByUser(userId);
            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,\"logs\":[");
            for (int i = 0; i < logs.size(); i++) {
                AuditLog log = logs.get(i);
                json.append("{")
                    .append("\"id\":").append(log.getId()).append(",")
                    .append("\"actionType\":\"").append(escape(log.getActionType())).append("\",")
                    .append("\"entityType\":\"").append(escape(log.getEntityType())).append("\",")
                    .append("\"entityId\":").append(log.getEntityId()).append(",")
                    .append("\"oldValue\":\"").append(escape(log.getOldValue())).append("\",")
                    .append("\"newValue\":\"").append(escape(log.getNewValue())).append("\",")
                    .append("\"ipAddress\":\"").append(escape(log.getIpAddress())).append("\",")
                    .append("\"timestamp\":\"").append(log.getTimestamp()).append("\"");
                json.append("}");
                if (i < logs.size() - 1) json.append(",");
            }
            json.append("]}");
            out.print(json.toString());
        } else if ("mergeWithSession".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            List<AuditLog> logs = auditLogDAO.getLogsByUser(userId);
            com.mycompany.adminscreen.dao.SessionDAO sessionDAO = new com.mycompany.adminscreen.dao.SessionDAO();
            List<com.mycompany.adminscreen.model.Session> sessions = sessionDAO.getSessionsByUser(userId);
            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,\"alerts\":[");
            boolean first = true;
            for (AuditLog log : logs) {
                for (com.mycompany.adminscreen.model.Session session : sessions) {
                    if (log.getUserId() == session.getUserId() && log.getIpAddress().equals(session.getIpAddress())) {
                        if (!first) json.append(",");
                        first = false;
                        String severity = getSeverity(
                            log.getActionType(),
                            log.getIpAddress(),
                            session.getDeviceInfo(),
                            session.isActive()
                        );
                        json.append("{")
                            .append("\"auditId\":").append(log.getId()).append(",")
                            .append("\"actionType\":\"").append(escape(log.getActionType())).append("\",")
                            .append("\"entityType\":\"").append(escape(log.getEntityType())).append("\",")
                            .append("\"entityId\":").append(log.getEntityId()).append(",")
                            .append("\"oldValue\":\"").append(escape(log.getOldValue())).append("\",")
                            .append("\"newValue\":\"").append(escape(log.getNewValue())).append("\",")
                            .append("\"auditIpAddress\":\"").append(escape(log.getIpAddress())).append("\",")
                            .append("\"auditTimestamp\":\"").append(log.getTimestamp()).append("\",")
                            .append("\"sessionId\":").append(session.getId()).append(",")
                            .append("\"sessionToken\":\"").append(escape(session.getSessionToken())).append("\",")
                            .append("\"sessionIpAddress\":\"").append(escape(session.getIpAddress())).append("\",")
                            .append("\"deviceInfo\":\"").append(escape(session.getDeviceInfo())).append("\",")
                            .append("\"loginTime\":\"").append(session.getLoginTime()).append("\",")
                            .append("\"lastActiveTime\":\"").append(session.getLastActiveTime()).append("\",")
                            .append("\"logoutTime\":\"").append(session.getLogoutTime()).append("\",")
                            .append("\"isActive\":").append(session.isActive()).append(",")
                            .append("\"severity\":\"").append(severity).append("\"");
                        json.append("}");
                    }
                }
            }
            json.append("]}");
            out.print(json.toString());
        } else {
            out.print("{\"success\":false,\"message\":\"Invalid action\"}");
        }
        out.flush();
    }

    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }

    private String getSeverity(String actionType, String ip, String device, boolean isActive) {
        // Example logic, adjust as needed
        if ("Password change".equalsIgnoreCase(actionType)) return "danger";
        if ("Login attempt".equalsIgnoreCase(actionType)) {
            if (isActive && (device == null || device.isEmpty())) return "danger";
            return "warning";
        }
        if ("Failed login".equalsIgnoreCase(actionType)) return "warning";
        return "info";
    }
} 