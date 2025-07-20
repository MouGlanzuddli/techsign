<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý đơn ứng tuyển | TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #17ac6a;
            --secondary-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --info-color: #17a2b8;
            --light-bg: #f8f9fa;
            --border-color: #dee2e6;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--light-bg);
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .page-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .stats-row {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .stat-card {
            flex: 1;
            min-width: 200px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        .stat-number {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #666;
            font-size: 14px;
        }

        .stat-pending { color: var(--warning-color); }
        .stat-approved { color: var(--primary-color); }
        .stat-rejected { color: var(--danger-color); }
        .stat-total { color: var(--info-color); }

        .applications-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .applications-header {
            padding: 20px;
            border-bottom: 1px solid var(--border-color);
            background: #f8f9fa;
        }

        .applications-body {
            padding: 20px;
        }

        .application-item {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        .application-item:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }

        .application-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .candidate-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .candidate-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 18px;
        }

        .candidate-details h5 {
            margin: 0;
            color: #333;
        }

        .candidate-details p {
            margin: 5px 0 0 0;
            color: #666;
            font-size: 14px;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-approved {
            background: #d4edda;
            color: #155724;
        }

        .status-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        .application-body {
            margin-bottom: 15px;
        }

        .job-title {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .application-meta {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .cover-letter {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            border-left: 4px solid var(--primary-color);
            margin-bottom: 15px;
        }

        .cover-letter h6 {
            margin: 0 0 10px 0;
            color: #333;
        }

        .cover-letter p {
            margin: 0;
            color: #666;
            line-height: 1.6;
        }

        .application-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-success {
            background: var(--secondary-color);
            color: white;
        }

        .btn-danger {
            background: var(--danger-color);
            color: white;
        }

        .btn-outline-primary {
            background: white;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .cv-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .no-applications {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .no-applications i {
            font-size: 64px;
            margin-bottom: 20px;
            color: #ddd;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .stats-row {
                flex-direction: column;
            }
            
            .application-header {
                flex-direction: column;
                gap: 10px;
            }
            
            .application-actions {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="mb-2">
                <i class="fas fa-users me-2"></i>
                Quản lý đơn ứng tuyển
            </h1>
            <p class="mb-0">
                <c:choose>
                    <c:when test="${not empty selectedJob}">
                        Đơn ứng tuyển cho vị trí: <strong>${selectedJob.title}</strong>
                    </c:when>
                    <c:otherwise>
                        Tất cả đơn ứng tuyển của bạn
                    </c:otherwise>
                </c:choose>
            </p>
        </div>

        <!-- Statistics -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-number stat-total">${applications.size()}</div>
                <div class="stat-label">Tổng đơn ứng tuyển</div>
            </div>
            <div class="stat-card">
                <div class="stat-number stat-pending">
                    <c:set var="pendingCount" value="0"/>
                    <c:forEach var="app" items="${applications}">
                        <c:if test="${app.status == 'pending'}">
                            <c:set var="pendingCount" value="${pendingCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${pendingCount}
                </div>
                <div class="stat-label">Đang chờ</div>
            </div>
            <div class="stat-card">
                <div class="stat-number stat-approved">
                    <c:set var="approvedCount" value="0"/>
                    <c:forEach var="app" items="${applications}">
                        <c:if test="${app.status == 'approved'}">
                            <c:set var="approvedCount" value="${approvedCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${approvedCount}
                </div>
                <div class="stat-label">Được duyệt</div>
            </div>
            <div class="stat-card">
                <div class="stat-number stat-rejected">
                    <c:set var="rejectedCount" value="0"/>
                    <c:forEach var="app" items="${applications}">
                        <c:if test="${app.status == 'rejected'}">
                            <c:set var="rejectedCount" value="${rejectedCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${rejectedCount}
                </div>
                <div class="stat-label">Từ chối</div>
            </div>
        </div>

        <!-- Applications List -->
        <div class="applications-container">
            <div class="applications-header">
                <h4 class="mb-0">
                    <i class="fas fa-file-alt me-2"></i>
                    Danh sách đơn ứng tuyển
                </h4>
            </div>
            <div class="applications-body">
                <c:choose>
                    <c:when test="${not empty applications}">
                        <c:forEach var="application" items="${applications}">
                            <div class="application-item">
                                <div class="application-header">
                                    <div class="candidate-info">
                                        <div class="candidate-avatar">
                                            ${candidateMap[application.candidateId].fullName.substring(0,1).toUpperCase()}
                                        </div>
                                        <div class="candidate-details">
                                            <h5>${candidateMap[application.candidateId].fullName}</h5>
                                            <p><i class="fas fa-envelope me-1"></i>${candidateMap[application.candidateId].email}</p>
                                        </div>
                                    </div>
                                    <span class="status-badge status-${application.status}">
                                        <c:choose>
                                            <c:when test="${application.status == 'pending'}">Đang chờ</c:when>
                                            <c:when test="${application.status == 'approved'}">Được duyệt</c:when>
                                            <c:when test="${application.status == 'rejected'}">Từ chối</c:when>
                                            <c:otherwise>${application.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                
                                <div class="application-body">
                                    <c:if test="${empty selectedJob}">
                                        <div class="job-title">
                                            <i class="fas fa-briefcase me-1"></i>
                                            ${jobMap[application.jobId].title}
                                        </div>
                                    </c:if>
                                    
                                    <div class="application-meta">
                                        <i class="fas fa-calendar me-1"></i>
                                        Ứng tuyển ngày: <fmt:formatDate value="${application.appliedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </div>
                                    
                                    <c:if test="${not empty application.coverLetter}">
                                        <div class="cover-letter">
                                            <h6><i class="fas fa-file-text me-1"></i>Thư xin việc:</h6>
                                            <p>${application.coverLetter}</p>
                                        </div>
                                    </c:if>
                                    
                                    <!-- CV Actions -->
                                    <c:if test="${not empty application.cvFileName}">
                                        <div class="cv-actions">
                                            <a href="CVPreviewServlet?file=${application.cvFileName}&applicationId=${application.id}&action=view" 
                                               class="btn btn-outline-primary" target="_blank">
                                                <i class="fas fa-eye"></i> Xem CV
                                            </a>
                                            <a href="CVPreviewServlet?file=${application.cvFileName}&applicationId=${application.id}&action=download" 
                                               class="btn btn-primary">
                                                <i class="fas fa-download"></i> Tải CV
                                            </a>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="application-actions">
                                    <c:if test="${application.status == 'pending'}">
                                        <form method="post" action="ManageApplicationsServlet" style="display: inline;">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="applicationId" value="${application.id}">
                                            <input type="hidden" name="status" value="approved">
                                            <input type="hidden" name="jobId" value="${param.jobId}">
                                            <button type="submit" class="btn btn-success">
                                                <i class="fas fa-check"></i> Duyệt
                                            </button>
                                        </form>
                                        <form method="post" action="ManageApplicationsServlet" style="display: inline;">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="applicationId" value="${application.id}">
                                            <input type="hidden" name="status" value="rejected">
                                            <input type="hidden" name="jobId" value="${param.jobId}">
                                            <button type="submit" class="btn btn-danger">
                                                <i class="fas fa-times"></i> Từ chối
                                            </button>
                                        </form>
                                    </c:if>
                                    
                                    <a href="mailto:${candidateMap[application.candidateId].email}" class="btn btn-outline-primary">
                                        <i class="fas fa-envelope"></i> Liên hệ
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-applications">
                            <i class="fas fa-inbox"></i>
                            <h4>Chưa có đơn ứng tuyển nào</h4>
                            <p>Các đơn ứng tuyển sẽ hiển thị tại đây khi có ứng viên nộp đơn.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            // Confirm before status change
            $('form').on('submit', function(e) {
                const action = $(this).find('input[name="status"]').val();
                const actionText = action === 'approved' ? 'duyệt' : 'từ chối';
                
                if (!confirm(`Bạn có chắc chắn muốn ${actionText} đơn ứng tuyển này không?`)) {
                    e.preventDefault();
                }
            });
            
            // Auto-hide alerts
            setTimeout(function() {
                $('.alert').fadeOut();
            }, 5000);
        });
    </script>
</body>
</html>
