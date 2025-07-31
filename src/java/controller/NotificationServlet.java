package controller;

import dao.NotificationDAO;
import model.Notification;
import com.google.gson.Gson;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import dao.DBConnection;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("[DEBUG] NotificationServlet - doGet called");
        String action = req.getParameter("action");
        System.out.println("[DEBUG] Action parameter: " + action);
        if ("ajax".equals(action)) {
            System.out.println("[DEBUG] Handling AJAX request");
            try (Connection conn = DBConnection.getConnection()) {
                NotificationDAO notificationDAO = new NotificationDAO();
                List<Notification> pinned = notificationDAO.getPinned();
                List<Notification> notifications = notificationDAO.getAll();
                Map<String, Integer> stats = notificationDAO.getStats();
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                Gson gson = new Gson();
                Map<String, Object> result = new java.util.HashMap<>();
                result.put("pinnedNotifications", pinned);
                result.put("notifications", notifications);
                result.put("stats", stats);
                String jsonResponse = gson.toJson(result);
                System.out.println("[DEBUG] Sending JSON response: " + jsonResponse);
                resp.getWriter().write(jsonResponse);
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().write("{\"error\":\"Failed to fetch notifications\"}");
            }
            return;
        }
        try (Connection conn = DBConnection.getConnection()) {
            NotificationDAO notificationDAO = new NotificationDAO();
            List<Notification> pinned = notificationDAO.getPinned();
            List<Notification> notifications = notificationDAO.getAll();
            Map<String, Integer> stats = notificationDAO.getStats();
            req.setAttribute("pinnedNotifications", pinned);
            req.setAttribute("notifications", notifications);
            req.setAttribute("stats", stats);
            req.getRequestDispatcher("/views/sections/system-notifications.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to fetch notifications");
            req.getRequestDispatcher("/views/sections/system-notifications.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        try (Connection conn = DBConnection.getConnection()) {
            NotificationDAO notificationDAO = new NotificationDAO();
            if ("pin".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                notificationDAO.pinNotification(id);
                resp.getWriter().write("{\"success\":true}");
                return;
            } else if ("unpin".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                notificationDAO.unpinNotification(id);
                resp.getWriter().write("{\"success\":true}");
                return;
            } else if ("delete".equals(action)) {
                String idStr = req.getParameter("id");
                if (idStr == null || idStr.trim().isEmpty()) {
                    resp.getWriter().write("{\"success\":false,\"message\":\"Thiếu thông tin bắt buộc\"}");
                    return;
                }
                int id = Integer.parseInt(idStr);
                boolean ok = notificationDAO.delete(id);
                if (ok) {
                    resp.getWriter().write("{\"success\":true}");
                } else {
                    resp.getWriter().write("{\"success\":false,\"message\":\"Không thể xóa thông báo\"}");
                }
                return;
            } else if ("edit".equals(action)) {
                String idStr = req.getParameter("id");
                String title = req.getParameter("title");
                String message = req.getParameter("message");
                String type = req.getParameter("type");
                boolean autoDismiss = req.getParameter("auto_dismiss") != null;
                int duration = 5000;
                boolean pinned = req.getParameter("pinned") != null;
                try {
                    duration = Integer.parseInt(req.getParameter("duration_ms"));
                } catch (Exception ignored) {}
                if (idStr == null || idStr.trim().isEmpty() ||
                    title == null || title.trim().isEmpty() ||
                    message == null || message.trim().isEmpty() ||
                    type == null || type.trim().isEmpty()) {
                    resp.getWriter().write("{\"success\":false,\"message\":\"Thiếu thông tin bắt buộc\"}");
                    return;
                }
                int id = Integer.parseInt(idStr);
                Notification n = new Notification(title, message, type, autoDismiss, duration, pinned);
                n.setId(id);
                boolean ok = notificationDAO.update(n);
                if (ok) {
                    resp.getWriter().write("{\"success\":true}");
                } else {
                    resp.getWriter().write("{\"success\":false,\"message\":\"Không thể cập nhật thông báo\"}");
                }
                return;
            }
            String title = req.getParameter("title");
            String message = req.getParameter("message");
            String type = req.getParameter("type");
            System.out.println("[NotificationServlet] title=" + title + ", message=" + message + ", type=" + type);
            boolean autoDismiss = req.getParameter("auto_dismiss") != null;
            int duration = 5000;
            boolean pinned = req.getParameter("pinned") != null;
            try {
                duration = Integer.parseInt(req.getParameter("duration_ms"));
            } catch (Exception ignored) {}
            if (title == null || title.trim().isEmpty() ||
                message == null || message.trim().isEmpty() ||
                type == null || type.trim().isEmpty()) {
                resp.getWriter().write("{\"success\":false,\"message\":\"Thiếu thông tin bắt buộc\"}");
                return;
            }
            Notification n = new Notification(title, message, type, autoDismiss, duration, pinned);
            boolean ok = notificationDAO.insert(n);
            if (ok) {
                resp.getWriter().write("{\"success\":true}");
            } else {
                resp.getWriter().write("{\"success\":false,\"message\":\"Không thể lưu vào CSDL\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\":false,\"message\":\"Failed to process request\"}");
        }
    }
} 