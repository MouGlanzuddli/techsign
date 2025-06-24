package controller;

import dal.DBContext;
import dal.EmailOtpDao;
import dal.UserDao;
import model.EmailOtp;
import model.User;
import util.EmailService;
import util.OtpGenerator;
import util.DeviceInfoUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

@WebServlet(name = "SendOtpServlet", urlPatterns = {"/SendOtpServlet"})
public class SendOtpServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String actionType = request.getParameter("action_type");
        
        if (actionType == null || actionType.trim().isEmpty()) {
            actionType = "EMAIL_VERIFICATION"; // Default action type
        }
        
        if (email == null || email.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Email không được để trống\"}");
            return;
        }
        
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            UserDao userDao = new UserDao(conn);
            EmailOtpDao otpDao = new EmailOtpDao(conn);
        
            // Kiểm tra email có tồn tại trong hệ thống không
            if (!userDao.checkEmailExists(email)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Email không tồn tại trong hệ thống\"}");
                return;
            }
        
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
        
            // Tạo OTP mới
            String otpCode = OtpGenerator.generateSixDigitOtp();
            Date now = new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(now);
            cal.add(Calendar.MINUTE, 10); // OTP có hiệu lực 10 phút
            Date expiresAt = cal.getTime();
        
            // Lấy thông tin device và IP
            String ipAddress = DeviceInfoUtil.getClientIpAddress(request);
            String deviceInfo = DeviceInfoUtil.getDeviceInfo(request);
        
            EmailOtp otp = new EmailOtp(user.getId(), otpCode, actionType, expiresAt, ipAddress, deviceInfo);
        
            // Lưu OTP vào database
            boolean otpSaved = otpDao.insertOtp(otp);
        
            if (otpSaved) {
                // Gửi email
                boolean emailSent = EmailService.sendOtpEmail(email, otpCode);
            
                if (emailSent) {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": true, \"message\": \"Mã OTP đã được gửi đến email của bạn\"}");
                } else {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": false, \"message\": \"Không thể gửi email. Vui lòng thử lại\"}");
                }
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Lỗi hệ thống. Vui lòng thử lại\"}");
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