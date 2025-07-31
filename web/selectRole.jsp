<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chọn vai trò</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .role-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .role-button {
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="role-container">
            <h2 class="text-center mb-4">Chọn vai trò của bạn</h2>
            <div class="role-button">
                <a href="${pageContext.request.contextPath}/LoginGoogleHandler?role=candidate" class="btn btn-primary btn-lg w-100">
                    <i class="fas fa-user me-2"></i>Candidate
                </a>
            </div>
            <div class="role-button">
                <a href="${pageContext.request.contextPath}/LoginGoogleHandler?role=company" class="btn btn-success btn-lg w-100">
                    <i class="fas fa-building me-2"></i>Company
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
