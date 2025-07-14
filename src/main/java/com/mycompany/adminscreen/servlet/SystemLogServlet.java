package com.mycompany.adminscreen.servlet;

import com.mycompany.adminscreen.dao.SystemLogDAO;
import com.mycompany.adminscreen.model.SystemLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/SystemLogServlet")
public class SystemLogServlet extends HttpServlet {
    private SystemLogDAO systemLogDAO = new SystemLogDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if ("listByUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            List<SystemLog> logs = systemLogDAO.getLogsByUser(userId);
            StringBuilder json = new StringBuilder();
            json.append("{\"success\":true,\"logs\":[");
            for (int i = 0; i < logs.size(); i++) {
                SystemLog log = logs.get(i);
                json.append("{")
                    .append("\"id\":").append(log.getId()).append(",")
                    .append("\"action\":\"").append(escape(log.getAction())).append("\",")
                    .append("\"description\":\"").append(escape(log.getDescription())).append("\",")
                    .append("\"createdAt\":\"").append(log.getCreatedAt()).append("\"");
                json.append("}");
                if (i < logs.size() - 1) json.append(",");
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
} 