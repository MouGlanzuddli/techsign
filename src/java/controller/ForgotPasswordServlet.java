package controller;

import dal.DBContext;
import dal.EmailOtpDao;
import dal.UserDao;
import model.EmailOtp;
import model.User;
import util.EmailService;
import util.OtpGenerator;
import util.DeviceInfoUtil;
import util.EmailServiceExtended;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/ForgotPasswordServlet"})
public class ForgotPasswordServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String step = request.getParameter("step");
        
        if ("verify".equals(step)) {
            // Hiển thị trang nhập OTP
            request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
        } else {
            // Hiển thị trang nhập email
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("send_otp".equals(action)) {
            sendOtpForPasswordReset(request, response);
        } else if ("verify_otp".equals(action)) {
            verifyOtpAndResetPassword(request, response);
        }
    }
    
    private void sendOtpForPasswordReset(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }
        
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            UserDao userDao = new UserDao(conn);
            EmailOtpDao otpDao = new EmailOtpDao(conn);
            
            // Kiểm tra email có tồn tại không
            if (!userDao.checkEmailExists(email)) {
                request.setAttribute("error", "Email không tồn tại trong hệ thống");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }
            
            // Lấy thông tin user
            User user = userDao.getUserByEmail(email);
            if (user == null) {
                request.setAttribute("error", "Không tìm thấy thông tin người dùng");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }
            
            // Kiểm tra số lần thử
            int attemptCount = otpDao.getAttemptCount(user.getId(), "PASSWORD_RESET");
            if (attemptCount >= 5) {
                request.setAttribute("error", "Bạn đã thử quá nhiều lần. Vui lòng thử lại sau 1 giờ");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
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
            String ipAddress = getClientIpAddress(request);
            String deviceInfo = getDeviceInfo(request);
            
            EmailOtp otp = new EmailOtp(user.getId(), otpCode, "PASSWORD_RESET", expiresAt, ipAddress, deviceInfo);
            
            // Lưu OTP vào database
            boolean otpSaved = otpDao.insertOtp(otp);
            
            if (otpSaved) {
                // Gửi email
                boolean emailSent = EmailServiceExtended.sendPasswordResetOtpEmail(email, otpCode, user.getFullName());
                
                if (emailSent) {
                    // Lưu email vào session để sử dụng ở bước tiếp theo
                    HttpSession session = request.getSession();
                    session.setAttribute("reset_email", email);
                    session.setAttribute("reset_user_id", user.getId());
                    
                    request.setAttribute("success", "Mã OTP đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư.");
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại");
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Lỗi hệ thống. Vui lòng thử lại");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
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
    
    private void verifyOtpAndResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("reset_email");
        Integer userId = (Integer) session.getAttribute("reset_user_id");
        
        if (email == null || userId == null) {
            response.sendRedirect(request.getContextPath() + "/ForgotPasswordServlet");
            return;
        }
        
        String otpCode = request.getParameter("otp_code");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");
        
        // Validate input
        if (otpCode == null || otpCode.trim().isEmpty()) {
            request.setAttribute("error", "Mã OTP không được để trống");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
            return;
        }
        
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "Mật khẩu mới không được để trống");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
            return;
        }
        
        if (newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
            return;
        }
        
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            EmailOtpDao otpDao = new EmailOtpDao(conn);
            UserDao userDao = new UserDao(conn);
            
            // Xác thực OTP
            boolean otpValid = otpDao.verifyOtp(userId, otpCode, "PASSWORD_RESET");
            
            if (otpValid) {
                // Cập nhật mật khẩu mới
                User user = userDao.getUserById(userId);
                if (user != null) {
                    // Hash mật khẩu mới
                    String hashedPassword = org.mindrot.jbcrypt.BCrypt.hashpw(newPassword, org.mindrot.jbcrypt.BCrypt.gensalt());
                    user.setPasswordHash(hashedPassword);
                    user.setUpdatedAt(new Date());
                    
                    boolean passwordUpdated = userDao.updateUser(user);
                    
                    if (passwordUpdated) {
                        // Xóa session
                        session.removeAttribute("reset_email");
                        session.removeAttribute("reset_user_id");
                        
                        request.setAttribute("success", "Mật khẩu đã được đặt lại thành công. Bạn có thể đăng nhập với mật khẩu mới.");
                        request.getRequestDispatcher("/index.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Không thể cập nhật mật khẩu. Vui lòng thử lại");
                        request.setAttribute("email", email);
                        request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Không tìm thấy thông tin người dùng");
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
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
    
    private String getClientIpAddress(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }
    
    private String getDeviceInfo(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        return userAgent != null ? userAgent : "Unknown Device";
    }
}
