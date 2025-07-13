<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${job.title} - ${company.fullName} | TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <!-- Colors CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .job-detail-card {
            border-radius: 10px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .job-detail-header {
            background: linear-gradient(135deg, #17ac6a, #28a745);
            color: white;
            padding: 20px;
        }
        .job-detail-body {
            padding: 25px;
        }
        .sidebar-card {
            border-radius: 10px;
            background: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }
        .btn-primary, .btn-dark {
            background: #17ac6a;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
        }
        .btn-primary:hover, .btn-dark:hover {
            background: #139756;
        }
        .btn-outline-primary {
            border-color: #17ac6a;
            color: #17ac6a;
            border-radius: 5px;
        }
        .btn-outline-primary:hover {
            background: #17ac6a;
            color: white;
        }
    </style>
</head>
<body class="green-theme">
    <!-- Preloader -->
    <div id="preloader"><div class="preloader"><span></span><span></span></div></div>

    <!-- Main wrapper -->
    <div id="main-wrapper">
        <!-- Navigation -->
        <div class="header header-transparent change-logo">
            <div class="container">
                <nav id="navigation" class="navigation navigation-landscape">
                    <div class="nav-header">
                        <a class="nav-brand static-logo" href="index.jsp"><img src="${pageContext.request.contextPath}/assets/img/logo-light.png" class="logo" alt=""></a>
                        <a class="nav-brand fixed-logo" href="index.jsp"><img src="${pageContext.request.contextPath}/assets/img/logo.png" class="logo" alt=""></a>
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
                            <li><a href="index.jsp">Home</a></li>
                            <li><a href="JobListServlet">Jobs</a></li>
                            <li><a href="companies.jsp">Company</a></li>
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
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                            <i class="fas fa-user me-1"></i> ${sessionScope.user.fullName}
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="profile.jsp">Profile</a></li>
                                            <li><a class="dropdown-item" href="my-applications.jsp">My Applications</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="LogoutServlet">Logout</a></li>
                                        </ul>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login"><i class="fas fa-sign-in-alt me-2"></i>Sign In</a></li>
                                    <li class="list-buttons ms-2"><a href="signup.jsp"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Upload Resume</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <div class="clearfix"></div>

        <!-- Job Header -->
        <div class="image-cover hero-header primary-bg-dark" data-overlay="0">
            <div class="position-absolute top-0 end-0 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-3-soft-light.svg" alt="SVG" width="500">
            </div>
            <div class="position-absolute top-0 start-0 me-10 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-1-soft-light.svg" alt="SVG" width="250">
            </div>
            <div class="container position-relative zindex-2 pt-5">
                <div class="row align-items-center">
                    <div class="col-md-2 text-center">
                        <div class="company-logo mx-auto mb-3">${company.fullName.substring(0,1).toUpperCase()}</div>
                    </div>
                    <div class="col-md-8">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <h1 class="mb-0">${job.title}</h1>
                            <c:if test="${job.featured}">
                                <span class="featured-text">Featured</span>
                            </c:if>
                            <c:if test="${job.urgent}">
                                <span class="urgent">Urgent</span>
                            </c:if>
                        </div>
                        <h4 class="mb-3">${company.fullName}</h4>
                        <div class="d-flex flex-wrap gap-2">
                            <span class="${job.jobType == 'Internship' ? 'enternship' : job.jobType == 'Freelance' ? 'freelanc' : job.jobType == 'Part Time' ? 'part-time' : 'full-time'}">${job.jobType}</span>
                            <span class="job-badge badge-level">${job.jobLevel}</span>
                        </div>
                    </div>
                    <div class="col-md-2 text-center text-light">
                        <div class="mb-2"><i class="fas fa-eye me-1"></i> ${job.viewsCount} views</div>
                        <div><i class="fas fa-calendar me-1"></i> <fmt:formatDate value="${job.createdAt}" pattern="MM/dd/yyyy"/></div>
                    </div>
                </div>
            </div>
            <div class="position-absolute bottom-0 start-0 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-2-soft-light.svg" alt="SVG" width="400">
            </div>
        </div>

        <!-- Main Content -->
        <section class="py-5">
            <div class="container">
                <div class="row g-4">
                    <!-- Job Details -->
                    <div class="col-lg-8">
                        <div class="job-detail-card">
                            <c:if test="${not empty job.salaryMin or not empty job.salaryMax}">
                                <div class="job-detail-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-dollar-sign me-2"></i>
                                        <c:choose>
                                            <c:when test="${not empty job.salaryMin and not empty job.salaryMax}">
                                                <fmt:formatNumber value="${job.salaryMin}" pattern="#,###"/> - <fmt:formatNumber value="${job.salaryMax}" pattern="#,###"/> M VND
                                            </c:when>
                                            <c:when test="${not empty job.salaryMin}">
                                                From <fmt:formatNumber value="${job.salaryMin}" pattern="#,###"/> M VND
                                            </c:when>
                                            <c:when test="${not empty job.salaryMax}">
                                                Up to <fmt:formatNumber value="${job.salaryMax}" pattern="#,###"/> M VND
                                            </c:when>
                                        </c:choose>
                                    </h5>
                                </div>
                            </c:if>
                            <div class="job-detail-body">
                                <h5 class="text-primary mb-3"><i class="fas fa-file-alt me-2"></i>Job Description</h5>
                                <p class="text-muted">${job.description}</p>
                                <c:if test="${not empty job.requirements}">
                                    <h5 class="text-primary mb-3 mt-4"><i class="fas fa-list-check me-2"></i>Candidate Requirements</h5>
                                    <p class="text-muted">${job.requirements}</p>
                                </c:if>
                                <c:if test="${not empty job.benefits}">
                                    <h5 class="text-primary mb-3 mt-4"><i class="fas fa-gift me-2"></i>Benefits</h5>
                                    <p class="text-muted">${job.benefits}</p>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar -->
                    <div class="col-lg-4">
                        <div class="sidebar-card mb-4 text-center">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user and sessionScope.user.roleId == 2}">
                                    <a href="ApplyJobServlet?id=${job.id}" class="btn btn-dark btn-lg full-width mb-3"><i class="fas fa-paper-plane me-2"></i>Apply Now</a>
                                    <button class="btn btn-outline-primary full-width"><i class="fas fa-heart me-2"></i>Save Job</button>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted mb-3">Please login to apply for this job</p>
                                    <a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login" class="btn btn-dark full-width"><i class="fas fa-sign-in-alt me-2"></i>Login</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="sidebar-card mb-4">
                            <h6 class="text-primary mb-3"><i class="fas fa-info-circle me-2"></i>Job Information</h6>
                            <div class="work-process mb-3">
                                <div class="work-process-icon"><span><i class="fas fa-map-marker-alt"></i></span></div>
                                <div class="work-process-caption">
                                    <h6>Location</h6>
                                    <p class="mb-0">${job.location}</p>
                                </div>
                            </div>
                            <div class="work-process mb-3">
                                <div class="work-process-icon"><span><i class="fas fa-briefcase"></i></span></div>
                                <div class="work-process-caption">
                                    <h6>Category</h6>
                                    <p class="mb-0">${job.category}</p>
                                </div>
                            </div>
                            <c:if test="${job.experienceRequired > 0}">
                                <div class="work-process mb-3">
                                    <div class="work-process-icon"><span><i class="fas fa-clock"></i></span></div>
                                    <div class="work-process-caption">
                                        <h6>Experience</h6>
                                        <p class="mb-0">${job.experienceRequired} years</p>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${not empty job.applicationDeadline}">
                                <div class="work-process">
                                    <div class="work-process-icon"><span><i class="fas fa-calendar-times"></i></span></div>
                                    <div class="work-process-caption">
                                        <h6>Application Deadline</h6>
                                        <p class="mb-0"><fmt:formatDate value="${job.applicationDeadline}" pattern="MM/dd/yyyy"/></p>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        <div class="sidebar-card mb-4">
                            <h6 class="text-primary mb-3"><i class="fas fa-building me-2"></i>Company Information</h6>
                            <div class="text-center mb-3">
                                <div class="company-logo mx-auto mb-2">${company.fullName.substring(0,1).toUpperCase()}</div>
                                <h6>${company.fullName}</h6>
                            </div>
                            <a href="company-profile.jsp?id=${company.id}" class="btn btn-outline-primary full-width"><i class="fas fa-eye me-2"></i>View Company Profile</a>
                        </div>
                        <c:if test="${not empty relatedJobs}">
                            <div class="sidebar-card">
                                <h6 class="text-primary mb-3"><i class="fas fa-list me-2"></i>Related Jobs</h6>
                                <c:forEach var="relatedJob" items="${relatedJobs}" varStatus="status">
                                    <c:if test="${status.index < 3}">
                                        <div class="work-process mb-3">
                                            <div class="work-process-caption">
                                                <h6><a href="JobDetailServlet?id=${relatedJob.id}">${relatedJob.title}</a></h6>
                                                <p class="mb-0"><i class="fas fa-map-marker-alt me-1"></i>${relatedJob.location} • <i class="fas fa-briefcase me-1"></i>${relatedJob.jobType}</p>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <a href="JobListServlet?category=${job.category}" class="btn btn-outline-primary full-width">View More Similar Jobs</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer skin-dark-footer">
            <div>
                <div class="container">
                    <div class="row">
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
            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <div class="col-12 text-center">
                            <p class="mb-0">© 2025 TechSign®</p>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Login Modal -->
        <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="loginmodal" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered login-pop-form" role="document">
                <div class="modal-content" id="loginmodal">
                    <span class="mod-close" data-bs-dismiss="modal" aria-hidden="true"><i class="fas fa-close"></i></span>
                    <div class="modal-header">
                        <div class="mdl-thumb">
                            <img src="${pageContext.request.contextPath}/assets/img/ico.png" class="img-fluid" width="70" alt="">
                        </div>
                        <div class="mdl-title">
                            <h4 class="modal-header-title">Hello, Again</h4>
                        </div>
                    </div>
                    <div class="modal-body">
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        <div class="modal-login-form">
                            <form action="${pageContext.request.contextPath}/LoginServlet" method="POST">
                                <div class="form-floating mb-4">
                                    <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                                    <label>Email</label>
                                </div>
                                <div class="form-floating mb-4">
                                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                                    <label>Password</label>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-dark full-width font--bold btn-lg">Log In</button>
                                </div>
                                <div class="modal-flex-item mb-3">
                                    <div class="modal-flex-first">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" name="rem" id="savepassword" value="on">
                                            <label class="form-check-label" for="savepassword">Save Password</label>
                                        </div>
                                    </div>
                                    <div class="modal-flex-last">
                                        <a href="forgot-password.jsp">Forget Password?</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="social-login mt-3">
                            <ul class="list-unstyled d-flex justify-content-center mb-0">
                                <li>
                                    <a href="https://accounts.google.com/o/oauth2/v2/auth?scope=email%20profile&access_type=online&include_granted_scopes=true&response_type=code&redirect_uri=http://localhost:8080/JobSearchManagement/LoginGoogleHandler&client_id=662818990560-8t0tkh07kp0kktc2mk7177k5gj8dvkdn.apps.googleusercontent.com" class="btn connect-google">
                                        <i class="fa-brands fa-google"></i> Login With Google
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <p>Don't have an account yet? <a href="${pageContext.request.contextPath}/SignupServlet" class="text-primary font--bold ms-1">Sign Up</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/rangeslider.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/slick.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/counterup.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/custom.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/cl-switch.js"></script>
    <script>
        $(document).ready(function() {
            <% if (request.getAttribute("error") != null) { %>
                $('#login').modal('show');
            <% } %>
        });
    </script>
</body>
</html>