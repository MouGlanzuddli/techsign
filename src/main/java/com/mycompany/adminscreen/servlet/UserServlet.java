    package com.mycompany.adminscreen.servlet;

    import com.mycompany.adminscreen.dao.UserDAO;
    import com.mycompany.adminscreen.dao.RoleAssignmentDAO;
    import com.mycompany.adminscreen.model.User;
    import com.mycompany.adminscreen.model.RoleAssignmentRequest;
    import com.mycompany.adminscreen.util.EmailUtil;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import org.mindrot.jbcrypt.BCrypt;

    import java.io.IOException;
    import java.io.PrintWriter;
    import java.sql.SQLException;
    import java.sql.Timestamp;
    import java.time.LocalDateTime;
    import java.util.List;
    import java.util.UUID;

      @WebServlet({"/users", "/UserServlet"})
    public class UserServlet extends HttpServlet {

        private UserDAO userDAO;
        private RoleAssignmentDAO roleAssignmentDAO;

        @Override
        public void init() throws ServletException {
            try {
                userDAO = new UserDAO();
                roleAssignmentDAO = new RoleAssignmentDAO();
            } catch (Exception e) {
                throw new ServletException("Failed to initialize DAOs", e);
            }
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String action = req.getParameter("action");
            if (action == null || action.trim().isEmpty()) {
        action = "list"; // Or whatever your default action is, typically displaying the main list
    }
            
            try {
                switch (action) {
                    case "delete":
                        handleDelete(req, resp);
                        break;
                    case "edit":
                        handleEdit(req, resp);
                        break;
                    case "getData":
                        handleGetData(req, resp);
                        break;
                    case "assignRole":
                        handleAssignRole(req, resp);
                        break;
                    case "confirmRole":
                        handleConfirmRole(req, resp);
                        break;
                    case "rejectRole":
                        handleRejectRole(req, resp);
                        break;
                    case "testEmail":
                        handleTestEmail(req, resp);
                        break;
                    case "testEmailConfig":
                        handleTestEmailConfig(req, resp);
                        break;
                    case "getEmailConfig":
                        handleGetEmailConfig(req, resp);
                        break;
                    case "updateEmailConfig":
                        handleUpdateEmailConfig(req, resp);
                        break;
                    case "reloadEmailConfig":
                        handleReloadEmailConfig(req, resp);
                        break;
                    default:
                        listUsers(req, resp);
                        break;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
            }
        }

        private void listUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
            String search = req.getParameter("search");
            String role = req.getParameter("role");

            List<User> userList = userDAO.getUsers(search, role);
            req.setAttribute("userList", userList);
            req.setAttribute("totalUsers", userDAO.getTotalUsers());
            req.getRequestDispatcher("/views/sections/user-account.jsp").forward(req, resp);
        }

        private void handleSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
            String search = req.getParameter("search");
            String role = req.getParameter("role");

            List<User> userList = userDAO.getUsers(search, role);
            req.setAttribute("userList", userList);
            req.getRequestDispatcher("/views/sections/user-account.jsp").forward(req, resp);
        }

        private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            try {
                int userId = Integer.parseInt(req.getParameter("id"));
                if (userDAO.deleteUser(userId)) {
                    resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=deleted");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=delete_failed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=error");
            }
        }

        private void handleEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                int userId = Integer.parseInt(req.getParameter("id"));
                System.out.println("Edit user id: " + req.getParameter("id"));
                User user = userDAO.getUserById(userId);
                System.out.println("Fetched user: " + user);
                if (user != null) {
                    req.setAttribute("user", user);
                    // Check if this is a cancel action
                    String cancel = req.getParameter("cancel");
                    if ("true".equals(cancel)) {
                        // Redirect to user management section
                        resp.sendRedirect(req.getContextPath() + "/UserServlet#user-accounts");
                        return;
                    }
                    req.getRequestDispatcher("/views/sections/edit-user.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=not_found");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=error");
            }
        }

        private void handleGetData(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                String search = req.getParameter("search");
                String role = req.getParameter("role");
                
                List<User> users = userDAO.getUsers(search, role);
                
                // Set content type to JSON
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                
                // Create JSON response
                StringBuilder json = new StringBuilder();
                json.append("{\"users\":[");
                
                for (int i = 0; i < users.size(); i++) {
                    User user = users.get(i);
                    json.append("{");
                    json.append("\"id\":").append(user.getId()).append(",");
                    json.append("\"email\":\"").append(user.getEmail()).append("\",");
                    json.append("\"fullName\":\"").append(user.getFullName()).append("\",");
                    json.append("\"roleId\":").append(user.getRoleId()).append(",");
                    json.append("\"phone\":\"").append(user.getPhone() != null ? user.getPhone() : "").append("\",");
                    json.append("\"status\":\"").append(user.getStatus()).append("\",");
                    json.append("\"isEmailVerified\":").append(user.isEmailVerified()).append(",");
                    json.append("\"isPhoneVerified\":").append(user.isPhoneVerified()).append(",");
                    json.append("\"createdAt\":\"").append(user.getCreatedAt()).append("\",");
                    json.append("\"updatedAt\":\"").append(user.getUpdatedAt() != null ? user.getUpdatedAt() : "").append("\"");
                    json.append("}");
                    
                    if (i < users.size() - 1) {
                        json.append(",");
                    }
                }
                
                json.append("],\"totalUsers\":").append(userDAO.getTotalUsers()).append("}");
                
                resp.getWriter().write(json.toString());
                
            } catch (SQLException e) {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("{\"error\":\"Database error occurred\"}");
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("{\"error\":\"An error occurred while fetching data\"}");
            }
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String action = req.getParameter("action");

            if (action != null) {
                switch (action) {
                    case "create":
                        handleCreate(req, resp);
                        break;
                    case "update":
                        handleUpdate(req, resp);
                        break;
                    case "logout":
                        handleLogout(req, resp);
                        break;
                    case "login":
                        handleLogin(req, resp);
                        break;
                    default:
                        resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=invalid_action");
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=invalid_action");
            }
        }

        private void handleCreate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            try {
                String email = req.getParameter("email");

                // Check if email already exists
                if (userDAO.checkEmailExists(email)) {
                    resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=email_exists");
                    return;
                }

                String password = req.getParameter("password");
                String fullName = req.getParameter("fullName");
                int roleId = Integer.parseInt(req.getParameter("roleId"));
                String phone = req.getParameter("phone");
                String avatarUrl = req.getParameter("avatarUrl");

                String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());
                User user = new User(roleId, email, phone, passwordHash, fullName, avatarUrl);

                String token = UUID.randomUUID().toString();
                Timestamp expiresAt = Timestamp.valueOf(LocalDateTime.now().plusDays(1));

                userDAO.addUserWithToken(user, token, expiresAt);

                // Get the newly created user with ID
                User createdUser = userDAO.getUserByEmail(email);
                
                // Send verification email
                String link = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() 
                        + req.getContextPath() + "/verify?token=" + token;
                String subject = "Xác nhận tài khoản";
                String body = "Chào " + fullName + ",<br>Vui lòng xác nhận tài khoản bằng cách nhấn vào liên kết sau: <a href='" + link + "'>Xác nhận</a>";

                try {
                    System.out.println("=== EMAIL DEBUG INFO ===");
                    System.out.println("Sending verification email to: " + email);
                    System.out.println("Subject: " + subject);
                    System.out.println("Verification link: " + link);
                    System.out.println("Token: " + token);
                    System.out.println("=========================");
                    
                    EmailUtil.sendEmail(email, subject, body);
                    System.out.println("✅ Email sent successfully to: " + email);
                } catch (Exception e) {
                    // Log the error but continue with user creation
                    System.err.println("❌ Failed to send verification email to: " + email);
                    System.err.println("Error details: " + e.getMessage());
                    e.printStackTrace();
                }

                // Return JSON response with the created user data for immediate addition to the list
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                
                StringBuilder json = new StringBuilder();
                json.append("{");
                json.append("\"success\":true,");
                json.append("\"message\":\"Người dùng đã được tạo thành công!\",");
                json.append("\"user\":{");
                json.append("\"id\":").append(createdUser.getId()).append(",");
                json.append("\"email\":\"").append(createdUser.getEmail()).append("\",");
                json.append("\"fullName\":\"").append(createdUser.getFullName()).append("\",");
                json.append("\"roleId\":").append(createdUser.getRoleId()).append(",");
                json.append("\"phone\":\"").append(createdUser.getPhone() != null ? createdUser.getPhone() : "").append("\",");
                json.append("\"status\":\"").append(createdUser.getStatus()).append("\",");
                json.append("\"isEmailVerified\":").append(createdUser.isEmailVerified()).append(",");
                json.append("\"isPhoneVerified\":").append(createdUser.isPhoneVerified()).append(",");
                json.append("\"createdAt\":\"").append(createdUser.getCreatedAt()).append("\",");
                json.append("\"updatedAt\":\"").append(createdUser.getUpdatedAt() != null ? createdUser.getUpdatedAt() : "").append("\"");
                json.append("}");
                json.append("}");
                
                resp.getWriter().write(json.toString());
                
            } catch (Exception e) {
                e.printStackTrace();
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"success\":false,\"message\":\"Lỗi khi tạo người dùng: " + e.getMessage() + "\"}");
            }
        }

        private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();
            
            try {
                int userId = Integer.parseInt(req.getParameter("id"));
                String email = req.getParameter("email");
                String fullName = req.getParameter("fullName");
                String roleIdStr = req.getParameter("roleId");
                String phone = req.getParameter("phone");
                String avatarUrl = req.getParameter("avatarUrl");
                String status = req.getParameter("status");

                if (email == null || fullName == null || roleIdStr == null || status == null) {
                    out.print("{\"success\":false,\"message\":\"Thiếu thông tin bắt buộc\"}");
                    return;
                }

                int roleId = Integer.parseInt(roleIdStr.trim());
                email = email.trim();
                fullName = fullName.trim();
                phone = (phone != null) ? phone.trim() : "";
                avatarUrl = (avatarUrl != null) ? avatarUrl.trim() : "";

                User existingUser = userDAO.getUserById(userId);
                if (existingUser == null) {
                    out.print("{\"success\":false,\"message\":\"Không tìm thấy người dùng\"}");
                    return;
                }

                existingUser.setEmail(email);
                existingUser.setFullName(fullName);
                existingUser.setRoleId(roleId);
                existingUser.setPhone(phone);
                existingUser.setAvatarUrl(avatarUrl);
                existingUser.setStatus(status);
                existingUser.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

                String password = req.getParameter("password");
                String securityAnswer = req.getParameter("securityAnswer");
                if (password != null) {
                    password = password.trim();
                    if (!password.isEmpty()) {
                        // Require security answer
                        if (securityAnswer == null || securityAnswer.trim().isEmpty()) {
                            out.print("{\"success\":false,\"message\":\"Vui lòng nhập câu trả lời bảo mật để thay đổi mật khẩu\"}");
                            return;
                        }
                        // Check security answer
                        String storedHash = existingUser.getSecurityAnswerHash();
                        if (storedHash == null || !org.mindrot.jbcrypt.BCrypt.checkpw(securityAnswer.trim(), storedHash)) {
                            out.print("{\"success\":false,\"message\":\"Câu trả lời bảo mật không đúng\"}");
                            return;
                        }
                        String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());
                        existingUser.setPasswordHash(passwordHash);
                    }
                }

                if (userDAO.updateUser(existingUser)) {
                    out.print("{\"success\":true,\"message\":\"Cập nhật người dùng thành công\"}");
                } else {
                    out.print("{\"success\":false,\"message\":\"Lỗi khi cập nhật người dùng\"}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.print("{\"success\":false,\"message\":\"Lỗi hệ thống: " + e.getMessage() + "\"}");
            }
        }

        private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            try {
                Integer userId = (Integer) req.getSession().getAttribute("userId");
                if (userId != null) {
                    userDAO.updateUserStatus(userId, "offline");
                }
                req.getSession().invalidate();
                resp.setStatus(HttpServletResponse.SC_OK);
            } catch (Exception e) {
                e.printStackTrace();
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }

        private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            try {
                User user = userDAO.login(email, password);
                if (user != null) {
                    userDAO.setUserOnline(user.getId());
                    req.getSession().setAttribute("userId", user.getId());
                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":true,\"userId\":" + user.getId() + "}");
                } else {
                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"success\":false,\"message\":\"Sai email hoặc mật khẩu\"}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.setContentType("application/json");
                resp.getWriter().write("{\"success\":false,\"message\":\"Lỗi đăng nhập\"}");
            }
        }

        private void handleAssignRole(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                int userId = Integer.parseInt(req.getParameter("userId"));
                int newRoleId = Integer.parseInt(req.getParameter("roleId"));
                int adminId = Integer.parseInt(req.getParameter("adminId")); // Admin who is making the request
                
                // Get user details
                User user = userDAO.getUserById(userId);
                if (user == null) {
                    resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=user_not_found");
                    return;
                }
                
                // Create role assignment request
                String token = UUID.randomUUID().toString();
                Timestamp expiresAt = Timestamp.valueOf(LocalDateTime.now().plusDays(7)); // 7 days expiry
                
                RoleAssignmentRequest request = new RoleAssignmentRequest(userId, newRoleId, adminId, token, expiresAt);
                
                if (roleAssignmentDAO.createRoleAssignmentRequest(request)) {
                    // Send confirmation email with professional template
                    String acceptLink = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() 
                            + req.getContextPath() + "/UserServlet?action=confirmRole&token=" + token;
                    String rejectLink = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() 
                            + req.getContextPath() + "/UserServlet?action=rejectRole&token=" + token;
                    
                    String roleName = getRoleName(newRoleId);
                    String subject = "🔐 Yêu cầu phân quyền mới - " + roleName;
                    String body = generateRoleAssignmentEmailTemplate(user.getFullName(), roleName, acceptLink, rejectLink, expiresAt);

                    try {
                        System.out.println("=== ROLE ASSIGNMENT EMAIL DEBUG INFO ===");
                        System.out.println("Sending role assignment email to: " + user.getEmail());
                        System.out.println("Subject: " + subject);
                        System.out.println("User: " + user.getFullName() + " (ID: " + user.getId() + ")");
                        System.out.println("Requested Role: " + roleName + " (ID: " + newRoleId + ")");
                        System.out.println("Accept Link: " + acceptLink);
                        System.out.println("Reject Link: " + rejectLink);
                        System.out.println("Token: " + token);
                        System.out.println("Expires: " + expiresAt);
                        System.out.println("=========================================");
                        
                        EmailUtil.sendEmail(user.getEmail(), subject, body);
                        System.out.println("✅ Role assignment email sent successfully to: " + user.getEmail());
                        resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=role_assignment_sent");
                    } catch (Exception e) {
                        System.err.println("❌ Failed to send role assignment email to: " + user.getEmail());
                        System.err.println("Error details: " + e.getMessage());
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=email_send_failed");
                    }
                } else {
                    resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=role_assignment_failed");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/UserServlet?msg=error");
            }
        }

        private void handleConfirmRole(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                String token = req.getParameter("token");
                
                RoleAssignmentRequest request = roleAssignmentDAO.getByToken(token);
                if (request == null) {
                    req.setAttribute("message", "Liên kết không hợp lệ hoặc đã hết hạn.");
                    req.getRequestDispatcher("/views/sections/role-assignment-result.jsp").forward(req, resp);
                    return;
                }
                
                if (!"pending".equals(request.getStatus())) {
                    req.setAttribute("message", "Yêu cầu này đã được xử lý trước đó.");
                    req.getRequestDispatcher("/views/sections/role-assignment-result.jsp").forward(req, resp);
                    return;
                }
                
                // Update user's role
                User user = userDAO.getUserById(request.getUserId());
                if (user != null) {
                    user.setRoleId(request.getRequestedRoleId());
                    user.setStatus("active");
                    user.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
                    
                    if (userDAO.updateUser(user)) {
                        // Update request status
                        roleAssignmentDAO.updateRequestStatus(request.getId(), "accepted");
                        
                        req.setAttribute("message", "Bạn đã chấp nhận phân quyền thành công!");
                        req.setAttribute("success", true);
                    } else {
                        req.setAttribute("message", "Có lỗi xảy ra khi cập nhật quyền.");
                        req.setAttribute("success", false);
                    }
                } else {
                    req.setAttribute("message", "Không tìm thấy người dùng.");
                    req.setAttribute("success", false);
                }
                
                req.getRequestDispatcher("/views/sections/role-assignment-result.jsp").forward(req, resp);
                
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("message", "Có lỗi xảy ra.");
                req.setAttribute("success", false);
                req.getRequestDispatcher("/views/sections/role-assignment-result.jsp").forward(req, resp);
            }
        }

        private void handleRejectRole(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                String token = req.getParameter("token");
                
                RoleAssignmentRequest request = roleAssignmentDAO.getByToken(token);
                if (request == null) {
                    req.setAttribute("message", "Liên kết không hợp lệ hoặc đã hết hạn.");
                    req.getRequestDispatcher("/views/sections/role-assignment-result.jsp").forward(req, resp);
                    return;
                }
                
                if (!"pending".equals(request.getStatus())) {
                    req.setAttribute("message", "Yêu cầu này đã được xử lý trước đó.");
                    req.getRequestDispatcher("/views/sections/role-assignment-result.jsp").forward(req, resp);
                    return;
                }
                
                // Update request status to rejected
                roleAssignmentDAO.updateRequestStatus(request.getId(), "rejected");
                
                req.setAttribute("message", "Bạn đã từ chối phân quyền.");
                req.setAttribute("success", true);
                req.getRequestDispatcher("/views/sections/role-assignment-result.jsp").forward(req, resp);
                
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("message", "Có lỗi xảy ra.");
                req.setAttribute("success", false);
                req.getRequestDispatcher("/views/sections/role-assignment-result.jsp").forward(req, resp);
            }
        }

        private String getRoleName(int roleId) {
            switch (roleId) {
                case 1: return "Admin";
                default: return "Không xác định";
            }
        }

        private void handleTestEmail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                String testEmail = req.getParameter("email");
                String testType = req.getParameter("type"); // "verification" or "role_assignment"
                
                if (testEmail == null || testEmail.trim().isEmpty()) {
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write("{\"success\":false,\"message\":\"Email address is required\"}");
                    return;
                }
                
                String subject = "";
                String body = "";
                
                if ("verification".equals(testType)) {
                    // Test verification email
                    subject = "Test - Xác nhận tài khoản";
                    body = "Đây là email test cho chức năng xác nhận tài khoản.<br><br>" +
                           "Thời gian gửi: " + new java.util.Date() + "<br>" +
                           "Email nhận: " + testEmail + "<br><br>" +
                           "Nếu bạn nhận được email này, chức năng gửi email đang hoạt động bình thường.";
                } else if ("role_assignment".equals(testType)) {
                    // Test role assignment email with professional template
                    subject = "Test - 🔐 Yêu cầu phân quyền mới";
                    
                    // Create test links
                    String testAcceptLink = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() 
                            + req.getContextPath() + "/UserServlet?action=testAccept&token=test_token";
                    String testRejectLink = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() 
                            + req.getContextPath() + "/UserServlet?action=testReject&token=test_token";
                    
                    // Use the professional template for test
                    body = generateRoleAssignmentEmailTemplate("Người dùng Test", "Admin", testAcceptLink, testRejectLink, 
                            Timestamp.valueOf(LocalDateTime.now().plusDays(7)));
                    
                    // Add test indicator
                    body = body.replace("<div class='header'>", 
                            "<div class='header' style='background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);'>");
                    body = body.replace("🔐 Yêu cầu phân quyền mới", "🧪 TEST - Yêu cầu phân quyền mới");
                    body = body.replace("<div class='content'>", 
                            "<div class='content'><div style='background-color: #fff3cd; border: 1px solid #ffeaa7; border-radius: 5px; padding: 15px; margin-bottom: 20px; text-align: center;'><strong>🧪 Đây là email test - Không phải yêu cầu thật</strong></div>");
                } else {
                    // Default test email
                    subject = "Test - Hệ thống quản trị";
                    body = "Đây là email test từ hệ thống quản trị.<br><br>" +
                           "Thời gian gửi: " + new java.util.Date() + "<br>" +
                           "Email nhận: " + testEmail + "<br><br>" +
                           "Nếu bạn nhận được email này, chức năng gửi email đang hoạt động bình thường.";
                }
                
                // Send test email
                EmailUtil.sendEmail(testEmail, subject, body);
                
                // Return success response
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"success\":true,\"message\":\"Email test đã được gửi thành công đến " + testEmail + "\"}");
                
            } catch (Exception e) {
                e.printStackTrace();
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"success\":false,\"message\":\"Lỗi khi gửi email test: " + e.getMessage() + "\"}");
            }
        }

        private void handleTestEmailConfig(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                
                boolean configValid = EmailUtil.testConfiguration();
                
                if (configValid) {
                    resp.getWriter().write("{\"success\":true,\"message\":\"Email configuration is valid and working correctly\"}");
                } else {
                    resp.getWriter().write("{\"success\":false,\"message\":\"Email configuration test failed. Check server logs for details.\"}");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"success\":false,\"message\":\"Error testing email configuration: " + e.getMessage() + "\"}");
            }
        }

        private void handleGetEmailConfig(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                
                // Return current email configuration (without sensitive data)
                StringBuilder json = new StringBuilder();
                json.append("{");
                json.append("\"success\":true,");
                json.append("\"config\":{");
                json.append("\"smtpHost\":\"smtp.gmail.com\",");
                json.append("\"smtpPort\":587,");
                json.append("\"smtpUsername\":\"").append(EmailUtil.getSmtpUsername()).append("\",");
                json.append("\"smtpPasswordConfigured\":").append(EmailUtil.isPasswordConfigured()).append(",");
                json.append("\"configurationValid\":").append(EmailUtil.testConfiguration()).append(",");
                json.append("\"configFilePath\":\"").append(EmailUtil.getConfigFilePath()).append("\"");
                json.append("}");
                json.append("}");
                
                resp.getWriter().write(json.toString());
                
            } catch (Exception e) {
                e.printStackTrace();
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"success\":false,\"message\":\"Error retrieving email configuration: " + e.getMessage() + "\"}");
            }
        }

        private void handleUpdateEmailConfig(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                String smtpUsername = req.getParameter("smtpUsername");
                String smtpPassword = req.getParameter("smtpPassword");
                
                if (smtpUsername == null || smtpUsername.trim().isEmpty()) {
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write("{\"success\":false,\"message\":\"SMTP username is required\"}");
                    return;
                }
                
                // Update email configuration
                boolean updated = EmailUtil.updateConfiguration(smtpUsername, smtpPassword);
                
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                
                if (updated) {
                    resp.getWriter().write("{\"success\":true,\"message\":\"Email configuration updated successfully\"}");
                } else {
                    resp.getWriter().write("{\"success\":false,\"message\":\"Failed to update email configuration\"}");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"success\":false,\"message\":\"Error updating email configuration: " + e.getMessage() + "\"}");
            }
        }

        private void handleReloadEmailConfig(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                
                // Reload configuration from file
                EmailUtil.reloadConfiguration();
                
                resp.getWriter().write("{\"success\":true,\"message\":\"Email configuration reloaded successfully\"}");
                
            } catch (Exception e) {
                e.printStackTrace();
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"success\":false,\"message\":\"Error reloading email configuration: " + e.getMessage() + "\"}");
            }
        }

        private String generateRoleAssignmentEmailTemplate(String userFullName, String roleName, String acceptLink, String rejectLink, Timestamp expiresAt) {
            String expiryDate = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(expiresAt);
            
            return "<!DOCTYPE html>" +
                   "<html lang='vi'>" +
                   "<head>" +
                   "    <meta charset='UTF-8'>" +
                   "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
                   "    <title>Yêu cầu phân quyền mới</title>" +
                   "    <style>" +
                   "        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; background-color: #f4f4f4; }" +
                   "        .container { max-width: 600px; margin: 0 auto; background-color: #ffffff; }" +
                   "        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center; }" +
                   "        .header h1 { margin: 0; font-size: 24px; font-weight: 300; }" +
                   "        .content { padding: 40px 30px; }" +
                   "        .greeting { font-size: 18px; margin-bottom: 20px; color: #2c3e50; }" +
                   "        .role-info { background-color: #f8f9fa; border-left: 4px solid #667eea; padding: 20px; margin: 25px 0; border-radius: 0 5px 5px 0; }" +
                   "        .role-name { font-size: 20px; font-weight: bold; color: #667eea; margin-bottom: 10px; }" +
                   "        .role-description { color: #6c757d; font-size: 14px; }" +
                   "        .action-buttons { text-align: center; margin: 35px 0; }" +
                   "        .btn { display: inline-block; padding: 12px 30px; margin: 0 10px; text-decoration: none; border-radius: 25px; font-weight: 500; font-size: 16px; transition: all 0.3s ease; }" +
                   "        .btn-accept { background-color: #28a745; color: white; }" +
                   "        .btn-accept:hover { background-color: #218838; transform: translateY(-2px); box-shadow: 0 4px 8px rgba(40, 167, 69, 0.3); }" +
                   "        .btn-reject { background-color: #dc3545; color: white; }" +
                   "        .btn-reject:hover { background-color: #c82333; transform: translateY(-2px); box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3); }" +
                   "        .info-box { background-color: #e3f2fd; border: 1px solid #bbdefb; border-radius: 5px; padding: 15px; margin: 25px 0; }" +
                   "        .info-box h4 { margin: 0 0 10px 0; color: #1976d2; font-size: 16px; }" +
                   "        .info-box p { margin: 0; color: #424242; font-size: 14px; }" +
                   "        .footer { background-color: #f8f9fa; padding: 20px; text-align: center; border-top: 1px solid #dee2e6; }" +
                   "        .footer p { margin: 0; color: #6c757d; font-size: 12px; }" +
                   "        .expiry-warning { background-color: #fff3cd; border: 1px solid #ffeaa7; border-radius: 5px; padding: 15px; margin: 25px 0; }" +
                   "        .expiry-warning h4 { margin: 0 0 10px 0; color: #856404; font-size: 16px; }" +
                   "        .expiry-warning p { margin: 0; color: #856404; font-size: 14px; }" +
                   "        @media only screen and (max-width: 600px) {" +
                   "            .container { width: 100% !important; }" +
                   "            .content { padding: 20px 15px !important; }" +
                   "            .header { padding: 20px 15px !important; }" +
                   "            .btn { display: block !important; margin: 10px 0 !important; }" +
                   "        }" +
                   "    </style>" +
                   "</head>" +
                   "<body>" +
                   "    <div class='container'>" +
                   "        <div class='header'>" +
                   "            <h1>🔐 Yêu cầu phân quyền mới</h1>" +
                   "        </div>" +
                   "        <div class='content'>" +
                   "            <div class='greeting'>" +
                   "                Xin chào <strong>" + userFullName + "</strong>," +
                   "            </div>" +
                   "            <p>Admin đã gửi yêu cầu phân quyền mới cho tài khoản của bạn. Vui lòng xem xét thông tin bên dưới và đưa ra quyết định.</p>" +
                   "            <div class='role-info'>" +
                   "                <div class='role-name'>Quyền được yêu cầu: " + roleName + "</div>" +
                   "                <div class='role-description'>" + getRoleDescription(roleName) + "</div>" +
                   "            </div>" +
                   "            <div class='info-box'>" +
                   "                <h4>📋 Thông tin quan trọng</h4>" +
                   "                <p>• Yêu cầu này sẽ được xử lý ngay khi bạn xác nhận hoặc từ chối</p>" +
                   "                <p>• Việc thay đổi quyền có thể ảnh hưởng đến khả năng truy cập các tính năng của hệ thống</p>" +
                   "                <p>• Bạn có thể liên hệ admin nếu có thắc mắc về quyền mới</p>" +
                   "            </div>" +
                   "            <div class='action-buttons'>" +
                   "                <a href='" + acceptLink + "' class='btn btn-accept'>✅ Chấp nhận</a>" +
                   "                <a href='" + rejectLink + "' class='btn btn-reject'>❌ Từ chối</a>" +
                   "            </div>" +
                   "            <div class='expiry-warning'>" +
                   "                <h4>⏰ Lưu ý về thời hạn</h4>" +
                   "                <p>Liên kết này sẽ hết hạn vào: <strong>" + expiryDate + "</strong></p>" +
                   "                <p>Vui lòng thực hiện hành động trước thời hạn để tránh yêu cầu bị hủy bỏ.</p>" +
                   "            </div>" +
                   "        </div>" +
                   "        <div class='footer'>" +
                   "            <p>Email này được gửi tự động từ hệ thống quản trị</p>" +
                   "            <p>Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email này</p>" +
                   "        </div>" +
                   "    </div>" +
                   "</body>" +
                   "</html>";
        }
        
        private String getRoleDescription(String roleName) {
            switch (roleName) {
                case "Admin":
                    return "Quyền quản trị cao nhất với khả năng quản lý toàn bộ hệ thống, người dùng, cấu hình và tất cả tính năng quản trị.";
                default:
                    return "Quyền được cấu hình đặc biệt cho tài khoản của bạn.";
            }
        }
    }
