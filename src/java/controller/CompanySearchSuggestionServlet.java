package controller;

import dal.DBContext;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class CompanySearchSuggestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String term = request.getParameter("term");
        List<String> suggestions = new ArrayList<>();

        try (Connection conn = new DBContext().getConnection()) {
            String sql = "SELECT company_name FROM company_profiles WHERE company_name LIKE ? ";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + term + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                suggestions.add(rs.getString("company_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new com.google.gson.Gson().toJson(suggestions));
    }
}


