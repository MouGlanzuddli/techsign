package controller;

import model.User;
import model.Candidate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

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
        // Nếu có lỗi, trả về form với thông báo lỗi
        if (errorMsg != null) {
            request.setAttribute("fullName", fullName);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("experienceYears", experienceYears);
            request.setAttribute("educationLevel", educationLevel);
            request.setAttribute("address", address);
            request.setAttribute("isSearchable", isSearchable);
            request.setAttribute("email", email);
            request.setAttribute("phoneInput", phone);
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("candidate-dashboard.jsp").forward(request, response);
            return;
        }
        // Chỉ cập nhật database khi không có lỗi
        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            dao.CandidateDAO candidateDAO = new dao.CandidateDAO(conn);
            dal.UserDao userDao = new dal.UserDao(conn);
            Candidate candidate = candidateDAO.getCandidateByUserId(userId);
            java.util.Date now = new java.util.Date();
            if (candidate == null) {
                candidate = new Candidate();
                candidate.setUserId(userId);
                candidate.setCreatedAt(now);
                candidate.setFullName(fullName);
                candidate.setJobTitle(jobTitle);
                candidate.setExperienceYears(experienceYears);
                candidate.setEducationLevel(educationLevel);
                candidate.setAddress(address);
                candidate.setEmail(email);
                candidate.setSearchable(isSearchable);
                candidate.setUpdatedAt(now);
                candidateDAO.createCandidate(candidate);
            } else {
                candidate.setFullName(fullName);
                candidate.setJobTitle(jobTitle);
                candidate.setExperienceYears(experienceYears);
                candidate.setEducationLevel(educationLevel);
                candidate.setAddress(address);
                candidate.setEmail(email);
                candidate.setSearchable(isSearchable);
                candidate.setUpdatedAt(now);
                candidateDAO.updateCandidate(candidate);
            }
            // Luôn cập nhật phone cho cả Candidate và User
            user.setPhone(phone);
            user.setFullName(fullName);
            userDao.updateUser(user);
            session.setAttribute("user", user);
            request.setAttribute("success", "Profile updated successfully!");
            Candidate updatedCandidate = candidateDAO.getCandidateByUserId(userId);
            request.setAttribute("fullName", updatedCandidate != null ? updatedCandidate.getFullName() : fullName);
            request.setAttribute("jobTitle", updatedCandidate != null ? updatedCandidate.getJobTitle() : "");
            request.setAttribute("experienceYears", updatedCandidate != null ? updatedCandidate.getExperienceYears() : experienceYears);
            request.setAttribute("educationLevel", updatedCandidate != null ? updatedCandidate.getEducationLevel() : educationLevel);
            request.setAttribute("address", updatedCandidate != null ? updatedCandidate.getAddress() : address);
            request.setAttribute("isSearchable", updatedCandidate != null && updatedCandidate.isSearchable());
            request.setAttribute("email", updatedCandidate != null ? updatedCandidate.getEmail() : email);
            request.setAttribute("phone", user.getPhone());
            request.setAttribute("phoneInput", user.getPhone());
            request.setAttribute("fullName", user.getFullName());
            request.getRequestDispatcher("candidate-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("candidate-dashboard.jsp").forward(request, response);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 2) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();
        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            dao.CandidateDAO candidateDAO = new dao.CandidateDAO(conn);
            Candidate candidate = candidateDAO.getCandidateByUserId(userId);
            if (candidate != null) {
                request.setAttribute("fullName", candidate.getFullName());
                request.setAttribute("jobTitle", candidate.getJobTitle());
                request.setAttribute("experienceYears", candidate.getExperienceYears());
                request.setAttribute("educationLevel", candidate.getEducationLevel());
                request.setAttribute("address", candidate.getAddress());
                request.setAttribute("isSearchable", candidate.isSearchable());
                request.setAttribute("email", candidate.getEmail());
                request.setAttribute("phone", user.getPhone());
            } else {
                request.setAttribute("fullName", "");
                request.setAttribute("jobTitle", "");
                request.setAttribute("experienceYears", 0);
                request.setAttribute("educationLevel", "");
                request.setAttribute("address", "");
                request.setAttribute("isSearchable", false);
                request.setAttribute("email", "");
                request.setAttribute("phone", "");
            }
            request.setAttribute("fullName", user.getFullName());
            request.setAttribute("jobTitle", candidate != null ? candidate.getJobTitle() : "");
            request.getRequestDispatcher("candidate-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("candidate-dashboard.jsp").forward(request, response);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
} 