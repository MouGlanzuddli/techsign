package controller;

import dal.DBContext;
import dal.JobDao;
import dal.ADao2;
import dal.UserDao;
import model.Job;
import model.User;
import model.Application;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.UUID;

@WebServlet(name = "ApplyJobServlet", urlPatterns = {"/ApplyJobServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ApplyJobServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads/cv";
    private static final String[] ALLOWED_EXTENSIONS = {".pdf", ".doc", ".docx"};
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp?error=login_required");
            return;
        }
        
        // Kiểm tra role candidate
        if (user.getRoleId() != 2) {
            response.sendRedirect("JobDetailServlet?id=" + request.getParameter("id") + "&error=not_candidate");
            return;
        }
        
        String jobIdStr = request.getParameter("id");
        if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
            response.sendRedirect("JobListServlet?error=invalid_job");
            return;
        }
        
        try {
            int jobId = Integer.parseInt(jobIdStr);
            
            // Lấy thông tin job và company
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            JobDao jobDao = new JobDao(conn);
            UserDao userDao = new UserDao(conn);
            
            Job job = jobDao.getJobById(jobId);
            if (job == null) {
                response.sendRedirect("JobListServlet?error=job_not_found");
                return;
            }
            
            // Lấy thông tin company
            User company = userDao.getUserById(job.getCompanyId());
            
            // Set attributes và forward đến trang apply
            request.setAttribute("job", job);
            request.setAttribute("company", company);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/apply-job.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("JobListServlet?error=invalid_job_id");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getRoleId() != 2) {
            response.sendRedirect("login.jsp?error=login_required");
            return;
        }
        
        String jobIdStr = request.getParameter("jobId");
        String coverLetter = request.getParameter("coverLetter");
        
        if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
            response.sendRedirect("JobListServlet?error=invalid_job");
            return;
        }
        
        try {
            int jobId = Integer.parseInt(jobIdStr);
            
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            ADao2 applicationDao = new ADao2(conn);
            
            // Kiểm tra đã ứng tuyển chưa
            if (applicationDao.hasApplied(user.getId(), jobId)) {
                response.sendRedirect("JobDetailServlet?id=" + jobId + "&error=already_applied");
                return;
            }
            
            // Xử lý upload CV
            String cvFileName = null;
            Part cvPart = request.getPart("cvFile");
            
            if (cvPart != null && cvPart.getSize() > 0) {
                // Validate file
                String validationResult = validateCVFile(cvPart);
                if (validationResult != null) {
                    response.sendRedirect("ApplyJobServlet?id=" + jobId + "&error=" + validationResult);
                    return;
                }
                
                // Upload file
                cvFileName = uploadCVFile(cvPart, user.getId(), jobId);
                if (cvFileName == null) {
                    response.sendRedirect("ApplyJobServlet?id=" + jobId + "&error=upload_failed");
                    return;
                }
            }
            
            // Tạo application mới
            Application application = new Application();
            application.setJobId(jobId);
            application.setCandidateId(user.getId());
            application.setCoverLetter(coverLetter);
            application.setCvFileName(cvFileName);
            application.setStatus("pending");
            application.setAppliedAt(new Date());
            application.setUpdatedAt(new Date());
            
            boolean success = applicationDao.insertApplication(application);
            
            if (success) {
                response.sendRedirect("JobDetailServlet?id=" + jobId + "&success=applied");
            } else {
                // Xóa file đã upload nếu insert thất bại
                if (cvFileName != null) {
                    deleteCVFile(cvFileName);
                }
                response.sendRedirect("JobDetailServlet?id=" + jobId + "&error=apply_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("JobListServlet?error=invalid_job_id");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("JobDetailServlet?id=" + request.getParameter("jobId") + "&error=database_error");
        }
    }
    
    /**
     * Validate CV file
     */
    private String validateCVFile(Part filePart) {
        // Kiểm tra kích thước file
        if (filePart.getSize() > MAX_FILE_SIZE) {
            return "file_too_large";
        }
        
        // Kiểm tra extension
        String fileName = getFileName(filePart);
        if (fileName == null || fileName.trim().isEmpty()) {
            return "invalid_filename";
        }
        
        String extension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        boolean validExtension = false;
        for (String allowedExt : ALLOWED_EXTENSIONS) {
            if (extension.equals(allowedExt)) {
                validExtension = true;
                break;
            }
        }
        
        if (!validExtension) {
            return "invalid_file_type";
        }
        
        return null; // Valid
    }
    
    /**
     * Upload CV file
     */
    private String uploadCVFile(Part filePart, int userId, int jobId) {
        try {
            String originalFileName = getFileName(filePart);
            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            
            // Tạo tên file unique
            String uniqueFileName = "CV_" + userId + "_" + jobId + "_" + 
                                  UUID.randomUUID().toString().substring(0, 8) + extension;
            
            // Tạo thư mục upload nếu chưa có
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Lưu file
            Path filePath = Paths.get(uploadPath, uniqueFileName);
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            
            return uniqueFileName;
            
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Delete CV file
     */
    private void deleteCVFile(String fileName) {
        try {
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            Path filePath = Paths.get(uploadPath, fileName);
            Files.deleteIfExists(filePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Get filename from Part
     */
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }
}
