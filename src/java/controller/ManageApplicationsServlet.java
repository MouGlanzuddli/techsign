package controller;

import dal.DBContext;
import dal.ApplicationDAO;
import dal.JobDao;
import dal.UserDao;
import model.Application;
import model.Job;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "ManageApplicationsServlet", urlPatterns = {"/ManageApplicationsServlet"})
public class ManageApplicationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập và role company
        if (user == null || user.getRoleId() != 3) { // role_id = 3 là company
            response.sendRedirect("login.jsp?error=access_denied");
            return;
        }
        
        String jobIdStr = request.getParameter("jobId");
        String action = request.getParameter("action");
        
        try {
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            
            ApplicationDAO applicationDao = new ApplicationDAO(conn);
            JobDao jobDao = new JobDao(conn);
            UserDao userDao = new UserDao(conn);
            
            // Xử lý cập nhật trạng thái
            if ("updateStatus".equals(action)) {
                handleUpdateStatus(request, response, applicationDao, userDao);
                return;
            }
            
            List<Application> applications;
            Job selectedJob = null;
            
            if (jobIdStr != null && !jobIdStr.trim().isEmpty()) {
                // Xem applications của 1 job cụ thể
                int jobId = Integer.parseInt(jobIdStr);
                selectedJob = jobDao.getJobById(jobId);
                
                // Kiểm tra job có thuộc về company này không
                if (selectedJob == null || selectedJob.getCompanyId() != user.getId()) {
                    response.sendRedirect("ManageApplicationsServlet?error=access_denied");
                    return;
                }
                
                applications = applicationDao.getApplicationsByJobId(jobId);
            } else {
                // Xem tất cả applications của company
                applications = applicationDao.getApplicationsByEmployerId(user.getId());
            }
            
            // Lấy thông tin candidates và jobs
            Map<Integer, User> candidateMap = new HashMap<>();
            Map<Integer, Job> jobMap = new HashMap<>();
            
            for (Application app : applications) {
                // Lấy thông tin candidate
                if (!candidateMap.containsKey(app.getCandidateId())) {
                    User candidate = userDao.getUserById(app.getCandidateId());
                    candidateMap.put(app.getCandidateId(), candidate);
                }
                
                // Lấy thông tin job
                if (!jobMap.containsKey(app.getJobId())) {
                    Job job = jobDao.getJobById(app.getJobId());
                    jobMap.put(app.getJobId(), job);
                }
            }
            
            // Tính toán thống kê
            int totalApplications = applications.size();
            int pendingApplications = 0;
            int approvedApplications = 0;
            int rejectedApplications = 0;
            
            for (Application app : applications) {
                switch (app.getStatus()) {
                    case "pending": pendingApplications++; break;
                    case "approved": approvedApplications++; break;
                    case "rejected": rejectedApplications++; break;
                }
            }
            
            // Set attributes
            request.setAttribute("applications", applications);
            request.setAttribute("candidateMap", candidateMap);
            request.setAttribute("jobMap", jobMap);
            request.setAttribute("selectedJob", selectedJob);
            request.setAttribute("totalApplications", totalApplications);
            request.setAttribute("pendingApplications", pendingApplications);
            request.setAttribute("approvedApplications", approvedApplications);
            request.setAttribute("rejectedApplications", rejectedApplications);
            
            request.getRequestDispatcher("/manage-applications.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("ManageApplicationsServlet?error=invalid_job_id");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response, 
                                   ApplicationDAO applicationDao, UserDao userDao) throws IOException {
        
        String applicationIdStr = request.getParameter("applicationId");
        String newStatus = request.getParameter("status");
        String jobIdStr = request.getParameter("jobId");
        
        try {
            int applicationId = Integer.parseInt(applicationIdStr);
            
            // Cập nhật trạng thái
            boolean success = applicationDao.updateApplicationStatus(applicationId, newStatus);
            
            if (success) {
                // Gửi thông báo cho candidate
                Application application = applicationDao.getApplicationById(applicationId);
                if (application != null) {
                    sendNotificationToCandidate(application, newStatus, userDao);
                }
                
                String redirectUrl = "ManageApplicationsServlet?success=status_updated";
                if (jobIdStr != null && !jobIdStr.trim().isEmpty()) {
                    redirectUrl += "&jobId=" + jobIdStr;
                }
                response.sendRedirect(redirectUrl);
            } else {
                String redirectUrl = "ManageApplicationsServlet?error=update_failed";
                if (jobIdStr != null && !jobIdStr.trim().isEmpty()) {
                    redirectUrl += "&jobId=" + jobIdStr;
                }
                response.sendRedirect(redirectUrl);
            }
            
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            String redirectUrl = "ManageApplicationsServlet?error=invalid_data";
            if (jobIdStr != null && !jobIdStr.trim().isEmpty()) {
                redirectUrl += "&jobId=" + jobIdStr;
            }
            response.sendRedirect(redirectUrl);
        }
    }
    
    private void sendNotificationToCandidate(Application application, String newStatus, UserDao userDao) {
        try {
            // Tạo thông báo cho candidate
            String title = "Cập nhật trạng thái đơn ứng tuyển";
            String message = "";
            
            switch (newStatus) {
                case "approved":
                    message = "Chúc mừng! Đơn ứng tuyển của bạn đã được chấp nhận. Chúng tôi sẽ liên hệ với bạn sớm.";
                    break;
                case "rejected":
                    message = "Rất tiếc, đơn ứng tuyển của bạn chưa phù hợp lần này. Cảm ơn bạn đã quan tâm đến công ty.";
                    break;
                case "reviewing":
                    message = "Đơn ứng tuyển của bạn đang được xem xét. Chúng tôi sẽ phản hồi sớm nhất có thể.";
                    break;
                default:
                    message = "Trạng thái đơn ứng tuyển của bạn đã được cập nhật.";
            }
            
            // Lưu thông báo vào database (có thể implement sau)
            // NotificationDao.insertNotification(application.getCandidateId(), title, message);
            
            System.out.println("Notification sent to candidate " + application.getCandidateId() + ": " + message);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
