/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import connectDB.DBContext;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import model.User;

@MultipartConfig
public class CreateNewCVServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part avatarPart = request.getPart("avatar");
        String avatarFileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
        String avatarUploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File avatarDir = new File(avatarUploadPath);
        if (!avatarDir.exists()) {
            avatarDir.mkdir();
        }
        avatarPart.write(avatarUploadPath + File.separator + avatarFileName);

        String fullname = request.getParameter("fullname");
        String jobtitle = request.getParameter("jobtitle");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String skills = request.getParameter("skills");
        String objective = request.getParameter("objective");

        // Kinh nghiệm: nếu nhiều block
        String[] companies = request.getParameterValues("company");
        String[] positions = request.getParameterValues("position");
        String[] periods = request.getParameterValues("period");
        String[] details = request.getParameterValues("detail");
        StringBuilder sb = new StringBuilder();
        if (companies != null) {
            for (int i = 0; i < companies.length; i++) {
                sb.append(companies[i]).append("\n")
                        .append(positions[i]).append("\n")
                        .append(periods[i]).append("\n")
                        .append(details[i]).append("\n=====\n");
            }
        }
        String experience = sb.toString();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try (Connection conn = new DBContext().getConnection()) {
            String sql = "INSERT INTO system_cvs (user_id, avatar, fullname, jobtitle, phone, email, dob, address, skills, objective, experience, created_at) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, user.getId());
            ps.setString(2, "uploads/" + avatarFileName);
            ps.setString(3, fullname);
            ps.setString(4, jobtitle);
            ps.setString(5, phone);
            ps.setString(6, email);
            ps.setString(7, dob);
            ps.setString(8, address);
            ps.setString(9, skills);
            ps.setString(10, objective);
            ps.setString(11, experience);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("resumeCandidate.jsp");
    }
}
