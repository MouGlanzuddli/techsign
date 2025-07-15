package controller;

import DAO.CompaniesDAO;
import connectDB.DBContext;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.List;
import model.Companies;

public class SearchCompaniesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;
        int companiesPerPage = 9;

        String pageParam = request.getParameter("page");
        String limitParam = request.getParameter("companiesPerPage");
        String keyword = request.getParameter("keyword");

        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }
        if (limitParam != null) {
            companiesPerPage = Integer.parseInt(limitParam);
        }

        if (keyword == null) {
            keyword = ""; // default = ALL companies
        }

        int offset = (page - 1) * companiesPerPage;

        CompaniesDAO dao = new CompaniesDAO();
        List<Companies> companies = dao.getCompaniesWithPaging(keyword, offset, companiesPerPage);
        int totalCompanies = dao.getTotalCompanies(keyword);
        int totalPages = (int) Math.ceil((double) totalCompanies / companiesPerPage);

        request.setAttribute("companies", companies);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("companiesPerPage", companiesPerPage);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("searchForCompanies.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
