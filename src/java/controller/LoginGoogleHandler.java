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
import dao.CompanyDAO;
import model.Company;

import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import java.sql.Connection;


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
            response.sendRedirect("index.jsp?error=google_login_failed");
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
            HttpSession session = request.getSession();

            if (!emailExists) {
                // Nếu chưa có tài khoản thì tạo mới với role mặc định
                user = new User();
                user.setRoleId(2); // Mặc định là Candidate, sẽ được cập nhật sau khi chọn role
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

                System.out.println("=== DEBUG LoginGoogleHandler ===");
                System.out.println("Creating new user: " + user.getEmail());
                
                boolean inserted = userDao.insertUser(user);
                System.out.println("Insert result: " + inserted);
                
                if (inserted) {
                    // Lấy lại user sau khi insert để có ID
                    user = userDao.getUserByEmail(googleUser.getEmail());
                    System.out.println("Retrieved user after insert - ID: " + (user != null ? user.getId() : "null"));
                    
                    if (user != null && user.getId() > 0) {
                        // Lưu user tạm thời vào session và chuyển đến trang chọn role
                        session.setAttribute("tempUser", user);
                        response.sendRedirect("roleSelection.jsp");
                    } else {
                        System.out.println("ERROR: Failed to retrieve user after insert");
                        response.sendRedirect("index.jsp?error=user_creation_failed");
                    }
                } else {
                    System.out.println("ERROR: Failed to insert user");
                    response.sendRedirect("index.jsp?error=user_creation_failed");
                }
            } else {
                // Nếu đã tồn tại, lấy user theo email
                user = userDao.getUserByEmail(googleUser.getEmail());
                
                // Lưu user vào session
                session.setAttribute("user", user);

                // Chuyển hướng theo vai trò hiện tại
                switch (user.getRoleId()) {
                    case 1:
                        response.sendRedirect("adminHome.jsp");
                        break;
                    case 2:
                        response.sendRedirect("CandidateHome");
                        break;
                    case 3: {
                        CompanyDAO companyDAO = new CompanyDAO(conn);
                        Company company = companyDAO.getCompanyByUserId(user.getId());
                        if (company == null || !isCompanyProfileComplete(company)) {
                            response.sendRedirect("company-dashboard.jsp?requireCompleteProfile=true");
                        } else {
                            response.sendRedirect("company-dashboard.jsp");
                        }
                        break;
                    }
                    default:
                        response.sendRedirect("index.jsp?error=invalid_role");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=internal_error");
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

    private boolean isCompanyProfileComplete(Company company) {
        return company != null
            && company.getCompanyName() != null && !company.getCompanyName().trim().isEmpty()
            && company.getIndustryId() != null
            && company.getAddress() != null && !company.getAddress().trim().isEmpty()
            && company.getDescription() != null && !company.getDescription().trim().isEmpty()
            && company.getWebsite() != null && !company.getWebsite().trim().isEmpty();
    }
} // END OF CLASS