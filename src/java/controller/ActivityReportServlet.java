package controller;

import dao.AuditDao;
import dao.DBContext;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ActivityReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = DBContext.getConnection()) {
            AuditDao auditDao = new AuditDao(conn);
            List<AuditDao.AuditLog> logs = auditDao.getRecentLogs(10);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(new Gson().toJson(logs));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Internal Server Error");
        }
    }
} 