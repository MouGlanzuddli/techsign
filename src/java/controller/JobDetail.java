package controller;

import dal.*;
import model.*;

import java.io.IOException;
import java.sql.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class JobDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        int jobId = Integer.parseInt(idStr);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        boolean saved = false;
        boolean applied = false;
        int profileId = -1;

        try (Connection conn = new DBContext().getConnection()) {

            // Lấy job
            JobPostingDAO jobDao = new JobPostingDAO();
            JobPosting job = jobDao.getJobById(jobId);

            // Lấy công ty
            CompanyDao companyDao = new CompanyDao(conn);
            Company company = companyDao.getCompanyByUserId(job.getCompanyProfileId());

            // Nếu đã đăng nhập
            if (user != null) {
                BookmarkDAO bookmarkDao = new BookmarkDAO();
                saved = bookmarkDao.hasSaved(user.getId(), jobId);

                // Lấy profileId
                String sql = "SELECT id FROM candidate_profiles WHERE user_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, user.getId());
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            profileId = rs.getInt("id");
                        }
                    }
                }

                // Kiểm tra đã apply chưa
                if (profileId != -1) {
                    ApplicationDAO appDAO = new ApplicationDAO();
                    applied = appDAO.hasApplied(profileId, jobId);
                }
            }

            // Lấy danh sách kỹ năng
            JobPostingSkillDAO skillDAO = new JobPostingSkillDAO();
            List<Skill> skills = skillDAO.getSkillsByJobId(jobId);

            // Gửi dữ liệu sang JSP
            request.setAttribute("job", job);
            request.setAttribute("company", company);
            request.setAttribute("skills", skills);
            request.setAttribute("saved", saved);
            request.setAttribute("applied", applied);
            request.setAttribute("profileId", profileId);

            request.getRequestDispatcher("jobdetail.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Không thể tải chi tiết công việc.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
