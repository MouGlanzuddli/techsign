package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dal.DBContext;
import dal.UserDao;
import model.User;
import java.sql.Connection;
import java.util.Date;

@WebServlet(name="RoleSelectionServlet", urlPatterns={"/RoleSelectionServlet"})
public class RoleSelectionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String selectedRole = request.getParameter("role");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("tempUser");
        
        System.out.println("=== DEBUG RoleSelectionServlet ===");
        System.out.println("Selected role: " + selectedRole);
        System.out.println("User from session: " + (user != null ? user.getEmail() : "null"));
        
        if (user == null) {
            System.out.println("ERROR: User is null in session");
            response.sendRedirect("index.jsp?error=session_expired");
            return;
        }
      
        if (selectedRole == null || selectedRole.isEmpty()) {
            System.out.println("ERROR: No role selected");
            response.sendRedirect("roleSelection.jsp?error=please_select_role");
            return;
        }
        
        
        try {
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            UserDao userDao = new UserDao(conn);
            
            System.out.println("Database connection established");
            System.out.println("User ID: " + user.getId());
            System.out.println("User Email: " + user.getEmail());
            
            // Update user role based on selection
            int roleId;
            switch (selectedRole) {
                case "candidate":
                    roleId = 2; // Candidate role
                    break;
                case "company":
                    roleId = 3; // Company role
                    break;
                default:
                    System.out.println("ERROR: Invalid role - " + selectedRole);
                    response.sendRedirect("roleSelection.jsp?error=invalid_role");
                    return;
            }
            
            System.out.println("Setting role ID to: " + roleId);
            
            user.setRoleId(roleId);
            user.setUpdatedAt(new Date());
            
            // Update user in database
            boolean updated = userDao.updateUser(user);
            System.out.println("Update result: " + updated);
            
            if (updated) {
                // Remove temp user and set actual user in session
                session.removeAttribute("tempUser");
                session.setAttribute("user", user);
                
                System.out.println("User updated successfully, redirecting to home page");
                
                // Redirect based on selected role
                switch (roleId) {
                    case 2:
                        response.sendRedirect("candidateHome.jsp");
                        break;
                    case 3:
                        response.sendRedirect("companyHome.jsp");
                        break;
                    default:
                        response.sendRedirect("index.jsp?error=invalid_role");
                }
            } else {
                System.out.println("ERROR: Failed to update user in database");
                response.sendRedirect("roleSelection.jsp?error=update_failed");
            }
            
        } catch (Exception e) {
            System.out.println("EXCEPTION in RoleSelectionServlet:");
            e.printStackTrace();
            response.sendRedirect("roleSelection.jsp?error=internal_error&details=" + e.getMessage());
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to role selection page
        response.sendRedirect("roleSelection.jsp");
    }
}
