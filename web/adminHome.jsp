<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard - Hệ thống tuyển dụng</title>

    <!-- External CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Local CSS -->
    <link href="<c:url value='/assets/css/plugins/admin.css'/>" rel="stylesheet" />
    <link href="<c:url value='/assets/css/plugins/chatbox.css'/>" rel="stylesheet" />
    <link href="<c:url value='/assets/css/plugins/content.css'/>" rel="stylesheet" />
    <link href="<c:url value='/assets/css/plugins/job-postings.css'/>" rel="stylesheet" />
    <link href="<c:url value='/assets/css/plugins/ui-common.css'/>" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/statistics-reports.css">
</head>
<body>
<div class="d-flex" style="min-height: 100vh;">
    <nav class="sidebar d-flex flex-column justify-content-center align-items-center" style="width: 240px; min-width: 200px; background: #183a7d;">
        <%@ include file="views/components/sidebar.jsp" %>
    </nav>
    <div style="flex:1;display:flex;flex-direction:column;min-height:100vh;">
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
        <main class="flex-grow-1 px-4 py-4" style="background: #f8f9fa;">
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

<!-- External Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Local Scripts -->
<script src="${pageContext.request.contextPath}/assets/js/statistics-reports.js?v=<%= System.currentTimeMillis() %>"></script>
<script src="<c:url value='/assets/js/admin.js'/>"></script>
<script src="<c:url value='/assets/js/chatbox.js'/>"></script>
<script src="<c:url value='/assets/js/job-postings.js'/>"></script>
<script src="<c:url value='/assets/js/section-loader.js'/>"></script>
<script src="<c:url value='/assets/js/alert.js'/>"></script>
<script src="<c:url value='/assets/js/content.js'/>"></script>
<script src="<c:url value='/assets/js/category.js'/>"></script>
<script src="<c:url value='/assets/js/system-notifications.js'/>"></script>
<script src="<c:url value='/assets/js/settings.js'/>"></script>

<script>
    const logoutBtn = document.querySelector('.logout-btn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', function() {
            fetch('UserServlet?action=logout', { method: 'POST' })
                .then(() => {
                    window.location.href = 'login.jsp';
                })
                .catch(error => {
                    console.error('Logout error:', error);
                    window.location.href = 'login.jsp';
                });
        });
    }

    function updateDashboardStats() {
        console.log('Fetching dashboard stats...');
        fetch('<c:url value="/adminHome" />', {
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(response => {
            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            return response.json();
        })
        .then(data => {
            document.querySelector('#totalUsers').innerText = data.totalUsers;
            document.querySelector('#totalJobPosts').innerText = data.totalJobPosts;
            document.querySelector('#securityAlerts').innerText = data.securityAlerts;
            document.querySelector('#totalVisitsToday').innerText = data.totalVisits;
            console.log('Dashboard stats updated.');
        })
        .catch(error => console.error('Lỗi khi lấy dữ liệu:', error));
    }

    setInterval(updateDashboardStats, 600000); // Every 10 minutes
    updateDashboardStats();
</script>

</body>
</html>
