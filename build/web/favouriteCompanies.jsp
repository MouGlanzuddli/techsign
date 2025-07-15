<!doctype html>
<%@page import="java.util.List"%>
<%@page import="model.Companies"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="companies" class="java.util.ArrayList" scope="request"/>
<html lang="en">

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/candidate-follow-employers.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:39 GMT -->
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

        <div id="main-wrapper">
            <!-- Top Header -->
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
                                <li class="active"><a href="index.jsp;">Home<span class="submenu-indicator"></span></a></li>
                                <li><a href="JavaScript:Void(0);">Jobs<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="SearchandView">Job List</a></li>
                                        <li><a href="grid-style-2.html">Suitable Jobs</a></li>
                                    </ul>
                                </li>
                                <li><a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="JavaScript:Void(0);">Company List</a></li>
                                    </ul>
                                </li>
                                <li><a href="JavaScript:Void(0);">Pages<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="about-us.html">About Us</a></li>
                                        <li><a href="404.html">Error Page</a></li>
                                        <li><a href="checkout.html">Checkout</a></li>
                                        <li><a href="blog.html">Blogs Page</a></li>
                                        <li><a href="blog-detail.html">Blog Detail</a></li>
                                        <li><a href="privacy.html">Terms & Privacy</a></li>
                                        <li><a href="pricing.html">Pricing</a></li>
                                        <li><a href="faq.html">FAQ's</a></li>
                                        <li><a href="contact.html">Contacts</a></li>
                                    </ul>
                                </li>
                                <li><a href="#">Help</a></li>
                            </ul>
                            <ul class="nav-menu nav-menu-social align-to-right">
                                <li><a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login"><i class="fas fa-sign-in-alt me-2"></i>Sign In</a></li>
                                <li class="list-buttons ms-2"><a href="signup.html"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Upload Resume</a></li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
            <div class="clearfix"></div>


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
                    <li><a href="candidate-applied-jobs.html"><i class="fa-regular fa-paper-plane me-2"></i>Applied jobs</a></li>
                    <li><a href="candidate-alert-job.html"><i class="fa-solid fa-bell me-2"></i>Alert Jobs<span class="count-tag bg-warning">4</span></a></li>
                    <li><a href="candidatesavedjob.jsp"><i class="fa-solid fa-bookmark me-2"></i>Shortlist Jobs</a></li>
                    <li class="active"><a href="cFe.jsp"><i class="fa-solid fa-user-clock me-2"></i>Favorite Companies</a></li>
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
                    <h1 class="mb-1 fs-3 fw-medium">Following Employers</h1>
                    
                </div>
            </div>
        </div>

        <div class="dashboard-widg-bar d-block">


            <!-- Header Wrap -->
            <div class="row">
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                    <div class="card">
                        <div class="card-header">
                            <div class="_mp-inner-content elior">
                                <div class="_mp-inner-first">
                                    <div class="search-inline">
                                        <input type="text" class="form-control" placeholder="Job title, Keywords etc.">
                                        <button type="button" class="btn btn-primary">Search</button>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <div class="card-body">
                            <!-- Start All List -->
                            <div class="row justify-content-start gx-3 gy-4">





                                <!-- Single Item -->
                                <c:forEach var="company" items="${favCompanies}">
                                    <div class="col-xl-12 col-lg-12 col-md-12 col-12">
                                        <div class="emplors-list-box border">
                                            <div class="emplors-list-head">
                                                <div class="emplors-list-head-thunner">
                                                    <div class="emplors-list-emp-thumb">
                                                        <a href="CompanyDetailServlet?id=${company.id}">
                                                            <figure>
                                                                <img src="assets/img/l-1.png" class="img-fluid" alt="">
                                                            </figure>
                                                        </a>
                                                    </div>
                                                    <div class="emplors-list-job-caption">                                                      
                                                        <div class="emplors-job-title-wrap mb-1">
                                                            <h4>
                                                                <a href="CompanyDetailServlet?id=${company.id}" class="emplors-job-title">
                                                                    ${company.companyName}
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="emplors-job-mrch-lists">
                                                            <div class="single-mrch-lists">
                                                                <span>${company.description}</span>.
                                                                <span><i class="fa-solid fa-location-dot me-1"></i>${company.address}</span>.
                                                                <span>${company.website}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="emplors-list-head-last">
                                                    
                                                    <a href="UnfollowCompanyServlet?companyId=${company.id}" class="btn btn-md btn-light-danger px-3 me-2"><i class="fa-solid fa-xmark"></i></a>
                                                        
                                                    <a href="CompanyDetailServlet?id=${company.id}" class="btn btn-md btn-light-primary px-3">
                                                        View Company
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <!--end single list-->

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

<!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/candidate-follow-employers.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:39 GMT -->
</html>