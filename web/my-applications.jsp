<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đơn ứng tuyển của tôi | TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .main-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .page-header {
            background: linear-gradient(135deg, #17ac6a, #28a745);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .application-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .application-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        
        .application-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .application-body {
            padding: 20px;
        }
        
        .job-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        
        .company-name {
            color: #17ac6a;
            font-weight: 500;
            margin-bottom: 15px;
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
        
        .application-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .cv-info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-top: 10px;
        }
        
        .cv-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
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
            background: #17ac6a;
            color: white;
        }
        
        .btn-outline-primary {
            background: white;
            color: #17ac6a;
            border: 1px solid #17ac6a;
        }
        
        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="page-header">
            <h1><i class="fas fa-file-alt me-2"></i>Đơn ứng tuyển của tôi</h1>
            <p class="mb-0">Theo dõi trạng thái các đơn ứng tuyển đã nộp</p>
        </div>
        
        <c:forEach var="application" items="${applications}">
            <div class="application-card">
                <div class="application-header">
                    <div class="application-meta">
                        <div>
                            <div class="job-title">${jobMap[application.jobId].title}</div>
                            <div class="company-name">
                                <i class="fas fa-building me-1"></i>
                                ${companyMap[jobMap[application.jobId].employerId].fullName}
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
                </div>
                
                <div class="application-body">
                    <div class="mb-3">
                        <i class="fas fa-calendar me-1"></i>
                        Nộp đơn: <fmt:formatDate value="${application.appliedAt}" pattern="dd/MM/yyyy HH:mm"/>
                    </div>
                    
                    <c:if test="${not empty application.cvFileName}">
                        <div class="cv-info">
                            <h6><i class="fas fa-file-pdf me-1"></i>CV đã nộp:</h6>
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
                        </div>
                    </c:if>
                    
                    <div class="mt-3">
                        <a href="JobDetailServlet?id=${application.jobId}" class="btn btn-outline-primary">
                            <i class="fas fa-eye"></i> Xem công việc
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>
