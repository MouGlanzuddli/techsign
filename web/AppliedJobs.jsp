<!doctype html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/candidate-applied-jobs.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:39 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Job Stock - Responsive Job Portal Bootstrap Template | ThemezHub</title>
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.png">

        <!-- Custom CSS -->
        <link href="assets/css/styles.css" rel="stylesheet">

        <!-- Colors CSS -->
        <link href="assets/css/colors.css" rel="stylesheet">

    </head>

    <body class="green-theme">

        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div id="preloader"><div class="preloader"><span></span><span></span></div></div>

        <!-- ============================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <div id="main-wrapper">

            <!-- ============================================================== -->
            <!-- Top header  -->
            <!-- ============================================================== -->
            <!-- Start Navigation -->
            <div class="header header-light head-fixed">
                <div class="container">
                    <nav id="navigation" class="navigation navigation-landscape">
                        <div class="nav-header">
                            <a class="nav-brand static-logo" href="#"><img src="${pageContext.request.contextPath}/assets/img/logo-light.png" class="logo" alt=""></a>
                            
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
                                <li class="active"><a href="JavaScript:Void(0);">Home<span class="submenu-indicator"></span></a></li>
                                <li><a href="JavaScript:Void(0);">Jobs<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="SearchandView">Job List</a></li>
                                        <li><a href="grid-style-2.html">Suitable Jobs</a></li>
                                    </ul>
                                </li>
                                <li><a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="employer-grid-1.html">Company List</a></li>
                                    </ul>
                                </li>
                                <li><a href="JavaScript:Void(0);">Profile CV<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a>Create CV</a></li>
                                        <li><a>Manage CV</a></li>

                                    </ul>
                                </li>

                            </ul>
                            <ul class="nav-menu nav-menu-social align-to-right">
                                <li>
                                    <a href="JavaScript:Void(0);"><i class="fas fa-heart me-2"></i></a>
                                </li>
                                <li>
                                    <a href="JavaScript:Void(0);"><i class="fas fa-comment me-2"></i></a>
                                </li>
                                <li>
                                    <a href="JavaScript:Void(0);"><i class="fas fa-bell me-2"></i></a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="accountLogoDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <img src="${pageContext.request.contextPath}/assets/img/logo-account.png" class="nav-logo" alt="aa">
                                    </a>
                                    <ul class="dropdown-menu" aria-labelledby="accountLogoDropdown">
                                        <li><a class="dropdown-item" href="dashboardcandidate.jsp">Dashboard</a></li>
                                        <li><a class="dropdown-item" href= "LogoutServlet">Logout</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
            <!-- End Navigation -->
            <div class="clearfix"></div>
            <!-- ============================================================== -->
            <!-- Top header  -->
            <!-- ============================================================== -->

            <!-- ======================= dashboard Detail ======================== -->
            <div class="dashboard-wrap bg-light">
                <a class="mobNavigation" data-bs-toggle="collapse" href="#MobNav" role="button" aria-expanded="false" aria-controls="MobNav">
                    <i class="fas fa-bars mr-2"></i>Dashboard Navigation
                </a>
                <div class="collapse" id="MobNav">
                    <div class="dashboard-nav">
                        <div class="dash-user-blocks pt-5">
                            <div class="jbs-grid-usrs-thumb">
                                <div class="jbs-grid-yuo">
                                    <a href="candidate-detail.html"><figure><img src="assets/img/team-2.jpg" class="img-fluid circle" alt=""></figure></a>
                                </div>
                            </div>
                            <div class="jbs-grid-usrs-caption mb-3">
                                <div class="jbs-kioyer">
                                    <div class="jbs-kioyer-groups">
                                        <span class="fa-solid fa-star active"></span>
                                        <span class="fa-solid fa-star active"></span>
                                        <span class="fa-solid fa-star active"></span>
                                        <span class="fa-solid fa-star active"></span>
                                        <span class="fa-solid fa-star"></span>
                                        <span class="aal-reveis">4.7</span>
                                    </div>
                                </div>
                                <div class="jbs-tiosk">
                                    <h4 class="jbs-tiosk-title"><a href="candidate-detail.html">Linda D. Strong</a></h4>
                                    <div class="jbs-tiosk-subtitle"><span>Front-End Developer</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="dashboard-inner">
                            <ul data-submenu-title="Main Navigation">
                                <li><a href="candidate-dashboard.html"><i class="fa-solid fa-gauge-high me-2"></i>User Dashboard</a></li>
                                <li><a href="candidate-profile.html"><i class="fa-regular fa-user me-2"></i>My Profile </a></li>
                                <li><a href="candidate-resume.html"><i class="fa-solid fa-file-pdf me-2"></i>My Resumes</a></li>
                                <li class="active"><a href="AppliedJobsServlet"><i class="fa-regular fa-paper-plane me-2"></i>Applied jobs</a></li>
                                <li><a href="candidate-alert-job.html"><i class="fa-solid fa-bell me-2"></i>Alert Jobs<span class="count-tag bg-warning">4</span></a></li>
                                <li><a href="ShortlistJobServlet"><i class="fa-solid fa-bookmark me-2"></i>Shortlist Jobs</a></li>
                                <li><a href="candidate-follow-employers.html"><i class="fa-solid fa-user-clock me-2"></i>Following Employers</a></li>
                                <li><a href="candidate-messages.html"><i class="fa-solid fa-comments me-2"></i>Messages<span class="count-tag">4</span></a></li>
                                <li><a href="candidate-change-password.html"><i class="fa-solid fa-unlock-keyhole me-2"></i>Change Password</a></li>
                                <li><a href="candidate-delete-account.html"><i class="fa-solid fa-trash-can me-2"></i>Delete Account</a></li>
                                <li><a href="index.html"><i class="fa-solid fa-power-off me-2"></i>Log Out</a></li>
                            </ul>
                        </div>					
                    </div>
                </div>

                <div class="dashboard-content">
                    <div class="dashboard-tlbar d-block mb-4">
                        <div class="row">
                            <div class="colxl-12 col-lg-12 col-md-12">
                                <h1 class="mb-1 fs-3 fw-medium">Applied Jobs</h1>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">                                       
                                        <li class="breadcrumb-item"><a href="#" class="text-primary">Applied Jobs</a></li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-widg-bar d-block">

                        <!-- Header Wrap -->
                        <div class="row">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                <div class="card">
                                    <div class="card-body">  


                                        <form method="post" action="AppliedJobsServlet">
                                            <div class="row classic-search-box m-0 gx-2">
                                                <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12">
                                                    <div class="form-group briod">
                                                        <div class="input-with-icon">
                                                            <input type="text" name="keyword" class="form-control"
                                                                   placeholder="Skills, Designations, Keyword"
                                                                   value="${param.keyword}">
                                                            <i class="fa-solid fa-magnifying-glass text-primary"></i>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12">
                                                    <div class="form-group briod">
                                                        <div class="input-with-icon">
                                                            <select name="description" class="form-control">
                                                                <option value="">Job Category</option>
                                                                <option value="Accounting & Finance" ${param.description == 'Accounting' ? 'selected' : ''}>Accounting & Finance</option>
                                                                <option value="Automotive Jobs" ${param.description == 'Automotive Jobs' ? 'selected' : ''}>Automotive Jobs</option>
                                                                <option value="Business Services" ${param.description == 'Business Services' ? 'selected' : ''}>Business Services</option>
                                                                <option value="Education Training" ${param.description == 'Education Training' ? 'selected' : ''}>Education Training</option>
                                                                <option value="Restaurant & Food" ${param.description == 'Restaurant & Food' ? 'selected' : ''}>Restaurant & Food</option>
                                                                <option value="Healthcare" ${param.description == 'Healthcare' ? 'selected' : ''}>Healthcare</option>
                                                                <option value="Transportations" ${param.description == 'Transportation' ? 'selected' : ''}>Transportation</option>
                                                                <option value="Telecommunications" ${param.description == 'Telecommunications' ? 'selected' : ''}>Telecommunications</option>
                                                            </select>
                                                            <i class="fa-solid fa-briefcase text-primary"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--thành phố-->
                                                <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12">
                                                    <div class="form-group">
                                                        <div class="input-with-icon">
                                                            <select name="city" class="form-control">
                                                                <option value="">Select City</option>
                                                                <option value="Hanoi" ${param.city == 'Hanoi' ? 'selected' : ''}>Hà Nội</option>
                                                                <option value="Ho Chi Minh City" ${param.city == 'Ho Chi Minh City' ? 'selected' : ''}>TP.HCM</option>
                                                                <option value="Da Nang" ${param.city == 'Da Nang' ? 'selected' : ''}>Đà Nẵng</option>
                                                            </select>
                                                            <i class="fa-solid fa-location-crosshairs text-primary"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                            
                                                            
                                                <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12">
                                                    <div class="fliox-search-wiop">
                                                        
                                                        <div class="form-group">
                                                            <button type="submit" class="btn btn-primary full-width">Search</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                                            
                                         <section>  
                <div class="row justify-content-center mb-5">
                    <div class="col-lg-12 col-md-12">
                        <div class="item-shorting-box">
                            <div class="item-shorting clearfix">
                                <h5>Showing ${jobList.size()} of ${totalJobs} Results</h5>
                            </div>
                            <div class="item-shorting-box-right">
                                <div class="shorting-by me-2 small">
                                    <select name="sortBy" onchange="window.location = 'SearchandView?sortBy=' + this.value + '&papersPerPage=${papersPerPage}&description=${param.description}&city=${param.city}' + '&keyword=${param.keyword}'" class="form-select me-2">
                                        <option value="Internship" ${sortBy == 'Internship' ? 'selected' : ''}>Sort by (Internship)</option>
                                        <option value="Freelancer" ${sortBy == 'Freelancer' ? 'selected' : ''}>Sort by (Freelancer)</option>
                                        <option value="Part-time" ${sortBy == 'Part-time' ? 'selected' : ''}>Sort by (Part Time)</option>
                                        <option value="Full-time" ${sortBy == 'Full-time' ? 'selected' : ''}>Sort by (Full Time)</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

                                        <!-- Start All List -->
                                        <div class="row justify-content-start gx-3 gy-4">

                                            <c:if test="${empty appliedJobs}">
                                                <p>No applied jobs found.</p>
                                            </c:if>
                                            <c:forEach var="app" items="${appliedJobs}">
                                                <c:if test="${app.status == 'approved' || app.status == 'pending'}">
                                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                                        <div class="jbs-list-box border">
                                                            <div class="jbs-list-head">
                                                                <div class="jbs-list-head-thunner">
                                                                    <div class="jbs-list-emp-thumb jbs-verified">
                                                                        <a href="jobdetail.jsp?jobId=${app.jobId}">
                                                                            <figure>
                                                                                <c:choose>
                                                                                    <c:when test="${not empty app.logoUrl}">
                                                                                        <img src="${app.logoUrl}" class="img-fluid" alt="">
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <img src="assets/img/l-1.png" class="img-fluid" alt="">
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </figure>
                                                                        </a>
                                                                    </div>
                                                                    <div class="jbs-list-job-caption">
                                                                        <div class="jbs-job-types-wrap">
                                                                            <span class="label text-success bg-light-success">${app.jobType}</span>
                                                                        </div>
                                                                        <div class="jbs-job-title-wrap">
                                                                            <h4><a class="jbs-job-title">${app.jobTitle}</a></h4>
                                                                        </div>
                                                                        <div class="jbs-job-mrch-lists">
                                                                            <div class="single-mrch-lists">
                                                                                <span>${app.companyName}</span>.
                                                                                <span><i class="fa-solid fa-location-dot me-1"></i>${app.location}</span>.
                                                                                <span><fmt:formatDate value="${app.postedAt}" pattern="dd MMM yyyy"/></span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="jbs-list-head-middle">
                                                                    <div class="elsocrio-jbs">
                                                                        <span class="text-sm-muted">Apply <fmt:formatDate value="${app.appliedAt}" pattern="dd MMM yyyy"/></span>
                                                                    </div>
                                                                </div>
                                                                <div class="jbs-list-head-middle">
                                                                    <div class="elsocrio-jbs">
                                                                        <c:choose>
                                                                            <c:when test="${app.status == 'approved'}">
                                                                                <span class="text-sm-muted text-light bg-success py-2 px-3 rounded">Approved</span>
                                                                            </c:when>
                                                                            <c:when test="${app.status == 'pending'}">
                                                                                <span class="text-sm-muted text-light bg-success py-2 px-3 rounded">Pending</span>
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>
                                                                <div class="jbs-list-head-last">
                                                                    <a href="DeleteApplicationServlet?appId=${app.id}" class="btn btn-md btn-light-danger px-3 me-2"><i class="fa-solid fa-xmark"></i></a>
                                                                    <a href="JobDetail?id=${app.jobId}&applied=true" class="btn btn-md btn-light-primary px-3"><i class="fa-solid fa-eye"></i></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>




                                        </div>
                                    </div>
                                </div>
                            </div>	
                        </div>
                        <!-- Header Wrap -->

                    </div>

                    <!-- footer -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="py-3 text-center">© 2015 - 2023 Job Stock® Themezhub.</div>
                        </div>
                    </div>

                </div>				

            </div>
            <!-- ======================= dashboard Detail End ======================== -->

            <a id="back2Top" class="top-scroll" title="Back to top" href="#"><i class="ti-arrow-up"></i></a>


        </div>
        <!-- ============================================================== -->
        <!-- End Wrapper -->
        <!-- ============================================================== -->

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

        <!-- ============================================================== -->
        <!-- All Jquery -->
        <!-- ============================================================== -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/rangeslider.js"></script>
        <script src="assets/js/jquery.nice-select.min.js"></script>
        <script src="assets/js/slick.js"></script>
        <script src="assets/js/counterup.min.js"></script>


        <script src="assets/js/custom.js"></script><script src="assets/js/cl-switch.js"></script>
        <!-- ============================================================== -->
        <!-- This page plugins -->
        <!-- ============================================================== -->

    </body>

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/candidate-applied-jobs.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:39 GMT -->
</html>