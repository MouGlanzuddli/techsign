package controller;

import connectDB.DBContext;
import java.sql.Connection;

import java.io.IOException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.*;
import connectDB.DBContext;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import java.nio.file.Paths;

@MultipartConfig
public class UploadServlet extends HttpServlet {

    


@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {

            // 1. Lấy thông tin user từ session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            int userId = user.getId();

            // 2. Kết nối DB và tìm candidate_profile_id
            Connection conn = new DBContext().getConnection();
            String findProfileSQL = "SELECT id FROM candidate_profiles WHERE user_id = ?";
            PreparedStatement ps1 = conn.prepareStatement(findProfileSQL);
            ps1.setInt(1, userId);
            ResultSet rs = ps1.executeQuery();

            int candidateProfileId = -1;
            if (rs.next()) {
                candidateProfileId = rs.getInt("id");
            }
            rs.close();
            ps1.close();

            if (candidateProfileId == -1) {
                throw new Exception("Not found user ID: " + userId);
            }

            // 3. Lấy file từ form
            Part filePart = request.getPart("resumeFile");
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
            String cleanName = java.text.Normalizer
                    .normalize(originalFileName.substring(0, originalFileName.lastIndexOf(".")), java.text.Normalizer.Form.NFD)
                    .replaceAll("\\p{M}", "")
                    .replaceAll("[^a-zA-Z0-9_-]", "_");
            String fileName = cleanName + "_" + System.currentTimeMillis() + ext;

            // 4. Đảm bảo thư mục uploads tồn tại
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 5. Ghi file vào thư mục uploads
            String filePath = uploadPath + File.separator + fileName;
            if (filePart != null && filePart.getSize() > 0) {
                filePart.write(filePath);
            } else {
                throw new Exception("No file to upload.");
            }

            String relativeUrl = "uploads/" + fileName;

            // 6. Lưu thông tin vào bảng candidate_cvs
            String insertSQL = "INSERT INTO candidate_cvs (candidate_profile_id, cv_name, cv_url, is_default, uploaded_at) VALUES (?, ?, ?, 0, GETDATE())";
            PreparedStatement ps2 = conn.prepareStatement(insertSQL);
            ps2.setInt(1, candidateProfileId);
            ps2.setString(2, fileName);
            ps2.setString(3, "uploads/" + fileName);
            ps2.executeUpdate();
            ps2.close();
            conn.close();

            // 7. Chuyển hướng về resumeCandidate.jsp
            response.sendRedirect("resumeCandidate.jsp");

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("errorMessage", "Error upload CV: " + e.getMessage());
            request.getRequestDispatcher("resumeCandidate.jsp").forward(request, response);
        }

    }

}
