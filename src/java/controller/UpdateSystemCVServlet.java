package controller;

import connectDB.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;


@MultipartConfig
public class UpdateSystemCVServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));

        String fullname = request.getParameter("fullname");
        String jobtitle = request.getParameter("jobtitle");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String skills = request.getParameter("skills");
        String objective = request.getParameter("objective");
        String[] companies = request.getParameterValues("company");
        String[] positions = request.getParameterValues("position");
        String[] periods = request.getParameterValues("period");
        String[] details = request.getParameterValues("detail");

        StringBuilder sb = new StringBuilder();
        if (companies != null) {
            for (int i = 0; i < companies.length; i++) {
                sb.append(companies[i] != null ? companies[i] : "").append("\n")
                        .append(positions[i] != null ? positions[i] : "").append("\n")
                        .append(periods[i] != null ? periods[i] : "").append("\n")
                        .append(details[i] != null ? details[i] : "").append("\n=====\n");
            }
        }
        String experience = sb.toString();

        
        Part avatarPart = request.getPart("avatar");
        String avatarFileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
        String avatarPath = ""; 

        if (avatarFileName != null && !avatarFileName.trim().isEmpty()) {
            
            String avatarUploadPath = getServletContext().getRealPath("/uploads");

            File avatarDir = new File(avatarUploadPath);
            if (!avatarDir.exists()) {
                avatarDir.mkdirs(); 
            }

            avatarPart.write(avatarUploadPath + File.separator + avatarFileName);
            avatarPath = "uploads/" + avatarFileName;
        }

        try (Connection conn = new DBContext().getConnection()) {
            String sql;
            if (!avatarPath.isEmpty()) {
                sql = "UPDATE system_cvs SET avatar=?, fullname=?, jobtitle=?, phone=?, email=?, dob=?, address=?, skills=?, objective=?, experience=? WHERE id=?";
            } else {
                sql = "UPDATE system_cvs SET fullname=?, jobtitle=?, phone=?, email=?, dob=?, address=?, skills=?, objective=?, experience=? WHERE id=?";
            }

            PreparedStatement ps = conn.prepareStatement(sql);
            int idx = 1;

            if (!avatarPath.isEmpty()) {
                ps.setString(idx++, avatarPath);
            }

            ps.setString(idx++, fullname);
            ps.setString(idx++, jobtitle);
            ps.setString(idx++, phone);
            ps.setString(idx++, email);
            ps.setString(idx++, dob);
            ps.setString(idx++, address);
            ps.setString(idx++, skills);
            ps.setString(idx++, objective);
            ps.setString(idx++, experience);
            ps.setInt(idx, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("resumeCandidate.jsp");
    }
}
