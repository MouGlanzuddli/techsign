package controller;

import dao.UserDao;
import model.User;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        System.out.println("[UserListServlet] Bắt đầu doGet()");
        try (Connection conn = dao.DBContext.getConnection()) {
            System.out.println("[UserListServlet] Kết nối DB thành công");
            UserDao UserDao = new UserDao(conn);
            List<User> allUsers = UserDao.getAllUsers();
            
            System.out.println("[UserListServlet] Số users từ DB: " + (allUsers != null ? allUsers.size() : "null"));
            if (allUsers != null) {
                for (int i = 0; i < Math.min(allUsers.size(), 3); i++) {
                    User u = allUsers.get(i);
                    System.out.println("[UserListServlet] User " + i + ": " + 
                        (u != null ? "id=" + u.getId() + ", name=" + u.getFullName() + ", email=" + u.getEmail() : "null"));
                }
            }
            
            HttpSession session = request.getSession(false);
            Integer currentUserId = null;
            if (session != null && session.getAttribute("user") != null) {
                User currentUser = (User) session.getAttribute("user");
                currentUserId = currentUser.getId();
                System.out.println("[UserListServlet] Current user ID: " + currentUserId);
            }
            
            final Integer finalCurrentUserId = currentUserId;
            List<User> filtered = allUsers.stream()
                .filter(u -> u != null && u.getId() != finalCurrentUserId && u.getRoleId() != 1)
                .collect(Collectors.toList());
                
            System.out.println("[UserListServlet] Số users sau filter: " + filtered.size());
            for (User u : filtered) {
                System.out.println("[UserListServlet] User: id=" + u.getId() + ", email=" + u.getEmail() + ", role=" + u.getRoleId());
            }
            
            // Chỉ trả về id, fullName, email, avatarUrl
            // Test trực tiếp với User object
            System.out.println("[UserListServlet] Test với User object trực tiếp:");
            if (!filtered.isEmpty()) {
                User testUser = filtered.get(0);
                System.out.println("[UserListServlet] Test user: id=" + testUser.getId() + 
                    ", name=" + testUser.getFullName() + ", email=" + testUser.getEmail());
            }
            
            // Tạo JSON cho tất cả users
            System.out.println("[UserListServlet] Tạo JSON cho tất cả users:");
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < filtered.size(); i++) {
                User u = filtered.get(i);
                if (i > 0) json.append(",");
                json.append("{");
                json.append("\"id\":").append(u.getId()).append(",");
                json.append("\"fullName\":\"").append(u.getFullName()).append("\",");
                json.append("\"email\":\"").append(u.getEmail()).append("\",");
                json.append("\"avatarUrl\":\"").append(u.getAvatarUrl() != null ? u.getAvatarUrl() : "").append("\"");
                json.append("}");
            }
            json.append("]");
            
            String jsonResult = json.toString();
            System.out.println("[UserListServlet] JSON result: " + jsonResult);
            response.getWriter().write(jsonResult);
        } catch (Exception e) {
            System.err.println("[UserListServlet] Error: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("[]");
        }
    }
} 