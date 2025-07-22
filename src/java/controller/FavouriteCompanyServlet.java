package controller;

import dal.favouriteCompanyDAO;
import dal.DBContext;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
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

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String keyword = request.getParameter("search");
        if (keyword == null) {
            keyword = "";
        }

        int page = 1;
        int recordsPerPage = 5;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int offset = (page - 1) * recordsPerPage;

        favouriteCompanyDAO dao = new favouriteCompanyDAO();
        List<Companies> favCompanies = dao.getFavouriteCompaniesByUserId(user.getId(), keyword, offset, recordsPerPage);
        int totalRecords = dao.countFavouriteCompaniesByUserId(user.getId(), keyword);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        request.setAttribute("favCompanies", favCompanies);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", keyword);

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
