<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>
<%@ page import="model.User" %>
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

    </head>

    <body class="green-theme">

        <!-- =========================================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- =========================================================================== -->
        <div id="preloader"><div class="preloader"><span></span><span></span></div></div>

        <!-- =========================================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <!-- =========================================================================== -->
        <div id="main-wrapper">

            <!-- =========================================================================== -->
            <!-- Top header -->
            <!-- =========================================================================== -->
            <!-- Start Navigation -->
            <div class="header header-light head-shadow">
                <div class="container">
                    <nav id="navigation" class="navigation navigation-landscape">
                        <div class="nav-header">
                            <a class="nav-brand" href="#">
                                <img src="assets/img/logo.png" class="logo" alt="">
                            </a>
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
                                        <li><a href="SearchCompaniesServlet">Company List</a></li>
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
                                                <img src="assets/img/logo-account.png" class="nav-logo" alt="aa">
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
            <!-- End Navigation -->
            <div class="clearfix"></div>
            <!-- =========================================================================== -->
            <!-- Top header -->
            <!-- =========================================================================== -->

            <!-- ========================================== Header Information Start==================== -->
            <section class="primary-bg-dark position-related">
                <div class="position-absolute top-0 start-0 opacity-50">
                    <img src="assets/img/circle.png" alt="SVG" width="150">
                </div>
                <div class="position-absolute bottom-0 start-0 me-10 opacity-50">
                    <img src="assets/img/line.png" alt="SVG" width="100">
                </div>
                <div class="position-absolute top-0 end-0 opacity-50">
                    <img src="assets/img/curve.png" alt="SVG" width="150">
                </div>
                <div class="position-absolute bottom-0 end-0 opacity-50">
                    <img src="assets/img/circle.png" alt="SVG" width="120">
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12">
                            <div class="emplr-head-block">

                                <div class="emplr-head-left">
                                    <div class="emplr-head-thumb">
                                        <figure><img src="assets/img/l-5.png" class="img-fluid rounded" alt=""></figure>
                                    </div>
                                    <div class="emplr-head-caption">
                                        <div class="emplr-head-caption-top">                                            
                                            <div class="emplr-yior-2"><h4 class="emplr-title text-light">${company.companyName}</h4></div>
                                            <div class="emplr-yior-3 justify-content-start">
                                                <span class="text-light opacity-75"><i class="fa-solid fa-building-shield me-1"></i>Software</span>
                                                <span class="text-light opacity-75"><i class="fa-solid fa-location-dot me-1"></i>${company.address}</span>
                                                <span class="text-light opacity-75"><i class="fa-solid fa-location-dot me-1"></i>${company.description}</span>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="emplr-head-right">
                                    <c:choose>
                                        
                                        <c:when test="${sessionScope.user == null}">
                                            <button data-bs-toggle="modal" data-bs-target="#login" class="btn btn-success" type="button">Favourite Now</button>
                                        </c:when>

                                        
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${followed}">
                                                    <button type="button" class="btn btn-secondary" disabled>Favourited</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <form method="post" action="FavouriteCompanyServlet" style="display:inline;">
                                                        <input type="hidden" name="companyId" value="${company.id}" />
                                                        <button type="submit" class="btn btn-success">Favourite Now</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- ========================================== Header Information End ==================== -->

            <!-- ============================ Full Candidate Details Start ==================== -->
            <section>
                <div class="container">
                    <!-- row Start -->
                    <div class="row">

                        <div class="col-xl-8 col-lg-8 col-md-12">
                            <div class="cdtsr-groups-block">

                                <div class="single-cdtsr-block">
                                    <div class="single-cdtsr-header"><h5>About Company</h5></div>
                                    <div class="single-cdtsr-body">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<p>
                                        <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                    </div>
                                </div>

                                <div class="single-cdtsr-block">
                                    <div class="single-cdtsr-header"><h5>Our Award</h5></div>
                                    <div class="single-cdtsr-body">
                                        <div class="row gx-3 gy-4">

                                            <div class="col-xl-3 col-lg-3 col-md-3">
                                                <div class="escort-award-wrap">
                                                    <div class="escort-award-thumb">
                                                        <figure><img src="assets/img/award-1.png" class="img-fluid" alt=""></figure>
                                                    </div>
                                                    <div class="escort-award-caption">
                                                        <h6>FIFFA Award</h6>
                                                        <label>May 2014</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xl-3 col-lg-3 col-md-3">
                                                <div class="escort-award-wrap">
                                                    <div class="escort-award-thumb">
                                                        <figure><img src="assets/img/award-2.png" class="img-fluid" alt=""></figure>
                                                    </div>
                                                    <div class="escort-award-caption">
                                                        <h6>COMPRA Award</h6>
                                                        <label>Dec 2017</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xl-3 col-lg-3 col-md-3">
                                                <div class="escort-award-wrap">
                                                    <div class="escort-award-thumb">
                                                        <figure><img src="assets/img/award-4.png" class="img-fluid" alt=""></figure>
                                                    </div>
                                                    <div class="escort-award-caption">
                                                        <h6>ICCPR Award</h6>
                                                        <label>Apr 2022</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xl-3 col-lg-3 col-md-3">
                                                <div class="escort-award-wrap">
                                                    <div class="escort-award-thumb">
                                                        <figure><img src="assets/img/award-3.png" class="img-fluid" alt=""></figure>
                                                    </div>
                                                    <div class="escort-award-caption">
                                                        <h6>XICAGO Award</h6>
                                                        <label>July 2022</label>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="single-cdtsr-block">
                                    <div class="single-cdtsr-header"><h5>Company Services</h5></div>
                                    <div class="single-cdtsr-body">
                                        <div class="cndts-all-skills-list">
                                            <span>WordPress Developments</span>
                                            <span>Java Developments</span>
                                            <span>HTML To WordPress</span>
                                            <span>PHP Developments</span>
                                            <span>UI/UX Design</span>
                                            <span>Laravel</span>
                                            <span>Magento 2.0</span>
                                        </div>
                                    </div>
                                </div>




                                <!-- Company Review -->


                            </div>
                        </div>

                        <div class="col-xl-4 col-lg-4 col-md-12">

                            <div class="eflorio-wrap-block mb-4">
                                <div class="eflorio-wrap-group">
                                    <div class="eflorio-wrap-body">
                                        <div class="eflorio-list-groups">

                                            <div class="single-eflorio-list">
                                                <div class="eflorio-list-icons"><i class="fa-solid fa-envelope-circle-check text-primary"></i></div>
                                                <div class="eflorio-list-captions">
                                                    <label>Email Address</label>
                                                    <h6>themezhub@gmail.com</h6>
                                                </div>
                                            </div>

                                            <div class="single-eflorio-list">
                                                <div class="eflorio-list-icons"><i class="fa-solid fa-phone-volume text-primary"></i></div>
                                                <div class="eflorio-list-captions">
                                                    <label>Contact No.</label>
                                                    <h6>${company.phone}</h6>
                                                </div>
                                            </div>

                                            <div class="single-eflorio-list">
                                                <div class="eflorio-list-icons"><i class="fa-solid fa-layer-group text-primary"></i></div>
                                                <div class="eflorio-list-captions">
                                                    <label>Category</label>
                                                    <h6>${company.description}</h6>
                                                </div>
                                            </div>



                                            <div class="single-eflorio-list">
                                                <div class="eflorio-list-icons"><i class="fa-solid fa-map-location-dot text-primary"></i></div>
                                                <div class="eflorio-list-captions">
                                                    <label>Location</label>
                                                    <h6>${company.address}</h6>
                                                </div>
                                            </div>



                                        </div>
                                    </div>
                                    <div class="eflorio-wrap-footer">
                                        <div class="eflorio-footer-body">
                                            <button type="button" class="btn btn-primary fw-medium full-width">View Website</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="sidefr-usr-block">
                                <div class="cndts-share-block">
                                    <div class="cndts-share-title">
                                        <h5>Share Profile</h5>
                                    </div>
                                    <div class="cndts-share-list">
                                        <ul>
                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-facebook-f"></i></a></li>
                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-twitter"></i></a></li>
                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-google-plus-g"></i></a></li>
                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-instagram"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                    <!-- /row -->					
                </div>	
            </section>
            <!-- ============================ Full Candidate Details End ==================== -->						

            <!-- ========================================== Call To Action ==================== -->
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
                                    <a href="JavaScript:Void(0);" class="btn btn-lg btn-dark fw-medium px-xl-5 px-lg-4 me-2">Upload resume</a>
                                    <a href="JavaScript:Void(0);" class="btn btn-lg btn-whites fw-medium px-xl-5 px-lg-4 text-primary">Join Our Team</a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </section>
            <!-- ========================================== Call To Action End ==================== -->

            <!-- ========================================== Footer Start ==================== -->
            <footer class="footer skin-light-footer">

                <!-- Footer Top Start -->
                <div class="footer-top">
                    <div class="container">
                        <div class="row align-items-center justify-content-between">





                        </div>
                    </div>
                </div>
                <!-- Footer Top End -->

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
            <!-- ========================================== Footer End ==================== -->

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
                                <form>

                                    <div class="form-floating mb-4">
                                        <input type="email" class="form-control" placeholder="name@example.com">
                                        <label>User Name</label>
                                    </div>

                                    <div class="form-floating mb-4">
                                        <input type="password" class="form-control" placeholder="Password">
                                        <label>Password</label>
                                    </div>

                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary full-width font--bold btn-lg">Log In</button>
                                    </div>

                                    <div class="modal-flex-item mb-3">
                                        <div class="modal-flex-first">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="savepassword" value="option1">
                                                <label class="form-check-label" for="savepassword">Save Password</label>
                                            </div>
                                        </div>
                                        <div class="modal-flex-last">
                                            <a href="JavaScript:Void(0);">Forget Password?</a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="social-login">
                                <ul>
                                    <li><a href="JavaScript:Void(0);" class="btn connect-fb"><i class="fa-brands fa-facebook"></i>Facebook</a></li>
                                    <li><a href="JavaScript:Void(0);" class="btn connect-google"><i class="fa-brands fa-google"></i>Google+</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <p>Don't have an account yet?<a href="signup.html" class="text-primary font--bold ms-1">Sign Up</a></p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Modal -->

            <!-- Filter Modal -->

            <!-- End Modal -->


            <!-- Review Modal -->

            <!-- End Modal -->


            <a id="back2Top" class="top-scroll" title="Back to top" href="#"><i class="ti-arrow-up"></i></a>


        </div>
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
        <script src="assets/js/jquery.min.js"></script>
        <script src=" assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/rangeslider.js"></script>
        <script src="assets/js/jquery.nice-select.min.js"></script>
        <script src="assets/js/slick.js"></script>
        <script src="assets/js/counterup.min.js"></script>


        <script src="assets/js/custom.js"></script><script src="assets/js/cl-switch.js"></script>
        <!-- =========================================================================== -->
        <!-- This page plugins -->
        <!-- =========================================================================== -->

    </body>

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/employer-detail-2.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:21 GMT -->
</html>
