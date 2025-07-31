<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý Thông báo</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/ui-common.css">
  <style>
    /* Reset Bootstrap tab styles that might be hiding content */
    .tab-content > .tab-pane {
      display: block !important;
      opacity: 1 !important;
      visibility: visible !important;
      height: auto !important;
      position: static !important;
    }
    
    /* Ensure the notification container is visible */
    #notificationListContainer {
      min-height: 300px;
      padding: 20px;
      background-color: #f8f9fa;
      border-radius: 8px;
      margin: 15px 0;
      width: 100%;
      box-sizing: border-box;
      position: relative;
      overflow: visible;
    }
    
    /* Force the tab content to be visible */
    #tab-history {
      display: block !important;
      opacity: 1 !important;
      visibility: visible !important;
      height: auto !important;
      position: relative !important;
      overflow: visible !important;
    }
    
    /* Make sure the tab panel is visible */
    .tab-pane {
      display: block !important;
      height: auto !important;
      min-height: 50px;
    }
    
    /* Style for notification cards */
    .notification-card {
      transition: all 0.3s ease;
      margin-bottom: 15px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    
    .notification-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    
    /* Ensure active tab content is visible */
    .tab-content > .active {
      display: block !important;
      height: auto !important;
      overflow: visible !important;
    }
    
    /* Remove conflicting height rules */
    .tab-content > .tab-pane {
      height: auto !important;
      overflow: visible !important;
    }
  </style>
</head>
<body>
  <section id="system-notifications">
    <div class="container-fluid py-4">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0"><i class="fas fa-bell me-2"></i>Quản lý Thông báo</h2>
      </div>
      <ul class="nav nav-tabs mb-3" id="notificationTabs" role="tablist">
        <li class="nav-item" role="presentation">
          <button class="nav-link active" id="tab-demo-tab" data-bs-toggle="tab" data-bs-target="#tab-demo" type="button" role="tab" aria-controls="tab-demo" aria-selected="true">Demo & Điều Khiển</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="tab-history-tab" data-bs-toggle="tab" data-bs-target="#tab-history" type="button" role="tab" aria-controls="tab-history" aria-selected="false">Lịch Sử Thông Báo</button>
        </li>
      </ul>
      <div class="tab-content" id="notificationTabsContent">
        <div class="tab-pane fade show active" id="tab-demo" role="tabpanel" aria-labelledby="tab-demo-tab">
<!--          <div class="mb-4">
            <h4><span style="color:#22c55e;font-size:1.2em;">●</span> Demo Thông Báo</h4>
            <p>Thử nghiệm các loại thông báo khác nhau và xem cách chúng hiển thị</p>
            <div class="btn-group mb-3 demo-notification-buttons" role="group">
              <button class="btn btn-success">Thành Công</button>
              <button class="btn btn-danger">Lỗi Hệ Thống</button>
              <button class="btn btn-warning">Cảnh Báo</button>
              <button class="btn btn-info">Thông Tin</button>
            </div>
          </div>-->
          <form id="createNotificationForm" class="row g-3">
            <h4><i class="fas fa-plus-circle"></i> Tạo Thông Báo Mới</h4>
            <div class="col-md-6">
              <label for="noti-title" class="form-label">Tiêu đề</label>
              <input type="text" class="form-control" id="noti-title" name="title" placeholder="Tiêu đề thông báo" required>
            </div>
            <div class="col-md-6">
              <label for="noti-type" class="form-label">Type</label>
              <select class="form-select" id="noti-type" name="type" required>
                <option value="system">Info</option>
                <option value="maintenance">Maintenance</option>
                <option value="security">Security</option>
                <option value="update">Update</option>
              </select>
            </div>
            <div class="col-12">
              <label for="noti-message" class="form-label">Nội dung</label>
              <textarea class="form-control" id="noti-message" name="message" placeholder="Nội dung thông báo" required></textarea>
            </div>
            <div class="col-md-4">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" id="noti-auto-dismiss" name="auto_dismiss" checked>
                <label class="form-check-label" for="noti-auto-dismiss">Tự động ẩn</label>
              </div>
            </div>
            <div class="col-md-4">
              <label for="noti-duration" class="form-label">Thời gian (ms)</label>
              <input type="number" class="form-control" id="noti-duration" name="duration_ms" value="5000" min="1000">
            </div>
            <div class="col-md-4">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" id="noti-pinned" name="pinned">
                <label class="form-check-label" for="noti-pinned">Ghim</label>
              </div>
            </div>
            <div class="col-12">
              <button type="submit" class="btn btn-primary">Tạo Thông Báo</button>
              <button type="button" id="clearNotificationsBtn" class="btn btn-secondary ms-2">Xóa Tất Cả</button>
            </div>
            <div id="notificationCreateMsg" class="col-12"></div>
          </form>
        </div>
        <div class="tab-pane fade" id="tab-history" role="tabpanel" aria-labelledby="tab-history-tab">
          <div class="d-flex align-items-center mb-3" style="gap: 16px;">
            <h2 class="section-title mb-0">
              <i class="fas fa-bell"></i> Lịch sử Thông báo
            </h2>
            <button class="btn btn-outline" id="reloadNotificationsBtn" type="button" title="Tải lại thông báo">
              <i class="fas fa-sync"></i> Tải lại
            </button>
          </div>
          <!-- Notification List Container -->
          <div id="notificationListContainer" class="mt-3">
            <div class="text-center text-muted">
              <i class="fas fa-spinner fa-spin me-2"></i> Đang tải thông báo...
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Modal Sửa Thông Báo -->
  <div class="modal fade" id="editNotificationModal" tabindex="-1" aria-labelledby="editNotificationModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content p-2">
        <form id="editNotificationForm" class="needs-validation" novalidate>
          <div class="modal-header pb-2 mb-1">
            <h5 class="modal-title d-flex align-items-center gap-2" id="editNotificationModalLabel"><i class="fas fa-edit"></i> Sửa Thông Báo</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
          </div>
          <div class="modal-body pt-2 pb-1">
            <input type="hidden" id="edit-noti-id" name="id">
            <div class="mb-2">
              <label for="edit-noti-title" class="form-label mb-1">Tiêu đề</label>
              <input type="text" class="form-control form-control-sm" id="edit-noti-title" name="title" required>
            </div>
            <div class="mb-2">
              <label for="edit-noti-type" class="form-label mb-1">Loại</label>
              <select class="form-select form-select-sm" id="edit-noti-type" name="type" required>
                <option value="system">Info</option>
                <option value="maintenance">Maintenance</option>
                <option value="security">Security</option>
                <option value="update">Update</option>
              </select>
            </div>
            <div class="mb-2">
              <label for="edit-noti-message" class="form-label mb-1">Nội dung</label>
              <textarea class="form-control form-control-sm" id="edit-noti-message" name="message" rows="2" required></textarea>
            </div>
            <div class="form-check mb-1">
              <input class="form-check-input" type="checkbox" id="edit-noti-auto-dismiss" name="auto_dismiss">
              <label class="form-check-label" for="edit-noti-auto-dismiss">Tự động ẩn</label>
            </div>
            <div class="mb-1">
              <label for="edit-noti-duration" class="form-label mb-1">Thời gian (ms)</label>
              <input type="number" class="form-control form-control-sm" id="edit-noti-duration" name="duration_ms" min="1000" value="5000">
            </div>
            <div class="form-check mb-1">
              <input class="form-check-input" type="checkbox" id="edit-noti-pinned" name="pinned">
              <label class="form-check-label" for="edit-noti-pinned">Ghim</label>
            </div>
            <div id="editNotificationMsg" class="mt-1"></div>
          </div>
          <div class="modal-footer pt-2 pb-2">
            <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
            <button type="submit" class="btn btn-primary btn-sm">Lưu thay đổi</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script>
// Reload button handler for notifications
const reloadBtn = document.getElementById('reloadNotificationsBtn');
if (reloadBtn) {
  reloadBtn.addEventListener('click', function() {
    if (typeof loadNotifications === 'function') {
      loadNotifications();
    } else if (window.sectionLoader && typeof sectionLoader.loadNotifications === 'function') {
      sectionLoader.loadNotifications();
    } else {
      location.reload(); // fallback
    }
  });
}
</script>
</body>
</html>