<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Stock - Responsive Job Portal | Candidate List</title>
    <link rel="icon" type="image/x-icon" href="assets/img/favicon.png">
    <!-- Custom CSS -->
    <link href="assets/css/styles.css" rel="stylesheet">
    <!-- Colors CSS -->
    <link href="assets/css/colors.css" rel="stylesheet">
</head>
<body class="green-theme">
    <!-- Preloader -->
    <div id="preloader"><div class="preloader"><span></span><span></span></div></div>

    <!-- Main wrapper -->
    <div id="main-wrapper">
        <!-- Start Navigation -->
        <div class="header header-light head-fixed">
            <div class="container">
                <nav id="navigation" class="navigation navigation-landscape">
                    <div class="nav-header">
                        <a class="nav-brand" href="#">
                            <img src="assets/img/logo.png" class="logo" alt="">
                        </a>
                        <div class="nav-toggle"></div>
                        <ul class="mobile_nav dhsbrd">
                            <li>
                                <div class="btn-group account-drop">
                                    <button type="button" class="btn btn-order-by-filt" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fa-regular fa-comments"></i><span class="noti-status"></span>
                                    </button>
                                    <div class="dropdown-menu pull-right animated flipInX">
                                        <div class="drp_menu_headr bg-primary">
                                            <h4>Notifications</h4>
                                        </div>
                                        <div class="ntf-list-groups">
                                            <c:if test="${not empty notifications}">
                                                <c:forEach var="notification" items="${notifications}">
                                                    <div class="ntf-list-groups-single">
                                                        <div class="ntf-list-groups-icon ${notification.iconClass}"><i class="${notification.icon}"></i></div>
                                                        <div class="ntf-list-groups-caption"><p class="small">${notification.message}</p></div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${empty notifications}">
                                                <div class="ntf-list-groups-single">
                                                    <p class="small">No notifications available.</p>
                                                </div>
                                            </c:if>
                                            <div class="ntf-list-groups-single">
                                                <a href="#" class="ntf-more">View All Notifications</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="btn-group account-drop">
                                    <button type="button" class="btn btn-order-by-filt" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <img src="assets/img/user-5.png" class="img-fluid circle" alt="">
                                    </button>
                                    <div class="dropdown-menu pull-right animated flipInX">
                                        <div class="drp_menu_headr bg-primary">
                                            <c:if test="${not empty sessionScope.user}">
                                                <h4>Hi, ${sessionScope.user.name}</h4>
                                            </c:if>
                                            <c:if test="${empty sessionScope.user}">
                                                <h4>Hi, Guest</h4>
                                            </c:if>
                                            <div class="drp_menu_headr-right"><button type="button" class="btn btn-whites">Logout</button></div>
                                        </div>
                                        <ul>
                                            <li><a href="candidate-dashboard.jsp"><i class="fa fa-tachometer-alt"></i>Dashboard<span class="notti_coun style-1">4</span></a></li>
                                            <li><a href="candidate-profile.jsp"><i class="fa fa-user-tie"></i>My Profile</a></li>
                                            <li><a href="candidate-resume.jsp"><i class="fa fa-file"></i>My Resume<span class="notti_coun style-2">7</span></a></li>
                                            <li><a href="candidate-saved-jobs.jsp"><i class="fa-solid fa-bookmark"></i>Saved Resume</a></li>
                                            <li><a href="candidate-messages.jsp"><i class="fa fa-envelope"></i>Messages<span class="notti_coun style-3">3</span></a></li>
                                            <li><a href="candidate-change-password.jsp"><i class="fa fa-unlock-alt"></i>Change Password</a></li>
                                            <li><a href="candidate-delete-account.jsp"><i class="fa-solid fa-trash-can"></i>Delete Account</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="nav-menus-wrapper">
                        <ul class="nav-menu">
                            <li class="active"><a href="#">Home<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a class="active" href="index.jsp">Home Layout 1</a></li>
                                    <li><a href="home-2.jsp">Home Layout 2</a></li>
                                    <li><a href="home-3.jsp">Home Layout 3</a></li>
                                    <li><a href="home-4.jsp">Home Layout 4</a></li>
                                    <li><a href="home-5.jsp">Home Layout 5</a></li>
                                    <li><a href="home-6.jsp">Home Layout 6</a></li>
                                    <li><a href="home-7.jsp">Home Layout 7</a></li>
                                    <li><a href="#">New Homes Layouts<span class="new-update">New</span><span class="submenu-indicator"></span></a>
                                        <ul class="nav-dropdown nav-submenu">
                                            <li><a href="home-8.jsp">Home Layout 8</a></li>
                                            <li><a href="home-9.jsp">Home Layout 9</a></li>
                                            <li><a href="home-10.jsp">Home Layout 10</a></li>
                                            <li><a href="home-11.jsp">Home Layout 11</a></li>
                                            <li><a href="home-12.jsp">Home Layout 12</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li><a href="#">For Candidate<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a href="#">Browse Jobs<span class="submenu-indicator"></span></a>
                                        <ul class="nav-dropdown nav-submenu">
                                            <li><a href="grid-style-1.jsp">Job Grid Style 1</a></li>
                                            <li><a href="grid-style-2.jsp">Job Grid Style 2</a></li>
                                            <li><a href="grid-style-3.jsp">Job Grid Style 3</a></li>
                                            <li><a href="grid-style-4.jsp">Job Grid Style 4</a></li>
                                            <li><a href="grid-style-5.jsp">Job Grid Style 5</a></li>
                                            <li><a href="full-job-grid-1.jsp">Grid Full Style 1</a></li>
                                            <li><a href="full-job-grid-2.jsp">Grid Full Style 2</a></li>
                                            <li><a href="list-style-1.jsp">Job List Style 1</a></li>
                                            <li><a href="list-style-2.jsp">Job List Style 2</a></li>
                                            <li><a href="list-style-3.jsp">Job List Style 3</a></li>
                                            <li><a href="full-job-list-1.jsp">List Full Style 1</a></li>
                                            <li><a href="full-job-list-2.jsp">List Full Style 2</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Browse Map Jobs<span class="submenu-indicator"></span></a>
                                        <ul class="nav-dropdown nav-submenu">
                                            <li><a href="half-map.jsp">Job Search on Map 01</a></li>
                                            <li><a href="half-map-2.jsp">Job Search on Map 02</a></li>
                                            <li><a href="half-map-3.jsp">Job Search on Map 03</a></li>
                                            <li><a href="half-map-list-1.jsp">Job Search on Map 04</a></li>
                                            <li><a href="half-map-list-2.jsp">Job Search on Map 05</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Browse Candidate<span class="submenu-indicator"></span></a>
                                        <ul class="nav-dropdown nav-submenu">
                                            <li><a href="candidate-grid-1.jsp">Candidate Grid 01</a></li>
                                            <li><a href="candidate-grid-2.jsp">Candidate Grid 02</a></li>
                                            <li><a href="candidate-list-1.jsp">Candidate List 01</a></li>
                                            <li><a href="candidate-list-2.jsp">Candidate List 02</a></li>
                                            <li><a href="candidate-half-map.jsp">Candidate Half Map 01</a></li>
                                            <li><a href="candidate-half-map-list.jsp">Candidate Half Map 02</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Single job Detail<span class="submenu-indicator"></span></a>
                                        <ul class="nav-dropdown nav-submenu">
                                            <li><a href="single-layout-1.jsp">Single Layout 01</a></li>
                                            <li><a href="single-layout-2.jsp">Single Layout 02</a></li>
                                            <li><a href="single-layout-3.jsp">Single Layout 03</a></li>
                                            <li><a href="single-layout-4.jsp">Single Layout 04</a></li>
                                            <li><a href="single-layout-5.jsp">Single Layout 05<span class="new-update">New</span></a></li>
                                            <li><a href="single-layout-6.jsp">Single Layout 06<span class="new-update">New</span></a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Candidate Detail<span class="submenu-indicator"></span></a>
                                        <ul class="nav-dropdown nav-submenu">
                                            <li><a href="candidate-detail.jsp">Candidate Detail 01</a></li>
                                            <li><a href="candidate-detail-2.jsp">Candidate Detail 02</a></li>
                                            <li><a href="candidate-detail-3.jsp">Candidate Detail 03</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="advance-search.jsp">Advance Search</a></li>
                                    <li><a href="candidate-dashboard.jsp">Candidate Dashboard<span class="new-update">New</span></a></li>
                                </ul>
                            </li>
                            <li><a href="#">For Employer<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a href="#">Explore Employers<span class="submenu-indicator"></span></a>
                                        <ul class="nav-dropdown nav-submenu">
                                            <li><a href="employer-grid-1.jsp">Search Employers 01</a></li>
                                            <li><a href="employer-grid-2.jsp">Search Employers 02</a></li>
                                            <li><a href="employer-list-1.jsp">Search List Employers 01</a></li>
                                            <li><a href="employer-half-map.jsp">Search Employers Map</a></li>
                                            <li><a href="employer-half-map-list.jsp">Search List Employers Map</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Employer Detail<span class="submenu-indicator"></span></a>
                                        <ul class="nav-dropdown nav-submenu">
                                            <li><a href="employer-detail.jsp">Employer Detail 01</a></li>
                                            <li><a href="employer-detail-2.jsp">Employer Detail 02</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="employer-dashboard.jsp">Employer Dashboard<span class="new-update">New</span></a></li>
                                </ul>
                            </li>
                            <li><a href="#">Pages<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a href="about-us.jsp">About Us</a></li>
                                    <li><a href="404.jsp">Error Page</a></li>
                                    <li><a href="checkout.jsp">Checkout</a></li>
                                    <li><a href="blog.jsp">Blogs Page</a></li>
                                    <li><a href="blog-detail.jsp">Blog Detail</a></li>
                                    <li><a href="privacy.jsp">Terms & Privacy</a></li>
                                    <li><a href="pricing.jsp">Pricing</a></li>
                                    <li><a href="faq.jsp">FAQ's</a></li>
                                    <li><a href="contact.jsp">Contacts</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Help</a></li>
                        </ul>
                        <ul class="nav-menu nav-menu-social align-to-right dhsbrd">
                            <li>
                                <div class="btn-group account-drop">
                                    <button type="button" class="btn btn-order-by-filt" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fa-regular fa-comments"></i><span class="noti-status"></span>
                                    </button>
                                    <div class="dropdown-menu pull-right animated flipInX">
                                        <div class="drp_menu_headr bg-primary">
                                            <h4>Notifications</h4>
                                        </div>
                                        <div class="ntf-list-groups">
                                            <c:if test="${not empty notifications}">
                                                <c:forEach var="notification" items="${notifications}">
                                                    <div class="ntf-list-groups-single">
                                                        <div class="ntf-list-groups-icon ${notification.iconClass}"><i class="${notification.icon}"></i></div>
                                                        <div class="ntf-list-groups-caption"><p class="small">${notification.message}</p></div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${empty notifications}">
                                                <div class="ntf-list-groups-single">
                                                    <p class="small">No notifications available.</p>
                                                </div>
                                            </c:if>
                                            <div class="ntf-list-groups-single">
                                                <a href="#" class="ntf-more">View All Notifications</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="btn-group account-drop">
                                    <button type="button" class="btn btn-order-by-filt" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <img src="assets/img/user-5.png" class="img-fluid circle" alt="">
                                    </button>
                                    <div class="dropdown-menu pull-right animated flipInX">
                                        <div class="drp_menu_headr bg-primary">
                                            <c:if test="${not empty sessionScope.user}">
                                                <h4>Hi, ${sessionScope.user.name}</h4>
                                            </c:if>
                                            <c:if test="${empty sessionScope.user}">
                                                <h4>Hi, Guest</h4>
                                            </c:if>
                                            <div class="drp_menu_headr-right"><button type="button" class="btn btn-whites">Logout</button></div>
                                        </div>
                                        <ul>
                                            <li><a href="candidate-dashboard.jsp"><i class="fa fa-tachometer-alt"></i>Dashboard<span class="notti_coun style-1">4</span></a></li>
                                            <li><a href="candidate-profile.jsp"><i class="fa fa-user-tie"></i>My Profile</a></li>
                                            <li><a href="candidate-resume.jsp"><i class="fa fa-file"></i>My Resume<span class="notti_coun style-2">7</span></a></li>
                                            <li><a href="candidate-saved-jobs.jsp"><i class="fa-solid fa-bookmark"></i>Saved Resume</a></li>
                                            <li><a href="candidate-messages.jsp"><i class="fa fa-envelope"></i>Messages<span class="notti_coun style-3">3</span></a></li>
                                            <li><a href="candidate-change-password.jsp"><i class="fa fa-unlock-alt"></i>Change Password</a></li>
                                            <li><a href="candidate-delete-account.jsp"><i class="fa-solid fa-trash-can"></i>Delete Account</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li class="list-buttons ms-2">
                                <a href="employer-submit-job.jsp"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Post Job</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <!-- End Navigation -->
        <div class="clearfix"></div>

        <!-- Dashboard Detail -->
        <div class="dashboard-wrap bg-light">
            <a class="mobNavigation" data-bs-toggle="collapse" href="#MobNav" role="button" aria-expanded="false" aria-controls="MobNav">
                <i class="fas fa-bars mr-2"></i>Dashboard Navigation
            </a>
            <div class="collapse" id="MobNav">
                <div class="dashboard-nav">
                    <div class="dash-user-blocks pt-5">
                        <div class="jbs-grid-usrs-thumb">
                            <div class="jbs-grid-yuo">
                                <a href="candidate-detail.jsp"><figure><img src="assets/img/l-12.png" class="img-fluid circle" alt=""></figure></a>
                            </div>
                        </div>
                        <div class="jbs-grid-usrs-caption mb-3">
                            <div class="jbs-kioyer">
                                <span class="label text-light theme-bg">05 Openings</span>
                            </div>
                            <div class="jbs-tiosk">
                                <h4 class="jbs-tiosk-title"><a href="candidate-detail.jsp">Instagram App</a></h4>
                                <div class="jbs-tiosk-subtitle"><span><i class="fa-solid fa-location-dot me-2"></i>Canada</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="dashboard-inner">
                        <ul data-submenu-title="Main Navigation">
                            <li><a href="employer-dashboard.jsp"><i class="fa-solid fa-gauge-high me-2"></i>User Dashboard</a></li>
                            <li><a href="employer-profile.jsp"><i class="fa-regular fa-user me-2"></i>User Profile </a></li>
                            <li><a href="employer-jobs.jsp"><i class="fa-solid fa-business-time me-2"></i>My Jobs</a></li>
                            <li><a href="employer-submit-job.jsp"><i class="fa-solid fa-pen-ruler me-2"></i>Submit Jobs</a></li>
                            <li><a href="employer-applicants-jobs.jsp"><i class="fa-solid fa-user-group me-2"></i>Applicants Jobs</a></li>
                            <li class="active"><a href="CandidateList.jsp"><i class="fa-solid fa-user-clock me-2"></i>Candidate List</a></li>
                            <li><a href="employer-package.jsp"><i class="fa-solid fa-wallet me-2"></i>Package</a></li>
                            <li><a href="employer-messages.jsp"><i class="fa-solid fa-comments me-2"></i>Messages</a></li>
                            <li><a href="employer-change-password.jsp"><i class="fa-solid fa-unlock-keyhole me-2"></i>Change Password</a></li>
                            <li><a href="employer-delete-account.jsp"><i class="fa-solid fa-trash-can me-2"></i>Delete Account</a></li>
                            <li><a href="index.jsp"><i class="fa-solid fa-power-off me-2"></i>Log Out</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="dashboard-content">
                <div class="dashboard-tlbar d-block mb-4">
                    <div class="row">
                        <div class="colxl-12 col-lg-12 col-md-12">
                            <h1 class="mb-1 fs-3 fw-medium">Candidate List</h1>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item text-muted"><a href="#">Employer</a></li>
                                    <li class="breadcrumb-item text-muted"><a href="#">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="#" class="text-primary">Candidate List</a></li>
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
                                <div class="card-header">
                                    <div class="_mp-inner-content elior">
                                        <div class="_mp-inner-first">
                                            <div class="search-inline">
                                                <form action="searchCandidates" method="get">
                                                    <input type="text" name="keyword" class="form-control" placeholder="Job title, Keywords etc.">
                                                    <button type="submit" class="btn btn-primary">Search</button>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="_mp_inner-last">
                                            <div class="item-shorting-box-right">
                                                <div class="shorting-by me-2 small">
                                                    <select name="sortBy" onchange="this.form.submit()">
                                                        <option value="0">Short by (Default)</option>
                                                        <option value="1">Short by (Featured)</option>
                                                        <option value="2">Short by (Urgent)</option>
                                                        <option value="3">Short by (Post Date)</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <!-- Start All List -->
                                    <div class="row justify-content-start gx-3 gy-4">
                                        <c:if test="${not empty candidateList}">
                                            <c:forEach var="candidate" items="${candidateList}">
                                                <!-- Single Item -->
                                                <div class="col-xl-12 col-lg-12 col-md-12 col-12">
                                                    <div class="jbs-list-box border">
                                                        <div class="jbs-list-head m-0">
                                                            <div class="jbs-list-head-thunner">
                                                                <div class="jbs-list-usrs-thumb jbs-verified">
                                                                    <a href="candidate-detail.jsp?id=${candidate.id}">
                                                                        <figure><img src="assets/img/${candidate.image}" class="img-fluid circle" alt=""></figure>
                                                                    </a>
                                                                </div>
                                                                <div class="jbs-list-job-caption">
                                                                    <div class="jbs-job-title-wrap">
                                                                        <h4><a href="candidate-detail.jsp?id=${candidate.id}" class="jbs-job-title">${candidate.name}</a></h4>
                                                                    </div>
                                                                    <div class="jbs-job-mrch-lists">
                                                                        <div class="single-mrch-lists">
                                                                            <span>${candidate.jobTitle}</span>.<span><i class="fa-solid fa-location-dot me-1"></i>${candidate.location}</span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="jbs-grid-job-edrs-group mt-1">
                                                                        <c:if test="${not empty candidate.skills}">
                                                                            <c:forEach var="skill" items="${candidate.skills}">
                                                                                <span>${skill}</span>
                                                                            </c:forEach>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="jbs-list-head-middle">
                                                                <div class="elsocrio-jbs sm"><div class="ilop-tr"><i class="fa-solid fa-coins"></i></div><h5 class="jbs-list-pack">${candidate.experience}</h5></div>
                                                            </div>
                                                            <div class="jbs-list-head-last">
                                                                <a href="viewCandidate.jsp?id=${candidate.id}" class="rounded btn-md text-info bg-light-info px-3"><i class="fa-solid fa-eye"></i></a>
                                                                <a href="emailCandidate.jsp?id=${candidate.id}" class="rounded btn-md text-success bg-light-success px-3"><i class="fa-solid fa-envelope-circle-check"></i></a>
                                                                <a href="deleteCandidate.jsp?id=${candidate.id}" class="rounded btn-md text-danger bg-light-danger px-3"><i class="fa-solid fa-trash-can"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty candidateList}">
                                            <div class="col-xl-12 col-lg-12 col-md-12 col-12">
                                                <p>No candidates available.</p>
                                            </div>
                                        </c:if>
                                    </div>
                                    <!-- End All Job List -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Header Wrap -->
                </div>

                <!-- Footer -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="py-3 text-center">© 2015 - 2023 Job Stock® Themezhub.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <a id="back2Top" class="top-scroll" title="Back to top" href="#"><i class="ti-arrow-up"></i></a>
</div>
<!-- End Wrapper -->

<!-- Color Switcher -->
<div class="style-switcher">
    <div class="css-trigger"><a href="#"><i class="fa-solid fa-paintbrush"></i></a></div>
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

<!-- All Jquery -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/popper.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/rangeslider.js"></script>
<script src="assets/js/jquery.nice-select.min.js"></script>
<script src="assets/js/slick.js"></script>
<script src="assets/js/counterup.min.js"></script>
<script src="assets/js/custom.js"></script>
<script src="assets/js/cl-switch.js"></script>
</body>
</html>