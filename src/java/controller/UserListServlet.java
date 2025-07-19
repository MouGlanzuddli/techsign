package controller;

import dal.UserDao;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/UserListServlet")
public class UserListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (Connection conn = dal.DBContext.getConnection()) {
            UserDao userDao = new UserDao(conn);
            List<User> allUsers = userDao.getAllUsers();
            HttpSession session = request.getSession(false);
            Integer currentUserId = null;
            if (session != null && session.getAttribute("user") != null) {
                User currentUser = (User) session.getAttribute("user");
                currentUserId = currentUser.getId();
            }
            final Integer finalCurrentUserId = currentUserId;
            List<User> filtered = (finalCurrentUserId == null) ? allUsers : allUsers.stream()
                .filter(u -> u.getId() != finalCurrentUserId)
                .collect(Collectors.toList());
            // Chỉ trả về id, fullName, email, avatarUrl
            var result = filtered.stream().map(u -> new Object() {
                public int id = u.getId();
                public String fullName = u.getFullName();
                public String email = u.getEmail();
                public String avatarUrl = u.getAvatarUrl();
            }).collect(Collectors.toList());
            response.getWriter().write(new Gson().toJson(result));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("[]");
        }
    }
} 