package controller;

import connectDB.DBContext;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.sql.*;

public class DeleteBookmarkServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        model.User user = (model.User) session.getAttribute("user");
        
//        if (user == null) {
//            response.sendRedirect("signup.jsp"); (chưa cần dùng)
//            return;
//        }

        
        

         int jobId = Integer.parseInt(request.getParameter("jobId"));
        
         
        int userId = user.getId();

        try (Connection conn = new DBContext().getConnection()) {
            String sql = "DELETE FROM bookmarks WHERE user_id = ? AND job_postings_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, jobId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Sau khi xóa, trở về danh sách
        response.sendRedirect("ShortlistJobServlet");
    }
}
