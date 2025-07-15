package controller;

import connectDB.DBContext;
import model.User;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import java.sql.ResultSet;

public class SaveJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("signup.jsp"); // Chưa đăng nhập
            return;
        }

        int userId = user.getId();
        int jobId = Integer.parseInt(request.getParameter("jobId"));

        try (Connection conn = new DBContext().getConnection()) {
            String checkSql = "SELECT COUNT(*) FROM bookmarks WHERE user_id = ? AND job_postings_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, jobId);
            ResultSet rs = checkStmt.executeQuery();

            boolean alreadySaved = false;
            if (rs.next()) {
                alreadySaved = rs.getInt(1) > 0;
            }

            if (!alreadySaved) {
                String insertSql = "INSERT INTO bookmarks (user_id, job_postings_id, created_at) VALUES (?, ?, GETDATE())";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, jobId);
                insertStmt.executeUpdate();
            }

            
            response.sendRedirect("JobDetail?id=" + jobId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jobdetail.jsp?error=save_failed");
        }
    }

}
