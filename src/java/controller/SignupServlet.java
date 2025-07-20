package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import dal.DBContext;
import dal.UserDao;
import dal.CompanyDao; // Import CompanyDao
import model.User;
import model.Company; // Import Company model
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SignupServlet.class.getName());
    // Giả định roleId = 2 là vai trò cho tài khoản công ty.
    // Vui lòng điều chỉnh giá trị này nếu schema cơ sở dữ liệu của bạn sử dụng ID khác.
    private static final int COMPANY_ROLE_ID = 3; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        // Đã loại bỏ useridStr vì ID người dùng nên được cơ sở dữ liệu tự động tạo
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String roleStr = request.getParameter("role");

        int roleId;

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

        User user = new User();
        // Không đặt ID ở đây, ID sẽ được DB tạo và gán lại bởi UserDao
        user.setFullName(fullname);
        user.setEmail(email);
        user.setPasswordHash(hashedPassword);
        user.setRoleId(roleId);
        user.setPhone(""); // Có thể thêm input cho số điện thoại nếu cần
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
            CompanyDao companyDao = new CompanyDao(conn); // Khởi tạo CompanyDao

            // Kiểm tra xem email đã tồn tại chưa
            if (userDao.checkEmailExists(email)) { // Sử dụng checkEmailExists từ UserDao của bạn
                request.setAttribute("registerError", "Email already registered.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            // Chèn người dùng vào DB. user.getId() sẽ được điền sau khi chèn thành công.
            boolean userInsertSuccess = userDao.insertUser(user); 

            if (userInsertSuccess) {
                // Nếu người dùng đăng ký là công ty, tạo hồ sơ công ty tương ứng
                if (user.getRoleId() == COMPANY_ROLE_ID) { 
                    Company company = new Company();
                    company.setUserId(user.getId()); // Liên kết với ID của người dùng vừa tạo
                    company.setCompanyName(fullname); // Sử dụng tên đầy đủ làm tên công ty (có thể thêm input riêng)
                    company.setWebsite(""); // Giá trị mặc định hoặc thêm input vào signup.jsp
                    company.setDescription(""); // Giá trị mặc định hoặc thêm input vào signup.jsp
                    company.setAddress(""); // Giá trị mặc định hoặc thêm input vào signup.jsp
                    company.setPhone(""); // Giá trị mặc định hoặc thêm input vào signup.jsp
                    company.setLogoUrl(null);
                    company.setBannerUrl(null);
                    company.setIconUrl(null);
                    company.setFeatured(false);
                    company.setSearchable(true); // Đặt là true để công ty hiển thị trên trang danh sách
                    company.setCreatedAt(now);
                    company.setUpdatedAt(now);
                    company.setIndustryId(0); // Giá trị mặc định hoặc thêm input vào signup.jsp, hoặc đặt null nếu DB cho phép

                    boolean companyInsertSuccess = companyDao.insertCompany(company);
                    if (!companyInsertSuccess) {
                        LOGGER.log(Level.WARNING, "Failed to create company profile for user: {0}", user.getEmail());
                        // Tùy chọn: Nếu tạo hồ sơ công ty thất bại, có thể xóa người dùng đã tạo để duy trì tính toàn vẹn dữ liệu
                        // userDao.deleteUser(user.getId()); 
                        request.setAttribute("registerError", "Account created, but failed to create company profile. Please contact support.");
                        request.getRequestDispatcher("signup.jsp").forward(request, response);
                        return;
                    }
                }
                response.sendRedirect("index.jsp?message=registrationSuccess"); // Chuyển hướng về trang chủ với thông báo thành công
            } else {
                request.setAttribute("registerError", "Failed to create account. Please try again.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error during signup", e);
            request.setAttribute("registerError", "Database error: " + e.getMessage());
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) conn.close();
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "Error closing connection", ex);
            }
        }
    }
}
