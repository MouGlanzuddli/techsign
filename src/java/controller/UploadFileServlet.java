package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/UploadFileServlet")
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
            String uploadDir = getServletContext().getRealPath("/uploads");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            File file = new File(dir, fileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            String fileUrl = request.getContextPath() + "/uploads/" + fileName;
            response.getWriter().write("{\"url\":\"" + fileUrl + "\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Upload failed\"}");
        }
    }
} 