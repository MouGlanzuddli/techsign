<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Job Stock - Responsive Job Portal Bootstrap Template | ThemezHub</title>
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.png">
        <!-- Custom CSS -->
        <link href="assets/css/styles.css" rel="stylesheet">
        <!-- Colors CSS -->
        <link href="assets/css/colors.css" rel="stylesheet">
        <style>
            .social-login-centered {
                text-align: center;
            }
            .social-login-centered ul {
                display: inline-block;
                margin: 0;
                padding: 0;
            }
        </style>
    </head>
    <body class="green-theme">
        <!-- Preloader -->
        <div id="preloader"><div class="preloader"><span></span><span></span></div></div>

        <!-- Main wrapper -->
        <div id="main-wrapper">
            <!-- Start Navigation -->
            <div class="header header-transparent change-logo">
                <div class="container">
                    <nav id="navigation" class="navigation navigation-landscape">
                        <div class="nav-header">
                            <a class="nav-brand static-logo" href="#"><img src="${pageContext.request.contextPath}/assets/img/logo-light.png" class="logo" alt=""></a>
                            <a class="nav-brand fixed-logo" href="#"><img src="${pageContext.request.contextPath}/assets/img/logo.png" class="logo" alt=""></a>
                            <div class="nav-toggle"></div>
                            <div class="mobile_nav">
                                <ul>
                                    <li class="list-buttons">
                                        <a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login"><i class="fas fa-sign-in-alt me-2"></i>Log In</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="nav-menus-wrapper">
                            <ul class="nav-menu">

                                <li class="active"><a href="JavaScript:Void(0);">Home<span class="submenu-indicator"></span></a>

                                </li>

                                <li><a href="JavaScript:Void(0);">Jobs<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="JavaScript:Void(0);">Job List<span class="submenu-indicator"></span></a>	
                                        </li>


                                    </ul>
                                </li>

                                <li><a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="JavaScript:Void(0);">Company list<span class="submenu-indicator"></span></a>

                                        </li>

                                    </ul>
                                </li>

                                <li><a href="JavaScript:Void(0);">Pages<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="about-us.html">About Us</a></li> 



                                        <li><a href="faq.html">FAQ's</a></li>
                                        <li><a href="contact.html">Contacts</a></li>
                                    </ul>
                                </li>

                                <li><a href="#">Help</a></li>

                            </ul>

                            <ul class="nav-menu nav-menu-social align-to-right">
                                <li>
                                    <a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login"><i class="fas fa-sign-in-alt me-2"></i>Sign In</a>
                                </li>
                                <li class="list-buttons ms-2">
                                    <a href="signup.html"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Upload Resume</a>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
            <!-- End Navigation -->
            <div class="clearfix"></div>

            <!-- Page Title -->
            <section class="bg-cover primary-bg-dark" style="background:url(assets/img/bg2.png)no-repeat;">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <h2 class="ipt-title text-light">Create An Account</h2>
                            <span class="text-light opacity-75">Create an account or signin</span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Login Form -->
            <section class="gray-simple">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-xl-6 col-lg-8 col-md-12">
                            <div class="vesh-detail-bloc">
                                <div class="vesh-detail-bloc-body pt-3">
                                    <ul class="nav nav-pills mb-3 justify-content-center" id="pills-tab" role="tablist">
                                        <li class="nav-item">
                                            <button class="nav-link" id="register-tab" data-bs-toggle="pill" data-bs-target="#register" type="button" role="tab" aria-controls="register" aria-selected="false">Candidate</button>
                                        </li>
                                        <li class="nav-item">
                                            <button class="nav-link" id="register-tab" data-bs-toggle="pill" data-bs-target="#register" type="button" role="tab" aria-controls="register" aria-selected="false">Company</button>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="pills-tabContent">
                                        <!-- Login Tab -->
                                        <div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab" tabindex="0">
                                            <div class="row gx-3 gy-4">
                                                <div class="modal-login-form">
                                                    <c:if test="${not empty registerError}">
                                                        <div class="alert alert-danger">${registerError}</div>
                                                    </c:if>
                                                    <form action="SignupServlet" method="post">
                                                        <input type="hidden" name="role" id="roleInput" value="1">
                                                        <div class="form-floating mb-4">
                                                            <input type="text" class="form-control" name="fullname" placeholder="Your Name" required>
                                                            <label>Full Name</label>
                                                        </div>
                                                        <div class="form-floating mb-4">
                                                            <input type="email" class="form-control" name="email" placeholder="name@example.com" required>
                                                            <label>Email</label>
                                                        </div>
                                                     <div class="form-floating mb-4">
                                                            <input type="text" class="form-control" name="userid" placeholder="example123" required>
                                                            <label>User ID</label>
                                                  </div>
                                                        <div class="form-floating mb-4">
                                                            <input type="password" class="form-control" name="password" placeholder="Password" required>
                                                            <label>Password</label>
                                                        </div>
                                                        <div class="form-floating mb-4">
                                                            <input type="password" class="form-control" name="confirm_password" placeholder="Password" required>
                                                            <label>Confirm Password</label>
                                                        </div>
                                                        <div class="form-group">
                                                            <button type="submit" class="btn btn-primary full-width font--bold btn-lg">Create An Account</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Register Tab -->
                                        <div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab" tabindex="0">
                                            <div class="row gx-3 gy-4">
                                                <div class="modal-login-form">
                                                    <c:if test="${not empty registerError}">
                                                        <div class="alert alert-danger">${registerError}</div>
                                                    </c:if>
                                                    <form action="SignupServlet" method="post">
                                                        <input type="hidden" name="role" id="roleInput" value="1">
                                                        <div class="form-floating mb-4">
                                                            <input type="text" class="form-control" name="fullname" placeholder="Your Name" required>
                                                            <label>Full Name</label>
                                                        </div>
                                                        <div class="form-floating mb-4">
                                                            <input type="email" class="form-control" name="email" placeholder="name@example.com" required>
                                                            <label>Email</label>
                                                        </div>
                                                        <div class="form-floating mb-4">
                                                            <input type="text" class="form-control" name="userid" placeholder="example123" required>
                                                            <label>User ID</label>
                                                        </div>
                                                        <div class="form-floating mb-4">
                                                            <input type="password" class="form-control" name="password" placeholder="Password" required>
                                                            <label>Password</label>
                                                        </div>
                                                        <div class="form-floating mb-4">
                                                            <input type="password" class="form-control" name="confirm_password" placeholder="Password" required>
                                                            <label>Confirm Password</label>
                                                        </div>
                                                        <div class="form-group">
                                                            <button type="submit" class="btn btn-primary full-width font--bold btn-lg">Create An Account</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Call To Action -->
            <section class="bg-cover primary-bg-dark" style="background:url(assets/img/footer-bg-dark.png)no-repeat;">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-xl-7 col-lg-10 col-md-12 col-sm-12">
                            <div class="call-action-wrap">
                                <div class="sec-heading center">
                                    <h2 class="lh-base mb-3 text-light">Find The Perfect Job<br>on Job Stock That is Superb For You</h2>
                                    <p class="fs-6 text-light">At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias</p>
                                </div>
                                <div class="call-action-buttons mt-3">
                                    <a href="#" class="btn btn-lg btn-dark fw-medium px-xl-5 px-lg-4 me-2">Upload resume</a>
                                    <a href="#" class="btn btn-lg btn-whites fw-medium px-xl-5 px-lg-4 text-primary">Join Our Team</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Footer -->
            <footer class="footer skin-dark-footer">
                <div>
                    <div class="container">
                        <div class="row">
                            <!-- Cột 1: Logo & Địa chỉ -->
                            <div class="col-lg-3 col-md-6">
                                <div class="footer-widget">
                                    <img src="${pageContext.request.contextPath}/assets/img/logo-light.png" class="img-footer" alt="">
                                    <div class="footer-add">
                                        <p>+348888702<br> Hoa Hai, Ngu Hanh Son, Da Nang, Viet Nam</p>
                                    </div>
                                    <div class="foot-socials">
                                        <ul>
                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-facebook"></i></a></li>

                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-google-plus"></i></a></li>

                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- Cột 2: For Clients -->
                            <div class="col-lg-3 col-md-6">
                                <div class="footer-widget">
                                    <h4 class="widget-title">For Clients</h4>
                                    <ul class="footer-menu">
                                        <li><a href="JavaScript:Void(0);">Talent Marketplace</a></li>
                                        <li><a href="JavaScript:Void(0);">Payroll Services</a></li>
                                        <li><a href="JavaScript:Void(0);">Direct Contracts</a></li>
                                        <li><a href="JavaScript:Void(0);">Hire Worldwide</a></li>
                                        <li><a href="JavaScript:Void(0);">Hire in the USA</a></li>
                                        <li><a href="JavaScript:Void(0);">How to Hire</a></li>
                                    </ul>
                                </div>
                            </div>

                            <!-- Cột 3: Our Resources -->
                            <div class="col-lg-3 col-md-6">
                                <div class="footer-widget">
                                    <h4 class="widget-title">Our Resources</h4>
                                    <ul class="footer-menu">
                                        <li><a href="JavaScript:Void(0);">Free Business tools</a></li>
                                        <li><a href="JavaScript:Void(0);">Affiliate Program</a></li>
                                        <li><a href="JavaScript:Void(0);">Success Stories</a></li>
                                        <li><a href="JavaScript:Void(0);">Upwork Reviews</a></li>
                                        <li><a href="JavaScript:Void(0);">Resources</a></li>
                                        <li><a href="JavaScript:Void(0);">Help & Support</a></li>
                                    </ul>
                                </div>
                            </div>

                            <!-- Cột 4: The Company -->
                            <div class="col-lg-3 col-md-6">
                                <div class="footer-widget">
                                    <h4 class="widget-title">The Company</h4>
                                    <ul class="footer-menu">
                                        <li><a href="JavaScript:Void(0);">About Us</a></li>
                                        <li><a href="JavaScript:Void(0);">Leadership</a></li>
                                        <li><a href="JavaScript:Void(0);">Contact Us</a></li>
                                        <li><a href="JavaScript:Void(0);">Investor Relations</a></li>
                                        <li><a href="JavaScript:Void(0);">Trust, Safety & Security</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer Bottom -->
                <div class="footer-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-12 text-center">
                                <p class="mb-0">© 2025 Tech Sign®</p>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>

            <!-- Log In Modal -->
            <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="loginmodal" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered login-pop-form" role="document">
                    <div class="modal-content" id="loginmodal">
                        <span class="mod-close" data-bs-dismiss="modal" aria-hidden="true"><i class="fas fa-close"></i></span>
                        <div class="modal-header">
                            <div class="mdl-thumb"><img src="assets/img/ico.png" class="img-fluid" width="70" alt=""></div>
                            <div class="mdl-title"><h4 class="modal-header-title">Hello, Again</h4></div>
                        </div>
                        <div class="modal-body">
                            <div class="modal-login-form">
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger">${errorMessage}</div>
                                </c:if>
                                <form action="login" method="post">
                                    <div class="form-floating mb-4">
                                        <input type="email" class="form-control" name="username" placeholder="name@example.com" required>
                                        <label>User Name</label>
                                    </div>
                                    <div class="form-floating mb-4">
                                        <input type="password" class="form-control" name="password" placeholder="Password" required>
                                        <label>Password</label>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary full-width font--bold btn-lg">Log In</button>
                                    </div>
                                    <div class="modal-flex-item mb-3">
                                        <div class="modal-flex-first">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="savepassword" name="savepassword" value="option1">
                                                <label class="form-check-label" for="savepassword">Save Password</label>
                                            </div>
                                        </div>
                                        <div class="modal-flex-last">
                                            <a href="forgot-password.jsp">Forget Password?</a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="social-login" style="display: flex; justify-content: center; align-items: center; margin-top: 20px; width: 100%;">
                                <style scoped>
                                    .social-login ul {
                                        list-style: none;
                                        padding: 0;
                                        margin: 0;
                                        display: inline-flex;
                                    }
                                </style>
                                <ul>
                                    <li><a href="#" class="btn connect-google"><i class="fa-brands fa-google"></i>Google+</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <p>Don't have an account yet?<a href="signup.jsp" class="text-primary font--bold ms-1">Sign Up</a></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filter Modal -->
            <div class="modal fade" id="filter" tabindex="-1" role="dialog" aria-labelledby="filtermodal" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered filter-popup" role="document">
                    <div class="modal-content" id="filtermodal">
                        <span class="mod-close" data-bs-dismiss="modal" aria-hidden="true"><i class="fas fa-close"></i></span>
                        <div class="modal-header">
                            <h4 class="modal-header-sub-title">Start Your Filter</h4>
                        </div>
                        <div class="modal-body p-0">
                            <div class="filter-content">
                                <div class="full-tabs-group">
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Job Match Score</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <c:forEach var="score" items="${['6.0', '6.5', '7.0', '7.5', '8.0', '8.5', '9.0', '9.5', '10']}">
                                                    <div class="sing-btn-groups">
                                                        <input type="checkbox" class="btn-check" id="ms${score.replace('.', '')}" name="jobMatchScore" value="${score}">
                                                        <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="ms${score.replace('.', '')}">${score}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Job Value Score</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <c:forEach var="score" items="${['6.0', '6.5', '7.0', '7.5', '8.0', '8.5', '9.0', '9.5', '10']}">
                                                    <div class="sing-btn-groups">
                                                        <input type="checkbox" class="btn-check" id="vs${score.replace('.', '')}" name="jobValueScore" value="${score}">
                                                        <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="vs${score.replace('.', '')}">${score}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Place Of Work</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <c:forEach var="place" items="${['Anywhere', 'On Site', 'Fully Remote']}">
                                                    <div class="sing-btn-groups">
                                                        <input type="checkbox" class="btn-check" id="${place.toLowerCase().replace(' ', '')}" name="placeOfWork" value="${place}">
                                                        <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="${place.toLowerCase().replace(' ', '')}">${place}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Type Of Contract</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <c:forEach var="contract" items="${['Employee', 'Freelancer', 'Contractor', 'Internship']}">
                                                    <div class="sing-btn-groups">
                                                        <input type="checkbox" class="btn-check" id="${contract.toLowerCase()}1" name="contractType" value="${contract}">
                                                        <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="${contract.toLowerCase()}1">${contract}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Type Of Employment</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <c:forEach var="employment" items="${['Full Time', 'Part Time', 'Freelance', 'Internship']}">
                                                    <div class="sing-btn-groups">
                                                        <input type="checkbox" class="btn-check" id="${employment.toLowerCase().replace(' ', '')}" name="employmentType" value="${employment}">
                                                        <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="${employment.toLowerCase().replace(' ', '')}">${employment}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Radius In Miles</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="rg-slider">
                                                <input type="text" class="js-range-slider" name="radius" value="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Explore Top Categories</h5></div>
                                        <div class="single-tabs-group-content">
                                            <ul class="row p-0 m-0">
                                                <c:forEach var="category" items="${['IT Computers', 'Web Design', 'Web development', 'SEO Services', 'Financial Service', 'Art, Design, Media', 'Coach & Education', 'Apps Developements', 'IOS Development', 'Android Development']}" varStatus="status">
                                                    <li class="col-lg-6 col-md-6 p-0">
                                                        <div class="form-check form-check-inline">
                                                            <input id="s-${status.count}" class="form-check-input" name="category" type="checkbox" value="${category}">
                                                            <label for="s-${status.count}" class="form-check-label">${category}</label>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Keywords</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="keywords" placeholder="Design, Java, Python, WordPress etc...">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="filt-buttons-updates">
                                    <button type="button" class="btn btn-dark">Clear Filter</button>
                                    <button type="button" class="btn btn-primary">Search</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <a id="back2Top" class="top-scroll" title="Back to top" href="#"><i class="ti-arrow-up"></i></a>
            </div>

            <!-- Color Switcher -->
            <div class="style-switcher">
                <div class="css-trigger shadow"><a href="#"><i class="fa-solid fa-paintbrush"></i></a></div>
                <div>
                    <ul id="themecolors" class="m-t-20">
                        <li><a href="javascript:void(0)" data-skin="green-theme" class="green-theme">1</a></li>
                        <li><a href="javascript:void(0)" data-skin="red-theme" class="red-theme">2</a></li>
                        <li><a href="javascript:void(0)" data-skin="blue-theme" class="blue-theme">3</a></li>
                        <li><a href="javascript:void(0)" data-skin="yellow-theme" class="yellow-theme">4</a></li>
                        <li><a href="javascript:void(0)" data-skin="purple-theme" class="purple-theme">5</a></li>
                        <li><a href="javascript:void(0)" data-skin="orange-theme" class="orange-theme">6</a></li>
                        <li><a href="javascript:void(0)" data-skin="brown-theme" class="brown-theme">7</a></li>
                        <li><a href="javascript:void(0)" data-skin="cadmium-theme" class="cadmium-theme">8</a></li>            
                    </ul>
                </div>
            </div>

            <!-- JavaScript -->
            <script src="assets/js/jquery.min.js"></script>
            <script src="assets/js/popper.min.js"></script>
            <script src="assets/js/bootstrap.min.js"></script>
            <script src="assets/js/rangeslider.js"></script>
            <script src="assets/js/jquery.nice-select.min.js"></script>
            <script src="assets/js/slick.js"></script>
            <script src="assets/js/counterup.min.js"></script>
            <script src="assets/js/custom.js"></script>
            <script src="assets/js/cl-switch.js"></script>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const roleInput = document.getElementById("roleInput");
                    const candidateTab = document.querySelectorAll("#pills-tab button")[0];
                    const companyTab = document.querySelectorAll("#pills-tab button")[1];

                    // Khi click vào tab Candidate
                    candidateTab.addEventListener("click", function () {
                        roleInput.value = "2"; // Candidate
                    });

                    // Khi click vào tab Company
                    companyTab.addEventListener("click", function () {
                        roleInput.value = "3"; // Company
                    });
                });
            </script>
    </body>
</html>