package controller;


import DAO.ApplicationDAO;
import connectDB.DBContext;
import jakarta.servlet.ServletException;
import java.sql.PreparedStatement;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;



public class DeleteApplicationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String appIdStr = request.getParameter("appId");

        if (appIdStr == null || !appIdStr.matches("\\d+")) {
            response.sendRedirect("Lỗi get"); // hoặc error.jsp nếu muốn
            return;
        }

        int appId = Integer.parseInt(appIdStr);

        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            ApplicationDAO dao = new ApplicationDAO();

            boolean deleted = dao.deleteApplicationById(appId);

            // Có thể set thông báo nếu muốn
            response.sendRedirect("AppliedJobsServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Lỗi get 2");
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

 }

