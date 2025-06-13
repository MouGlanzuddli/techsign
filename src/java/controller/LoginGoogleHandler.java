/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.DBContext;
import dal.UserDao;
import java.util.Date;
import model.User;

import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * @author Admin
 */
@WebServlet(name="LoginGoogleHandler", urlPatterns={"/LoginGoogleHandler"})
public class LoginGoogleHandler extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp?error=google_login_failed");
            return;
        }

        try {
            // Lấy access token
            String accessToken = getToken(code);

            // Lấy thông tin người dùng từ Google
            UserGoogleDto googleUser = getUserInfo(accessToken);

            // Mở kết nối đến database
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            UserDao userDao = new UserDao(conn);

            // Kiểm tra email đã tồn tại chưa
            boolean emailExists = userDao.checkEmailExists(googleUser.getEmail());

            User user;

            if (!emailExists) {
                // Nếu chưa có tài khoản thì tạo mới
                user = new User();
                user.setRoleId(2); // Mặc định là Candidate (hoặc 1 tùy hệ thống)
                user.setEmail(googleUser.getEmail());
                user.setPhone(""); // Google không trả số điện thoại
                user.setPasswordHash(""); // Vì đăng nhập Google, không cần password
                user.setFullName(googleUser.getName());
                user.setEmailVerified(true);
                user.setPhoneVerified(false);
                user.setAvatarUrl(googleUser.getPicture());
                user.setStatus("active");
                Date now = new Date();
                user.setCreatedAt(now);
                user.setUpdatedAt(now);

                userDao.insertUser(user);

                // Lấy lại user sau khi insert để có ID
                user = userDao.login(googleUser.getEmail(), "");
            } else {
                // Nếu đã tồn tại, lấy user theo email
                user = userDao.getUserByEmail(googleUser.getEmail());
 // Login không cần password cho Google
            }

            // Lưu user vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Chuyển hướng đến trang chính
            response.sendRedirect("candidateHome.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("loginGG.jsp?error=internal_error");
        }
    }

    private String getToken(String code) throws IOException {
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("code", code)
                        .add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI)
                        .add("grant_type", "authorization_code")
                        .build())
                .execute().returnContent().asString();

        JsonObject jsonObject = new Gson().fromJson(response, JsonObject.class);
        return jsonObject.get("access_token").getAsString();
    }

    private UserGoogleDto getUserInfo(String accessToken) throws IOException {
        String response = Request.Get(Constants.GOOGLE_LINK_GET_USER_INFO)
                .addHeader("Authorization", "Bearer " + accessToken)
                .execute().returnContent().asString();

        return new Gson().fromJson(response, UserGoogleDto.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
} // END OF CLASS
