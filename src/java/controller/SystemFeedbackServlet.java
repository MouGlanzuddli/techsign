package controller;

import connectDB.DBContext;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class SystemFeedbackServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

//        if (user == null) {
//            response.sendRedirect("signup.jsp");
//            return;
//        }

        String feedback = request.getParameter("feedback");

        try (Connection conn = new DBContext().getConnection()) {
            String sql = "INSERT INTO system_feedback (user_id, feedback_text, created_at) VALUES (?, ?, GETDATE())";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, user.getId());
            ps.setString(2, feedback);
            ps.executeUpdate();

            response.sendRedirect("evaluateSystem.jsp?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("evaluateSystem.jsp?error=true");
        }
    }
}
