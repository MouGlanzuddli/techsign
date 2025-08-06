package controller;

import DAO.favouriteCompanyDAO;
import connectDB.DBContext;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.List;
import model.Companies;

public class FavouriteCompanyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        favouriteCompanyDAO dao = new favouriteCompanyDAO();
        List<Companies> favCompanies = dao.getFavouriteCompaniesByUserId(user.getId());

        request.setAttribute("favCompanies", favCompanies);
        request.getRequestDispatcher("favouriteCompanies.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        int userId = user.getId();
        int companyId = Integer.parseInt(request.getParameter("companyId"));

        try (Connection conn = new DBContext().getConnection()) {

            String checkSql = "SELECT COUNT(*) FROM user_favourite WHERE user_id = ? AND entity_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, companyId);
            var rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) == 0) {
                String insertSql = "INSERT INTO user_favourite (user_id, entity_id, favourite_at) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, companyId);
                insertStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                insertStmt.executeUpdate();
            }

            
            response.sendRedirect("CompanyDetailServlet?id=" + companyId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
