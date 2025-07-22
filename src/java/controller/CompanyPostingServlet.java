package controller;

import dao.CompanyProfileDAO;
import dao.JobPostingDAO;
import model.CompanyProfile;
import model.JobPosting;
import util.DBConnection;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.time.LocalDateTime;
import util.LocalDateTimeAdapter;

public class CompanyPostingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try (Connection conn = DBConnection.getConnection()) {
            CompanyProfileDAO companyDao = new CompanyProfileDAO();
            JobPostingDAO jobDao = new JobPostingDAO();
            Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .setDateFormat("yyyy-MM-dd HH:mm:ss")
                .create();

            if ("getCompanies".equals(action)) {
                List<CompanyProfile> companies = companyDao.getAllCompanies();
                response.setContentType("application/json");
                response.getWriter().write("{\"companies\":" + gson.toJson(companies) + "}");
            } else if ("getJobsByCompany".equals(action)) {
                int companyId = Integer.parseInt(request.getParameter("companyId"));
                List<JobPosting> jobs = jobDao.getJobsByCompany(companyId);
                response.setContentType("application/json");
                response.getWriter().write("{\"jobs\":" + gson.toJson(jobs) + "}");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
} 