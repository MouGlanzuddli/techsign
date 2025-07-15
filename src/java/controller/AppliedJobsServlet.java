package controller;

import DAO.ApplicationDAO;
import DAO.UserDao;
import connectDB.DBContext;
import model.Application;
import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.sql.*;

public class AppliedJobsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy user từ session
        User user = (User) request.getSession().getAttribute("user");


        List<Application> appliedJobs = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = new DBContext().getConnection();
            UserDao userDao = new UserDao(conn);
            int candidateProfileId = userDao.getCandidateProfileId(user.getId());

            if (candidateProfileId == -1) {
                request.setAttribute("appliedJobs", appliedJobs);
                request.getRequestDispatcher("AppliedJobs.jsp").forward(request, response);
                return;
            }

            String sql = "SELECT a.id, a.job_posting_id, a.status, a.applied_at, "
                    + "j.title, j.job_type, j.location, j.posted_at, "
                    + "c.company_name, c.logo_url "
                    + "FROM applications a "
                    + "JOIN job_postings j ON a.job_posting_id = j.id "
                    + "JOIN company_profiles c ON j.company_profile_id = c.id "
                    + "WHERE a.candidate_profile_id = ? AND a.status IN ('pending', 'approved')";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, candidateProfileId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setJobId(rs.getInt("job_posting_id"));
                app.setJobTitle(rs.getString("title"));
                app.setJobType(rs.getString("job_type"));
                app.setCompanyName(rs.getString("company_name"));
                app.setLocation(rs.getString("location"));
                app.setPostedAt(rs.getTimestamp("posted_at"));
                app.setAppliedAt(rs.getTimestamp("applied_at"));
                app.setStatus(rs.getString("status"));
                app.setLogoUrl(rs.getString("logo_url"));
                appliedJobs.add(app);

            }

            request.setAttribute("appliedJobs", appliedJobs);
            request.getRequestDispatcher("AppliedJobs.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String city = request.getParameter("city");
        String category = request.getParameter("description");

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        try {
            // Mở kết nối DB
            conn = new DBContext().getConnection();

            // Lấy candidate profile ID
            UserDao userDao = new UserDao(conn);
            int candidateId = userDao.getCandidateProfileId(user.getId());

            // Gọi DAO lọc danh sách công việc đã ứng tuyển
            ApplicationDAO appDao = new ApplicationDAO(); 
            List<Application> appliedJobs = appDao.searchAppliedJobs(candidateId, keyword, category, city);

            request.setAttribute("appliedJobs", appliedJobs);
            request.setAttribute("param", request.getParameterMap());

            request.getRequestDispatcher("AppliedJobs.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
