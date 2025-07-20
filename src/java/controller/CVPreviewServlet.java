package controller;

import dal.DBContext;
import dal.ApplicationDao;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "CVPreviewServlet", urlPatterns = {"/CVPreviewServlet"})
public class CVPreviewServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads/cv";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
            return;
        }
        
        String fileName = request.getParameter("file");
        String applicationIdStr = request.getParameter("applicationId");
        String action = request.getParameter("action"); // "view" hoặc "download"
        
        if (fileName == null || applicationIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }
        
        try {
            int applicationId = Integer.parseInt(applicationIdStr);
            
            // Kiểm tra quyền truy cập file
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            ApplicationDao applicationDao = new ApplicationDao(conn);
            
            boolean hasAccess = false;
            if (user.getRoleId() == 1) { // Employer
                hasAccess = applicationDao.canEmployerAccessCV(user.getId(), applicationId);
            } else if (user.getRoleId() == 2) { // Candidate
                hasAccess = applicationDao.canCandidateAccessCV(user.getId(), applicationId);
            }
            
            if (!hasAccess) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
                return;
            }
            
            // Đường dẫn file
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File file = new File(uploadPath, fileName);
            
            if (!file.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
                return;
            }
            
            // Set response headers
            String mimeType = getServletContext().getMimeType(file.getAbsolutePath());
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            
            response.setContentType(mimeType);
            response.setContentLength((int) file.length());
            
            // Nếu là download thì set header attachment
            if ("download".equals(action)) {
                response.setHeader("Content-Disposition", "attachment; filename=\"" + getOriginalFileName(fileName) + "\"");
            } else {
                // Nếu là view thì set header inline để mở trong browser
                response.setHeader("Content-Disposition", "inline; filename=\"" + getOriginalFileName(fileName) + "\"");
            }
            
            // Stream file
            try (FileInputStream inStream = new FileInputStream(file);
                 OutputStream outStream = response.getOutputStream()) {
                
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid application ID");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
    
    private String getOriginalFileName(String storedFileName) {
        // Tạo tên file hiển thị từ stored filename
        // CV_123_456_abc12345.pdf -> CV_Application.pdf
        String extension = storedFileName.substring(storedFileName.lastIndexOf("."));
        return "CV_Application" + extension;
    }
}
