<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - TechSign</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .forgot-password-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 450px;
            width: 100%;
        }
        .forgot-password-header {
            background: linear-gradient(135deg, #17ac6a 0%, #15a85e 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .forgot-password-body {
            padding: 2rem;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #17ac6a;
            box-shadow: 0 0 0 0.2rem rgba(23, 172, 106, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #17ac6a 0%, #15a85e 100%);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(23, 172, 106, 0.4);
        }
        .alert {
            border-radius: 10px;
            border: none;
        }
        .back-to-login {
            text-align: center;
            margin-top: 1rem;
        }
        .back-to-login a {
            color: #17ac6a;
            text-decoration: none;
            font-weight: 500;
        }
        .back-to-login a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="forgot-password-container">
                    <div class="forgot-password-header">
                        <i class="fas fa-key fa-3x mb-3"></i>
                        <h3>Forgot Password</h3>
                        <p class="mb-0">Enter email to receive verification code</p>
                    </div>
                    
                    <div class="forgot-password-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                ${error}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle me-2"></i>
                                ${success}
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/ForgotPasswordServlet" method="post">
                            <input type="hidden" name="action" value="send_otp">
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope me-2"></i>Email
                                </label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${email}" required placeholder="Enter your email address">
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-paper-plane me-2"></i>
                                Send Verification Code
                            </button>
                        </form>
                        
                        <div class="back-to-login">
                            <a href="${pageContext.request.contextPath}/index.jsp">
                                <i class="fas fa-arrow-left me-2"></i>
                                Back to login
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
