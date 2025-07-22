package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import dal.DBContext;
import dal.UserDao;
import dal.CompanyDao;
import model.User;
import model.Company;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SignupServlet.class.getName());

    private static final int COMPANY_ROLE_ID = 3;
    private static final int CANDIDATE_ROLE_ID = 2;

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
        user.setFullName(fullname);
        user.setEmail(email);
        user.setPasswordHash(hashedPassword);
        user.setRoleId(roleId);
        user.setPhone("");
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
            CompanyDao companyDao = new CompanyDao(conn);

            if (userDao.checkEmailExists(email)) {
                request.setAttribute("registerError", "Email already registered.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            boolean userInsertSuccess = userDao.insertUser(user);

            if (userInsertSuccess) {
                if (user.getRoleId() == COMPANY_ROLE_ID) {
                    Company company = new Company();
                    company.setUserId(user.getId());
                    company.setCompanyName(fullname);
                    company.setWebsite("");
                    company.setDescription("");
                    company.setAddress("");
                    company.setPhone("");
                    company.setLogoUrl(null);
                    company.setBannerUrl(null);
                    company.setIconUrl(null);
                    company.setFeatured(false);
                    company.setSearchable(true);
                    company.setCreatedAt(now);
                    company.setUpdatedAt(now);
                    company.setIndustryId(0);

                    boolean companyInsertSuccess = companyDao.insertCompany(company);
                    if (!companyInsertSuccess) {
                        LOGGER.log(Level.WARNING, "Failed to create company profile for user: {0}", user.getEmail());
                        request.setAttribute("registerError", "Account created, but failed to create company profile. Please contact support.");
                        request.getRequestDispatcher("signup.jsp").forward(request, response);
                        return;
                    }

                } else if (user.getRoleId() == CANDIDATE_ROLE_ID) {
                    // ✅ Tạo hồ sơ ứng viên mặc định
                    String sql = "INSERT INTO candidate_profiles (user_id, headline, summary, experience_years, education_level) VALUES (?, '', '', 0, '')";
                    try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setInt(1, user.getId());
                        ps.executeUpdate();
                    } catch (SQLException ex) {
                        LOGGER.log(Level.WARNING, "Failed to create candidate profile for user: {0}", user.getEmail());
                        request.setAttribute("registerError", "Account created, but failed to create candidate profile. Please contact support.");
                        request.getRequestDispatcher("signup.jsp").forward(request, response);
                        return;
                    }
                }

                response.sendRedirect("index.jsp?message=registrationSuccess");

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
