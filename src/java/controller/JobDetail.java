/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.ApplicationDAO;
import DAO.BookmarkDAO;
import DAO.JobPostingDAO;
import connectDB.DBContext;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.JobPosting;
import model.User;

public class JobDetail extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // Lấy ID job từ URL
    String idStr = request.getParameter("id");
    int jobId = Integer.parseInt(idStr);

    // Lấy user từ session (có thể null)
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    // Lấy job detail từ DAO
    JobPostingDAO dao = new JobPostingDAO();
    JobPosting job = null;
    try {
        job = dao.getJobById(jobId);
    } catch (Exception ex) {
        ex.printStackTrace();
    }

    // Mặc định trạng thái
    boolean saved = false;
    boolean applied = false;
    int profileId = -1;

    // Bookmark chỉ kiểm tra nếu đã login
    if (user != null) {
        BookmarkDAO bookmarkDao = new BookmarkDAO();
        saved = bookmarkDao.hasSaved(user.getId(), jobId);

        // Tìm profileId nếu có user
        try (Connection conn = new DBContext().getConnection()) {
            String sql = "SELECT id FROM candidate_profiles WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, user.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                profileId = rs.getInt("id");
            }
            rs.close();
            ps.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        // Nếu tìm được profileId thì mới kiểm tra đã ứng tuyển chưa
        if (profileId != -1) {
            ApplicationDAO appDAO = new ApplicationDAO();
            applied = appDAO.hasApplied(profileId, jobId);
        }
    }

    // Đẩy dữ liệu sang JSP
    request.setAttribute("job", job);
    request.setAttribute("saved", saved);
    request.setAttribute("applied", applied);
    request.setAttribute("profileId", profileId);

    // Chuyển trang
    request.getRequestDispatcher("jobdetail.jsp").forward(request, response);   
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
