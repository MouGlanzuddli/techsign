package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import connectDB.DBContext;
import DAO.UserDao;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

/**
 * @author MouGlanzuddli
 */
@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang đăng ký
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
       String useridStr = request.getParameter("userid");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String roleStr = request.getParameter("role");

        int userid;
        int roleId;

        try {
            userid = Integer.parseInt(useridStr);
        } catch (NumberFormatException e) {
            request.setAttribute("registerError", "User ID must be a number.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        try {
            roleId = Integer.parseInt(roleStr);
        } catch (NumberFormatException e) {
            request.setAttribute("registerError", "Invalid role selection.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("registerError", "Passwords do not match.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Tạo user object
        User user = new User();
        user.setId(userid);  // ID từ form
        user.setFullName(fullname);
        user.setEmail(email);
        user.setPasswordHash(hashedPassword);
        user.setRoleId(roleId);
        user.setPhone(""); // hoặc có thể để null nếu chưa có input phone
        user.setEmailVerified(false);
        user.setPhoneVerified(false);
        user.setAvatarUrl(null);
        user.setStatus("active");
        Date now = new Date();
        user.setCreatedAt(now);
        user.setUpdatedAt(now);

        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            UserDao userDao = new UserDao(conn);

          if (userDao.getUserById(userid) != null) {
                request.setAttribute("registerError", "User ID already exists.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
           } else {
                boolean success = userDao.insertUser(user);
                if (success) {
                   response.sendRedirect("index.jsp");
                } else {
                    request.setAttribute("registerError", "Failed to create account. Please try again.");
                    request.getRequestDispatcher("signup.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("registerError", "Database error: " + e.getMessage());
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}