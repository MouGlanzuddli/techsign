package controller;

import dao.SessionDAO;
import model.Session;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import dao.DBConnection;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SessionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        try (Connection conn = DBConnection.getConnection()) {
            // TODO: Refactor SessionDAO to support connection injection
            SessionDAO sessionDAO = new SessionDAO();
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
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Error fetching sessions\"}");
        }
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        try (Connection conn = DBConnection.getConnection()) {
            // TODO: Refactor SessionDAO to support connection injection
            SessionDAO sessionDAO = new SessionDAO();
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
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Error logging out session\"}");
        }
        out.flush();
    }

    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }
} 