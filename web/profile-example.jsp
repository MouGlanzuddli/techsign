<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Người Dùng/Công Ty - TechSign</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Thêm CSS tương tự như các trang khác của bạn */
        .profile-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 30px;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #667eea;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            margin: 0 auto 20px auto;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <!-- Navigation (có thể include từ navigation.jsp của bạn) -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-code text-primary"></i> TechSign
            </a>
            <!-- ... các mục navigation khác ... -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="JobListServlet">Việc làm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="companies.jsp">Công ty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.jsp">Về chúng tôi</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="messages.jsp">Tin nhắn</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i> ${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu">
                                    <c:if test="${sessionScope.user.roleId == 3}">
                                        <li><a class="dropdown-item" href="MyJobsServlet"><i class="fas fa-briefcase me-2"></i>Quản lý tin tuyển dụng</a></li>
                                        <li><a class="dropdown-item" href="PostJobServlet"><i class="fas fa-plus me-2"></i>Đăng tin mới</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <c:if test="${sessionScope.user.roleId == 2}">
                                        <li><a class="dropdown-item" href="my-applications.jsp"><i class="fas fa-file-alt me-2"></i>Ứng tuyển của tôi</a></li>
                                        <li><a class="dropdown-item" href="saved-jobs.jsp"><i class="fas fa-heart me-2"></i>Việc làm đã lưu</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user me-2"></i>Hồ sơ cá nhân</a></li>
                                    <li><a class="dropdown-item" href="settings.jsp"><i class="fas fa-cog me-2"></i>Cài đặt</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="LogoutServlet"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="register.jsp">Đăng ký</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="profile-card text-center">
                    <c:set var="profileUser" value="${requestScope.userProfile}" />
                    <c:if test="${profileUser == null}">
                        <%-- Giả định một người dùng/công ty để minh họa --%>
                        <jsp:useBean id="dummyUser" class="model.User" scope="request">
                            <jsp:setProperty name="dummyUser" property="id" value="2" />
                            <jsp:setProperty name="dummyUser" property="fullName" value="John Doe" />
                            <jsp:setProperty name="dummyUser" property="roleId" value="2" />
                        </jsp:useBean>
                        <c:set var="profileUser" value="${dummyUser}" />
                    </c:if>

                    <div class="profile-avatar">
                        ${profileUser.fullName.substring(0,1).toUpperCase()}
                    </div>
                    <h2>${profileUser.fullName}</h2>
                    <p class="text-muted">
                        <c:choose>
                            <c:when test="${profileUser.roleId == 2}">Ứng viên</c:when>
                            <c:when test="${profileUser.roleId == 3}">Nhà tuyển dụng</c:when>
                            <c:otherwise>Người dùng</c:otherwise>
                        </c:choose>
                    </p>
                    <p>Email: ${profileUser.email}</p>
                    <p>Số điện thoại: ${profileUser.phone}</p>
                    <p>Địa chỉ: ${profileUser.address}</p>

                    <hr class="my-4">

                    <%-- NÚT "MESSAGE" ĐỂ BẮT ĐẦU CUỘC TRÒ CHUYỆN --%>
                    <c:if test="${sessionScope.user != null && sessionScope.user.id != profileUser.id}">
                        <a href="MessageServlet?recipientId=${profileUser.id}" class="btn btn-primary btn-lg">
                            <i class="fas fa-envelope me-2"></i>Nhắn tin
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.user == null}">
                        <p class="text-muted">Đăng nhập để nhắn tin cho người dùng này.</p>
                        <a href="login.jsp" class="btn btn-primary">Đăng nhập</a>
                    </c:if>
                    <%-- KẾT THÚC NÚT "MESSAGE" --%>

                </div>
            </div>
        </div>
    </div>

    <!-- Footer (có thể include từ footer của bạn) -->
    <footer class="bg-dark text-light py-4 mt-auto">
        <div class="container text-center">
            <p class="mb-0">&copy; 2023 TechSign. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
