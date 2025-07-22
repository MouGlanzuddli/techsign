<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>Forgot Password - TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    
    <!-- Colors CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body class="green-theme">
    <!-- Preloader -->
    <div id="preloader">
        <div class="preloader">
            <span></span><span></span>
        </div>
    </div>

    <!-- Main wrapper -->
    <div id="main-wrapper">
        <!-- Forgot Password Section -->
        <div class="image-cover hero-header primary-bg-dark" data-overlay="0">
            <div class="position-absolute top-0 end-0 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-3-soft-light.svg" alt="SVG" width="500">
            </div>
            <div class="position-absolute top-0 start-0 me-10 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-1-soft-light.svg" alt="SVG" width="250">
            </div>

            <div class="container d-flex flex-column justify-content-center position-relative zindex-2 min-vh-100">
                <div class="row justify-content-center">
                    <div class="col-xl-5 col-lg-6 col-md-8 col-sm-10">
                        <div class="hero-search-wrap">
                            <div class="hero-search text-center mb-4">
                                <img src="${pageContext.request.contextPath}/assets/img/logo-light.png" class="img-fluid mb-3" width="200" alt="TechSign Logo">
                                <h1 class="text-white">Forgot Your Password?</h1>
                                <p class="text-light">Enter your email address and we'll send you a link to reset your password</p>
                            </div>

                            <div class="hero-search-content">
                                <!-- Success Message -->
                                <div class="alert alert-success mb-4" id="successMessage" style="display: none;">
                                    <i class="fas fa-check-circle me-2"></i>
                                    <span id="successText">Password reset link has been sent to your email address. Please check your inbox.</span>
                                </div>

                                <!-- Error Message -->
                                <div class="alert alert-danger mb-4" id="errorMessage" style="display: none;">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    <span id="errorText">Please enter a valid email address.</span>
                                </div>

                                <form id="forgotPasswordForm">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group">
                                                <div class="input-with-icon">
                                                    <input type="email" id="email" name="email" class="form-control border"
                                                           placeholder="Enter your email address..." required>
                                                    <i class="fas fa-envelope"
                                                       style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: #666;"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <button type="submit" class="btn btn-primary full-width font--bold btn-lg" id="submitBtn">
                                                <i class="fas fa-paper-plane me-2"></i>Send Reset Link
                                            </button>
                                        </div>

                                        <div class="col-12 text-center mt-3">
                                            <a href="${pageContext.request.contextPath}/index.jsp" class="text-light">
                                                <i class="fas fa-arrow-left me-2"></i>Back to Login
                                            </a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="position-absolute bottom-0 start-0 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-2-soft-light.svg" alt="SVG" width="400">
            </div>
        </div>
    </div>

    <!-- JS Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/custom.js"></script>

    <script>
        // Form submission handling
        document.getElementById('forgotPasswordForm').addEventListener('submit', function (e) {
            e.preventDefault();

            const email = document.getElementById('email').value;
            const submitBtn = document.getElementById('submitBtn');
            const successMessage = document.getElementById('successMessage');
            const errorMessage = document.getElementById('errorMessage');

            // Hide previous messages
            successMessage.style.display = 'none';
            errorMessage.style.display = 'none';

            if (!email || !isValidEmail(email)) {
                showError('Please enter a valid email address.');
                return;
            }

            // Show loading state
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Sending...';
            submitBtn.disabled = true;

            setTimeout(() => {
                showSuccess('Password reset link has been sent to ' + email + '. Please check your inbox.');
                submitBtn.innerHTML = '<i class="fas fa-paper-plane me-2"></i>Send Reset Link';
                submitBtn.disabled = false;
                document.getElementById('email').value = '';
            }, 2000);
        });

        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }

        function showSuccess(message) {
            const successMessage = document.getElementById('successMessage');
            const successText = document.getElementById('successText');
            successText.textContent = message;
            successMessage.style.display = 'block';
        }

        function showError(message) {
            const errorMessage = document.getElementById('errorMessage');
            const errorText = document.getElementById('errorText');
            errorText.textContent = message;
            errorMessage.style.display = 'block';
        }
    </script>

</body>
</html>
