<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Test Candidate List | TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-12">
                <h1>Test Candidate List</h1>
                
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger">
                        <strong>Error:</strong> ${param.error}
                        <c:if test="${not empty param.message}">
                            <br>Message: ${param.message}
                        </c:if>
                        <c:if test="${not empty param.role}">
                            <br>Role ID: ${param.role}
                        </c:if>
                    </div>
                </c:if>
                
                <div class="card">
                    <div class="card-header">
                        <h5>Test Links</h5>
                    </div>
                    <div class="card-body">
                        <a href="CandidateViewListServlet" class="btn btn-primary me-2">
                            <i class="fas fa-users me-2"></i>Test Candidate List Servlet
                        </a>
                        
                        <a href="companyHome.jsp" class="btn btn-secondary me-2">
                            <i class="fas fa-home me-2"></i>Go to Company Home
                        </a>
                        
                        <a href="index.jsp" class="btn btn-info">
                            <i class="fas fa-arrow-left me-2"></i>Go to Index
                        </a>
                    </div>
                </div>
                
                <div class="card mt-3">
                    <div class="card-header">
                        <h5>Session Information</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty sessionScope.user}">
                            <p><strong>User ID:</strong> ${sessionScope.user.id}</p>
                            <p><strong>Name:</strong> ${sessionScope.user.name}</p>
                            <p><strong>Email:</strong> ${sessionScope.user.email}</p>
                            <p><strong>Role ID:</strong> ${sessionScope.user.roleId}</p>
                            <p><strong>Status:</strong> ${sessionScope.user.status}</p>
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            <p class="text-warning">No user logged in</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 