package controller;

import model.User;
import model.Candidate;
import dal.CandidateDAO;
import dal.UserDao;
import dal.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.util.Date;

@WebServlet(name = "UpdateCandidateProfile", urlPatterns = {"/UpdateCandidateProfile"})
public class UpdateCandidateProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 2) { // 2: candidate
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();

        // Nhận dữ liệu từ form
        String fullName = request.getParameter("candidateName");
        String jobTitle = request.getParameter("jobTitle");
        String experienceYearsStr = request.getParameter("experienceYears");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String educationLevel = request.getParameter("educationLevel");
        String address = request.getParameter("address");
        boolean isSearchable = "on".equals(request.getParameter("isSearchable"));
        int experienceYears = 0;
        try {
            experienceYears = experienceYearsStr != null && !experienceYearsStr.isEmpty() ? Integer.parseInt(experienceYearsStr) : 0;
        } catch (NumberFormatException e) {
            experienceYears = 0;
        }
        String skills = request.getParameter("skills");
        // Validate input
        String errorMsg = null;
        if (fullName == null || fullName.trim().isEmpty()) {
            errorMsg = "Full name must not be empty!";
        } else if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            errorMsg = "Invalid email format!";
        } else if (phone != null && !phone.trim().isEmpty() && !phone.matches("^0\\d{9}$")) {
            errorMsg = "Phone number must be 10 digits, start with 0!";
        } else if (address == null || address.trim().isEmpty()) {
            errorMsg = "Address must not be empty!";
        }
        
        // Handle null values for optional fields
        if (jobTitle == null) jobTitle = "";
        if (educationLevel == null) educationLevel = "";
        if (phone == null) phone = "";
        if (address == null) address = "";
        if (skills == null) skills = "";
        // Nếu có lỗi, trả về form với thông báo lỗi
        if (errorMsg != null) {
            // Store error in session instead of request
            session.setAttribute("error", errorMsg);
            session.setAttribute("formData", new String[]{fullName, jobTitle, experienceYearsStr, educationLevel, address, email, phone, skills});
            response.sendRedirect("CandidateProfilesServlet");
            return;
        }
        // Chỉ cập nhật database khi không có lỗi
        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            dal.CandidateDAO candidateDAO = new dal.CandidateDAO(conn);
            dal.UserDao userDao = new dal.UserDao(conn);
            Candidate candidate = candidateDAO.getCandidateByUserId(userId);
            java.util.Date now = new java.util.Date();
            if (candidate == null) {
                candidate = new Candidate();
                candidate.setUserId(userId);
                candidate.setCreatedAt(now);
                candidate.setJobTitle(jobTitle);
                candidate.setExperienceYears(experienceYears);
                candidate.setEducationLevel(educationLevel);
                candidate.setAddress(address);
                candidate.setSearchable(isSearchable);
                candidate.setUpdatedAt(now);
                candidateDAO.createCandidate(candidate);
            } else {
                candidate.setJobTitle(jobTitle);
                candidate.setExperienceYears(experienceYears);
                candidate.setEducationLevel(educationLevel);
                candidate.setAddress(address);
                candidate.setSearchable(isSearchable);
                candidate.setUpdatedAt(now);
                candidateDAO.updateCandidate(candidate);
            }
            // Luôn cập nhật fullName, email, phone cho User
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            userDao.updateUser(user);
            session.setAttribute("user", user);
            // Store success message in session
            session.setAttribute("success", "Profile updated successfully!");
            response.sendRedirect("CandidateProfilesServlet");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "System error: " + e.getMessage());
            response.sendRedirect("CandidateProfilesServlet");
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to the profile servlet
        response.sendRedirect("CandidateProfilesServlet");
    }
} 