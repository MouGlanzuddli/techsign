<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kết quả phân quyền</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .result-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .result-icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }
        
        .success-icon {
            color: #4CAF50;
        }
        
        .error-icon {
            color: #f44336;
        }
        
        .result-message {
            font-size: 1.2rem;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .back-button {
            display: inline-block;
            padding: 12px 24px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            transition: background-color 0.3s;
        }
        
        .back-button:hover {
            background: #1d4ed8;
        }
        
        .info-box {
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 6px;
            padding: 20px;
            margin: 20px 0;
            text-align: left;
        }
        
        .info-box h3 {
            margin-top: 0;
            color: #495057;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <% if (request.getAttribute("success") != null && (Boolean) request.getAttribute("success")) { %>
            <div class="result-icon success-icon">✓</div>
            <h2>Thành công!</h2>
        <% } else { %>
            <div class="result-icon error-icon">✗</div>
            <h2>Thông báo</h2>
        <% } %>
        
        <div class="result-message">
            <%= request.getAttribute("message") != null ? request.getAttribute("message") : "Không có thông báo" %>
        </div>
        
        <div class="info-box">
            <h3>Thông tin bổ sung:</h3>
            <ul>
                <li>Bạn có thể đăng nhập vào hệ thống để kiểm tra quyền mới</li>
                <li>Nếu có vấn đề, vui lòng liên hệ admin</li>
                <li>Email xác nhận này chỉ có hiệu lực một lần</li>
            </ul>
        </div>
        
        <a href="${pageContext.request.contextPath}/" class="back-button">
            Về trang chủ
        </a>
    </div>
</body>
</html> 