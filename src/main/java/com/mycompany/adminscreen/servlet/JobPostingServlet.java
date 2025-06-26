package com.mycompany.adminscreen.servlet;

import com.mycompany.adminscreen.dao.JobPostingDAO;
import com.mycompany.adminscreen.dao.CompanyProfileDAO;
import com.mycompany.adminscreen.dao.IndustryDAO;
import com.mycompany.adminscreen.model.JobPosting;
import com.mycompany.adminscreen.model.CompanyProfile;
import com.mycompany.adminscreen.model.Industry;
import com.mycompany.adminscreen.util.DBConnection;
import com.mycompany.adminscreen.util.LocalDateTimeAdapter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.mycompany.adminscreen.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "JobPostingServlet", urlPatterns = {"/job-posting", "/job-posting/*"})
public class JobPostingServlet extends HttpServlet {
    private JobPostingDAO jobPostingDAO;
    private CompanyProfileDAO companyProfileDAO;
    private IndustryDAO industryDAO;
    
    // Static Gson instance with proper LocalDateTime handling
    private static final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .setDateFormat("yyyy-MM-dd HH:mm:ss")
            .create();

    @Override
    public void init() throws ServletException {
        try {
            jobPostingDAO = new JobPostingDAO();
            companyProfileDAO = new CompanyProfileDAO();
            industryDAO = new IndustryDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing JobPostingServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String pathInfo = req.getPathInfo();
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        PrintWriter out = resp.getWriter();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            if ("getAll".equals(action)) {
                // Get all job postings for admin content management
                List<JobPosting> jobPostings = jobPostingDAO.getAllJobPostingsForAdmin();
                jsonResponse.addProperty("success", true);
                jsonResponse.add("data", gson.toJsonTree(jobPostings));
                jsonResponse.addProperty("message", "Lấy danh sách bài đăng thành công");
                
            } else if ("getById".equals(action)) {
                // Get specific job posting by ID
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.trim().isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    JobPosting jobPosting = jobPostingDAO.getJobPostingById(id);
                    
                    if (jobPosting != null) {
                        jsonResponse.addProperty("success", true);
                        jsonResponse.add("data", gson.toJsonTree(jobPosting));
                        jsonResponse.addProperty("message", "Lấy thông tin bài đăng thành công");
                    } else {
                        jsonResponse.addProperty("success", false);
                        jsonResponse.addProperty("message", "Không tìm thấy bài đăng");
                    }
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "ID bài đăng không hợp lệ");
                }
                
            } else if ("getByStatus".equals(action)) {
                // Get job postings by status
                String status = req.getParameter("status");
                if (status != null && !status.trim().isEmpty()) {
                    List<JobPosting> jobPostings = jobPostingDAO.getJobPostingsByStatus(status);
                    jsonResponse.addProperty("success", true);
                    jsonResponse.add("data", gson.toJsonTree(jobPostings));
                    jsonResponse.addProperty("message", "Lấy danh sách bài đăng theo trạng thái thành công");
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Trạng thái không hợp lệ");
                }
                
            } else if ("getCategories".equals(action)) {
                // Get all categories for filtering
                List<Category> categories = jobPostingDAO.getAllCategories();
                jsonResponse.addProperty("success", true);
                jsonResponse.add("data", gson.toJsonTree(categories));
                jsonResponse.addProperty("message", "Lấy danh sách danh mục thành công");
                
            } else if ("getByCategory".equals(action)) {
                // Get job postings by category
                String categoryName = req.getParameter("category");
                if (categoryName != null && !categoryName.trim().isEmpty()) {
                    List<JobPosting> jobPostings = jobPostingDAO.getJobPostingsByCategory(categoryName);
                    jsonResponse.addProperty("success", true);
                    jsonResponse.add("data", gson.toJsonTree(jobPostings));
                    jsonResponse.addProperty("message", "Lấy danh sách bài đăng theo danh mục thành công");
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Tên danh mục không hợp lệ");
                }
                
            } else if ("search".equals(action)) {
                // Search job postings
                String searchTerm = req.getParameter("term");
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    List<JobPosting> jobPostings = jobPostingDAO.searchJobPostings(searchTerm);
                    jsonResponse.addProperty("success", true);
                    jsonResponse.add("data", gson.toJsonTree(jobPostings));
                    jsonResponse.addProperty("message", "Tìm kiếm bài đăng thành công");
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Từ khóa tìm kiếm không hợp lệ");
                }
                
            } else if ("getStats".equals(action)) {
                // Get job posting statistics
                JobPostingDAO.JobPostingStats stats = jobPostingDAO.getJobPostingStats();
                jsonResponse.addProperty("success", true);
                jsonResponse.add("data", gson.toJsonTree(stats));
                jsonResponse.addProperty("message", "Lấy thống kê thành công");
                
            } else {
                // Default: get all job postings
                List<JobPosting> jobPostings = jobPostingDAO.getAllJobPostingsForAdmin();
                jsonResponse.addProperty("success", true);
                jsonResponse.add("data", gson.toJsonTree(jobPostings));
                jsonResponse.addProperty("message", "Lấy danh sách bài đăng thành công");
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "ID không hợp lệ");             
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Lỗi server: " + e.getMessage());
            e.printStackTrace();
        }
        
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        PrintWriter out = resp.getWriter();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            if ("updateStatus".equals(action)) {
                // Update job posting status (approve/reject)
                String idParam = req.getParameter("postId");
                String status = req.getParameter("status");
                
                if (idParam != null && status != null && !idParam.trim().isEmpty() && !status.trim().isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    boolean success = jobPostingDAO.updateJobPostingStatus(id, status);
                    
                    if (success) {
                        jsonResponse.addProperty("success", true);
                        jsonResponse.addProperty("message", "Cập nhật trạng thái thành công");
                    } else {
                        jsonResponse.addProperty("success", false);
                        jsonResponse.addProperty("message", "Không thể cập nhật trạng thái");
                    }
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Thông tin không hợp lệ");
                }
                
            } else if ("delete".equals(action)) {
                // Delete job posting
                String idParam = req.getParameter("postId");
                
                if (idParam != null && !idParam.trim().isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    boolean success = jobPostingDAO.deleteJobPosting(id);
                    
                    if (success) {
                        jsonResponse.addProperty("success", true);
                        jsonResponse.addProperty("message", "Xóa bài đăng thành công");
                    } else {
                        jsonResponse.addProperty("success", false);
                        jsonResponse.addProperty("message", "Không thể xóa bài đăng");
                    }
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "ID bài đăng không hợp lệ");
                }
                
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Hành động không được hỗ trợ");
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "ID không hợp lệ");
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Lỗi server: " + e.getMessage());
            e.printStackTrace();
        }
        
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
    
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle PUT requests if needed
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle DELETE requests if needed
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}
