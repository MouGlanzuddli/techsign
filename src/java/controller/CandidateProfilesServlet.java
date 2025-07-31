package controller;

import model.User;
import model.Candidate;
import dal.CandidateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "CandidateProfilesServlet", urlPatterns = {"/CandidateProfilesServlet"})
public class CandidateProfilesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getRoleId() != 2) { // 2: candidate
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = user.getId();
        Connection conn = null;
        
        try {
            conn = new dal.DBContext().getConnection();
            dal.CandidateDAO candidateDAO = new dal.CandidateDAO(conn);
            Candidate candidate = candidateDAO.getCandidateByUserId(userId);
            
            // Check for any messages in session and move them to request
            if (session.getAttribute("error") != null) {
                request.setAttribute("error", session.getAttribute("error"));
                session.removeAttribute("error");
            }
            
            if (session.getAttribute("success") != null) {
                request.setAttribute("success", session.getAttribute("success"));
                session.removeAttribute("success");
            }
            
            // Check if there is form data from a failed validation
            if (session.getAttribute("formData") != null) {
                String[] formData = (String[]) session.getAttribute("formData");
                request.setAttribute("fullName", formData[0]);
                request.setAttribute("jobTitle", formData[1]);
                request.setAttribute("experienceYears", formData[2]);
                request.setAttribute("educationLevel", formData[3]);
                request.setAttribute("address", formData[4]);
                request.setAttribute("email", formData[5]);
                request.setAttribute("phoneInput", formData[6]);
                request.setAttribute("skills", formData[7]);
                session.removeAttribute("formData");
            } else if (candidate != null) {
                // Normal case: display data from database
                request.setAttribute("jobTitle", candidate.getJobTitle());
                request.setAttribute("experienceYears", candidate.getExperienceYears());
                request.setAttribute("educationLevel", candidate.getEducationLevel());
                request.setAttribute("address", candidate.getAddress());
                request.setAttribute("isSearchable", candidate.isSearchable());
                request.setAttribute("email", candidate.getEmail());
            } else {
                request.setAttribute("jobTitle", "");
                request.setAttribute("experienceYears", 0);
                request.setAttribute("educationLevel", "");
                request.setAttribute("address", "");
                request.setAttribute("isSearchable", false);
                request.setAttribute("email", "");
            }
            
            request.setAttribute("fullName", user.getFullName());
            request.setAttribute("phone", user.getPhone());
            request.setAttribute("avatarUrl", user.getAvatarUrl() != null ? user.getAvatarUrl() : "assets/img/default-avatar.png");
            
            request.getRequestDispatcher("candidate-profiles.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("candidate-profiles.jsp").forward(request, response);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 