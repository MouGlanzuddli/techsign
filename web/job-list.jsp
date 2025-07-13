<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Listings - TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <!-- Colors CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .job-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border-radius: 10px;
            overflow: hidden;
        }
        .job-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        .job-card-header {
            background: linear-gradient(135deg, #17ac6a, #28a745);
            color: white;
            padding: 15px;
            position: relative;
        }
        .job-card-body {
            padding: 20px;
            background: #fff;
        }
        .job-card-footer {
            padding: 15px 20px;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
        }
        .filter-content {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }
        .form-control {
            border-radius: 5px;
            border: 1px solid #ced4da;
        }
        .btn-dark {
            background: #17ac6a;
            border: none;
            border-radius: 5px;
            padding: 10px;
        }
        .btn-dark:hover {
            background: #139756;
        }
        .hero-search-wrap {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
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
                            <li class="active"><a href="JobListServlet">Jobs</a></li>
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

        <!-- Hero Section -->
        <div class="image-cover hero-header primary-bg-dark" data-overlay="0">
            <div class="position-absolute top-0 end-0 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-3-soft-light.svg" alt="SVG" width="500">
            </div>
            <div class="position-absolute top-0 start-0 me-10 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-1-soft-light.svg" alt="SVG" width="250">
            </div>
            <div class="container d-flex flex-column justify-content-center position-relative zindex-2 pt-5">
                <div class="row justify-content-center">
                    <div class="col-xl-8 col-lg-9 col-md-10 text-center">
                        <h6 class="primary-2-cl fw-medium d-inline-flex align-items-center mb-3"><span class="primary-2-bg w-10 h-05 me-2"></span>Explore Job Opportunities</h6>
                        <h1 class="mb-4">Discover Your Next Career Move</h1>
                        <p class="fs-5">Browse thousands of job opportunities tailored to your skills and preferences.</p>
                    </div>
                </div>
                <!-- Search Box -->
                <div class="hero-search-wrap mt-4">
                    <div class="hero-search-content verticle-space">
                        <form action="JobListServlet" method="get">
                            <div class="row g-3 align-items-center">
                                <div class="col-xl-5 col-lg-5 col-md-5 col-sm-12">
                                    <div class="form-group">
                                        <div class="input-with-icon">
                                            <input type="text" class="form-control" name="search" placeholder="Search Job Keywords..." value="${searchKeyword}">
                                            <img src="${pageContext.request.contextPath}/assets/img/pin.svg" width="18" alt="">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <select class="form-control" name="category">
                                            <option value="">All Categories</option>
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat}" ${categoryFilter == cat ? 'selected' : ''}>${cat}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xl-2 col-lg-2 col-md-2 col-sm-6">
                                    <div class="form-group">
                                        <select class="form-control" name="location">
                                            <option value="">All Locations</option>
                                            <c:forEach var="loc" items="${locations}">
                                                <option value="${loc}" ${locationFilter == loc ? 'selected' : ''}>${loc}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xl-2 col-lg-2 col-md-2 col-sm-12">
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-dark full-width">Search</button>
                                    </div>
                                </div>
                            </div>
                        </form>
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
                <div class="row">
                    <!-- Filters Sidebar -->
                    <div class="col-lg-3">
                        <div class="filter-content">
                            <h4 class="modal-header-sub-title mb-4">Refine Your Search</h4>
                            <form action="JobListServlet" method="get" id="filterForm">
                                <input type="hidden" name="search" value="${searchKeyword}">
                                <div class="single-tabs-group mb-4">
                                    <div class="single-tabs-group-header"><h5>Job Type</h5></div>
                                    <div class="single-tabs-group-content">
                                        <select class="form-control" name="jobType" onchange="this.form.submit()">
                                            <option value="">All Types</option>
                                            <option value="Full Time" ${jobTypeFilter == 'Full Time' ? 'selected' : ''}>Full Time</option>
                                            <option value="Part Time" ${jobTypeFilter == 'Part Time' ? 'selected' : ''}>Part Time</option>
                                            <option value="Contract" ${jobTypeFilter == 'Contract' ? 'selected' : ''}>Contract</option>
                                            <option value="Internship" ${jobTypeFilter == 'Internship' ? 'selected' : ''}>Internship</option>
                                            <option value="Remote" ${jobTypeFilter == 'Remote' ? 'selected' : ''}>Remote</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="single-tabs-group mb-4">
                                    <div class="single-tabs-group-header"><h5>Job Level</h5></div>
                                    <div class="single-tabs-group-content">
                                        <select class="form-control" name="jobLevel" onchange="this.form.submit()">
                                            <option value="">All Levels</option>
                                            <option value="Intern" ${jobLevelFilter == 'Intern' ? 'selected' : ''}>Intern</option>
                                            <option value="Junior" ${jobLevelFilter == 'Junior' ? 'selected' : ''}>Junior</option>
                                            <option value="Mid" ${jobLevelFilter == 'Mid' ? 'selected' : ''}>Mid-Level</option>
                                            <option value="Senior" ${jobLevelFilter == 'Senior' ? 'selected' : ''}>Senior</option>
                                            <option value="Lead" ${jobLevelFilter == 'Lead' ? 'selected' : ''}>Lead</option>
                                            <option value="Manager" ${jobLevelFilter == 'Manager' ? 'selected' : ''}>Manager</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="single-tabs-group mb-4">
                                    <div class="single-tabs-group-header"><h5>Sort By</h5></div>
                                    <div class="single-tabs-group-content">
                                        <select class="form-control" name="sortBy" onchange="this.form.submit()">
                                            <option value="newest" ${sortBy == 'newest' ? 'selected' : ''}>Newest</option>
                                            <option value="oldest" ${sortBy == 'oldest' ? 'selected' : ''}>Oldest</option>
                                            <option value="title" ${sortBy == 'title' ? 'selected' : ''}>Job Title</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="filt-buttons-updates">
                                    <a href="JobListServlet" class="btn btn-dark full-width">Clear Filters</a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Jobs List -->
                    <div class="col-lg-9">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="mb-0"><strong>${totalJobs}</strong> Jobs Found</h5>
                            <div class="text-muted"><i class="fas fa-clock me-1"></i> Latest Update</div>
                        </div>
                        <c:choose>
                            <c:when test="${empty jobs}">
                                <div class="text-center py-5">
                                    <i class="fas fa-search fa-4x text-muted mb-3"></i>
                                    <h5 class="text-muted">No Jobs Found</h5>
                                    <p class="text-muted">Try adjusting your search keywords or filters.</p>
                                    <a href="JobListServlet" class="btn btn-dark">View All Jobs</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="row g-4">
                                    <c:forEach var="job" items="${jobs}">
                                        <div class="col-xl-4 col-lg-6 col-md-6">
                                            <div class="job-card border">
                                                <div class="job-card-header">
                                                    <div class="left-tags-capt">
                                                        <c:if test="${job.featured}">
                                                            <span class="featured-text">Featured</span>
                                                        </c:if>
                                                        <c:if test="${job.urgent}">
                                                            <span class="urgent">Urgent</span>
                                                        </c:if>
                                                    </div>
                                                    <span class="${job.jobType == 'Internship' ? 'enternship' : job.jobType == 'Freelance' ? 'freelanc' : job.jobType == 'Part Time' ? 'part-time' : 'full-time'}">${job.jobType}</span>
                                                </div>
                                                <div class="job-card-body">
                                                    <div class="d-flex align-items-center mb-3">
                                                        <div class="company-logo me-3">${companies[job.companyId].fullName.substring(0,1).toUpperCase()}</div>
                                                        <h4 class="mb-0"><a href="JobDetailServlet?id=${job.id}">${job.title}</a></h4>
                                                    </div>
                                                    <div class="text-muted mb-2">${job.category}</div>
                                                    <div class="text-muted small">
                                                        <i class="fas fa-map-marker-alt me-1"></i> ${job.location}
                                                        <c:if test="${job.experienceRequired > 0}">
                                                            <span class="mx-2">•</span>
                                                            <i class="fas fa-clock me-1"></i> ${job.experienceRequired} years
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="job-card-footer d-flex justify-content-between align-items-center">
                                                    <h5 class="mb-0">
                                                        <c:if test="${not empty job.salaryMin or not empty job.salaryMax}">
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
                                                        </c:if>
                                                    </h5>
                                                    <span class="text-muted small"><fmt:formatDate value="${job.createdAt}" pattern="MM/dd/yyyy"/></span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
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