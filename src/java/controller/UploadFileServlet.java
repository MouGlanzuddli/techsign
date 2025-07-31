package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class UploadFileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try {
            Part filePart = request.getPart("file");
            if (filePart == null || filePart.getSize() == 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"No file uploaded\"}");
                return;
            }
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            
            // Lưu vào thư mục uploads trong project root (không phải build)
            String projectRoot = getServletContext().getRealPath("/").replace("build\\web", "").replace("build/web", "");
            String uploadDir = projectRoot + "uploads";
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            File file = new File(dir, fileName);
            
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            
            // URL để truy cập file
            String fileUrl = request.getContextPath() + "/uploads/" + fileName;
            response.getWriter().write("{\"url\":\"" + fileUrl + "\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Upload failed\"}");
        }
    }
} 