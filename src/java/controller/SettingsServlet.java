package controller;

import dao.SettingsDAO;
import model.Settings;
import java.io.IOException;
import dao.DBConnection;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SettingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            // TODO: Refactor SettingsDAO to support connection injection
            SettingsDAO dao = new SettingsDAO();
            Settings settings = dao.loadSettings();
            req.setAttribute("settings", settings);
            req.getRequestDispatcher("/views/sections/settings.jsp").forward(req, resp);
        } catch (SQLException ex) {
            Logger.getLogger(SettingsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SettingsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try (Connection conn = DBConnection.getConnection()) {
            // TODO: Refactor SettingsDAO to support connection injection
            SettingsDAO dao = new SettingsDAO();
            Settings s = new Settings();
            s.setMinPasswordLength(Integer.parseInt(req.getParameter("minPasswordLength")));
            s.setPasswordExpiryDays(Integer.parseInt(req.getParameter("passwordExpiryDays")));
            s.setRequireUppercase(req.getParameter("requireUppercase") != null);
            s.setRequireLowercase(req.getParameter("requireLowercase") != null);
            s.setRequireNumber(req.getParameter("requireNumber") != null);
            s.setRequireSpecial(req.getParameter("requireSpecial") != null);
            s.setSessionTimeout(Integer.parseInt(req.getParameter("sessionTimeout")));
            s.setMaxLoginAttempts(Integer.parseInt(req.getParameter("maxLoginAttempts")));
            s.setLockoutDuration(Integer.parseInt(req.getParameter("lockoutDuration")));
            s.setEnable2FA(req.getParameter("enable2FA") != null);
            s.setAppName(req.getParameter("appName"));
            s.setAppLogo(req.getParameter("appLogo"));
            s.setAppDescription(req.getParameter("appDescription"));
            s.setDefaultLanguage(req.getParameter("defaultLanguage"));
            s.setDefaultTimezone(req.getParameter("defaultTimezone"));
            s.setDateFormat(req.getParameter("dateFormat"));
            s.setTimeFormat(req.getParameter("timeFormat"));
            s.setSmtpHost(req.getParameter("smtpHost"));
            s.setSmtpPort(req.getParameter("smtpPort"));
            s.setSmtpUsername(req.getParameter("smtpUsername"));
            s.setSmtpPassword(req.getParameter("smtpPassword"));
            s.setSmtpEncryption(req.getParameter("smtpEncryption"));
            s.setSenderEmail(req.getParameter("senderEmail"));
            s.setSenderName(req.getParameter("senderName"));
            s.setEnableEmail(req.getParameter("enableEmail") != null);
            s.setEnableSMS(req.getParameter("enableSMS") != null);
            s.setAuditLogRetention(Integer.parseInt(req.getParameter("auditLogRetention")));
            s.setMaxFileSize(Integer.parseInt(req.getParameter("maxFileSize")));
            s.setBackupFrequency(req.getParameter("backupFrequency"));
            s.setEnableAudit(req.getParameter("enableAudit") != null);
            s.setEnableAutoBackup(req.getParameter("enableAutoBackup") != null);
            s.setMaintenanceMode(req.getParameter("maintenanceMode") != null);
            s.setMaintenanceMessage(req.getParameter("maintenanceMessage"));
            s.setMaintenanceStart(req.getParameter("maintenanceStart"));
            s.setMaintenanceEnd(req.getParameter("maintenanceEnd"));
            dao.saveSettings(s);
            resp.sendRedirect("settings?success=1");
        } catch (SQLException ex) {
            Logger.getLogger(SettingsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SettingsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
} 