<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>TechSign - Responsive Job Portal Bootstrap Template | ThemezHub</title>
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.png">

        <!-- Custom CSS -->
        <link href="assets/css/styles.css" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css">
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
                            <c:choose>

                                <c:when test="${sessionScope.user == null}">

                                    <ul class="nav-menu">							
                                        <li class="active"><a href="JavaScript:Void(0);">Home<span class="submenu-indicator"></span></a></li>

                                        <li><a href="JavaScript:Void(0);">Jobs<span class="submenu-indicator"></span></a>
                                            <ul class="nav-dropdown nav-submenu">
                                                <li><a href="SearchandView">Job List</a></li>
                                            </ul>
                                        </li>

                                        <li><a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
                                            <ul class="nav-dropdown nav-submenu">
                                                <li><a href="JavaScript:Void(0);">Company list</a></li>
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
                                            <a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login">
                                                <i class="fas fa-sign-in-alt me-2"></i>Sign In
                                            </a>
                                        </li>
                                        <li class="list-buttons ms-2">
                                            <a href="signup.html"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Upload Resume</a>
                                        </li>
                                    </ul>

                                </c:when>


                                <c:otherwise>
                                    <ul class="nav-menu">
                                        <li><a href="JavaScript:Void(0);">Home<span class="submenu-indicator"></span></a></li>

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

                                        <li><a href="JavaScript:Void(0);">Profile CV<span class="submenu-indicator"></span></a>
                                            <ul class="nav-dropdown nav-submenu">
                                                <li><a href="#">Create CV</a></li>
                                                <li><a href="#">Manage CV</a></li>
                                            </ul>
                                        </li>

                                        <li><a href="JavaScript:Void(0);">Pages<span class="submenu-indicator"></span></a>
                                            <ul class="nav-dropdown nav-submenu">
                                                <li><a href="about-us.html">About Us</a></li>
                                                <li><a href="faq.html">FAQ's</a></li>
                                                <li><a href="contact.html">Contacts</a></li>
                                                <li><a href="evaluateSystem.jsp">Evaluate System</a></li>
                                            </ul>
                                        </li>

                                        <li><a href="#">Help</a></li>
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
                                            <a class="nav-link dropdown-toggle" href="#" id="accountLogoDropdown"
                                               role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <img src="$assets/img/logo-account.png"
                                                     class="nav-logo" alt="aa">
                                            </a>
                                            <ul class="dropdown-menu" aria-labelledby="accountLogoDropdown">
                                                <li><a class="dropdown-item" href="dashboardcandidate.jsp">Dashboard</a></li>
                                                <li><a class="dropdown-item" href="LogoutServlet">Logout</a></li>
                                            </ul>
                                        </li>
                                    </ul>
                                </c:otherwise>
                            </c:choose>   
                        </div> 
                    </nav>
                </div>
            </div>

            <!-- End Navigation -->
            <div class="clearfix"></div>
            <div class="container py-5">
                <div class="row">
                    <!-- FORM BÊN TRÁI -->
                    <div class="col-md-6">
                        <h3 class="mb-4">Tạo CV Mới</h3>
                        <form action="CreateNewCVServlet" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label>Tiêu đề hồ sơ</label>
                                <input type="text" name="jobtitle" id="jobtitle" class="form-control" oninput="updatePreview()" required>
                            </div>
                            <div class="mb-3">
                                <label>Họ và tên</label>
                                <input type="text" name="fullname" id="fullname" class="form-control" oninput="updatePreview()" required>
                            </div>
                            <div class="mb-3">
                                <label>Email</label>
                                <input type="email" name="email" id="email" class="form-control" oninput="updatePreview()" required>
                            </div>
                            <div class="mb-3">
                                <label>Số điện thoại</label>
                                <input type="text" name="phone" id="phone" class="form-control" oninput="updatePreview()" required>
                            </div>
                            <div class="mb-3">
                                <label>Ngày sinh</label>
                                <input type="date" name="dob" id="dob" class="form-control" oninput="updatePreview()">
                            </div>
                            <div class="mb-3">
                                <label>Địa chỉ</label>
                                <input type="text" name="address" id="address" class="form-control" oninput="updatePreview()">
                            </div>
                            <div class="mb-3">
                                <label>Ảnh đại diện</label>
                                <input type="file" name="avatar" id="avatar" class="form-control" accept="image/*" onchange="previewAvatar()">
                            </div>
                            <div class="mb-3">
                                <label>Mục tiêu nghề nghiệp</label>
                                <textarea name="objective" id="objective" class="form-control" oninput="updatePreview()"></textarea>
                            </div>
                            <div class="mb-3">
                                <label>Kỹ năng (Mỗi kỹ năng 1 dòng)</label>
                                <textarea name="skills" id="skills" class="form-control" oninput="updatePreview()"></textarea>
                            </div>
                            <h5 class="mt-4">Work Experience</h5>
                            <div id="experience-list">
                                <div class="exp-block mb-3">
                                    <input type="text" name="company" placeholder="Company name" class="form-control exp-company mb-2" oninput="updatePreview()">
                                    <input type="text" name="position" placeholder="Position" class="form-control exp-position mb-2" oninput="updatePreview()">
                                    <input type="text" name="period" placeholder="Time (e.g., March 2019 - September 2020)" class="form-control exp-period mb-2" oninput="updatePreview()">
                                    <textarea name="detail" placeholder="One line per idea" class="form-control exp-detail" oninput="updatePreview()"></textarea>
                                </div>
                            </div>

                            <button type="button" class="btn btn-success mb-3" onclick="addExperience()">+ Add Experience</button>
                            <button type="submit" class="btn btn-primary">Lưu CV</button>
                            <button type="button" class="btn btn-secondary" onclick="history.back()">Quay lại</button>
                        </form>
                    </div>

                    <!-- PREVIEW BÊN PHẢI -->
                    <div class="col-md-6">
                        <h3 class="mb-4">Xem trước CV</h3>
                        <div class="cv-card">
                            <!-- Trái -->
                            <div class="cv-left">
                                <div class="text-center mb-3">
                                    <img id="preview-avatar" src="https://via.placeholder.com/120" alt="Avatar">
                                    <h2 id="preview-fullname" class="fw-bold mb-1">Họ Tên</h2>
                                    <h5 id="preview-jobtitle" class="text-uppercase mb-4">Tiêu đề hồ sơ</h5>
                                </div>
                                <h6 class="fw-bold mb-2">Liên lạc</h6>
                                <p><i class="fa-solid fa-envelope me-2"></i><span id="preview-email"></span></p>
                                <p><i class="fa-solid fa-phone me-2"></i><span id="preview-phone"></span></p>
                                <p><i class="fa-solid fa-calendar me-2"></i><span id="preview-dob"></span></p>
                                <p><i class="fa-solid fa-location-dot me-2"></i><span id="preview-address"></span></p>

                                <h6 class="fw-bold mb-2 mt-4">Kỹ năng</h6>
                                <ul class="cv-skill-list" id="preview-skills"></ul>
                            </div>

                            <!-- Phải -->
                            <div class="cv-right">
                                <h4 class="fw-bold mb-3">Mục tiêu nghề nghiệp</h4>
                                <p id="preview-objective"></p>

                                <h4 class="fw-bold mb-3 mt-4">Kinh nghiệm làm việc</h4>
                                <ul class="cv-exp-list" id="preview-experience"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/rangeslider.js"></script>
        <script src="assets/js/jquery.nice-select.min.js"></script>
        <script src="assets/js/slick.js"></script>
        <script src="assets/js/counterup.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/reviewbeforeupload.js"></script>
        <script src="assets/js/custom.js"></script>
        <script src="assets/js/cl-switch.js"></script>
        <script src="assets/js/createcvsystem.js"></script>
    </body>
</html>
