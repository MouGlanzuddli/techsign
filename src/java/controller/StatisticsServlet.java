package controller;

import dal.StatisticsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Map;
import com.google.gson.Gson;

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
            
            // ✅ NÂNG CẤP: Lấy tất cả dữ liệu tăng trưởng cần thiết
            statistics.put("monthlyCandidateGrowth", statisticsDAO.getMonthlyCandidateGrowth());
            statistics.put("monthlyEmployerGrowth", statisticsDAO.getMonthlyEmployerGrowth());

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