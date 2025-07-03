package controller;

import dal.DBContext;
import dal.SmtpConfigDao;
import model.SmtpConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "SmtpConfigServlet", urlPatterns = {"/admin/SmtpConfigServlet"})
public class SmtpConfigServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            SmtpConfigDao smtpDao = new SmtpConfigDao(conn);
            SmtpConfig currentConfig = smtpDao.getActiveSmtpConfig();
            
            request.setAttribute("smtpConfig", currentConfig);
            request.getRequestDispatcher("/admin/smtp-config.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu");
            request.getRequestDispatcher("/admin/smtp-config.jsp").forward(request, response);
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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            saveSmtpConfig(request, response);
        } else if ("test".equals(action)) {
            testSmtpConfig(request, response);
        }
    }
    
    private void saveSmtpConfig(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String smtpHost = request.getParameter("smtp_host");
        String smtpPort = request.getParameter("smtp_port");
        String smtpUsername = request.getParameter("smtp_username");
        String smtpPassword = request.getParameter("smtp_password");
        String fromEmail = request.getParameter("from_email");
        String fromName = request.getParameter("from_name");
        boolean smtpAuth = "on".equals(request.getParameter("smtp_auth"));
        boolean smtpStarttls = "on".equals(request.getParameter("smtp_starttls"));
        
        SmtpConfig config = new SmtpConfig();
        config.setSmtpHost("smtp.gmail.com");
        config.setSmtpPort("587");
        config.setSmtpUsername("hhqan61@gmail.com");
        config.setSmtpPassword("cxhrqgtzdxegmorh");
        config.setFromEmail(fromEmail);
        config.setFromName(fromName);
        config.setSmtpAuth(true);
        config.setSmtpStarttls(true);
        
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            SmtpConfigDao smtpDao = new SmtpConfigDao(conn);
            
            boolean success = smtpDao.saveSmtpConfig(config);
            
            if (success) {
                request.setAttribute("success", "Cấu hình SMTP đã được lưu thành công!");
            } else {
                request.setAttribute("error", "Không thể lưu cấu hình SMTP");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        request.setAttribute("smtpConfig", config);
        request.getRequestDispatcher("/admin/smtp-config.jsp").forward(request, response);
    }
    
    private void testSmtpConfig(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String smtpHost = request.getParameter("smtp_host");
        String smtpPort = request.getParameter("smtp_port");
        String smtpUsername = request.getParameter("smtp_username");
        String smtpPassword = request.getParameter("smtp_password");
        boolean smtpAuth = "on".equals(request.getParameter("smtp_auth"));
        boolean smtpStarttls = "on".equals(request.getParameter("smtp_starttls"));
        
        SmtpConfig config = new SmtpConfig();
        config.setSmtpHost(smtpHost);
        config.setSmtpPort(smtpPort);
        config.setSmtpUsername(smtpUsername);
        config.setSmtpPassword(smtpPassword);
        config.setSmtpAuth(smtpAuth);
        config.setSmtpStarttls(smtpStarttls);
        
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            SmtpConfigDao smtpDao = new SmtpConfigDao(conn);
            
            boolean testResult = smtpDao.testSmtpConnection(config);
            
            response.setContentType("application/json");
            if (testResult) {
                response.getWriter().write("{\"success\": true, \"message\": \"Kết nối SMTP thành công!\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể kết nối đến server SMTP. Vui lòng kiểm tra lại thông tin.\"}");
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
