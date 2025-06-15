
<!doctype html>
<html lang="en">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
                                        <li><a href="JavaScript:Void(0);">Job List</a></li>
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
                                                               placeholder="Skills, Designations, Keyword"
                                                               value="${param.keyword}">
                                                        <i class="fa-solid fa-magnifying-glass text-primary"></i>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12">
                                                <div class="form-group briod">
                                                    <div class="input-with-icon">
                                                        <select name="category" class="form-control">
                                                            <option value="">Job Category</option>
                                                            <option value="Accounting & Finance" ${param.category == 'Accounting' ? 'selected' : ''}>Accounting & Finance</option>
                                                            <option value="Automotive Jobs" ${param.category == 'Automotive Jobs' ? 'selected' : ''}>Automotive Jobs</option>
                                                            <option value="Business Services" ${param.category == 'Business Services' ? 'selected' : ''}>Business Services</option>
                                                            <option value="Education Training" ${param.category == 'Education Training' ? 'selected' : ''}>Education Training</option>

                                                            <option value="Restaurant & Food" ${param.category == 'Restaurant & Food' ? 'selected' : ''}>Restaurant & Food</option>
                                                            <option value="Healthcare" ${param.category == 'Healthcare' ? 'selected' : ''}>Healthcare</option>
                                                            <option value="Transportations" ${param.category == 'Transportation' ? 'selected' : ''}>Transportation</option>
                                                            <option value="Telecommunications" ${param.category == 'Telecommunications' ? 'selected' : ''}>Telecommunications</option>
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
                                                            <option value="1">Select City</option>
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
            <div class="row justify-content-center mb-5">
                <div class="col-lg-12 col-md-12">
                    <div class="item-shorting-box">
                        <h5>Showing ${jobList.size()} of ${totalJobs} Results</h5>
                        <div class="item-shorting-box-right">
                            <div class="shorting-by me-2 small">
                                <select name="sortBy" onchange="window.location = 'SearchandView?sortBy=' + this.value + '&papersPerPage=${papersPerPage}&category=${param.category}&city=${param.city}'" class="form-select me-2">
                                    <option value="Internship" ${sortBy == 'Internship' ? 'selected' : ''}>Sort by (Internship)</option>
                                    <option value="Freelancer" ${sortBy == 'Freelancer' ? 'selected' : ''}>Sort by (Freelancer)</option>
                                    <option value="Part-time" ${sortBy == 'Part-time' ? 'selected' : ''}>Sort by (Part Time)</option>
                                    <option value="Full-time" ${sortBy == 'Full-time' ? 'selected' : ''}>Sort by (Full Time)</option>
                                </select>
                            </div>
                            <div class="shorting-by small">
                                <select name="papersPerPage" onchange="window.location = 'SearchandView?sortBy=${sortBy}&papersPerPage=' + this.value + '&category=${param.category}&city=${param.city}'" class="form-select">
                                    <option value="10" ${papersPerPage == 10 ? 'selected' : ''}>10 Per Page</option>
                                    <option value="20" ${papersPerPage == 20 ? 'selected' : ''}>20 Per Page</option>
                                    <option value="50" ${papersPerPage == 50 ? 'selected' : ''}>50 Per Page</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

                    <div class="row">
                        <c:if test="${empty jobList}">
                            <p>No jobs found.</p>
                            <% System.out.println("jobList = " + request.getAttribute("jobList"));%>
                        </c:if>

                        <c:forEach var="job" items="${jobList}">
                            <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12">
                                <div class="job-instructor-layout border">


                                    <!-- Job Type -->
                                    <div class="brows-job-type">
                                        <span class="
                                              <c:choose>
                                                  <c:when test="${job.jobType == 'Internship'}">internship</c:when>
                                                  <c:when test="${job.jobType == 'Freelancer'}">freelancer</c:when>
                                                  <c:when test="${job.jobType == 'Part Time'}">part-time</c:when>
                                                  <c:otherwise>full-time</c:otherwise>
                                              </c:choose>
                                              ">
                                            ${job.jobType}
                                        </span>
                                    </div>

                                    <!-- Logo -->
                                    <div class="job-instructor-thumb">
                                        <a href="JobDetail?id=${job.id}">${job.title}</a>

                                        <img src="${pageContext.request.contextPath}/assets/img/l-1.png" class="img-fluid" alt="">
                                        </a>
                                    </div>

                                    <!-- Content -->
                                    <div class="job-instructor-content">
                                        <h4 class="instructor-title"><a href="JobDetail?id=${job.id}">${job.title}<a></a></h4>
                                        <div class="instructor-skills">
                                            ${job.skills}
                                        </div>
                                    </div>

                                    <!-- Footer -->
                                    <div class="job-instructor-footer">
                                        <div class="instructor-students">
                                            <fmt:formatNumber value="${job.salaryMin}" type="number" maxFractionDigits="0"/> - 
                                            <fmt:formatNumber value="${job.salaryMax}" type="number" maxFractionDigits="0"/>
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
                    </div>







                    <!-- Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center mt-4">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="SearchandView?page=${currentPage - 1}&sortBy=${sortBy}&papersPerPage=${papersPerPage}&category=${param.category}&city=${param.city}">Previous</a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="SearchandView?page=${i}&sortBy=${sortBy}&papersPerPage=${papersPerPage}&category=${param.category}&city=${param.city}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="SearchandView?page=${currentPage + 1}&sortBy=${sortBy}&papersPerPage=${papersPerPage}&category=${param.category}&city=${param.city}">Next</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>

            <!--End lop phan trang-->


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
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="msix">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="msix">6.0</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="msixfive">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="msixfive">6.5</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="mseven">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="mseven">7.0</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="msevenfive">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="msevenfive">7.5</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="meight">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="meight">8.0</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="meightfive">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="meightfive">8.5</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="mnine">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="mnine">9.0</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="mninefive">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="mninefive">9.5</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="mten">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="mten">10</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Job Value Score</h5></div>

                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="vsix">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="vsix">6.0</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="vsixfive">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="vsixfive">6.5</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="vseven">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="vseven">7.0</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="vsevenfive">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="vsevenfive">7.5</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="veight">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="veight">8.0</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="veightfive">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="veightfive">8.5</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="vnine">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="vnine">9.0</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="vninefive">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="vninefive">9.5</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="vten">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="vten">10</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Place Of Work</h5></div>

                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="anywhere" checked>
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="anywhere">Anywhere</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="onsite">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="onsite">On Site</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="remote">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="remote">Fully Remote</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Type Of Contract</h5></div>

                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="employee1">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="employee1">Employee</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="frelancers1">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="frelancers1">Freelancer</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="contractor1">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="contractor1">Contractor</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="internship1">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="internship1">Internship</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Type Of Employment</h5></div>

                                        <div class="single-tabs-group-content">
                                            <div class="d-flex flex-wrap">
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="fulltime">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="fulltime">Full Time</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="parttime">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="parttime">Part Time</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="freelance2" checked>
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="freelance2">Freelance</label>
                                                </div>
                                                <div class="sing-btn-groups">
                                                    <input type="checkbox" class="btn-check" id="internship2">
                                                    <label class="btn btn-md btn-outline-primary font--bold rounded-5" for="internship2">Internship</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Radius In Miles</h5></div>

                                        <div class="single-tabs-group-content">
                                            <div class="rg-slider">
                                                <input type="text" class="js-range-slider" name="my_range" value="">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Explore Top Categories</h5></div>

                                        <div class="single-tabs-group-content">
                                            <ul class="row p-0 m-0">
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-1" class="form-check-input" name="s-1" type="checkbox">
                                                        <label for="s-1" class="form-check-label">IT Computers</label>
                                                    </div>
                                                </li>
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-2" class="form-check-input" name="s-2" type="checkbox">
                                                        <label for="s-2" class="form-check-label">Web Design</label>
                                                    </div>
                                                </li>
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-3" class="form-check-input" name="s-3" type="checkbox">
                                                        <label for="s-3" class="form-check-label">Web development</label>
                                                    </div>
                                                </li>
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-4" class="form-check-input" name="s-4" type="checkbox">
                                                        <label for="s-4" class="form-check-label">SEO Services</label>
                                                    </div>
                                                </li>
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-5" class="form-check-input" name="s-5" type="checkbox">
                                                        <label for="s-5" class="form-check-label">Financial Service</label>
                                                    </div>
                                                </li>
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-6" class="form-check-input" name="s-6" type="checkbox">
                                                        <label for="s-6" class="form-check-label">Art, Design, Media</label>
                                                    </div>
                                                </li>
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-7" class="form-check-input" name="s-7" type="checkbox">
                                                        <label for="s-7" class="form-check-label">Coach & Education</label>
                                                    </div>
                                                </li>
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-8" class="form-check-input" name="s-8" type="checkbox">
                                                        <label for="s-8" class="form-check-label">Apps Developements</label>
                                                    </div>
                                                </li>
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-9" class="form-check-input" name="s-9" type="checkbox">
                                                        <label for="s-9" class="form-check-label">IOS Development</label>
                                                    </div>
                                                </li>
                                                <li class="col-lg-6 col-md-6 p-0">
                                                    <div class="form-check form-check-inline">
                                                        <input id="s-10" class="form-check-input" name="s-10" type="checkbox">
                                                        <label for="s-10" class="form-check-label">Android Development</label>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="single-tabs-group">
                                        <div class="single-tabs-group-header"><h5>Keywords</h5></div>

                                        <div class="single-tabs-group-content">
                                            <div class="form-group">
                                                <input type="text" class="form-control" placeholder="Design, Java, Python, WordPress etc...">
                                            </div>
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

            <script src="${pageContext.request.contextPath}/assets/js/custom.js"></script><script src="${pageContext.request.contextPath}/assets/js/cl-switch.js"></script>
            <!-- =========================================================================== -->
            <!-- This page plugins -->
            <!-- =========================================================================== -->


    </body>

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/full-job-grid-1.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:58:57 GMT -->
</html>
