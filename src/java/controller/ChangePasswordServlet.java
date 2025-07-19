package controller;

import dal.DBContext;
import dal.UserDao;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "ChangepasswordServlet", urlPatterns = {"/ChangepasswordServlet"})
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        forwardToChangePasswordPage(user, request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String errorMsg = null;
        if (oldPassword == null || oldPassword.trim().isEmpty()) {
            errorMsg = "Old password must not be empty!";
        } else if (newPassword == null || newPassword.trim().isEmpty()) {
            errorMsg = "New password must not be empty!";
        } else if (!newPassword.equals(confirmPassword)) {
            errorMsg = "New password and confirm password do not match!";
        } else if (newPassword.length() < 6) {
            errorMsg = "New password must be at least 6 characters!";
        }

        if (errorMsg != null) {
            request.setAttribute("error", errorMsg);
            forwardToChangePasswordPage(user, request, response);
            return;
        }

        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            UserDao userDao = new UserDao(conn);
            // Lấy user từ DB để đảm bảo không bị mất các trường khác
            User dbUser = userDao.getUserById(userId);
            if (dbUser == null) {
                request.setAttribute("error", "User not found!");
                forwardToChangePasswordPage(user, request, response);
                return;
            }
            if (!BCrypt.checkpw(oldPassword, dbUser.getPasswordHash())) {
                request.setAttribute("error", "Old password is incorrect!");
                forwardToChangePasswordPage(user, request, response);
                return;
            }
            // Chỉ cập nhật password_hash và updatedAt, giữ nguyên các trường khác
            dbUser.setPasswordHash(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
            dbUser.setUpdatedAt(new java.util.Date());
            boolean updated = userDao.updateUser(dbUser);
            if (updated) {
                session.setAttribute("user", dbUser);
                request.setAttribute("success", "Password changed successfully!");
                forwardToChangePasswordPage(dbUser, request, response);
            } else {
                request.setAttribute("error", "Failed to update password. Please try again.");
                forwardToChangePasswordPage(user, request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            forwardToChangePasswordPage(user, request, response);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    private void forwardToChangePasswordPage(User user, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (user.getRoleId() == 2) {
            request.getRequestDispatcher("candidate-change-password.jsp").forward(request, response);
        } else if (user.getRoleId() == 3) {
            request.getRequestDispatcher("company-change-password.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
} 