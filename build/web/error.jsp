<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 50px; }
        .error-container { text-align: center; }
        .error-message { color: #d9534f; margin: 20px 0; }
        .back-btn { 
            background: #007bff; 
            color: white; 
            padding: 10px 20px; 
            text-decoration: none; 
            border-radius: 5px; 
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Đã xảy ra lỗi</h1>
        <div class="error-message">
            <c:if test="${not empty error}">
                ${error}
            </c:if>
            <c:if test="${empty error}">
                Có lỗi xảy ra. Vui lòng thử lại.
            </c:if>
        </div>
        <a href="companyHome.jsp" class="back-btn">Quay lại Dashboard</a>
    </div>
</body>
</html> 