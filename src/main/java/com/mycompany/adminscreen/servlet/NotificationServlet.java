package com.mycompany.adminscreen.servlet;

import com.mycompany.adminscreen.dao.NotificationDAO;
import com.mycompany.adminscreen.model.Notification;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {
    private NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Notification> pinned = notificationDAO.getPinned();
        List<Notification> notifications = notificationDAO.getAll();
        Map<String, Integer> stats = notificationDAO.getStats();
        req.setAttribute("pinnedNotifications", pinned);
        req.setAttribute("notifications", notifications);
        req.setAttribute("stats", stats);
        req.getRequestDispatcher("/views/sections/system-notifications.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        if ("pin".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            notificationDAO.pinNotification(id);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"success\":true}");
            return;
        } else if ("unpin".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            notificationDAO.unpinNotification(id);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"success\":true}");
            return;
        }
        // Default: create notification
        String title = req.getParameter("title");
        String message = req.getParameter("message");
        String type = req.getParameter("type");
        boolean autoDismiss = req.getParameter("auto_dismiss") != null;
        int duration = 5000;
        boolean pinned = req.getParameter("pinned") != null;
        try {
            duration = Integer.parseInt(req.getParameter("duration_ms"));
        } catch (Exception ignored) {}
        Notification n = new Notification(title, message, type, autoDismiss, duration, pinned);
        notificationDAO.insert(n);
        resp.sendRedirect("notifications");
    }
} 