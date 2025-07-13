package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;
import java.sql.Connection;
import dao.CandidateDAO;
import model.Candidate;

@WebServlet(name = "CandidateHome", urlPatterns = {"/CandidateHome"})
public class CandidateHomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 2) {
            response.sendRedirect("login.jsp");
            return;
        }
        boolean isSearchable = true;
        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            CandidateDAO candidateDAO = new CandidateDAO(conn);
            Candidate candidate = candidateDAO.getCandidateByUserId(user.getId());
            if (candidate != null) {
                isSearchable = candidate.isSearchable();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        request.setAttribute("isSearchable", isSearchable);
        request.getRequestDispatcher("candidateHome.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 