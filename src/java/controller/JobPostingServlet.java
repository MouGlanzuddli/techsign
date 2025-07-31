package controller;

import dao.JobPostingDAO;
import dao.CompanyProfileDAO;
import model.JobPosting;
import model.CompanyProfile;
import dao.DBConnection;
import util.LocalDateTimeAdapter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import dao.UserDao;
import model.Category;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.EmailUtil;

public class JobPostingServlet extends HttpServlet {
    private JobPostingDAO jobPostingDAO;
    private CompanyProfileDAO companyProfileDAO;
    private UserDao userDAO;
    
    // Static Gson instance with proper LocalDateTime handling
    private static final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .setDateFormat("yyyy-MM-dd HH:mm:ss")
            .create();

    @Override
    public void init() throws ServletException {
        try {
            try (Connection conn = DBConnection.getConnection()) {
                jobPostingDAO = new JobPostingDAO(conn);
                companyProfileDAO = new CompanyProfileDAO();
                userDAO = new UserDao(conn);
            }
        } catch (Exception e) {
            throw new ServletException("Error initializing JobPostingServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Debug: Log HTTP method and action
        System.out.println("[JobPostingServlet] doGet called. Method: " + req.getMethod() + ", action: " + req.getParameter("action"));

        String action = req.getParameter("action");
        String pathInfo = req.getPathInfo();
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        PrintWriter out = resp.getWriter();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            if ("getAll".equals(action)) {
                // Get all job postings for admin content management
                try (Connection conn = DBConnection.getConnection()) {
                    jobPostingDAO = new JobPostingDAO(conn);
                    List<JobPosting> jobPostings = jobPostingDAO.getAllJobPostingsForAdmin();
                    jsonResponse.addProperty("success", true);
                    jsonResponse.add("data", gson.toJsonTree(jobPostings));
                    jsonResponse.addProperty("message", "Lấy danh sách bài đăng thành công");
                }
                
            } else if ("getById".equals(action)) {
                // Get specific job posting by ID
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.trim().isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    try (Connection conn = DBConnection.getConnection()) {
                        jobPostingDAO = new JobPostingDAO(conn);
                        JobPosting jobPosting = jobPostingDAO.getJobPostingById(id);
                        
                        if (jobPosting != null) {
                            jsonResponse.addProperty("success", true);
                            jsonResponse.add("data", gson.toJsonTree(jobPosting));
                            jsonResponse.addProperty("message", "Lấy thông tin bài đăng thành công");
                        } else if ("rejectWithReason".equals(action)) {
                            handleRejectionWithReason(req, jsonResponse, conn);
                        } else {
                            jsonResponse.addProperty("success", false);
                            jsonResponse.addProperty("message", "Không tìm thấy bài đăng");
                        }
                    }
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "ID bài đăng không hợp lệ");
                }
                
            } else if ("getByStatus".equals(action)) {
                // Get job postings by status
                String status = req.getParameter("status");
                if (status != null && !status.trim().isEmpty()) {
                    try (Connection conn = DBConnection.getConnection()) {
                        jobPostingDAO = new JobPostingDAO(conn);
                        List<JobPosting> jobPostings = jobPostingDAO.getJobPostingsByStatus(status);
                        jsonResponse.addProperty("success", true);
                        jsonResponse.add("data", gson.toJsonTree(jobPostings));
                        jsonResponse.addProperty("message", "Lấy danh sách bài đăng theo trạng thái thành công");
                    }
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Trạng thái không hợp lệ");
                }
                
            } else if ("getCategories".equals(action)) {
                // Get all categories for filtering
                try (Connection conn = DBConnection.getConnection()) {
                    jobPostingDAO = new JobPostingDAO(conn);
                    List<Category> categories = jobPostingDAO.getAllCategories();
                    jsonResponse.addProperty("success", true);
                    jsonResponse.add("data", gson.toJsonTree(categories));
                    jsonResponse.addProperty("message", "Lấy danh sách danh mục thành công");
                }
                
            } else if ("getByCategory".equals(action)) {
                // Get job postings by category
                String categoryName = req.getParameter("category");
                if (categoryName != null && !categoryName.trim().isEmpty()) {
                    try (Connection conn = DBConnection.getConnection()) {
                        jobPostingDAO = new JobPostingDAO(conn);
                        List<JobPosting> jobPostings = jobPostingDAO.getJobPostingsByCategory(categoryName);
                        jsonResponse.addProperty("success", true);
                        jsonResponse.add("data", gson.toJsonTree(jobPostings));
                        jsonResponse.addProperty("message", "Lấy danh sách bài đăng theo danh mục thành công");
                    }
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Tên danh mục không hợp lệ");
                }
                
            } else if ("search".equals(action)) {
                // Search job postings
                String searchTerm = req.getParameter("term");
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    try (Connection conn = DBConnection.getConnection()) {
                        jobPostingDAO = new JobPostingDAO(conn);
                        List<JobPosting> jobPostings = jobPostingDAO.searchJobPostings(searchTerm);
                        jsonResponse.addProperty("success", true);
                        jsonResponse.add("data", gson.toJsonTree(jobPostings));
                        jsonResponse.addProperty("message", "Tìm kiếm bài đăng thành công");
                    }
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Từ khóa tìm kiếm không hợp lệ");
                }
                
            } else if ("getStats".equals(action)) {
                // Get job posting statistics
                try (Connection conn = DBConnection.getConnection()) {
                    jobPostingDAO = new JobPostingDAO(conn);
                    JobPostingDAO.JobPostingStats stats = jobPostingDAO.getJobPostingStats();
                    jsonResponse.addProperty("success", true);
                    jsonResponse.add("data", gson.toJsonTree(stats));
                    jsonResponse.addProperty("message", "Lấy thống kê thành công");
                }
                
            } else {
                // Default: get all job postings
                try (Connection conn = DBConnection.getConnection()) {
                    jobPostingDAO = new JobPostingDAO(conn);
                    List<JobPosting> jobPostings = jobPostingDAO.getAllJobPostingsForAdmin();
                    jsonResponse.addProperty("success", true);
                    jsonResponse.add("data", gson.toJsonTree(jobPostings));
                    jsonResponse.addProperty("message", "Lấy danh sách bài đăng thành công");
                }
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

        // Debug: Log all received parameters
        System.out.println("[JobPostingServlet] Received POST parameters:");
        req.getParameterMap().forEach((k, v) -> System.out.println("  " + k + " = " + java.util.Arrays.toString(v)));

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
                    try (Connection conn = DBConnection.getConnection()) {
                        jobPostingDAO = new JobPostingDAO(conn);
                        boolean success = jobPostingDAO.updateJobPostingStatus(id, status);
                        
                        if (success) {
                            jsonResponse.addProperty("success", true);
                            jsonResponse.addProperty("message", "Cập nhật trạng thái thành công");
                        } else {
                            jsonResponse.addProperty("success", false);
                            jsonResponse.addProperty("message", "Không thể cập nhật trạng thái");
                        }
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
                    try (Connection conn = DBConnection.getConnection()) {
                        jobPostingDAO = new JobPostingDAO(conn);
                        boolean success = jobPostingDAO.deleteJobPosting(id);
                        
                        if (success) {
                            jsonResponse.addProperty("success", true);
                            jsonResponse.addProperty("message", "Xóa bài đăng thành công");
                        } else {
                            jsonResponse.addProperty("success", false);
                            jsonResponse.addProperty("message", "Không thể xóa bài đăng");
                        }
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
    
    private void handleStatusUpdate(HttpServletRequest req, JsonObject jsonResponse, Connection conn) 
            throws Exception {
        String idParam = req.getParameter("postId");
        String status = req.getParameter("status");
        
        if (idParam == null || status == null || idParam.trim().isEmpty() || status.trim().isEmpty()) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Thông tin không hợp lệ");
            return;
        }
        
        int id = Integer.parseInt(idParam);
        boolean success = jobPostingDAO.updateJobPostingStatus(id, status);
        
        if (success) {
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "Cập nhật trạng thái thành công");
            
            // If approving, send approval notification
            if ("approved".equals(status)) {
                sendStatusNotification(id, "approved", null);
            }
        } else {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Không thể cập nhật trạng thái");
        }
    }

    private void handleRejectionWithReason(HttpServletRequest req, JsonObject jsonResponse, Connection conn) 
            throws Exception {
        String idParam = req.getParameter("postId");
        String reason = req.getParameter("reason");
        
        if (idParam == null || reason == null || idParam.trim().isEmpty() || reason.trim().isEmpty()) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Vui lòng nhập lý do từ chối");
            return;
        }
        
        int id = Integer.parseInt(idParam);
        sendStatusNotification(id, "rejected", reason);
        
        jsonResponse.addProperty("success", true);
        jsonResponse.addProperty("message", "Thông báo từ chối đã được gửi");
    }

    private void sendStatusNotification(int postId, String status, String reason) throws Exception {
    JobPosting post = jobPostingDAO.getJobPostingById(postId);
    CompanyProfile company = companyProfileDAO.getById(post.getCompanyProfileId());
    
    // Use the instance userDAO instead of static call
    User user = userDAO.getUserById(company.getUserId());
    
    if ("approved".equals(status)) {
        EmailUtil.sendPostApprovalEmail(
            user.getEmail(),
            post.getTitle(),
            "https://yourdomain.com/jobs/" + postId
        );
    } else if ("rejected".equals(status)) {
        EmailUtil.sendPostRejectionEmail(
            user.getEmail(),
            post.getTitle(),
            reason,
            "https://yourdomain.com/jobs/" + postId + "/edit"
        );
    }
}
}
