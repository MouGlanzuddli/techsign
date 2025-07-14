<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Candidates View Analytics | TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <!-- Colors CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .analytics-header {
            background: linear-gradient(135deg, #17ac6a, #28a745);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #17ac6a;
        }
        .candidate-list { 
            display: flex; 
            flex-direction: column; 
            gap: 15px; 
        }
        .candidate-card { 
            display: flex; 
            align-items: center; 
            padding: 20px; 
            border: 1px solid #e0e0e0; 
            border-radius: 10px; 
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .candidate-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .candidate-avatar { 
            width: 70px; 
            height: 70px; 
            border-radius: 50%; 
            object-fit: cover; 
            margin-right: 20px;
            border: 3px solid #f0f0f0;
        }
        .candidate-info { 
            flex: 1; 
        }
        .candidate-info h4 { 
            margin: 0 0 8px 0; 
            color: #333; 
            font-size: 1.1rem;
        }
        .candidate-info p { 
            margin: 4px 0; 
            color: #666; 
            font-size: 0.9rem;
        }
        .view-time {
            color: #17ac6a;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .view-profile-btn { 
            padding: 8px 16px; 
            background: #17ac6a; 
            color: white; 
            text-decoration: none; 
            border-radius: 5px;
            transition: background 0.3s;
            font-size: 0.9rem;
        }
        .view-profile-btn:hover { 
            background: #139756; 
            color: white; 
            text-decoration: none;
        }
        .no-candidates { 
            text-align: center; 
            color: #777; 
            padding: 50px; 
            background: #f8f9fa;
            border-radius: 10px;
        }
        .chart-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .back-btn {
            background: #6c757d;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-bottom: 20px;
        }
        .back-btn:hover {
            background: #5a6268;
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="analytics-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1><i class="fas fa-chart-line me-3"></i>Candidate View Analytics</h1>
                    <p class="mb-0">Theo dõi ứng viên đã xem bài đăng tuyển dụng của bạn</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="companyHome.jsp" class="back-btn">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="stats-card text-center">
                    <i class="fas fa-users fa-2x text-primary mb-3"></i>
                    <div class="stats-number">${totalCandidates}</div>
                    <p class="mb-0">Tổng ứng viên đã xem</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card text-center">
                    <i class="fas fa-eye fa-2x text-success mb-3"></i>
                    <div class="stats-number">
                        <c:set var="totalViews" value="0" />
                        <c:forEach var="stat" items="${viewsStatistics}">
                            <c:set var="totalViews" value="${totalViews + stat[1]}" />
                        </c:forEach>
                        ${totalViews}
                    </div>
                    <p class="mb-0">Lượt xem (7 ngày qua)</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card text-center">
                    <i class="fas fa-calendar-day fa-2x text-info mb-3"></i>
                    <div class="stats-number">${viewsStatistics.size()}</div>
                    <p class="mb-0">Ngày có hoạt động</p>
                </div>
            </div>
        </div>

        <!-- Chart Container -->
        <c:if test="${not empty viewsStatistics}">
            <div class="chart-container">
                <h5><i class="fas fa-chart-bar me-2"></i>Thống kê lượt xem theo ngày</h5>
                <div class="row">
                    <c:forEach var="stat" items="${viewsStatistics}">
                        <div class="col-md-2 col-4 mb-3">
                            <div class="text-center">
                                <div class="stats-number" style="font-size: 1.5rem;">${stat[1]}</div>
                                <small class="text-muted">
                                    <fmt:formatDate value="${stat[0]}" pattern="dd/MM"/>
                                </small>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Candidates List -->
        <div class="stats-card">
            <h5><i class="fas fa-list me-2"></i>Danh sách ứng viên đã xem</h5>
            
            <c:if test="${empty viewedCandidates}">
                <div class="no-candidates">
                    <i class="fas fa-users fa-3x text-muted mb-3"></i>
                    <h4>Chưa có ứng viên nào xem bài đăng</h4>
                    <p>Khi có ứng viên xem bài đăng tuyển dụng của bạn, họ sẽ xuất hiện ở đây.</p>
                </div>
            </c:if>
            
            <c:if test="${not empty viewedCandidates}">
                <div class="candidate-list">
                    <c:forEach var="candidate" items="${viewedCandidates}">
                        <div class="candidate-card">
                            <div class="candidate-avatar">
                                <c:choose>
                                    <c:when test="${not empty candidate.candidateProfile.profilePictureUrl}">
                                        <img src="${candidate.candidateProfile.profilePictureUrl}" alt="${candidate.candidateUser.fullName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width: 100%; height: 100%; background: #17ac6a; color: white; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; font-weight: bold;">
                                            ${candidate.candidateUser.fullName.substring(0,1).toUpperCase()}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="candidate-info">
                                <h4>${candidate.candidateUser.fullName}</h4>
                                <p><i class="fas fa-envelope me-2"></i>${candidate.candidateUser.email}</p>
                                <c:if test="${not empty candidate.candidateProfile}">
                                    <p><i class="fas fa-briefcase me-2"></i>${candidate.candidateProfile.headline != null ? candidate.candidateProfile.headline : 'Chưa cập nhật'}</p>
                                    <p><i class="fas fa-clock me-2"></i>${candidate.candidateProfile.experienceYears} năm kinh nghiệm</p>
                                </c:if>
                                <p class="view-time">
                                    <i class="fas fa-eye me-1"></i>
                                    Đã xem lúc: <fmt:formatDate value="${candidate.viewedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </p>
                            </div>
                            <div class="text-end">
                                <a href="candidate-profile-detail?userId=${candidate.candidateUserId}" class="view-profile-btn">
                                    <i class="fas fa-user me-1"></i>Xem hồ sơ
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container text-center">
            <p>&copy; 2024 TechSign. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>