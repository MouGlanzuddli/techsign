package controller;

import DAO.JobPostingDAO;
import DAO.JobPostingSkillDAO;
import connectDB.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.JobPosting;
import java.sql.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import model.Skill;

public class SearchandView extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String description = request.getParameter("description");
        String city = request.getParameter("city");
        String sortBy = request.getParameter("sortBy");

        // Lấy số trang hiện tại (nếu không có mặc định là 1)
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            currentPage = Integer.parseInt(pageParam);
        }

        // Lấy số lượng job trên mỗi trang
        int papersPerPage = 8; // mặc định
        String papersPerPageStr = request.getParameter("papersPerPage");
        if (papersPerPageStr != null && papersPerPageStr.matches("\\d+")) {
            papersPerPage = Integer.parseInt(papersPerPageStr);
        }

        try (Connection conn = new DBContext().getConnection()) {
            if (sortBy == null) {
                sortBy = "default";
            }
            final String finalSortBy = sortBy;

            JobPostingDAO dao = new JobPostingDAO();
            List<JobPosting> allJobs;

            boolean noFilters = (keyword == null || keyword.isBlank())
                    && (description == null || description.isBlank())
                    && (city == null || city.isBlank())
                    && (sortBy == null || sortBy.equals("default"));

            if (noFilters) {
                allJobs = dao.getAllJobPostings();
            } else {
                allJobs = dao.searchJobs(keyword, description, city, sortBy);
            }

            // Nếu có sortBy là loại job_type
            if (finalSortBy != null && !finalSortBy.isBlank() && !"default".equals(finalSortBy)) {
                allJobs = allJobs.stream()
                        .filter(j -> finalSortBy.equalsIgnoreCase(j.getJobType()))
                        .collect(Collectors.toList());
            }

            int totalJobs = allJobs.size();
            int totalPages = (int) Math.ceil((double) totalJobs / papersPerPage);

            // Tính index bắt đầu và kết thúc
            int start = (currentPage - 1) * papersPerPage;
            int end = Math.min(start + papersPerPage, totalJobs);

            List<JobPosting> jobList = new ArrayList<>();
            if (start < end) {
                jobList = allJobs.subList(start, end);
            }

            JobPostingSkillDAO skillDAO = new JobPostingSkillDAO();
            Map<Integer, List<Skill>> skillsMap = new HashMap<>();
            for (JobPosting job : jobList) {
                skillsMap.put(job.getId(), skillDAO.getSkillsByJobId(job.getId()));
            }
            request.setAttribute("skillsMap", skillsMap);

            request.setAttribute("jobs", jobList);
            request.setAttribute("totalJobs", totalJobs);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("papersPerPage", papersPerPage);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("param", request.getParameterMap());

            List<String> categories = dao.getAllCategories();
            request.setAttribute("categories", categories);

            request.getRequestDispatcher("searchandview.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] placeOfWork = request.getParameterValues("place_of_work");
        String[] contractTypes = request.getParameterValues("contract_type");
        String[] employmentTypes = request.getParameterValues("employment_type");
        String salaryRange = request.getParameter("salary_range");
        String[] categories = request.getParameterValues("category");
        String keyword = request.getParameter("keyword");
        String sortBy = request.getParameter("sortBy");

        // Lấy page & papersPerPage
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            currentPage = Integer.parseInt(pageParam);
        }

        int papersPerPage = 10;
        String perPageParam = request.getParameter("papersPerPage");
        if (perPageParam != null && perPageParam.matches("\\d+")) {
            papersPerPage = Integer.parseInt(perPageParam);
        }

        try (Connection conn = new DBContext().getConnection()) {

            JobPostingDAO dao = new JobPostingDAO();
            List<JobPosting> allJobs = dao.filterJobs(
                    placeOfWork, contractTypes, employmentTypes, salaryRange, categories, keyword
            );

            // Sort theo jobType nếu có sortBy
            if ((employmentTypes == null || employmentTypes.length == 0)
                    && sortBy != null && !"default".equals(sortBy)) {
                final String finalSortBy = sortBy;
                allJobs = allJobs.stream()
                        .filter(j -> finalSortBy.equalsIgnoreCase(j.getJobType()))
                        .collect(Collectors.toList());
            }

            // Tính tổng & phân trang
            int totalJobs = allJobs.size();
            int totalPages = (int) Math.ceil((double) totalJobs / papersPerPage);

            if (currentPage > totalPages) {
                currentPage = totalPages == 0 ? 1 : totalPages;
            }

            int start = (currentPage - 1) * papersPerPage;
            int end = Math.min(start + papersPerPage, totalJobs);
            List<JobPosting> jobList = new ArrayList<>();
            if (start < end) {
                jobList = allJobs.subList(start, end);
            }

            request.setAttribute("jobs", jobList);
            request.setAttribute("categories", dao.getAllCategories());
            request.setAttribute("param", request.getParameterMap());
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("papersPerPage", papersPerPage);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("searchandview.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
