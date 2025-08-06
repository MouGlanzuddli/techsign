package controller;

import connectDB.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UnfollowCompanyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        model.User user = (model.User) session.getAttribute("user");

//        if (user == null) {
//            response.sendRedirect("signup.jsp");
//            return;
//        }

        int userId = user.getId();
        int companyId = Integer.parseInt(request.getParameter("companyId"));

        try (Connection conn = new DBContext().getConnection()) {
            String sql = "DELETE FROM user_favourite WHERE user_id = ? AND entity_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, companyId);
            stmt.executeUpdate();

            
            response.sendRedirect("FavouriteCompanyServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
