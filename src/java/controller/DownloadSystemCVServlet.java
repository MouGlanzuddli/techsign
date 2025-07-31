package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import dal.DBContext;

public class DownloadSystemCVServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cvIdParam = request.getParameter("id");
        if (cvIdParam == null || cvIdParam.trim().isEmpty()) {
            response.getWriter().println("CV ID is missing or empty");
            return;
        }

        int cvId = Integer.parseInt(cvIdParam);

        try (Connection conn = new DBContext().getConnection()) {
            String sql = "SELECT * FROM system_cvs WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cvId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                response.setContentType("text/html");
                response.setHeader("Content-Disposition", "attachment;filename=CV_" + cvId + ".html");

                PrintWriter out = response.getWriter();

                out.println("<html><head><meta charset='UTF-8'><title>CV</title></head><body>");
                out.println("<h1>" + rs.getString("fullname") + "</h1>");
                out.println("<p>Job Title: " + rs.getString("jobtitle") + "</p>");
                out.println("<p>Email: " + rs.getString("email") + "</p>");
                out.println("<p>Phone: " + rs.getString("phone") + "</p>");
                out.println("<p>Address: " + rs.getString("address") + "</p>");
                out.println("<h3>Skills</h3>");
                out.println("<p>" + rs.getString("skills") + "</p>");
                out.println("<h3>Objective</h3>");
                out.println("<p>" + rs.getString("objective") + "</p>");
                out.println("<h3>Experience</h3>");
                out.println("<pre>" + rs.getString("experience") + "</pre>");
                out.println("</body></html>");

            } else {
                response.getWriter().println("System CV not found");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
