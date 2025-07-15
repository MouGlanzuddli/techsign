
package controller;

import connectDB.DBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import model.User;

/**
 *
 * @author Thien An
 */
@MultipartConfig
public class UploadCVforjobdetailServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            int userId = user.getId();

            
            int jobId = Integer.parseInt(request.getParameter("jobId"));
            String coverLetter = request.getParameter("coverLetter");

            
            int candidateProfileId = -1;
            try (Connection conn = new DBContext().getConnection()) {
                String sql = "SELECT id FROM candidate_profiles WHERE user_id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    candidateProfileId = rs.getInt("id");
                }
            }
            if (candidateProfileId == -1) {
                throw new Exception("Không tìm thấy hồ sơ ứng viên!");
            }

            
            String candidateCvIdStr = request.getParameter("candidateCvId");
            String systemCvIdStr = request.getParameter("systemCvId");
            Part filePart = request.getPart("resumeFile");

            boolean isUpload = filePart != null && filePart.getSize() > 0;

            try (Connection conn = new DBContext().getConnection()) {
                String sql = "INSERT INTO applications (candidate_profile_id, job_posting_id, cover_letter, status, applied_at, candidate_cv_id, system_cv_id, uploaded_cv_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                
                ps.setInt(1, candidateProfileId);
                ps.setInt(2, jobId);
                ps.setString(3, coverLetter);
                ps.setString(4, "pending");
                ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));

                if (candidateCvIdStr != null && !candidateCvIdStr.isEmpty()) {
                    
                    ps.setInt(6, Integer.parseInt(candidateCvIdStr));
                } else {
                    ps.setNull(6, java.sql.Types.INTEGER);
                }

                if (systemCvIdStr != null && !systemCvIdStr.isEmpty()) {
                    // Người dùng chọn CV từ system_cvs
                    ps.setInt(7, Integer.parseInt(systemCvIdStr));
                } else {
                    ps.setNull(7, java.sql.Types.INTEGER);
                }

                if (isUpload) {
                    // Người dùng upload file mới
                    String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
                    String cleanName = java.text.Normalizer
                            .normalize(originalFileName.substring(0, originalFileName.lastIndexOf(".")), java.text.Normalizer.Form.NFD)
                            .replaceAll("\\p{M}", "")
                            .replaceAll("[^a-zA-Z0-9_-]", "_");
                    String fileName = cleanName + "_" + System.currentTimeMillis() + ext;

                    // Thư mục uploads
                    String uploadPath = getServletContext().getRealPath("/uploads");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    filePart.write(uploadPath + File.separator + fileName);

                    ps.setString(8, "uploads/" + fileName);

                } else {
                    ps.setNull(8, java.sql.Types.VARCHAR);
                }

                ps.executeUpdate();
            }

            response.sendRedirect("JobDetail?id=" + jobId);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error upload CV: " + e.getMessage());
        }
    }

}
