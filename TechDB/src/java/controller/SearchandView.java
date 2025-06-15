package controller;

import DAO.JobPostingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.JobPosting;



public class SearchandView extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy tham số tìm kiếm từ form
        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String city = request.getParameter("city");

        // Sort và phân trang (mặc định nếu null)
        String sortBy = request.getParameter("sortBy");
        if (sortBy == null) sortBy = "default";

        int papersPerPage = 10;
        try {
            String papersPerPageStr = request.getParameter("papersPerPage");
            if (papersPerPageStr != null && papersPerPageStr.matches("\\d+")) {
                papersPerPage = Integer.parseInt(papersPerPageStr);
            }
        } catch (Exception e) {
            papersPerPage = 10;
        }

        // Gọi DAO để lấy kết quả
        JobPostingDAO dao = new JobPostingDAO();
        List<JobPosting> allJobs = dao.searchJobs(keyword, category, city, sortBy);

        int totalJobs = allJobs.size();
        List<JobPosting> jobList = allJobs.subList(0, Math.min(papersPerPage, totalJobs));

        // Gửi dữ liệu sang JSP
        request.setAttribute("jobList", jobList);
        request.setAttribute("totalJobs", totalJobs);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("papersPerPage", papersPerPage);
        request.setAttribute("param", request.getParameterMap());

        request.getRequestDispatcher("searchandview.jsp").forward(request, response);
    }
}
