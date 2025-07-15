package controller;

import DAO.CompaniesDAO;
import connectDB.DBContext;
import java.sql.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Companies;
import model.User;

public class CompanyDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int companyId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = new DBContext().getConnection()) {
            CompaniesDAO dao = new CompaniesDAO();
            Companies company = dao.getCompanyById(companyId);

            if (company == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            boolean followed = false;

            if (user != null) {
                String sql = "SELECT COUNT(*) FROM user_favourite WHERE user_id = ? AND entity_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, user.getId());
                    ps.setInt(2, companyId);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        followed = rs.getInt(1) > 0;
                    }
                }
            }

            request.setAttribute("company", company);
            request.setAttribute("followed", followed);

            request.getRequestDispatcher("companydetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
