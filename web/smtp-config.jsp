<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.SmtpConfig" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cấu hình SMTP - TechSign Admin</title>
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .admin-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .form-section {
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #e9ecef;
            border-radius: 8px;
        }
        .form-section h4 {
            color: #17ac6a;
            margin-bottom: 15px;
            border-bottom: 2px solid #17ac6a;
            padding-bottom: 5px;
        }
        .alert {
            padding: 12px 20px;
            border-radius: 5px;
            margin: 15px 0;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .btn-test {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #212529;
        }
        .btn-test:hover {
            background-color: #e0a800;
            border-color: #d39e00;
        }
        .smtp-providers {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        .provider-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        .provider-card:hover {
            border-color: #17ac6a;
            background-color: #f8f9fa;
        }
        .provider-card.active {
            border-color: #17ac6a;
            background-color: #e8f5e8;
        }
    </style>
</head>
<body class="green-theme">
    <div class="container">
        <div class="admin-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-envelope-open-text text-primary me-2"></i>Cấu hình SMTP</h2>
                <a href="${pageContext.request.contextPath}/adminHome.jsp" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Quay lại
                </a>
            </div>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i><%= request.getAttribute("success") %>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i><%= request.getAttribute("error") %>
                </div>
            <% } %>

            <div id="testResult"></div>

            <%
                SmtpConfig smtpConfig = (SmtpConfig) request.getAttribute("smtpConfig");
                if (smtpConfig == null) {
                    smtpConfig = new SmtpConfig();
                }
            %>

            <form id="smtpForm" action="${pageContext.request.contextPath}/admin/SmtpConfigServlet" method="POST">
                <input type="hidden" name="action" value="save">

                <!-- SMTP Provider Templates -->
                <div class="form-section">
                    <h4><i class="fas fa-server me-2"></i>Chọn nhà cung cấp SMTP</h4>
                    <div class="smtp-providers">
                        <div class="provider-card" data-provider="gmail">
                            <i class="fab fa-google text-danger" style="font-size: 24px;"></i>
                            <h6 class="mt-2">Gmail</h6>
                            <small class="text-muted">smtp.gmail.com:587</small>
                        </div>
                        <div class="provider-card" data-provider="outlook">
                            <i class="fab fa-microsoft text-primary" style="font-size: 24px;"></i>
                            <h6 class="mt-2">Outlook</h6>
                            <small class="text-muted">smtp-mail.outlook.com:587</small>
                        </div>
                        <div class="provider-card" data-provider="yahoo">
                            <i class="fab fa-yahoo text-purple" style="font-size: 24px;"></i>
                            <h6 class="mt-2">Yahoo</h6>
                            <small class="text-muted">smtp.mail.yahoo.com:587</small>
                        </div>
                        <div class="provider-card" data-provider="custom">
                            <i class="fas fa-cog text-secondary" style="font-size: 24px;"></i>
                            <h6 class="mt-2">Tùy chỉnh</h6>
                            <small class="text-muted">Cấu hình thủ công</small>
                        </div>
                    </div>
                </div>

                <!-- Server Settings -->
                <div class="form-section">
                    <h4><i class="fas fa-server me-2"></i>Cài đặt Server</h4>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="smtp_host" name="smtp_host" 
                                       value="<%= smtpConfig.getSmtpHost() != null ? smtpConfig.getSmtpHost() : "" %>" required>
                                <label for="smtp_host">SMTP Host</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="smtp_port" name="smtp_port" 
                                       value="<%= smtpConfig.getSmtpPort() != null ? smtpConfig.getSmtpPort() : "587" %>" required>
                                <label for="smtp_port">Port</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="smtp_auth" name="smtp_auth" 
                                       <%= smtpConfig.isSmtpAuth() ? "checked" : "" %>>
                                <label class="form-check-label" for="smtp_auth">
                                    Yêu cầu xác thực (SMTP Auth)
                                </label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="smtp_starttls" name="smtp_starttls" 
                                       <%= smtpConfig.isSmtpStarttls() ? "checked" : "" %>>
                                <label class="form-check-label" for="smtp_starttls">
                                    Sử dụng STARTTLS
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Authentication -->
                <div class="form-section">
                    <h4><i class="fas fa-key me-2"></i>Thông tin xác thực</h4>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="smtp_username" name="smtp_username" 
                                       value="<%= smtpConfig.getSmtpUsername() != null ? smtpConfig.getSmtpUsername() : "" %>" required>
                                <label for="smtp_username">Username/Email</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="smtp_password" name="smtp_password" 
                                       value="<%= smtpConfig.getSmtpPassword() != null ? smtpConfig.getSmtpPassword() : "" %>" required>
                                <label for="smtp_password">Password/App Password</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sender Info -->
                <div class="form-section">
                    <h4><i class="fas fa-user me-2"></i>Thông tin người gửi</h4>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="from_email" name="from_email" 
                                       value="<%= smtpConfig.getFromEmail() != null ? smtpConfig.getFromEmail() : "" %>" required>
                                <label for="from_email">Email người gửi</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="from_name" name="from_name" 
                                       value="<%= smtpConfig.getFromName() != null ? smtpConfig.getFromName() : "TechSign" %>" required>
                                <label for="from_name">Tên người gửi</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="d-flex gap-3">
                    <button type="button" class="btn btn-test" id="testBtn">
                        <i class="fas fa-vial me-2"></i>Test kết nối
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Lưu cấu hình
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // SMTP Provider selection
            $('.provider-card').on('click', function() {
                $('.provider-card').removeClass('active');
                $(this).addClass('active');
                
                const provider = $(this).data('provider');
                setProviderConfig(provider);
            });
            
            // Test SMTP connection
            $('#testBtn').on('click', function() {
                const formData = $('#smtpForm').serialize() + '&action=test';
                
                $(this).prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Đang test...');
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/SmtpConfigServlet',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        const alertClass = response.success ? 'alert-success' : 'alert-danger';
                        const icon = response.success ? 'fa-check-circle' : 'fa-exclamation-circle';
                        
                        $('#testResult').html(
                            `<div class="alert ${alertClass}">
                                <i class="fas ${icon} me-2"></i>${response.message}
                            </div>`
                        );
                        
                        setTimeout(() => $('#testResult').empty(), 5000);
                    },
                    error: function() {
                        $('#testResult').html(
                            '<div class="alert alert-danger">Có lỗi xảy ra khi test kết nối</div>'
                        );
                    },
                    complete: function() {
                        $('#testBtn').prop('disabled', false).html('<i class="fas fa-vial me-2"></i>Test kết nối');
                    }
                });
            });
            
            function setProviderConfig(provider) {
                const configs = {
                    gmail: {
                        host: 'smtp.gmail.com',
                        port: '587',
                        auth: true,
                        starttls: true
                    },
                    outlook: {
                        host: 'smtp-mail.outlook.com',
                        port: '587',
                        auth: true,
                        starttls: true
                    },
                    yahoo: {
                        host: 'smtp.mail.yahoo.com',
                        port: '587',
                        auth: true,
                        starttls: true
                    }
                };
                
                if (configs[provider]) {
                    const config = configs[provider];
                    $('#smtp_host').val(config.host);
                    $('#smtp_port').val(config.port);
                    $('#smtp_auth').prop('checked', config.auth);
                    $('#smtp_starttls').prop('checked', config.starttls);
                }
            }
        });
    </script>
</body>
</html>