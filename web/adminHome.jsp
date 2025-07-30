<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Admin Dashboard - Hệ thống tuyển dụng</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- In your <head> section -->
<link href="${pageContext.request.contextPath}/assets/css/plugins/admin.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/plugins/chatbox.css" rel="stylesheet"> 
<link href="${pageContext.request.contextPath}/assets/css/plugins/ui-common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/plugins/content.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/plugins/job-postings.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/statistics-reports.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/statistics-reports.css">




    </head>
    <body>
        
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>        
        
        <script>
        console.log('🔍 Testing Chart.js:', typeof Chart);
        if (typeof Chart !== 'undefined') {
            console.log('✅ Chart.js loaded successfully!');
        } else {
            console.error('❌ Chart.js failed to load!');
        }
        
        // Global variables
        window.contextPath = '${pageContext.request.contextPath}';
        console.log('Context Path:', window.contextPath);
    </script>
        
        
        <header>
            <div class="header-left">
                <input type="search" placeholder="Tìm kiếm nhanh..." />
                <i class="fas fa-search"></i>
            </div>
            <div class="header-right">
                <div class="icon-btn" title="Thông báo">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <div class="admin-name" title="Tên Admin">
                    <img src="https://via.placeholder.com/32" alt="Avatar" />
                    Admin Nguyễn Văn A
                </div>
                <button class="logout-btn">Đăng xuất</button>
            </div>
        </header>
        <div class="container">
            <%@ include file="views/components/sidebar.jsp" %>
            <main class="content">
                <h2>Dashboard Tổng Quan</h2>
                <div class="stats-cards" id="dashboard-overview">
                    <div class="card-box">
                        <div>
                            <span>Tổng số tài khoản</span><br />
                            <span id="totalUsers" class="number">${totalUsers}</span>
                        </div>
                        <i class="fas fa-users"></i>
                    </div>

                    <div class="card-box">
                        <div>
                            <span>Tin tuyển dụng</span><br />
                            <span id="totalJobPosts" class="number">${totalJobPosts}</span>
                        </div>
                        <i class="fas fa-briefcase"></i>
                    </div>

                    <div class="card-box">
                        <div>
                            <span>Cảnh báo bảo mật</span><br />
                            <span id="securityAlerts" class="number">${securityAlerts}</span>
                        </div>
                        <i class="fas fa-exclamation-circle"></i>
                    </div>

                    <div class="card-box">
                        <div>
                            <span>Lượt truy cập hôm nay</span><br />
                            <span id="totalVisitsToday" class="number">${totalVisitsToday}</span>
                        </div>
                        <i class="fas fa-chart-line"></i>
                    </div>

                </div>
                <div id="section-content" style="margin-top: 30px;">
                    <p>Chọn một mục từ menu để bắt đầu quản lý.</p>
                </div>
            </main>
        </div>

        <button class="chat-launcher" id="chatLauncher">💬</button>

        <div class="chatbox-container" id="chatboxContainer">
            <div class="chatbox-header">
                <span>Hỗ trợ & Ticket</span>
                <button class="chatbox-close-btn" id="chatCloseBtn">&times;</button>
            </div>

            <div class="chatbox-tabs">
                <div class="chatbox-tab active" id="newChatTab">Trò chuyện mới</div>
                <div class="chatbox-tab" id="historyTab">Lịch sử hỗ trợ</div>
            </div>

            <div class="tab-content active" id="newChatContent">
                <div class="chatbox-messages" id="newChatMessages">
                    <p class="message-agent">Chào mừng bạn đến với kênh hỗ trợ! Vui lòng mô tả vấn đề của bạn để chúng tôi tạo ticket.</p>
                </div>
                <div class="chatbox-input-area">
                    <input type="text" id="newChatInput" placeholder="Nhập tin nhắn của bạn...">
                    <button id="newChatSendBtn">Gửi</button>
                </div>
            </div>

            <div class="tab-content" id="historyContent">
                <div class="chat-history-list" id="chatHistoryList">
                    <p style="text-align: center; color: #777; margin-top: 20px;">Đang tải lịch sử ticket...</p>
                </div>
            </div>
        </div>
        
        
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
        
        
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<!-- Before closing </body> -->
<script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin-2.js"></script>  Fixed filename 
<script src="${pageContext.request.contextPath}/assets/js/chatbox.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/job-postings.js"></script><!--
--><script src="${pageContext.request.contextPath}/assets/js/section-loader.js"></script><!--
--><script src="${pageContext.request.contextPath}/assets/js/alert.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/content.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/category.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/system-notifications.js"></script>
<!--<script src="${pageContext.request.contextPath}/assets/js/settings.js"></script>-->

 <%-- Link to chatbox.js --%>

<script src="${pageContext.request.contextPath}/assets/js/statistics-reports.js?v=<%= System.currentTimeMillis() %>"></script>

               <script>
  function updateDashboardStats() {
    console.log('Fetching dashboard stats...');
    fetch('<c:url value="/adminHome" />', {
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        }
    })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Data received:', data);
            document.querySelector('#totalUsers').innerText = data.totalUsers;
            document.querySelector('#totalJobPosts').innerText = data.totalJobPosts;
            document.querySelector('#securityAlerts').innerText = data.securityAlerts;
            document.querySelector('#totalVisitsToday').innerText = data.totalVisits;
            console.log('Dashboard stats updated.');
        })
        .catch(error => console.error('Lỗi khi lấy dữ liệu:', error));
  }
  setInterval(updateDashboardStats, 600000); // Gọi updateDashboardStats() mỗi 15 giây
  // Call immediately on page load to see initial fetch
  updateDashboardStats();

        </script>


    </body>
</html>