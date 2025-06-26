<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard - Hệ thống tuyển dụng</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />
    <link href="<c:url value='/css/chatbox.css'/>" rel="stylesheet" /> <%-- Link to chatbox.css --%>
    <link href="<c:url value='/css/content.css'/>" rel="stylesheet" />
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">


</head>
<body>
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
<div class="d-flex" style="min-height: 100vh;">
    <nav class="sidebar d-flex flex-column justify-content-center align-items-center" style="width: 240px; min-width: 200px; background: #183a7d;">
        <%@ include file="views/components/sidebar.jsp" %>
    </nav>
    <main class="flex-grow-1 px-4 py-4" style="background: #f8f9fa;">
        <h2>Dashboard Tổng Quan</h2>
        <div class="stats-cards" id="dashboard-overview">
            <div class="card-box">
                <div>
                    <span>Tổng số tài khoản</span><br />
                    <span class="number">1,234</span>
                </div>
                <i class="fas fa-users"></i>
            </div>
            <div class="card-box">
                <div>
                    <span>Tin tuyển dụng</span><br />
                    <span class="number">56</span>
                </div>
                <i class="fas fa-briefcase"></i>
            </div>
            <div class="card-box">
                <div>
                    <span>Cảnh báo bảo mật</span><br />
                    <span class="number">3</span>
                </div>
                <i class="fas fa-exclamation-circle"></i>
            </div>
            <div class="card-box">
                <div>
                    <span>Lượt truy cập</span><br />
                    <span class="number">12,345</span>
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

<script src="${pageContext.request.contextPath}/js/admin.js"></script>
<script src="${pageContext.request.contextPath}/js/section-loader.js"></script>
<script src="${pageContext.request.contextPath}/js/chatbox.js"></script>
<script src="${pageContext.request.contextPath}/js/content.js"></script>

<script>
// Logout logic
const logoutBtn = document.querySelector('.logout-btn');
if (logoutBtn) {
    logoutBtn.addEventListener('click', function() {
        fetch('UserServlet?action=logout', { method: 'POST' })
            .then(() => {
                window.location.href = 'login.jsp'; // Redirect to login page after logout
            })
            .catch(error => {
                console.error('Logout error:', error);
                window.location.href = 'login.jsp';
            });
    });
}
</script>

<script>
    function openModalTest(){
         const div = document.getElementById('nguyentest');
        
        div.style.display = "block";
    }
</script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>