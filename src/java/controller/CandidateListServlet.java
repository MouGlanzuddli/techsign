package controller;

import dal.ApplicationDao;
import model.Application;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CandidateListServlet")
public class CandidateListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String jobIdStr = request.getParameter("jobId");
        if (jobIdStr == null) {
            response.sendRedirect("company-jobs.jsp");
            return;
        }
        int jobId = Integer.parseInt(jobIdStr);
        ApplicationDao appDao = null;
        try {
            appDao = new ApplicationDao();
            List<Application> candidateList = appDao.getApplicationsByJobId(jobId);
            request.setAttribute("candidateList", candidateList);
            request.setAttribute("jobId", jobId);
            request.getRequestDispatcher("CandidateList.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("CandidateList.jsp").forward(request, response);
        } finally {
            if (appDao != null) appDao.closeConnection();
        }
    }
} 