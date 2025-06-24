package controller;

import dal.DBContext;
import dal.EmailOtpDao;
import dal.UserDao;
import model.User;
import model.EmailOtp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "VerifyOtpServlet", urlPatterns = {"/VerifyOtpServlet"})
public class VerifyOtpServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String otpCode = request.getParameter("otp");
        String actionType = request.getParameter("action_type");
        
        if (actionType == null || actionType.trim().isEmpty()) {
            actionType = "EMAIL_VERIFICATION"; // Default action type
        }
        
        if (email == null || email.trim().isEmpty() || otpCode == null || otpCode.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng nhập đầy đủ thông tin\"}");
            return;
        }
        
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            EmailOtpDao otpDao = new EmailOtpDao(conn);
            UserDao userDao = new UserDao(conn);
            
            // Lấy thông tin user
            User user = userDao.getUserByEmail(email);
            if (user == null) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không tìm thấy thông tin người dùng\"}");
                return;
            }
            
            // Kiểm tra số lần thử
            int attemptCount = otpDao.getAttemptCount(user.getId(), actionType);
            if (attemptCount >= 5) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Bạn đã thử quá nhiều lần. Vui lòng thử lại sau 1 giờ\"}");
                return;
            }
            
            // Lấy OTP mới nhất
            EmailOtp latestOtp = otpDao.getLatestOtpByUserAndAction(user.getId(), actionType);
            if (latestOtp != null && !latestOtp.getOtpCode().equals(otpCode)) {
                // Tăng số lần thử nếu OTP sai
                otpDao.incrementAttempts(latestOtp.getId());
            }
            
            // Xác thực OTP
            boolean isValidOtp = otpDao.verifyOtp(user.getId(), otpCode, actionType);
            
            if (isValidOtp) {
                // Cập nhật trạng thái email đã xác thực cho user
                user.setEmailVerified(true);
                userDao.updateUser(user);
                
                // Lưu thông tin user vào session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("emailVerified", true);
                
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Xác thực email thành công!\"}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Mã OTP không hợp lệ hoặc đã hết hạn\"}");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi cơ sở dữ liệu\"}");
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}