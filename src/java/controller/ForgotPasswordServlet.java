package controller;

import dal.DBContext;
import dal.EmailOtpDao;
import dal.UserDao;
import model.EmailOtp;
import model.User;
import util.EmailServiceExtended;
import util.OtpGenerator;

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
            request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "send_otp":
                sendOtpForPasswordReset(request, response);
                break;
            case "verify_otp":
                verifyOtpAndResetPassword(request, response);
                break;
            case "resend_otp":
                resendOtp(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
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

        try (Connection conn = new DBContext().getConnection()) {
            UserDao userDao = new UserDao(conn);
            EmailOtpDao otpDao = new EmailOtpDao(conn);

            if (!userDao.checkEmailExists(email)) {
                request.setAttribute("error", "Email không tồn tại trong hệ thống");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

            User user = userDao.getUserByEmail(email);
            if (user == null) {
                request.setAttribute("error", "Không tìm thấy thông tin người dùng");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

            if (otpDao.getAttemptCount(user.getId(), "PASSWORD_RESET") >= 5) {
                request.setAttribute("error", "Bạn đã thử quá nhiều lần. Vui lòng thử lại sau 1 giờ");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

            String otpCode = OtpGenerator.generateSixDigitOtp();
            Date expiresAt = getOtpExpiryDate();

            HttpSession session = request.getSession();
            session.setAttribute("otp_expires_at", expiresAt);

            String ip = getClientIpAddress(request);
            String device = getDeviceInfo(request);

            EmailOtp otp = new EmailOtp(user.getId(), otpCode, "PASSWORD_RESET", expiresAt, ip, device);
            if (otpDao.insertOtp(otp)) {
                if (EmailServiceExtended.sendPasswordResetOtpEmail(email, otpCode, user.getFullName())) {
                    session.setAttribute("reset_email", email);
                    session.setAttribute("reset_user_id", user.getId());

                    request.setAttribute("success", "Mã OTP đã được gửi đến email của bạn.");
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại.");
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Không thể tạo mã OTP. Vui lòng thử lại.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }

    private void resendOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("reset_email");
        Integer userId = (Integer) session.getAttribute("reset_user_id");

        if (email == null || userId == null) {
            response.sendRedirect(request.getContextPath() + "/ForgotPasswordServlet");
            return;
        }

        try (Connection conn = new DBContext().getConnection()) {
            UserDao userDao = new UserDao(conn);
            EmailOtpDao otpDao = new EmailOtpDao(conn);

            User user = userDao.getUserById(userId);
            if (user == null) {
                request.setAttribute("error", "Không tìm thấy thông tin người dùng");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

          

            String otpCode = OtpGenerator.generateSixDigitOtp();
            Date expiresAt = getOtpExpiryDate();
            session.setAttribute("otp_expires_at", expiresAt);

            String ip = getClientIpAddress(request);
            String device = getDeviceInfo(request);

            EmailOtp otp = new EmailOtp(userId, otpCode, "PASSWORD_RESET", expiresAt, ip, device);

            if (otpDao.insertOtp(otp)) {
                if (EmailServiceExtended.sendPasswordResetOtpEmail(email, otpCode, user.getFullName())) {
                    request.setAttribute("success", "Mã OTP mới đã được gửi đến email.");
                    request.setAttribute("email", email);
                } else {
                    request.setAttribute("error", "Không thể gửi email.");
                    request.setAttribute("email", email);
                }
            } else {
                request.setAttribute("error", "Không thể tạo mã OTP.");
                request.setAttribute("email", email);
            }

            request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
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

        if (otpCode == null || otpCode.isBlank()) {
            sendErrorBack("Mã OTP không được để trống", email, request, response);
            return;
        }

        if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
            sendErrorBack("Mật khẩu xác nhận không khớp hoặc rỗng", email, request, response);
            return;
        }

        if (newPassword.length() < 8 || newPassword.length() > 50) {
            sendErrorBack("Mật khẩu phải từ 8 đến 50 ký tự", email, request, response);
            return;
        }

        boolean hasUpper = !newPassword.equals(newPassword.toLowerCase());
        boolean hasLower = !newPassword.equals(newPassword.toUpperCase());
        boolean hasDigit = newPassword.matches(".*\\d.*");
        boolean hasSpecial = newPassword.matches(".*[!@#$%^&*()_+\\-\\[\\]{};':\"\\\\|,.<>/?].*");

        if (!(hasUpper && hasLower && hasDigit && hasSpecial)) {
            sendErrorBack("Mật khẩu phải chứa ít nhất 1 chữ hoa, 1 chữ thường, 1 số, 1 ký tự đặc biệt", email, request, response);
            return;
        }

        if (!email.matches("[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,}")) {
            sendErrorBack("Địa chỉ email không hợp lệ", email, request, response);
            return;
        }

        try (Connection conn = new DBContext().getConnection()) {
            EmailOtpDao otpDao = new EmailOtpDao(conn);
            UserDao userDao = new UserDao(conn);

            if (otpDao.verifyOtp(userId, otpCode, "PASSWORD_RESET")) {
                User user = userDao.getUserById(userId);
                if (user != null) {
                    String hashed = org.mindrot.jbcrypt.BCrypt.hashpw(newPassword, org.mindrot.jbcrypt.BCrypt.gensalt());
                    user.setPasswordHash(hashed);
                    user.setUpdatedAt(new Date());

                    if (userDao.updateUser(user)) {
                        session.removeAttribute("reset_email");
                        session.removeAttribute("reset_user_id");
                        request.setAttribute("success", "Mật khẩu đã được đặt lại thành công.");
                        request.getRequestDispatcher("/index.jsp").forward(request, response);
                    } else {
                        sendErrorBack("Không thể cập nhật mật khẩu.", email, request, response);
                    }
                } else {
                    sendErrorBack("Không tìm thấy người dùng.", email, request, response);
                }
            } else {
                sendErrorBack("Mã OTP không hợp lệ hoặc đã hết hạn.", email, request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            sendErrorBack("Lỗi cơ sở dữ liệu.", email, request, response);
        }
    }

    private void sendErrorBack(String message, String email, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.setAttribute("email", email);
        request.getRequestDispatcher("/forgot-password-verify.jsp").forward(request, response);
    }

    private Date getOtpExpiryDate() {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MINUTE, 30);
        return cal.getTime();
    }

    private String getClientIpAddress(HttpServletRequest request) {
        String xForwarded = request.getHeader("X-Forwarded-For");
        return (xForwarded != null && !xForwarded.isBlank()) ? xForwarded.split(",")[0].trim() : request.getRemoteAddr();
    }

    private String getDeviceInfo(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        return userAgent != null ? userAgent : "Unknown Device";
    }
}
