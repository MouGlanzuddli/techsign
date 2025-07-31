<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${job.title} - ${company.fullName} | TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #17ac6a;
            --primary-dark: #139756;
            --secondary-color: #28a745;
            --accent-color: #f8f9fa;
            --text-dark: #2d3748;
            --text-muted: #718096;
            --border-color: #e2e8f0;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
            --shadow-lg: 0 10px 25px rgba(0,0,0,0.1);
            --border-radius: 12px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            font-family: 'Inter', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        /* Enhanced Hero Section */
        .job-hero {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 60px 0;
            position: relative;
            overflow: hidden;
        }

        .job-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }

        .job-hero .container {
            position: relative;
            z-index: 2;
        }

        .company-avatar {
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.2);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: 700;
            color: white;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255,255,255,0.3);
        }

        .job-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 20px;
        }

        .job-badge {
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.3);
        }

        .badge-featured {
            background: rgba(255, 193, 7, 0.9);
            color: #000;
        }

        .badge-urgent {
            background: rgba(220, 53, 69, 0.9);
            color: white;
        }

        .badge-type {
            background: rgba(255,255,255,0.2);
            color: white;
        }

        /* Main Content */
        .main-content {
            margin-top: -40px;
            position: relative;
            z-index: 3;
        }

        .content-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .content-card-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 25px;
            border-bottom: 1px solid var(--border-color);
        }

        .content-card-body {
            padding: 30px;
        }

        .section-title {
            color: var(--text-dark);
            font-weight: 700;
            font-size: 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title i {
            color: var(--primary-color);
            font-size: 24px;
        }

        /* Sidebar Enhancements */
        .sidebar-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-color);
            overflow: hidden;
            margin-bottom: 25px;
            position: sticky;
            top: 20px;
        }

        .sidebar-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px;
            text-align: center;
        }

        .sidebar-body {
            padding: 25px;
        }

        /* Apply Button Enhancement */
        .btn-apply {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 700;
            border-radius: 10px;
            color: white;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .btn-apply::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: var(--transition);
        }

        .btn-apply:hover::before {
            left: 100%;
        }

        .btn-apply:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(23, 172, 106, 0.4);
        }

        .btn-applied {
            background: #6c757d;
            cursor: not-allowed;
        }

        .btn-applied:hover {
            transform: none;
            box-shadow: none;
        }

        .btn-save {
            background: white;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            transition: var(--transition);
        }

        .btn-save:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        /* Info Items */
        .info-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #f1f3f4;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
            margin-right: 15px;
        }

        .info-content h6 {
            margin: 0;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 14px;
        }

        .info-content p {
            margin: 0;
            color: var(--text-muted);
            font-size: 16px;
            font-weight: 500;
        }

        /* Success/Error Messages */
        .alert {
            border-radius: 10px;
            border: none;
            padding: 15px 20px;
            margin-bottom: 25px;
            font-weight: 500;
        }

        .alert-success {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .alert-danger {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        /* Related Jobs */
        .related-job-item {
            padding: 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            margin-bottom: 15px;
            transition: var(--transition);
        }

        .related-job-item:hover {
            border-color: var(--primary-color);
            box-shadow: var(--shadow-sm);
            transform: translateY(-2px);
        }

        .related-job-title {
            font-weight: 600;
            color: var(--text-dark);
            text-decoration: none;
            font-size: 16px;
        }

        .related-job-title:hover {
            color: var(--primary-color);
        }

        .related-job-meta {
            color: var(--text-muted);
            font-size: 14px;
            margin-top: 5px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .job-hero {
                padding: 40px 0;
            }
            
            .company-avatar {
                width: 60px;
                height: 60px;
                font-size: 24px;
            }
            
            .main-content {
                margin-top: -20px;
            }
            
            .content-card-body,
            .sidebar-body {
                padding: 20px;
            }
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .content-card {
            animation: fadeInUp 0.6s ease-out;
        }

        .sidebar-card {
            animation: fadeInUp 0.6s ease-out 0.2s both;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <div class="header header-transparent change-logo">
        <div class="container">
            <nav id="navigation" class="navigation navigation-landscape">
                <div class="nav-header">
                    <a class="nav-brand static-logo" href="index.jsp">
                        <img src="${pageContext.request.contextPath}/assets/img/logo-light.png" class="logo" alt="TechSign">
                    </a>
                    <a class="nav-brand fixed-logo" href="index.jsp">
                        <img src="${pageContext.request.contextPath}/assets/img/logo.png" class="logo" alt="TechSign">
                    </a>
                    <div class="nav-toggle"></div>
                </div>
                <div class="nav-menus-wrapper">
                    <ul class="nav-menu">
                        <li><a href="index.jsp">Trang chủ</a></li>
                        <li><a href="JobListServlet">Việc làm</a></li>
                        <li><a href="companies.jsp">Công ty</a></li>
                        <li><a href="#">Trợ giúp</a></li>
                    </ul>
                    <ul class="nav-menu nav-menu-social align-to-right">
                        <c:choose>
                            <c:when test="${not empty currentUser}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                        <div class="d-flex align-items-center">
                                            <div class="company-avatar me-2" style="width: 32px; height: 32px; font-size: 14px;">
                                                ${currentUser.fullName.substring(0,1).toUpperCase()}
                                            </div>
                                            ${currentUser.fullName}
                                        </div>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user me-2"></i>Hồ sơ</a></li>
                                        <c:if test="${currentUser.roleId == 2}">
                                            <li><a class="dropdown-item" href="MyApplicationsServlet"><i class="fas fa-file-alt me-2"></i>Đơn ứng tuyển</a></li>
                                        </c:if>
                                        <c:if test="${currentUser.roleId == 1}">
                                            <li><a class="dropdown-item" href="ManageApplicationsServlet"><i class="fas fa-users me-2"></i>Quản lý ứng viên</a></li>
                                        </c:if>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="LogoutServlet"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                                    </ul>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login">
                                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                </a></li>
                                <li class="list-buttons ms-2">
                                    <a href="signup.jsp"><i class="fa-solid fa-user-plus me-2"></i>Đăng ký</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </nav>
        </div>
    </div>

    <!-- Job Hero Section -->
    <div class="job-hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-2 text-center mb-3 mb-md-0">
                    <div class="company-avatar mx-auto">
                        ${company.fullName.substring(0,1).toUpperCase()}
                    </div>
                </div>
                <div class="col-md-8">
                    <h1 class="mb-2 display-5 fw-bold">${job.title}</h1>
                    <h4 class="mb-3 opacity-90">${company.fullName}</h4>
                    <div class="job-badges">
                        <c:if test="${job.featured}">
                            <span class="job-badge badge-featured">
                                <i class="fas fa-star me-1"></i>Nổi bật
                            </span>
                        </c:if>
                        <c:if test="${job.urgent}">
                            <span class="job-badge badge-urgent">
                                <i class="fas fa-bolt me-1"></i>Gấp
                            </span>
                        </c:if>
                        <span class="job-badge badge-type">
                            <i class="fas fa-briefcase me-1"></i>${job.jobType}
                        </span>
                        <span class="job-badge badge-type">
                            <i class="fas fa-layer-group me-1"></i>${job.jobLevel}
                        </span>
                    </div>
                </div>
                <div class="col-md-2 text-center text-white">
                    <div class="mb-2">
                        <i class="fas fa-eye me-1"></i> ${job.viewsCount} lượt xem
                    </div>
                    <div>
                        <i class="fas fa-calendar me-1"></i> 
                        <fmt:formatDate value="${job.createdAt}" pattern="dd/MM/yyyy"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <!-- Success/Error Messages -->
            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i>
                    <c:choose>
                        <c:when test="${param.success == 'applied'}">
                            <strong>Thành công!</strong> Bạn đã nộp đơn ứng tuyển thành công. Chúng tôi sẽ liên hệ với bạn sớm nhất có thể.
                        </c:when>
                        <c:otherwise>Thao tác thành công!</c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <c:choose>
                        <c:when test="${param.error == 'already_applied'}">
                            <strong>Thông báo!</strong> Bạn đã ứng tuyển vào vị trí này rồi.
                        </c:when>
                        <c:when test="${param.error == 'not_candidate'}">
                            <strong>Lỗi!</strong> Chỉ ứng viên mới có thể ứng tuyển.
                        </c:when>
                        <c:otherwise>Có lỗi xảy ra. Vui lòng thử lại!</c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="row">
                <!-- Job Details -->
                <div class="col-lg-8">
                    <!-- Salary Information -->
                    <c:if test="${not empty job.salaryMin or not empty job.salaryMax}">
                        <div class="content-card">
                            <div class="content-card-header text-center">
                                <h3 class="mb-0 text-success">
                                    <i class="fas fa-money-bill-wave me-2"></i>
                                    <c:choose>
                                        <c:when test="${not empty job.salaryMin and not empty job.salaryMax}">
                                            <fmt:formatNumber value="${job.salaryMin}" pattern="#,###"/> - <fmt:formatNumber value="${job.salaryMax}" pattern="#,###"/> triệu VND
                                        </c:when>
                                        <c:when test="${not empty job.salaryMin}">
                                            Từ <fmt:formatNumber value="${job.salaryMin}" pattern="#,###"/> triệu VND
                                        </c:when>
                                        <c:when test="${not empty job.salaryMax}">
                                            Lên đến <fmt:formatNumber value="${job.salaryMax}" pattern="#,###"/> triệu VND
                                        </c:when>
                                    </c:choose>
                                </h3>
                                <small class="text-muted">Mức lương hấp dẫn</small>
                            </div>
                        </div>
                    </c:if>

                    <!-- Job Description -->
                    <div class="content-card">
                        <div class="content-card-body">
                            <h3 class="section-title">
                                <i class="fas fa-file-alt"></i>
                                Mô tả công việc
                            </h3>
                            <div class="job-description">
                                ${job.description}
                            </div>
                        </div>
                    </div>

                    <!-- Requirements -->
                    <c:if test="${not empty job.requirements}">
                        <div class="content-card">
                            <div class="content-card-body">
                                <h3 class="section-title">
                                    <i class="fas fa-list-check"></i>
                                    Yêu cầu ứng viên
                                </h3>
                                <div class="job-requirements">
                                    ${job.requirements}
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Benefits -->
                    <c:if test="${not empty job.benefits}">
                        <div class="content-card">
                            <div class="content-card-body">
                                <h3 class="section-title">
                                    <i class="fas fa-gift"></i>
                                    Quyền lợi được hưởng
                                </h3>
                                <div class="job-benefits">
                                    ${job.benefits}
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <!-- Apply Section -->
                    <div class="sidebar-card">
                        <div class="sidebar-header">
                            <h5 class="mb-0">Ứng tuyển ngay</h5>
                        </div>
                        <div class="sidebar-body text-center">
                            <c:choose>
                                <c:when test="${not empty currentUser and currentUser.roleId == 2}">
                                    <c:choose>
                                        <c:when test="${hasApplied}">
                                            <button class="btn btn-applied w-100 mb-3" disabled>
                                                <i class="fas fa-check me-2"></i>Đã ứng tuyển
                                            </button>
                                            <a href="MyApplicationsServlet" class="btn btn-outline-primary w-100">
                                                <i class="fas fa-eye me-2"></i>Xem đơn ứng tuyển
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="ApplyJobServlet?id=${job.id}" class="btn btn-apply w-100 mb-3">
                                                <i class="fas fa-paper-plane me-2"></i>Ứng tuyển ngay
                                            </a>
                                            <button class="btn btn-save w-100">
                                                <i class="fas fa-heart me-2"></i>Lưu việc làm
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:when test="${not empty currentUser and currentUser.roleId == 1}">
                                    <p class="text-muted mb-3">Bạn là nhà tuyển dụng</p>
                                    <a href="ManageApplicationsServlet?jobId=${job.id}" class="btn btn-apply w-100">
                                        <i class="fas fa-users me-2"></i>Xem ứng viên
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted mb-3">Vui lòng đăng nhập để ứng tuyển</p>
                                    <a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login" 
                                       class="btn btn-apply w-100">
                                        <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Job Information -->
                    <div class="sidebar-card">
                        <div class="sidebar-body">
                            <h5 class="mb-4">
                                <i class="fas fa-info-circle me-2 text-primary"></i>
                                Thông tin công việc
                            </h5>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="info-content">
                                    <h6>Địa điểm</h6>
                                    <p>${job.location}</p>
                                </div>
                            </div>

                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-layer-group"></i>
                                </div>
                                <div class="info-content">
                                    <h6>Ngành nghề</h6>
                                    <p>${job.category}</p>
                                </div>
                            </div>

                            <c:if test="${job.experienceRequired > 0}">
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-user-tie"></i>
                                    </div>
                                    <div class="info-content">
                                        <h6>Kinh nghiệm</h6>
                                        <p>${job.experienceRequired} năm</p>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${not empty job.applicationDeadline}">
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-calendar-times"></i>
                                    </div>
                                    <div class="info-content">
                                        <h6>Hạn nộp hồ sơ</h6>
                                        <p><fmt:formatDate value="${job.applicationDeadline}" pattern="dd/MM/yyyy"/></p>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Company Information -->
                    <div class="sidebar-card">
                        <div class="sidebar-body text-center">
                            <div class="company-avatar mx-auto mb-3" style="width: 60px; height: 60px; font-size: 24px;">
                                ${company.fullName.substring(0,1).toUpperCase()}
                            </div>
                            <h5 class="mb-3">${company.fullName}</h5>
                            <a href="company-profile.jsp?id=${company.id}" class="btn btn-outline-primary w-100">
                                <i class="fas fa-building me-2"></i>Xem thông tin công ty
                            </a>
                        </div>
                    </div>

                    <!-- Related Jobs -->
                    <c:if test="${not empty relatedJobs}">
                        <div class="sidebar-card">
                            <div class="sidebar-body">
                                <h5 class="mb-4">
                                    <i class="fas fa-list me-2 text-primary"></i>
                                    Việc làm liên quan
                                </h5>
                                <c:forEach var="relatedJob" items="${relatedJobs}" varStatus="status">
                                    <c:if test="${status.index < 3}">
                                        <div class="related-job-item">
                                            <a href="JobDetailServlet?id=${relatedJob.id}" class="related-job-title">
                                                ${relatedJob.title}
                                            </a>
                                            <div class="related-job-meta">
                                                <i class="fas fa-map-marker-alt me-1"></i>${relatedJob.location}
                                                <span class="mx-2">•</span>
                                                <i class="fas fa-briefcase me-1"></i>${relatedJob.jobType}
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <a href="JobListServlet?category=${job.category}" class="btn btn-outline-primary w-100 mt-3">
                                    Xem thêm việc làm tương tự
                                </a>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Login Modal -->
    <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="loginmodal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered login-pop-form" role="document">
            <div class="modal-content" id="loginmodal">
                <span class="mod-close" data-bs-dismiss="modal" aria-hidden="true">
                    <i class="fas fa-times"></i>
                </span>
                <div class="modal-header text-center">
                    <div class="w-100">
                        <div class="mdl-thumb mb-3">
                            <img src="${pageContext.request.contextPath}/assets/img/ico.png" class="img-fluid" width="70" alt="TechSign">
                        </div>
                        <div class="mdl-title">
                            <h4 class="modal-header-title mb-2">Chào mừng trở lại!</h4>
                            <p class="text-muted">Đăng nhập để ứng tuyển công việc</p>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="modal-login-form">
                        <form action="${pageContext.request.contextPath}/LoginServlet" method="POST">
                            <div class="form-floating mb-4">
                                <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                                <label>Địa chỉ Email</label>
                            </div>
                            <div class="form-floating mb-4">
                                <input type="password" name="password" class="form-control" placeholder="Password" required>
                                <label>Mật khẩu</label>
                            </div>
                            <div class="form-group mb-4">
                                <button type="submit" class="btn btn-apply w-100">
                                    Đăng nhập
                                </button>
                            </div>
                            <div class="modal-flex-item mb-3">
                                <div class="modal-flex-first">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="rem" id="savepassword" value="on">
                                        <label class="form-check-label" for="savepassword">Ghi nhớ đăng nhập</label>
                                    </div>
                                </div>
                                <div class="modal-flex-last">
                                    <a href="forgot-password.jsp" class="text-primary">Quên mật khẩu?</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer text-center">
                    <p class="mb-0">Chưa có tài khoản? 
                        <a href="${pageContext.request.contextPath}/SignupServlet" class="text-primary font--bold">
                            Đăng ký ngay
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/custom.js"></script>
    
    <script>
        $(document).ready(function() {
            // Auto-hide alerts after 5 seconds
            setTimeout(function() {
                $('.alert').fadeOut();
            }, 5000);
            
            // Smooth scroll for anchor links
            $('a[href^="#"]').on('click', function(event) {
                var target = $(this.getAttribute('href'));
                if( target.length ) {
                    event.preventDefault();
                    $('html, body').stop().animate({
                        scrollTop: target.offset().top - 100
                    }, 1000);
                }
            });
            
            // Save job functionality (placeholder)
            $('.btn-save').on('click', function() {
                $(this).toggleClass('saved');
                if ($(this).hasClass('saved')) {
                    $(this).html('<i class="fas fa-heart me-2"></i>Đã lưu');
                    $(this).removeClass('btn-save').addClass('btn-success');
                } else {
                    $(this).html('<i class="fas fa-heart me-2"></i>Lưu việc làm');
                    $(this).removeClass('btn-success').addClass('btn-save');
                }
            });
        });
    </script>
</body>
</html>
