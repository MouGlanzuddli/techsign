package com.mycompany.adminscreen.servlet;

import com.mycompany.adminscreen.dao.SessionDAO;
import com.mycompany.adminscreen.model.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/SessionServlet")
public class SessionServlet extends HttpServlet {
    private SessionDAO sessionDAO = new SessionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if ("listByUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            List<Session> sessions = sessionDAO.getSessionsByUser(userId);
            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,\"sessions\":[");
            for (int i = 0; i < sessions.size(); i++) {
                Session s = sessions.get(i);
                json.append("{")
                    .append("\"id\":").append(s.getId()).append(",")
                    .append("\"deviceInfo\":\"").append(escape(s.getDeviceInfo())).append("\",")
                    .append("\"ipAddress\":\"").append(escape(s.getIpAddress())).append("\",")
                    .append("\"loginTime\":\"").append(s.getLoginTime()).append("\",")
                    .append("\"lastActiveTime\":\"").append(s.getLastActiveTime()).append("\",")
                    .append("\"logoutTime\":\"").append(s.getLogoutTime()).append("\",")
                    .append("\"isActive\":").append(s.isActive());
                json.append("}");
                if (i < sessions.size() - 1) json.append(",");
            }
            json.append("]}");
            out.print(json.toString());
        } else {
            out.print("{\"success\":false,\"message\":\"Invalid action\"}");
        }
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if ("forceLogout".equals(action)) {
            int sessionId = Integer.parseInt(request.getParameter("id"));
            boolean success = sessionDAO.forceLogout(sessionId);
            if (success) {
                out.print("{\"success\":true,\"message\":\"Session logged out\"}");
            } else {
                out.print("{\"success\":false,\"message\":\"Failed to logout session\"}");
            }
        } else {
            out.print("{\"success\":false,\"message\":\"Invalid action\"}");
        }
        out.flush();
    }

    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }
} 