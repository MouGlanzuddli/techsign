package controller;

import dal.DBContext;
import dal.StatisticsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Map;
import com.google.gson.Gson;
import java.util.List;

public class StatisticsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, X-Requested-With");
        
        try {
            StatisticsDAO statisticsDAO = new StatisticsDAO();
            Map<String, Object> statistics = statisticsDAO.getAllStatistics();
            
            // Lấy tham số range cho biểu đồ truy cập
            String range = request.getParameter("range");
            if (range == null) range = "today";
            Object visitsChartData;
            switch (range) {
                case "7days":
                    visitsChartData = statisticsDAO.getDailyVisitsLast7Days();
                    break;
                case "30days":
                    visitsChartData = statisticsDAO.getDailyVisitsLast30Days();
                    break;
                case "today":
                default:
                    visitsChartData = statisticsDAO.getHourlyVisitsToday();
                    break;
            }
            statistics.put("visitsChartData", visitsChartData);
            
            // ✅ NÂNG CẤP: Lấy tất cả dữ liệu tăng trưởng cần thiết
            statistics.put("monthlyCandidateGrowth", statisticsDAO.getMonthlyCandidateGrowth());
            statistics.put("monthlyEmployerGrowth", statisticsDAO.getMonthlyEmployerGrowth());
            statistics.put("hourlyVisits", statisticsDAO.getHourlyVisitsToday());
            statistics.put("newUsersLast30Days", statisticsDAO.getNewUsersLast30Days());
            statistics.put("newUsersPrev30Days", statisticsDAO.getNewUsersPrevious30Days());
            statistics.put("todayVisitsPrevDay", statisticsDAO.getTodayVisitsPrevDay());

            // Xử lý cho biểu đồ hoạt động theo khoảng ngày
            String activityStartDate = request.getParameter("activityStartDate");
            String activityEndDate = request.getParameter("activityEndDate");
            if (activityStartDate != null && activityEndDate != null) {
                Map<String, Integer> activityData = statisticsDAO.getActivityCountsByDate(activityStartDate, activityEndDate);
                List<String> labels = new java.util.ArrayList<>(activityData.keySet());
                List<Integer> values = new java.util.ArrayList<>(activityData.values());
                String json = new Gson().toJson(Map.of("labels", labels, "values", values));
                response.getWriter().write(json);
                statisticsDAO.close();
                return;
            }

            // Xử lý cho biểu đồ tài khoản mới theo ngày
            String accountBarStartDate = request.getParameter("accountBarStartDate");
            String accountBarEndDate = request.getParameter("accountBarEndDate");
            if (accountBarStartDate != null && accountBarEndDate != null) {
                Map<String, Integer> accountData = statisticsDAO.getNewAccountsByDay(accountBarStartDate, accountBarEndDate);
                List<String> labels = new java.util.ArrayList<>(accountData.keySet());
                List<Integer> values = new java.util.ArrayList<>(accountData.values());
                String json = new Gson().toJson(Map.of("labels", labels, "values", values));
                response.getWriter().write(json);
                statisticsDAO.close();
                return;
            }

            String jsonResponse = new Gson().toJson(statistics);
            
            response.getWriter().write(jsonResponse);
            
            statisticsDAO.close();
            
        } catch (SQLException e) {
            System.err.println("Error getting statistics: " + e.getMessage());
            e.printStackTrace();
            
            String errorResponse = "{\"error\":\"Database error\",\"message\":\"Không thể lấy dữ liệu thống kê từ cơ sở dữ liệu\"}";
            response.getWriter().write(errorResponse);
        }
    }
} 