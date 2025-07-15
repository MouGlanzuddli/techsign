package controller;



import connectDB.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.*;

public class DeleteCVServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cvId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = new DBContext().getConnection()) {
            // Lấy tên file để xóa vật lý
            String sql = "SELECT cv_url FROM candidate_cvs WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cvId);
            ResultSet rs = ps.executeQuery();
            String cvUrl = null;
            if (rs.next()) {
                cvUrl = rs.getString("cv_url");
            }
            rs.close();
            ps.close();

            // Xoá file vật lý
            if (cvUrl != null) {
                String realPath = getServletContext().getRealPath("") + cvUrl;
                File file = new File(realPath);
                if (file.exists()) {
                    file.delete();
                }
            }

            // Xoá record DB
            String deleteSql = "DELETE FROM candidate_cvs WHERE id = ?";
            PreparedStatement ps2 = conn.prepareStatement(deleteSql);
            ps2.setInt(1, cvId);
            ps2.executeUpdate();
            ps2.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("resumeCandidate.jsp");
    }
}
