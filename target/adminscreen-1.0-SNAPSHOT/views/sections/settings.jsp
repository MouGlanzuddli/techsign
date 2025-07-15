<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mycompany.adminscreen.model.Settings" %>
<%
  Settings settings = (Settings) request.getAttribute("settings");
  if (settings == null) settings = new Settings();
%>
<div id="settings" class="container py-4">
  <form method="post" id="settingsForm">
    <div class="d-flex align-items-center mb-4">
      <i class="fas fa-cog fa-2x me-2 text-primary"></i>
      <h2 class="fw-bold mb-0">Cài đặt hệ thống</h2>
      <button type="submit" class="btn btn-dark ms-auto"><i class="fas fa-save me-2"></i>Lưu cài đặt</button>
    </div>
    <ul class="nav nav-tabs mb-4" id="settingsTab" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="security-tab" data-bs-toggle="tab" data-bs-target="#security" type="button" role="tab">Bảo mật</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="app-tab" data-bs-toggle="tab" data-bs-target="#app" type="button" role="tab">Ứng dụng</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="email-tab" data-bs-toggle="tab" data-bs-target="#email" type="button" role="tab">Email</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="data-tab" data-bs-toggle="tab" data-bs-target="#data" type="button" role="tab">Dữ liệu</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="maintenance-tab" data-bs-toggle="tab" data-bs-target="#maintenance" type="button" role="tab">Bảo trì</button>
      </li>
    </ul>
    <div class="tab-content" id="settingsTabContent">
      <!-- Security Tab -->
      <div class="tab-pane fade show active" id="security" role="tabpanel">
        <div class="card mb-4">
          <div class="card-body">
            <h5 class="fw-bold mb-3"><i class="fas fa-shield-alt text-primary me-2"></i>Chính sách mật khẩu</h5>
            <div class="row mb-3">
              <div class="col-md-3">
                <label class="form-label">Độ dài tối thiểu</label>
                <input type="number" class="form-control" name="minPasswordLength" value="<%= settings.getMinPasswordLength() %>" />
              </div>
              <div class="col-md-3">
                <label class="form-label">Hết hạn sau (ngày)</label>
                <input type="number" class="form-control" name="passwordExpiryDays" value="<%= settings.getPasswordExpiryDays() %>" />
              </div>
            </div>
            <label class="form-label mb-2">Yêu cầu độ phức tạp</label>
            <div class="row mb-3">
              <div class="col-md-2 col-6 mb-2">
                <div class="form-check form-switch">
                  <input class="form-check-input" type="checkbox" name="requireUppercase" id="upperCase" <%= settings.isRequireUppercase() ? "checked" : "" %>>
                  <label class="form-check-label" for="upperCase">Chữ hoa (A-Z)</label>
                </div>
              </div>
              <div class="col-md-2 col-6 mb-2">
                <div class="form-check form-switch">
                  <input class="form-check-input" type="checkbox" name="requireLowercase" id="lowerCase" <%= settings.isRequireLowercase() ? "checked" : "" %>>
                  <label class="form-check-label" for="lowerCase">Chữ thường (a-z)</label>
                </div>
              </div>
              <div class="col-md-2 col-6 mb-2">
                <div class="form-check form-switch">
                  <input class="form-check-input" type="checkbox" name="requireNumber" id="number" <%= settings.isRequireNumber() ? "checked" : "" %>>
                  <label class="form-check-label" for="number">Số (0-9)</label>
                </div>
              </div>
              <div class="col-md-3 col-6 mb-2">
                <div class="form-check form-switch">
                  <input class="form-check-input" type="checkbox" name="requireSpecial" id="specialChar" <%= settings.isRequireSpecial() ? "checked" : "" %>>
                  <label class="form-check-label" for="specialChar">Ký tự đặc biệt (!@#$)</label>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="card mb-4">
          <div class="card-body">
            <h5 class="fw-bold mb-3"><i class="fas fa-clock text-success me-2"></i>Phiên đăng nhập & Bảo mật</h5>
            <div class="row mb-3">
              <div class="col-md-3">
                <label class="form-label">Timeout phiên (phút)</label>
                <input type="number" class="form-control" name="sessionTimeout" value="<%= settings.getSessionTimeout() %>" />
              </div>
              <div class="col-md-3">
                <label class="form-label">Số lần đăng nhập sai tối đa</label>
                <input type="number" class="form-control" name="maxLoginAttempts" value="<%= settings.getMaxLoginAttempts() %>" />
              </div>
              <div class="col-md-3">
                <label class="form-label">Thời gian khóa (phút)</label>
                <input type="number" class="form-control" name="lockoutDuration" value="<%= settings.getLockoutDuration() %>" />
              </div>
            </div>
            <div class="form-check form-switch">
              <input class="form-check-input" type="checkbox" name="enable2FA" id="enable2FA" <%= settings.isEnable2FA() ? "checked" : "" %>>
              <label class="form-check-label" for="enable2FA">Bật xác thực 2 yếu tố (2FA) <span class="badge bg-secondary ms-2">Khuyên nghị</span></label>
            </div>
          </div>
        </div>
      </div>
      <!-- App Tab -->
      <div class="tab-pane fade" id="app" role="tabpanel">
        <div class="card mb-4">
          <div class="card-body">
            <h5 class="fw-bold mb-3"><i class="fas fa-globe-asia text-info me-2"></i>Thông tin ứng dụng</h5>
            <div class="row mb-3">
              <div class="col-md-6 mb-2">
                <label class="form-label">Tên ứng dụng</label>
                <input type="text" class="form-control" name="appName" value="<%= settings.getAppName() != null ? settings.getAppName() : "" %>" />
              </div>
              <div class="col-md-6 mb-2">
                <label class="form-label">Logo ứng dụng</label>
                <input type="file" class="form-control" name="appLogo" />
              </div>
            </div>
            <label class="form-label">Mô tả ứng dụng</label>
            <textarea class="form-control mb-3" name="appDescription" rows="2"><%= settings.getAppDescription() != null ? settings.getAppDescription() : "" %></textarea>
          </div>
        </div>
        <div class="card mb-4">
          <div class="card-body">
            <h5 class="fw-bold mb-3"><i class="fas fa-calendar-alt text-warning me-2"></i>Ngôn ngữ & Định dạng</h5>
            <div class="row mb-3">
              <div class="col-md-3 mb-2">
                <label class="form-label">Ngôn ngữ mặc định</label>
                <select class="form-select" name="defaultLanguage">
                  <option <%= "Tiếng Việt".equals(settings.getDefaultLanguage()) ? "selected" : "" %>>Tiếng Việt</option>
                  <option <%= "English".equals(settings.getDefaultLanguage()) ? "selected" : "" %>>English</option>
                </select>
              </div>
              <div class="col-md-3 mb-2">
                <label class="form-label">Múi giờ mặc định</label>
                <select class="form-select" name="defaultTimezone">
                  <option <%= "Việt Nam (UTC+7)".equals(settings.getDefaultTimezone()) ? "selected" : "" %>>Việt Nam (UTC+7)</option>
                  <option <%= "UTC".equals(settings.getDefaultTimezone()) ? "selected" : "" %>>UTC</option>
                </select>
              </div>
              <div class="col-md-3 mb-2">
                <label class="form-label">Định dạng ngày</label>
                <select class="form-select" name="dateFormat">
                  <option <%= "DD/MM/YYYY".equals(settings.getDateFormat()) ? "selected" : "" %>>DD/MM/YYYY</option>
                  <option <%= "MM/DD/YYYY".equals(settings.getDateFormat()) ? "selected" : "" %>>MM/DD/YYYY</option>
                </select>
              </div>
              <div class="col-md-3 mb-2">
                <label class="form-label">Định dạng giờ</label>
                <select class="form-select" name="timeFormat">
                  <option <%= "24 giờ (14:30)".equals(settings.getTimeFormat()) ? "selected" : "" %>>24 giờ (14:30)</option>
                  <option <%= "12 giờ (2:30 PM)".equals(settings.getTimeFormat()) ? "selected" : "" %>>12 giờ (2:30 PM)</option>
                </select>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Email Tab -->
      <div class="tab-pane fade" id="email" role="tabpanel">
        <div class="card mb-4">
          <div class="card-body">
            <h5 class="fw-bold mb-3"><i class="fas fa-envelope text-primary me-2"></i>Cấu hình Email & Thông báo</h5>
            <div class="row mb-3">
              <div class="col-md-3 mb-2">
                <label class="form-label">SMTP Host</label>
                <input type="text" class="form-control" name="smtpHost" value="<%= settings.getSmtpHost() != null ? settings.getSmtpHost() : "" %>" />
              </div>
              <div class="col-md-2 mb-2">
                <label class="form-label">SMTP Port</label>
                <input type="text" class="form-control" name="smtpPort" value="<%= settings.getSmtpPort() != null ? settings.getSmtpPort() : "" %>" />
              </div>
              <div class="col-md-3 mb-2">
                <label class="form-label">SMTP Username</label>
                <input type="text" class="form-control" name="smtpUsername" value="<%= settings.getSmtpUsername() != null ? settings.getSmtpUsername() : "" %>" />
              </div>
              <div class="col-md-3 mb-2">
                <label class="form-label">SMTP Password</label>
                <input type="password" class="form-control" name="smtpPassword" value="<%= settings.getSmtpPassword() != null ? settings.getSmtpPassword() : "" %>" />
              </div>
            </div>
            <div class="row mb-3">
              <div class="col-md-2 mb-2">
                <label class="form-label">Mã hóa</label>
                <select class="form-select" name="smtpEncryption">
                  <option <%= "TLS".equals(settings.getSmtpEncryption()) ? "selected" : "" %>>TLS</option>
                  <option <%= "SSL".equals(settings.getSmtpEncryption()) ? "selected" : "" %>>SSL</option>
                </select>
              </div>
              <div class="col-md-3 mb-2">
                <label class="form-label">Email gửi</label>
                <input type="text" class="form-control" name="senderEmail" value="<%= settings.getSenderEmail() != null ? settings.getSenderEmail() : "" %>" />
              </div>
              <div class="col-md-3 mb-2">
                <label class="form-label">Tên người gửi</label>
                <input type="text" class="form-control" name="senderName" value="<%= settings.getSenderName() != null ? settings.getSenderName() : "" %>" />
              </div>
              <div class="col-md-2 mb-2 d-flex align-items-end">
                <button class="btn btn-outline-secondary w-100" type="button"><i class="fas fa-link"></i> Kiểm tra kết nối</button>
              </div>
            </div>
            <div class="form-check form-switch mb-2">
              <input class="form-check-input" type="checkbox" name="enableEmail" id="enableEmail" <%= settings.isEnableEmail() ? "checked" : "" %>>
              <label class="form-check-label" for="enableEmail">Bật thông báo email</label>
            </div>
            <div class="form-check form-switch mb-2">
              <input class="form-check-input" type="checkbox" name="enableSMS" id="enableSMS" <%= settings.isEnableSMS() ? "checked" : "" %>>
              <label class="form-check-label" for="enableSMS">Bật thông báo SMS</label>
            </div>
          </div>
        </div>
      </div>
      <!-- Data Tab -->
      <div class="tab-pane fade" id="data" role="tabpanel">
        <div class="card mb-4">
          <div class="card-body">
            <h5 class="fw-bold mb-3"><i class="fas fa-database text-success me-2"></i>Dữ liệu & Nhật ký Audit</h5>
            <div class="row mb-3">
              <div class="col-md-3 mb-2">
                <label class="form-label">Lưu trữ audit log (ngày)</label>
                <input type="number" class="form-control" name="auditLogRetention" value="<%= settings.getAuditLogRetention() %>" />
              </div>
              <div class="col-md-3 mb-2">
                <label class="form-label">Kích thước file tối đa (MB)</label>
                <input type="number" class="form-control" name="maxFileSize" value="<%= settings.getMaxFileSize() %>" />
              </div>
              <div class="col-md-3 mb-2">
                <label class="form-label">Tần suất sao lưu</label>
                <select class="form-select" name="backupFrequency">
                  <option <%= "Hàng ngày".equals(settings.getBackupFrequency()) ? "selected" : "" %>>Hàng ngày</option>
                  <option <%= "Hàng tuần".equals(settings.getBackupFrequency()) ? "selected" : "" %>>Hàng tuần</option>
                  <option <%= "Hàng tháng".equals(settings.getBackupFrequency()) ? "selected" : "" %>>Hàng tháng</option>
                </select>
              </div>
            </div>
            <div class="form-check form-switch mb-2">
              <input class="form-check-input" type="checkbox" name="enableAudit" id="enableAudit" <%= settings.isEnableAudit() ? "checked" : "" %>>
              <label class="form-check-label" for="enableAudit">Bật ghi nhật ký audit <span class="badge bg-secondary ms-2">Khuyên nghị</span></label>
            </div>
            <div class="form-check form-switch mb-2">
              <input class="form-check-input" type="checkbox" name="enableAutoBackup" id="enableAutoBackup" <%= settings.isEnableAutoBackup() ? "checked" : "" %>>
              <label class="form-check-label" for="enableAutoBackup">Bật sao lưu dữ liệu tự động</label>
            </div>
          </div>
        </div>
      </div>
      <!-- Maintenance Tab -->
      <div class="tab-pane fade" id="maintenance" role="tabpanel">
        <div class="card mb-4">
          <div class="card-body">
            <h5 class="fw-bold mb-3"><i class="fas fa-tools text-warning me-2"></i>Chế độ bảo trì</h5>
            <div class="form-check form-switch mb-3">
              <input class="form-check-input" type="checkbox" name="maintenanceMode" id="enableMaintenance" <%= settings.isMaintenanceMode() ? "checked" : "" %>>
              <label class="form-check-label" for="enableMaintenance">Bật chế độ bảo trì</label>
            </div>
            <label class="form-label">Thông báo bảo trì</label>
            <textarea class="form-control mb-3" name="maintenanceMessage" rows="2"><%= settings.getMaintenanceMessage() != null ? settings.getMaintenanceMessage() : "" %></textarea>
            <div class="row">
              <div class="col-md-4 mb-2">
                <label class="form-label">Thời gian bắt đầu</label>
                <input type="datetime-local" class="form-control" name="maintenanceStart" value="<%= settings.getMaintenanceStart() != null ? settings.getMaintenanceStart() : "" %>" />
              </div>
              <div class="col-md-4 mb-2">
                <label class="form-label">Thời gian kết thúc</label>
                <input type="datetime-local" class="form-control" name="maintenanceEnd" value="<%= settings.getMaintenanceEnd() != null ? settings.getMaintenanceEnd() : "" %>" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </form>
</div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/settings.js"></script>
