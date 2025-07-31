<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP - TechSign</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .verify-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 500px;
            width: 100%;
        }
        .verify-header {
            background: linear-gradient(135deg, #17ac6a 0%, #15a85e 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .verify-body {
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
        .btn-outline-secondary {
            border-radius: 10px;
            border: 2px solid #6c757d;
            padding: 12px;
            font-weight: 600;
        }
        .alert {
            border-radius: 10px;
            border: none;
        }
        .otp-input {
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            letter-spacing: 0.5rem;
        }
        .email-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            text-align: center;
        }
        .password-requirements {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="verify-container">
                    <div class="verify-header">
                        <i class="fas fa-shield-alt fa-3x mb-3"></i>
                        <h3>OTP Authentication</h3>
                        <p class="mb-0">Enter OTP code and new password</p>
                    </div>
                    
                    <div class="verify-body">
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
                        
                        <div class="email-info">
                            <p>Email: ${email}</p>
                            <p>Mã OTP sẽ hết hạn vào: <fmt:formatDate value="${sessionScope.otp_expires_at}" pattern="HH:mm:ss dd/MM/yyyy" /></p>
                        </div>
                        
                        <div class="text-center mb-3">
                            <a href="${pageContext.request.contextPath}/ForgotPasswordServlet?step=verify&action=resend_otp" class="btn btn-link">
                                <i class="fas fa-sync-alt me-1"></i>
                                Gửi lại mã OTP
                            </a>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/ForgotPasswordServlet" method="post">
                            <input type="hidden" name="action" value="verify_otp">
                            
                            <div class="mb-3">
                                <label for="otp_code" class="form-label">
                                    <i class="fas fa-key me-2"></i>OTP code (6 digits)
                                </label>
                                <input type="text" class="form-control otp-input" id="otp_code" name="otp_code" 
                                       maxlength="6" required placeholder="000000" pattern="[0-9]{6}">
                                <div class="form-text">OTP code is valid for 10 minutes</div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="new_password" class="form-label">
                                    <i class="fas fa-lock me-2"></i>New Password
                                </label>
                                <input type="password" class="form-control" id="new_password" name="new_password" 
                                       required placeholder="Enter new password">
                                <div class="password-requirements">
                                    Yêu cầu mật khẩu:<br>
                                    - Từ 8 đến 50 ký tự<br>
                                    - Phải có ít nhất 1 chữ hoa<br>
                                    - Phải có ít nhất 1 chữ thường<br>
                                    - Phải có ít nhất 1 số<br>
                                    - Phải có ít nhất 1 ký tự đặc biệt (!@#$%^&*()_+\-=\[\]{};':""\|,.<>/?)
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="confirm_password" class="form-label">
                                    <i class="fas fa-lock me-2"></i>Confirm Password
                                </label>
                                <input type="password" class="form-control" id="confirm_password" name="confirm_password" 
                                       required placeholder="Re-enter new password">
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-check me-2"></i>
                                    Reset Password
                                </button>
                                
                                <a href="${pageContext.request.contextPath}/ForgotPasswordServlet" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>
                                    Come back
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-format OTP input
        document.getElementById('otp_code').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
        
        // Password confirmation validation
        document.getElementById('confirm_password').addEventListener('input', function(e) {
            const password = document.getElementById('new_password').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                this.setCustomValidity('');
            }
        });
        
        document.getElementById('new_password').addEventListener('input', function(e) {
            const confirmPassword = document.getElementById('confirm_password');
            if (confirmPassword.value) {
                confirmPassword.dispatchEvent(new Event('input'));
            }
        });
    </script>
</body>
</html>
