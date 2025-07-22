package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import dal.DBContext;

public class DownloadCVServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cvIdParam = request.getParameter("id");
        if (cvIdParam == null || cvIdParam.trim().isEmpty()) {
            response.getWriter().println("CV ID is missing or empty");
            return;
        }

        int cvId;
        try {
            cvId = Integer.parseInt(cvIdParam);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid CV ID");
            return;
        }

        try (Connection conn = new DBContext().getConnection()) {
            String sql = "SELECT cv_name, cv_url FROM candidate_cvs WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cvId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String fileName = rs.getString("cv_name");
                String fileUrl = rs.getString("cv_url");

                String absolutePath = getServletContext().getRealPath("/") + fileUrl;

                File file = new File(absolutePath);
                if (!file.exists()) {
                    response.getWriter().println("File not found");
                    return;
                }

                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
                FileInputStream inStream = new FileInputStream(file);
                OutputStream outStream = response.getOutputStream();

                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }

                inStream.close();
                outStream.close();

            } else {
                response.getWriter().println("CV not found");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
