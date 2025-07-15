<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="en">

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:57:49 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Companies- Responsive Job Portal Bootstrap Template | ThemezHub</title>
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
            <div class="header header-light head-shadow">
                <div class="container">
                    <nav id="navigation" class="navigation navigation-landscape">
                        <div class="nav-header">
                            <a class="nav-brand static-logo" href="#"><img src="assets/img/logo-light.png" class="logo" alt=""></a>

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
                                <li ><a href="index.jsp;">Home<span class="submenu-indicator"></span></a></li>
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
                                                <img src="${pageContext.request.contextPath}/assets/img/logo-account.png" class="nav-logo" alt="aa">
                                            </a>
                                            <ul class="dropdown-menu" aria-labelledby="accountLogoDropdown">
                                                <li><a class="dropdown-item" href="dashboardcandidate.jsp">Dashboard</a></li>
                                                <li><a class="dropdown-item" href= "LogoutServlet">Logout</a></li>
                                            </ul>
                                        </li>
                                    </c:when>
                                    <c:otherwise>

                                        <li><a data-bs-toggle="modal" data-bs-target="#login"><i class="fas fa-sign-in-alt me-2"></i>Sign In</a></li>
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
            <!-- ============================================================== -->
            <!-- Top header  -->
            <!-- ============================================================== -->


            <!-- ============================ Page Title Start================================== -->
            <div class="page-title primary-bg-dark" style="background:url(assets/img/bg2.png) no-repeat;">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">

                            <h2 class="ipt-title">Find your Companies</h2>
                            <div class="breadcrumbs light">
                                <nav aria-label="breadcrumb">

                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================ Page Title End ================================== -->

            <!-- ============================ All List Wrap ================================== -->
            <section>
                <div class="container">
                    <div class="row">

                        <!-- Search Sidebar -->
                        <div class="col-lg-4 col-md-12 col-sm-12">
                            <div class="side-widget-blocks">							

                                <div class="sidebar_header d-flex align-items-center justify-content-between px-4 py-3 br-bottom">

                                    <h4 class="fs-bold fs-5 mb-0">Search Companies</h4>
                                    <div class="ssh-header">                                       
                                        <a href="#search_open" data-bs-toggle="collapse" aria-expanded="false" role="button" class="collapsed _filter-ico ml-2"><i class="fa-solid fa-filter"></i></a>
                                    </div>

                                </div>

                                <!-- Find New Property -->
                                <div class="sidebar-widgets collapse miz_show" id="search_open" data-bs-parent="#search_open">
                                    <div class="search-inner">
                                        <div class="side-widget-inner">

                                            <div class="form-group">

                                                <label>Search By Keyword</label>
                                                <form method="get" action="SearchCompaniesServlet" class="d-flex mb-4">
                                                    <div class="form-group-inner">
                                                        <input type="text" name="keyword" placeholder="Search Companies..." 
                                                               value="${param.keyword}" class="form-control me-2">
                                                        <div class="form-group mb-1">
                                                            <button type="submit" class="btn btn-lg btn-primary fs-6 fw-medium full-width">Search</button>
                                                        </div>

                                                    </div>
                                                </form>
                                            </div>

                                        </div>

                                    </div>							
                                </div>
                            </div>							
                        </div>
                        <!-- Sidebar End -->

                        <!-- Job List Wrap -->
                        <div class="col-lg-8 col-md-12 col-sm-12">

                            <!-- Shorting Box -->
                            <div class="row justify-content-center mb-4">
                                <div class="col-lg-12 col-md-12">
                                    <div class="item-shorting-box">                                       
                                        <div class="item-shorting-box-right">                                           
                                            <div class="shorting-by small">
                                                <select name="companiesPerPage" 
                                                        onchange="location.href = 'SearchCompaniesServlet?keyword=${param.keyword}&companiesPerPage=' + this.value">
                                                    <option value="9" ${companiesPerPage == 9 ? 'selected' : ''}>9 Per Page</option>
                                                    <option value="18" ${companiesPerPage == 18 ? 'selected' : ''}>18 Per Page</option>
                                                    <option value="36" ${companiesPerPage == 36 ? 'selected' : ''}>36 Per Page</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Shorting Wrap End -->

                            <!-- Start All List -->
                            <div class="row justify-content-start gx-3 gy-4">


                                <c:choose>
                                    <c:when test="${not empty companies}">
                                        <c:forEach var="company" items="${companies}">
                                            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12">
                                                <div class="emp-grid-blocs border">
                                                    <div class="emp-grid-thumbs">
                                                        <a href="CompanyDetailServlet?id=${company.id}">
                                                            <figure><img src="assets/img/l-5.png" class="img-fluid" alt=""></figure>
                                                        </a>
                                                    </div>
                                                    <div class="emp-grid-captions">
                                                        <div class="emplors-job-types-wrap">
                                                            <span class="text-sm-muted">${company.description}</span>
                                                        </div>
                                                        <div class="emplors-job-title-wrap mb-1">
                                                            <h4><a href="CompanyDetailServlet?id=${company.id}" class="emplors-job-title">${company.companyName}</a></h4>
                                                        </div>
                                                        <div class="emplors-job-mrch-lists">
                                                            <div class="single-mrch-lists">
                                                                <span><i class="fa-solid fa-location-dot me-1"></i>${company.address}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="emp-grid-footrs">
                                                        <div class="emp-flexio">
                                                            <span class="label px-4 py-2 text-primary bg-light-primary">Open positions</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p>No companies found.</p>
                                    </c:otherwise>
                                </c:choose>


                            </div>	
                        </div>

                    </div>
                    <!-- End All Job List -->

                    <!-- Pagination -->
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="SearchCompaniesServlet?page=${currentPage - 1}&companiesPerPage=${companiesPerPage}">
                                                &laquo;
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link"
                                               href="SearchCompaniesServlet?page=${i}&companiesPerPage=${companiesPerPage}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="SearchCompaniesServlet?page=${currentPage + 1}&companiesPerPage=${companiesPerPage}">
                                                &raquo;
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>

                </div>
                <!-- Job List Wrap End-->

        </div>
    </div>		
</section>
<!-- ============================ All List Wrap ================================== -->


<!-- ============================ Footer End ================================== -->

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

<!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/employer-grid-1.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:19 GMT -->
</html>