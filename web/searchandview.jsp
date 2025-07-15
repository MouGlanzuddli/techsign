<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<%@ page import="model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    User user = (User) session.getAttribute("user");
%>
<html lang="en">
    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/full-job-grid-1.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:58:57 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>TechSign - Responsive Job Portal Bootstrap Template | ThemezHub</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">

        <!-- Colors CSS -->
        <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">       
    </head>

    <body class="green-theme">

        <!-- Main Wrapper -->

        <div id="main-wrapper">
            <!-- Top Header -->

            <div class="header header-light head-shadow">
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
                                <li><a href="index.jsp">Home<span class="submenu-indicator"></span></a></li>

                                <li>
                                    <a href="JavaScript:Void(0);">Jobs<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="SearchandView">Job List</a></li>
                                        <li><a href="grid-style-2.html">Suitable Jobs</a></li>

                                    </ul>
                                </li>

                                <li>
                                    <a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="SearchCompaniesServlet">Company List</a></li>

                                    </ul>
                                </li>

                                <li>
                                    <a href="JavaScript:Void(0);">Pages<span class="submenu-indicator"></span></a>
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
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
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
                                    </c:when>
                                    <c:otherwise>

                                        <li><a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login"><i class="fas fa-sign-in-alt me-2"></i>Sign In</a></li>
                                        <li class="list-buttons ms-2"><a href="signup.html"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Upload Resume</a></li>

                                    </c:otherwise>
                                </c:choose>

                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
            <div class="clearfix"></div>


            <!-- ========================================== Page Title Start==================== -->
            <div class="page-title primary-bg-dark" style="background:url(${pageContext.request.contextPath}/assets/img/bg2.png) no-repeat;">
                <div class="container">
                    <div class="row">


                        <div class="col-lg-12 col-md-12">
                            <div class="full-search-2">
                                <div class="hero-search-content search-shadow">
                                    <form method="get" action="SearchandView">
                                        <div class="row classic-search-box m-0 gx-2">
                                            <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12">
                                                <div class="form-group briod">
                                                    <div class="input-with-icon">
                                                        <input type="text" name="keyword" class="form-control"
                                                               placeholder="Skills, Title, Keyword"
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
                                                    <div class="form-group me-2">
                                                        <a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#filter" class="btn btn-filter-search"><i class="fa-solid fa-filter"></i>Filter</a>
                                                    </div>
                                                    <div class="form-group">
                                                        <button type="submit" class="btn btn-primary full-width">Search</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ========================================== Page Title End ==================== -->
            <!-- Job Listings Section -->
            <section>

                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">

                            <div class="row justify-content-center mb-5">
                                <div class="col-lg-12 col-md-12">
                                    <div class="item-shorting-box">
                                        <div class="item-shorting clearfix">
                                            <h5 class="m-sm-0 mb-2">Showing ${jobList.size()} of ${totalJobs} Results</h5>
                                        </div>
                                        <div class="item-shorting-box-right">
                                            <div class="shorting-by me-2 small">
                                                <select name="sortBy" onchange="window.location = 'SearchandView?sortBy=' + this.value + '&papersPerPage=${papersPerPage}&description=${param.description}&city=${param.city}' + '&keyword=${param.keyword}'" >                                                   
                                                    <option value="Internship" ${sortBy == 'Internship' ? 'selected' : ''}>Short by (Internship)</option>
                                                    <option value="Freelancer" ${sortBy == 'Freelancer' ? 'selected' : ''}>Short by (Freelancer)</option>
                                                    <option value="Part-time"  ${sortBy == 'Part-time' ? 'selected' : ''}>Short by (Part Time)</option>
                                                    <option value="Full-time"  ${sortBy == 'Full-time' ? 'selected' : ''}>Short by (Full Time)</option>
                                                </select>
                                            </div>
                                            <div class="shorting-by small">
                                                <select name="papersPerPage"
                                                        onchange="window.location.href = 'SearchandView?page=1&papersPerPage=' + this.value
                                                                        + '&description=${param.description}&city=${param.city}&keyword=${param.keyword}'">
                                                    <option value="8" ${papersPerPage == 8 ? 'selected' : ''}>8 Per Page</option>
                                                    <option value="16" ${papersPerPage == 16 ? 'selected' : ''}>16 Per Page</option>
                                                    <option value="32" ${papersPerPage == 32 ? 'selected' : ''}>32 Per Page</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>                         
            </section>

            <div class="row">
                <c:set var="listToShow" value="${not empty jobs ? jobs : jobList}" />

                <c:choose>
                    <c:when test="${not empty listToShow}">
                        <c:forEach var="job" items="${listToShow}">
                            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12">
                                <div class="job-instructor-layout border">

                                    <!-- Job Type -->
                                    <div class="brows-job-type">
                                        <span class="${job.jobType}">
                                            <c:choose>
                                                <c:when test="${job.jobType == 'Internship'}">Internship</c:when>
                                                <c:when test="${job.jobType == 'Freelancer'}">Freelancer</c:when>
                                                <c:when test="${job.jobType == 'Part-time'}">Part time</c:when>
                                                <c:otherwise>Full time</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>

                                    <!-- Logo -->
                                    <div class="job-instructor-thumb">
                                        <a href="JobDetail?id=${job.id}">
                                            <img src="assets/img/l-1.png" class="img-fluid" alt="" >
                                        </a>
                                    </div>

                                    <!-- Content -->
                                    <div class="job-instructor-content">
                                        <h4 class="instructor-title">
                                            <a href="JobDetail?id=${job.id}">${job.title}</a>
                                        </h4>
                                        <div class="instructor-skills">
                                            ${job.description}
                                        </div>
                                        <div class="instructor-skills">
                                            <c:set var="skills" value="${skillsMap[job.id]}" />                                          
                                            <c:forEach var="skill" items="${skills}" varStatus="loop">
                                                ${skill.name}<c:if test="${!loop.last}">, </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- Footer -->
                                    <div class="job-instructor-footer">
                                        <div class="instructor-students">
                                            <h4 class="instructor-scount">
                                                <fmt:formatNumber value="${job.salaryMin}" type="number" maxFractionDigits="0"/> ₫ - 
                                                <fmt:formatNumber value="${job.salaryMax}" type="number" maxFractionDigits="0"/> ₫
                                            </h4>
                                        </div>
                                        <div class="instructor-corses">
                                            <span class="c-counting">
                                                <c:choose>
                                                    <c:when test="${job.status == 'open'}">Open</c:when>
                                                    <c:otherwise>Closed</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>

                        <!-- Pagination -->
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="SearchandView?page=${currentPage - 1}&papersPerPage=${papersPerPage}
                                                   &keyword=${param.keyword}&description=${param.description}&city=${param.city}">
                                                    &laquo;
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link"
                                                   href="SearchandView?page=${i}&papersPerPage=${papersPerPage}
                                                   &keyword=${param.keyword}&description=${param.description}&city=${param.city}">
                                                    ${i}
                                                </a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="SearchandView?page=${currentPage + 1}&papersPerPage=${papersPerPage}
                                                   &keyword=${param.keyword}&description=${param.description}&city=${param.city}">
                                                    &raquo;
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="col-12">
                            <p>No jobs found.</p>
                        </div>
                    </c:otherwise>
                </c:choose>


            </div>
        </div>

        <!--End lop phan trang-->


        <!-- Filter Modal -->
        <form method="post" action="SearchandView">
            <input type="hidden" name="filterMode" value="true">

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

                                    <!-- Place Of Work -->
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Place Of Work</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="anywhere"
                                                           name="place_of_work" value="Anywhere"
                                                           <c:if test="${fn:contains(paramValues.place_of_work, 'Anywhere')}">checked</c:if> >
                                                           <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="anywhere">Anywhere</label>
                                                    </div>
                                                    <div class="sing-btn-groups">
                                                        <input type="checkbox" class="btn-check" id="onsite"
                                                               name="place_of_work" value="On site"
                                                        <c:if test="${fn:contains(paramValues.place_of_work, 'On site')}">checked</c:if> >
                                                        <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="onsite">On Site</label>
                                                    </div>
                                                    <div class="sing-btn-groups">
                                                        <input type="checkbox" class="btn-check" id="remote"
                                                               name="place_of_work" value="Fully Remote"
                                                        <c:if test="${fn:contains(paramValues.place_of_work, 'Fully Remote')}">checked</c:if> >
                                                        <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="remote">Fully Remote</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Type Of Contract -->
                                        <div class="single-tabs-group">
                                            <div class="single-tabs-group-header"><h5>Type Of Contract</h5></div>
                                            <div class="single-tabs-group-content">
                                                <div class="d-flex flex-wrap">
                                                <c:forEach var="ct" items="${['Employee','Freelancer','Contractor','Internship']}">
                                                    <div class="sing-btn-groups">
                                                        <input type="checkbox" class="btn-check" id="ct-${ct}" name="contract_type" value="${ct}"
                                                               <c:if test="${fn:contains(paramValues.contract_type, ct)}">checked</c:if> >
                                                        <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="ct-${ct}">${ct}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Type Of Employment -->
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Type Of Employment</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <c:forEach var="et" items="${['Full-time','Part-time','Freelancer','Internship']}">
                                                    <div class="sing-btn-groups">
                                                        <input type="checkbox" class="btn-check" id="et-${et}" name="employment_type" value="${et}"
                                                               <c:if test="${fn:contains(paramValues.employment_type, et)}">checked</c:if> >
                                                        <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="et-${et}">${et}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Salary Range -->
                                    <div class="single-tabs-group">
                                        <div><h5>Salary Range (VND)</h5></div>
                                        <select class="form-control" name="salary_range">
                                            <option value="">-- Select salary range --</option>
                                            <option value="0-20000000" <c:if test="${param.salary_range == '0-20000000'}">selected</c:if> >0 - 20.000.000</option>
                                            <option value="20000000-40000000" <c:if test="${param.salary_range == '20000000-40000000'}">selected</c:if> >20000000-40000000</option>
                                            <option value="40000000-60000000" <c:if test="${param.salary_range == '40000000-60000000'}">selected</c:if> >40.000.000 - 60.000.000</option>
                                            <option value="60000000-80000000" <c:if test="${param.salary_range == '60000000-80000000'}">selected</c:if> >60.000.000 - 80.000.000</option>
                                            <option value="80000000-100000000" <c:if test="${param.salary_range == '80000000-100000000'}">selected</c:if> >80.000.000 - 100.000.000</option>
                                            </select>
                                        </div>

                                        <!-- Categories -->
                                        <div class="single-tabs-group">
                                            <div class="single-tabs-group-header"><h5>Explore Top Categories</h5></div>
                                            <div class="single-tabs-group-content">
                                                <ul class="row p-0 m-0">
                                                <c:forEach var="cat" items="${categories}">
                                                    <li class="col-lg-6 col-md-6 p-0">
                                                        <div class="form-check form-check-inline">
                                                            <input type="checkbox" name="category" class="form-check-input" id="cat-${cat}" value="${cat}"
                                                                   <c:if test="${fn:contains(paramValues.category, cat)}">checked</c:if>>
                                                            <label for="cat-${cat}" class="form-check-label">${cat}</label>
                                                        </div>
                                                    </li>
                                                </c:forEach>

                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Keyword -->
                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Keywords</h5></div>
                                        <div class="single-tabs-group-content">
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="keyword"
                                                       value="${param.keyword}" placeholder="Design, Java, Python, WordPress etc...">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <div class="filt-buttons-updates">
                                <button type="reset" class="btn btn-dark">Clear Filter</button>
                                <button type="submit" class="btn btn-primary">Search</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </form>


        <footer class="footer skin-light-footer">

            <div>
                <div class="container">
                    <div class="row">

                        <div class="col-lg-3 col-md-4">
                            <div class="footer-widget">
                                <img src="assets/img/logo.png" class="img-footer" alt="">
                                <div class="footer-add">
                                    <p>Collins Street West, Victoria Near Bank Road<br>Australia QHR12456.</p>
                                </div>
                                <div class="foot-socials">
                                    <ul>
                                        <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-facebook"></i></a></li>
                                        <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-linkedin"></i></a></li>
                                        <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-google-plus"></i></a></li>
                                        <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-twitter"></i></a></li>
                                        <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-dribbble"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>		
                        <div class="col-lg-2 col-md-4">
                            <div class="footer-widget">
                                <h4 class="widget-title text-primary">For Clients</h4>
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

                        <div class="col-lg-2 col-md-4">
                            <div class="footer-widget">
                                <h4 class="widget-title text-primary">Our Resources</h4>
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

                        <div class="col-lg-2 col-md-6">
                            <div class="footer-widget">
                                <h4 class="widget-title text-primary">The Company</h4>
                                <ul class="footer-menu">
                                    <li><a href="JavaScript:Void(0);">About Us</a></li>
                                    <li><a href="JavaScript:Void(0);">Leadership</a></li>
                                    <li><a href="JavaScript:Void(0);">Contact Us</a></li>
                                    <li><a href="JavaScript:Void(0);">Investor Relations</a></li>
                                    <li><a href="JavaScript:Void(0);">Trust, Safety & Security</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="footer-widget">
                                <h4 class="widget-title text-primary">Download Apps</h4>	
                                <div class="app-wrap">
                                    <p><a href="JavaScript:Void(0);"><img src="assets/img/light-play.png" class="img-fluid" alt=""></a></p>
                                    <p><a href="JavaScript:Void(0);"><img src="assets/img/light-ios.png" class="img-fluid" alt=""></a></p>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="container">
                    <div class="row align-items-center justify-content-center">

                        <div class="col-xl-12 col-lg-12 col-md-12">
                            <p class="mb-0 text-center">© 2015 - 2023 Job Stock® Themezhub.</p>
                        </div>

                    </div>
                </div>
            </div>              
        </footer>

        <a id="back2Top" class="top-scroll" title="Back to top" href="#"><i class="ti-arrow-up"></i></a>

        <!-- =========================================================================== -->
        <!-- End Wrapper -->
        <!-- =========================================================================== -->

        <!-- Color Switcher -->
        <div class="style-switcher">
            <div class="css-trigger shadow"><a href="#"><i class="fa-solid fa-paintbrush"></i></a></div>
            <div>
                <ul id="themecolors" class="mt-20">
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

        <!-- =========================================================================== -->
        <!-- All Jquery -->
        <!-- =========================================================================== -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/rangeslider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery.nice-select.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/slick.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/counterup.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script src="${pageContext.request.contextPath}/assets/js/custom.js"></script><script src="${pageContext.request.contextPath}/assets/js/cl-switch.js"></script>
        <!-- =========================================================================== -->
        <!-- This page plugins -->
        <!-- =========================================================================== -->


    </body>

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/full-job-grid-1.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:58:57 GMT -->
</html>
