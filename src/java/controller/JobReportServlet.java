package controller;

import dal.JobPostDao;
import dal.DBContext;
import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

@WebServlet("/jobReport")
public class JobReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> report = new HashMap<>();
        try (Connection conn = DBContext.getConnection()) {
            JobPostDao jobDao = new JobPostDao(conn);
            if (from != null && to != null) {
                // Trả về dữ liệu biểu đồ: số tin mới theo ngày
                var chartData = jobDao.getNewJobPostsByDate(from, to);
                response.getWriter().write(new Gson().toJson(chartData));
                return;
            }
            // Tổng quan như cũ
            report.put("totalJobPosts", jobDao.getTotalJobPosts());
            report.put("activeJobPosts", jobDao.getActiveJobPosts());
            report.put("expiredJobPosts", jobDao.getExpiredJobPosts());
            report.put("avgApplications", jobDao.getAverageApplicationsPerJob());
            report.put("avgJobViews", jobDao.getAverageJobViews());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            report.put("error", "Internal Server Error");
        }
        response.getWriter().write(new Gson().toJson(report));
    }
} 