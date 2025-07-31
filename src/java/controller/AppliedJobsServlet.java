package controller;

import dal.JobPostingDAO;
import dal.ApplicationDAO;
import dal.UserDao;
import dal.DBContext;
import model.Application;
import model.User;
import java.sql.Connection;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AppliedJobsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int page = 1;
        int jobsPerPage = 5; // Số job mỗi trang
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }

        List<Application> appliedJobs = new ArrayList<>();
        List<String> des = new ArrayList<>();
        List<String> cities = new ArrayList<>();
        int totalJobs = 0;

        try (Connection conn = new DBContext().getConnection()) {
            UserDao userDao = new UserDao(conn);
            int candidateProfileId = userDao.getCandidateProfileId(user.getId());

            if (candidateProfileId == -1) {
                request.setAttribute("appliedJobs", appliedJobs);
                request.getRequestDispatcher("AppliedJobs.jsp").forward(request, response);
                return;
            }

            ApplicationDAO dao = new ApplicationDAO(conn);
            JobPostingDAO DAO = new JobPostingDAO();
            des = DAO.getAllJobCategoriesDes();
            cities = DAO.getAllCities();
            appliedJobs = dao.getAppliedJobsWithPagination(candidateProfileId, page, jobsPerPage);
            totalJobs = dao.countTotalAppliedJobs(candidateProfileId);
            int totalPages = (int) Math.ceil(totalJobs * 1.0 / jobsPerPage);

        } catch (Exception e) {
            e.printStackTrace();
        }

        int totalPages = (int) Math.ceil(totalJobs * 1.0 / jobsPerPage);

        request.setAttribute("des", des);
        request.setAttribute("cities", cities);
        request.setAttribute("appliedJobs", appliedJobs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalJobs", totalJobs);

        request.getRequestDispatcher("AppliedJobs.jsp").forward(request, response);
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
            ApplicationDAO appDao = new ApplicationDAO(conn);
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
