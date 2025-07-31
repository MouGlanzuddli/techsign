package controller;

import com.google.gson.Gson;
import dal.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class JobSkillSuggestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String term = request.getParameter("term");
        List<String> suggestions = new ArrayList<>();

        try (Connection conn = new DBContext().getConnection()) {
            String sql = """
                SELECT title FROM job_postings WHERE title LIKE ?
                UNION
                SELECT name FROM skills WHERE name LIKE ?
            """;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + term + "%");
            ps.setString(2, "%" + term + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                suggestions.add(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.write(new Gson().toJson(suggestions));
        out.close();
    }
}
