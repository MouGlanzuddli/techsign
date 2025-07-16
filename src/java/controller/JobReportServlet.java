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
            // --- Lấy số liệu tháng này và tháng trước ---
            int totalNow = jobDao.getTotalJobPosts(0);
            int totalPrev = jobDao.getTotalJobPosts(-1);
            int activeNow = jobDao.getActiveJobPostsTotal(); // Tổng số tin còn hoạt động (không lọc tháng)
            int activePrev = jobDao.getActiveJobPosts(-1);   // Số tin hoạt động đăng trong tháng trước (để so sánh %)
            int expiredNow = jobDao.getExpiredJobPosts(0);
            int expiredPrev = jobDao.getExpiredJobPosts(-1);
            int avgAppNow = jobDao.getAverageApplicationsPerJob(0);
            int avgAppPrev = jobDao.getAverageApplicationsPerJob(-1);
            int avgViewsNow = jobDao.getAverageJobViews(0);
            int avgViewsPrev = jobDao.getAverageJobViews(-1);

            // --- Tính phần trăm tăng/giảm trực tiếp ---
            double totalJobPostsPct = (totalPrev == 0) ? (totalNow > 0 ? 100.0 : 0.0) : ((totalNow - totalPrev) * 100.0) / totalPrev;
            double activeJobPostsPct = (activePrev == 0) ? (activeNow > 0 ? 100.0 : 0.0) : ((activeNow - activePrev) * 100.0) / activePrev;
            double expiredJobPostsPct = (expiredPrev == 0) ? (expiredNow > 0 ? 100.0 : 0.0) : ((expiredNow - expiredPrev) * 100.0) / expiredPrev;
            double avgApplicationsPct = (avgAppPrev == 0) ? (avgAppNow > 0 ? 100.0 : 0.0) : ((avgAppNow - avgAppPrev) * 100.0) / avgAppPrev;
            double avgJobViewsPct = (avgViewsPrev == 0) ? (avgViewsNow > 0 ? 100.0 : 0.0) : ((avgViewsNow - avgViewsPrev) * 100.0) / avgViewsPrev;

            report.put("totalJobPosts", totalNow);
            report.put("totalJobPostsPrev", totalPrev);
            report.put("totalJobPostsPct", totalJobPostsPct);

            report.put("activeJobPosts", activeNow);
            report.put("activeJobPostsPrev", activePrev);
            report.put("activeJobPostsPct", activeJobPostsPct);

            report.put("expiredJobPosts", expiredNow);
            report.put("expiredJobPostsPrev", expiredPrev);
            report.put("expiredJobPostsPct", expiredJobPostsPct);

            report.put("avgApplications", avgAppNow);
            report.put("avgApplicationsPrev", avgAppPrev);
            report.put("avgApplicationsPct", avgApplicationsPct);

            report.put("avgJobViews", avgViewsNow);
            report.put("avgJobViewsPrev", avgViewsPrev);
            report.put("avgJobViewsPct", avgJobViewsPct);

            // --- Thêm top 10 bài đăng ---
            report.put("topViewedPosts", jobDao.getTop10MostViewedActivePostsThisMonth());
            report.put("topAppliedPosts", jobDao.getTop10MostAppliedActivePostsThisMonth());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            report.put("error", "Internal Server Error");
        }
        response.getWriter().write(new Gson().toJson(report));
    }
} 