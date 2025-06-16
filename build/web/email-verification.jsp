<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực Email - TechSign</title>
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <style>
        .otp-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .otp-input-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }
        .otp-input {
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            border: 2px solid #ddd;
            border-radius: 8px;
            outline: none;
        }
        .otp-input:focus {
            border-color: #17ac6a;
        }
        .otp-input.filled {
            border-color: #17ac6a;
            background-color: #f0f9f4;
        }
        .resend-timer {
            text-align: center;
            margin: 15px 0;
            color: #666;
        }
        .alert {
            padding: 12px;
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
        .btn-resend {
            background: none;
            border: none;
            color: #17ac6a;
            text-decoration: underline;
            cursor: pointer;
        }
        .btn-resend:disabled {
            color: #ccc;
            cursor: not-allowed;
            text-decoration: none;
        }
    </style>
</head>
<body class="green-theme">
    <div class="container">
        <div class="otp-container">
            <div class="text-center mb-4">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="TechSign" width="120">
                <h2 class="mt-3">Xác thực Email</h2>
                <p class="text-muted">Chúng tôi đã gửi mã OTP 6 số đến email: <strong id="userEmail"></strong></p>
            </div>

            <div id="alertContainer"></div>

            <form id="otpForm">
                <div class="otp-input-group">
                    <input type="text" class="otp-input" maxlength="1" data-index="0">
                    <input type="text" class="otp-input" maxlength="1" data-index="1">
                    <input type="text" class="otp-input" maxlength="1" data-index="2">
                    <input type="text" class="otp-input" maxlength="1" data-index="3">
                    <input type="text" class="otp-input" maxlength="1" data-index="4">
                    <input type="text" class="otp-input" maxlength="1" data-index="5">
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary btn-lg" id="verifyBtn">
                        <span id="verifyBtnText">Xác thực</span>
                        <span id="verifySpinner" class="spinner-border spinner-border-sm d-none" role="status"></span>
                    </button>
                </div>
            </form>

            <div class="resend-timer">
                <span id="timerText">Gửi lại mã sau: <span id="countdown">60</span>s</span>
                <button type="button" class="btn-resend d-none" id="resendBtn">Gửi lại mã OTP</button>
            </div>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/index.jsp" class="text-muted">← Quay lại trang chủ</a>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            const email = new URLSearchParams(window.location.search).get('email');
            if (!email) {
                window.location.href = '${pageContext.request.contextPath}/index.jsp';
                return;
            }
            
            $('#userEmail').text(email);
            
            // OTP Input handling
            $('.otp-input').on('input', function() {
                const $this = $(this);
                const value = $this.val();
                
                if (value.length === 1) {
                    $this.addClass('filled');
                    const nextIndex = parseInt($this.data('index')) + 1;
                    if (nextIndex < 6) {
                        $(`.otp-input[data-index="${nextIndex}"]`).focus();
                    }
                } else {
                    $this.removeClass('filled');
                }
                
                // Auto submit when all fields are filled
                if ($('.otp-input.filled').length === 6) {
                    $('#otpForm').submit();
                }
            });
            
            $('.otp-input').on('keydown', function(e) {
                if (e.key === 'Backspace' && $(this).val() === '') {
                    const prevIndex = parseInt($(this).data('index')) - 1;
                    if (prevIndex >= 0) {
                        $(`.otp-input[data-index="${prevIndex}"]`).focus();
                    }
                }
            });
            
            // Form submission
            $('#otpForm').on('submit', function(e) {
                e.preventDefault();
                
                let otp = '';
                $('.otp-input').each(function() {
                    otp += $(this).val();
                });
                
                if (otp.length !== 6) {
                    showAlert('Vui lòng nhập đầy đủ 6 số OTP', 'danger');
                    return;
                }
                
                setLoading(true);
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/VerifyOtpServlet',
                    method: 'POST',
                    data: {
                        email: email,
                        otp: otp
                    },
                    success: function(response) {
                        if (response.success) {
                            showAlert(response.message, 'success');
                            setTimeout(function() {
                                window.location.href = '${pageContext.request.contextPath}/index.jsp';
                            }, 2000);
                        } else {
                            showAlert(response.message, 'danger');
                            clearOtpInputs();
                        }
                    },
                    error: function() {
                        showAlert('Có lỗi xảy ra. Vui lòng thử lại.', 'danger');
                        clearOtpInputs();
                    },
                    complete: function() {
                        setLoading(false);
                    }
                });
            });
            
            // Resend OTP
            $('#resendBtn').on('click', function() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/SendOtpServlet',
                    method: 'POST',
                    data: { email: email },
                    success: function(response) {
                        if (response.success) {
                            showAlert('Mã OTP mới đã được gửi!', 'success');
                            startCountdown();
                            clearOtpInputs();
                        } else {
                            showAlert(response.message, 'danger');
                        }
                    },
                    error: function() {
                        showAlert('Có lỗi xảy ra khi gửi lại mã OTP.', 'danger');
                    }
                });
            });
            
            // Start countdown timer
            startCountdown();
            
            function startCountdown() {
                let seconds = 60;
                $('#resendBtn').addClass('d-none');
                $('#timerText').removeClass('d-none');
                
                const timer = setInterval(function() {
                    seconds--;
                    $('#countdown').text(seconds);
                    
                    if (seconds <= 0) {
                        clearInterval(timer);
                        $('#timerText').addClass('d-none');
                        $('#resendBtn').removeClass('d-none');
                    }
                }, 1000);
            }
            
            function showAlert(message, type) {
                const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
                const alertHtml = `<div class="alert ${alertClass}">${message}</div>`;
                $('#alertContainer').html(alertHtml);
                
                setTimeout(function() {
                    $('#alertContainer').empty();
                }, 5000);
            }
            
            function setLoading(loading) {
                if (loading) {
                    $('#verifyBtnText').addClass('d-none');
                    $('#verifySpinner').removeClass('d-none');
                    $('#verifyBtn').prop('disabled', true);
                } else {
                    $('#verifyBtnText').removeClass('d-none');
                    $('#verifySpinner').addClass('d-none');
                    $('#verifyBtn').prop('disabled', false);
                }
            }
            
            function clearOtpInputs() {
                $('.otp-input').val('').removeClass('filled');
                $('.otp-input').first().focus();
            }
        });
    </script>
</body>
</html>
