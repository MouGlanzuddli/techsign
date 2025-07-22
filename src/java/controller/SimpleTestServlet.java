package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


public class SimpleTestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        
        try {
            System.out.println("=== SIMPLE TEST ===");
            
            // Test connection
            Connection conn = dao.DBContext.getConnection();
            System.out.println("✓ Connection OK");
            
            // Test query trực tiếp
            String sql = "SELECT id, full_name, email FROM users LIMIT 3";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            System.out.println("✓ Query executed");
            int count = 0;
            while (rs.next()) {
                count++;
                int id = rs.getInt("id");
                String name = rs.getString("full_name");
                String email = rs.getString("email");
                System.out.println("✓ Row " + count + ": id=" + id + ", name=" + name + ", email=" + email);
            }
            System.out.println("✓ Total rows: " + count);
            
            rs.close();
            stmt.close();
            conn.close();
            
            response.getWriter().write("Simple test completed - check console");
            
        } catch (Exception e) {
            System.err.println("✗ ERROR: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("ERROR: " + e.getMessage());
        }
    }
} 