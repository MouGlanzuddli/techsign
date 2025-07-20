package controller;

import dal.UserDao;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/TestUserServlet")
public class TestUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        
        try {
            System.out.println("=== TEST USER SERVLET ===");
            
            // Test connection
            Connection conn = dal.DBContext.getConnection();
            System.out.println("✓ DB Connection OK");
            
            // Test UserDao
            UserDao userDao = new UserDao(conn);
            System.out.println("✓ UserDao created");
            
            // Test getAllUsers
            List<User> users = userDao.getAllUsers();
            System.out.println("✓ getAllUsers() called, size: " + (users != null ? users.size() : "null"));
            
            if (users != null && !users.isEmpty()) {
                User firstUser = users.get(0);
                System.out.println("✓ First user: " + 
                    (firstUser != null ? 
                        "id=" + firstUser.getId() + 
                        ", name=" + firstUser.getFullName() + 
                        ", email=" + firstUser.getEmail() : "null"));
            }
            
            conn.close();
            response.getWriter().write("Test completed - check server console");
            
        } catch (Exception e) {
            System.err.println("✗ ERROR: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("ERROR: " + e.getMessage());
        }
    }
} 