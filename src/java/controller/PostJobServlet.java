package controller;

import dal.DBContext;
import dal.JobDao;
import model.Job;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "PostJobServlet", urlPatterns = {"/PostJobServlet"})
public class PostJobServlet extends HttpServlet {

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Kiểm tra đăng nhập và role
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    
    if (user == null || user.getRoleId() != 3) { // 3 = Employer role
        response.sendRedirect("login.jsp?error=access_denied");
        return;
    }
    
    // Hiển thị form post job
    request.getRequestDispatcher("/company-submit-job.jsp").forward(request, response);
}

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // Kiểm tra đăng nhập và role
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    
    if (user == null || user.getRoleId() != 3) { // 3 = Employer role
        response.sendRedirect("login.jsp?error=access_denied");
        return;
    }

    try {
        // Lấy dữ liệu từ form
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String requirements = request.getParameter("requirements");
        String benefits = request.getParameter("benefits");
        String jobType = request.getParameter("jobType");
        String jobLevel = request.getParameter("jobLevel");
        String salaryMinStr = request.getParameter("salaryMin");
        String salaryMaxStr = request.getParameter("salaryMax");
        String location = request.getParameter("location");
        String category = request.getParameter("category");
        String experienceStr = request.getParameter("experience");
        String deadlineStr = request.getParameter("applicationDeadline");
        String isFeaturedStr = request.getParameter("isFeatured");
        String isUrgentStr = request.getParameter("isUrgent");

        // Validate dữ liệu
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("error", "Tiêu đề công việc không được để trống");
            request.getRequestDispatcher("/company-submit-job.jsp").forward(request, response);
            return;
        }

        if (description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "Mô tả công việc không được để trống");
            request.getRequestDispatcher("/company-submit-job.jsp").forward(request, response);
            return;
        }

        // Tạo Job object với constructor mặc định để tránh null
        Job job = new Job();
        job.setCompanyId(user.getId());
        job.setTitle(title.trim());
        job.setDescription(description.trim());
        job.setRequirements(requirements != null ? requirements.trim() : "");
        job.setBenefits(benefits != null ? benefits.trim() : "");
        job.setJobType(jobType != null ? jobType : "Full Time");
        job.setJobLevel(jobLevel != null ? jobLevel : "Mid");
        job.setLocation(location != null ? location.trim() : "");
        job.setCategory(category != null ? category : "Information Technology");

        // Xử lý salary
        if (salaryMinStr != null && !salaryMinStr.trim().isEmpty()) {
            try {
                job.setSalaryMin(new BigDecimal(salaryMinStr));
            } catch (NumberFormatException e) {
                job.setSalaryMin(null);
            }
        }
        if (salaryMaxStr != null && !salaryMaxStr.trim().isEmpty()) {
            try {
                job.setSalaryMax(new BigDecimal(salaryMaxStr));
            } catch (NumberFormatException e) {
                job.setSalaryMax(null);
            }
        }

        // Xử lý experience
        if (experienceStr != null && !experienceStr.trim().isEmpty()) {
            try {
                job.setExperienceRequired(Integer.parseInt(experienceStr));
            } catch (NumberFormatException e) {
                job.setExperienceRequired(0);
            }
        }

        // Xử lý deadline
        if (deadlineStr != null && !deadlineStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                job.setApplicationDeadline(sdf.parse(deadlineStr));
            } catch (ParseException e) {
                job.setApplicationDeadline(null);
            }
        }

        // Xử lý featured và urgent
        job.setFeatured("on".equals(isFeaturedStr));
        job.setUrgent("on".equals(isUrgentStr));

        // Đảm bảo các giá trị mặc định
        job.setStatus("active");
        Date now = new Date();
        job.setCreatedAt(now);
        job.setUpdatedAt(now);

        // Lưu vào database
        DBContext dbContext = new DBContext();
        Connection conn = dbContext.getConnection();
        JobDao jobDao = new JobDao(conn);

        if (jobDao.insertJob(job)) {
            request.setAttribute("success", "Đăng tin tuyển dụng thành công!");
            response.sendRedirect("MyJobsServlet?success=job_posted");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi đăng tin. Vui lòng thử lại.");
            request.getRequestDispatcher("/company-submit-job.jsp").forward(request, response);
        }

    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
        request.getRequestDispatcher("/company-submit-job.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        request.getRequestDispatcher("/company-submit-job.jsp").forward(request, response);
    }
}
}
