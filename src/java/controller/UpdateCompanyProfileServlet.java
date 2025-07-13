package controller;

import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "UpdateCompanyProfile", urlPatterns = {"/UpdateCompanyProfile"})
public class UpdateCompanyProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Kiểm tra đăng nhập & phân quyền
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 3) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();

        // 2. Nhận dữ liệu từ form
        String companyName = request.getParameter("companyName");
        String website = request.getParameter("website");
        String address = request.getParameter("address");
        String description = request.getParameter("description");
        String industryIdStr = request.getParameter("industryId");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        Integer industryId = null;
        try {
            industryId = industryIdStr != null && !industryIdStr.isEmpty() ? Integer.parseInt(industryIdStr) : null;
        } catch (NumberFormatException e) {
            industryId = null;
        }
        // 3. Validate input (all error messages in English)
        String errorMsg = null;
        if (companyName == null || companyName.trim().isEmpty()) errorMsg = "Company name must not be empty!";
        else if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) errorMsg = "Invalid email format!";
        else if (phone == null || !phone.matches("^0\\d{9}$")) errorMsg = "Phone number must be 10 digits, start with 0, and contain only numbers!";
        else if (website == null || !website.matches("^(http:\\/\\/|https:\\/\\/)?[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}.*$")) errorMsg = "Invalid website format!";
        else if (industryId == null) errorMsg = "Please select a company category!";
        else if (address == null || address.trim().length() < 5) errorMsg = "Address is not valid!";
        else if (!companyName.matches("^[a-zA-Z0-9\\sÀ-ỹ.,'-]+$")) errorMsg = "Company name must not contain special characters!";
        // 4. Xử lý ảnh đại diện (nếu có)
        String avatarUrl = null;
        try {
            if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
                jakarta.servlet.http.Part avatarPart = request.getPart("avatar");
                if (avatarPart != null && avatarPart.getSize() > 0) {
                    String fileName = java.nio.file.Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
                    String ext = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
                    if (!ext.equals(".jpg") && !ext.equals(".jpeg") && !ext.equals(".png")) {
                        errorMsg = "Chỉ chấp nhận ảnh jpg, jpeg, png!";
                    } else if (avatarPart.getSize() > 2 * 1024 * 1024) {
                        errorMsg = "Ảnh không được lớn hơn 2MB!";
                    } else {
                        String newFileName = "avatar_" + userId + "_" + System.currentTimeMillis() + ext;
                        String uploadPath = getServletContext().getRealPath("/uploads/avatars/");
                        java.io.File uploadDir = new java.io.File(uploadPath);
                        if (!uploadDir.exists()) uploadDir.mkdirs();
                        avatarPart.write(uploadPath + java.io.File.separator + newFileName);
                        avatarUrl = "uploads/avatars/" + newFileName;
                    }
                }
            }
        } catch (Exception ex) {
            errorMsg = "Lỗi upload ảnh: " + ex.getMessage();
        }
        // Nếu có lỗi, trả về form với thông báo lỗi
        if (errorMsg != null) {
            // Nếu có lỗi, vẫn set lại các attribute để JSP hiển thị đúng dữ liệu đã nhập
            request.setAttribute("companyName", companyName);
            request.setAttribute("website", website);
            request.setAttribute("address", address);
            request.setAttribute("industryId", industryId);
            request.setAttribute("description", description);
            request.setAttribute("avatarUrl", avatarUrl != null ? avatarUrl : "assets/img/default-avatar.png");
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("phoneTop", user.getPhone());
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("company-dashboard.jsp").forward(request, response);
            return;
        }
        // 5. Cập nhật dữ liệu vào DB
        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            dao.CompanyDAO companyDAO = new dao.CompanyDAO(conn);
            dal.UserDao userDao = new dal.UserDao(conn);
            model.Company company = companyDAO.getCompanyByUserId(userId);
            java.util.Date now = new java.util.Date();
            if (company == null) {
                company = new model.Company();
                company.setUserId(userId);
                company.setCreatedAt(now);
                company.setCompanyName(companyName);
                company.setIndustryId(industryId);
                company.setAddress(address);
                company.setDescription(description);
                company.setWebsite(website);
                company.setLogoUrl(avatarUrl);
                company.setPhone(phone);
                company.setSearchable(true);
                company.setUpdatedAt(now);
                System.out.println("[DEBUG] Tạo mới company cho userId: " + userId);
                boolean created = companyDAO.createCompany(company);
                System.out.println("[DEBUG] Kết quả createCompany: " + created);
            } else {
                company.setCompanyName(companyName);
                company.setIndustryId(industryId);
                company.setAddress(address);
                company.setDescription(description);
                company.setWebsite(website);
                if (avatarUrl != null) company.setLogoUrl(avatarUrl);
                company.setPhone(phone);
                company.setUpdatedAt(now);
                System.out.println("[DEBUG] Update company cho userId: " + userId);
                boolean updated = companyDAO.updateCompany(company);
                System.out.println("[DEBUG] Kết quả updateCompany: " + updated);
            }
            // Cập nhật user
            user.setEmail(email);
            user.setPhone(phone);
            userDao.updateUser(user);
            session.setAttribute("user", user);
            // 6. Trả về thông báo thành công
            request.setAttribute("success", "Profile updated successfully!");
            // Lấy lại thông tin mới nhất
            model.Company updatedCompany = companyDAO.getCompanyByUserId(userId);
            request.setAttribute("companyName", updatedCompany != null ? updatedCompany.getCompanyName() : companyName);
            request.setAttribute("website", updatedCompany != null ? updatedCompany.getWebsite() : website);
            request.setAttribute("address", updatedCompany != null ? updatedCompany.getAddress() : address);
            request.setAttribute("industryId", updatedCompany != null ? updatedCompany.getIndustryId() : industryId);
            request.setAttribute("description", updatedCompany != null ? updatedCompany.getDescription() : description);
            request.setAttribute("avatarUrl", (updatedCompany != null && updatedCompany.getLogoUrl() != null) ? updatedCompany.getLogoUrl() : "assets/img/default-avatar.png");
            request.setAttribute("email", user.getEmail());
            request.setAttribute("phone", user.getPhone());
            request.setAttribute("isSearchable", updatedCompany != null ? updatedCompany.isSearchable() : true);
            request.getRequestDispatcher("company-dashboard.jsp").forward(request, response);

            // Sau khi lấy updatedCompany hoặc company, lấy tên ngành
            String industryName = "";
            Integer industryIdForName = null;
            if (updatedCompany != null) {
                industryIdForName = updatedCompany.getIndustryId();
            } else if (company != null) {
                industryIdForName = company.getIndustryId();
            } else if (industryId != null) {
                industryIdForName = industryId;
            }
            if (industryIdForName != null) {
                try (PreparedStatement stmt2 = conn.prepareStatement("SELECT name FROM industries WHERE id = ?")) {
                    stmt2.setInt(1, industryIdForName);
                    ResultSet rs2 = stmt2.executeQuery();
                    if (rs2.next()) {
                        industryName = rs2.getString("name");
                    }
                }
            }
            request.setAttribute("industryName", industryName);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("company-dashboard.jsp").forward(request, response);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 3) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();

        Connection conn = null;
        try {
            conn = new dal.DBContext().getConnection();
            dao.CompanyDAO companyDAO = new dao.CompanyDAO(conn);
            model.Company company = companyDAO.getCompanyByUserId(userId);

            if (company != null) {
                request.setAttribute("companyName", company.getCompanyName());
                request.setAttribute("website", company.getWebsite());
                request.setAttribute("address", company.getAddress());
                request.setAttribute("industryId", company.getIndustryId());
                request.setAttribute("description", company.getDescription());
                request.setAttribute("avatarUrl", company.getLogoUrl() != null ? company.getLogoUrl() : "assets/img/default-avatar.png");
                request.setAttribute("isSearchable", company.isSearchable());
            } else {
                request.setAttribute("companyName", "");
                request.setAttribute("website", "");
                request.setAttribute("address", "");
                request.setAttribute("industryId", "");
                request.setAttribute("description", "");
                request.setAttribute("avatarUrl", "assets/img/default-avatar.png");
                request.setAttribute("isSearchable", true);
            }
            request.setAttribute("email", user.getEmail());
            request.setAttribute("phone", user.getPhone());
            request.getRequestDispatcher("company-dashboard.jsp").forward(request, response);

            // Sau khi lấy updatedCompany hoặc company, lấy tên ngành
            String industryName = "";
            Integer industryIdForName = null;
            if (company != null) {
                industryIdForName = company.getIndustryId();
            }
            if (industryIdForName != null) {
                try (PreparedStatement stmt2 = conn.prepareStatement("SELECT name FROM industries WHERE id = ?")) {
                    stmt2.setInt(1, industryIdForName);
                    ResultSet rs2 = stmt2.executeQuery();
                    if (rs2.next()) {
                        industryName = rs2.getString("name");
                    }
                }
            }
            request.setAttribute("industryName", industryName);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("company-dashboard.jsp").forward(request, response);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
} 