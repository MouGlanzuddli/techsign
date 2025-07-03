<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Stock - Post Job</title>
    <link rel="icon" type="image/x-icon" href="assets/img/favicon.png">
    <link href="assets/css/styles.css" rel="stylesheet">
    <link href="assets/css/colors.css" rel="stylesheet">
    <link href="assets/css/vietnam-map.css" rel="stylesheet">
    <style>
        .nav-menu-item {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            padding: 10px 15px;
            margin: 0 5px;
            transition: all 0.3s ease;
            display: inline-block;
        }
        .nav-menu-item:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }
        .nav-menu-item.active {
            background-color: rgba(255, 255, 255, 0.3);
        }
    </style>
</head>
<body class="green-theme">
    <div id="preloader"><div class="preloader"><span></span><span></span></div></div>
    <div id="main-wrapper">
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
                            <li><a href="JavaScript:Void(0);" class="nav-menu-item active">Home<span class="submenu-indicator"></span></a></li>
                            <li><a href="JavaScript:Void(0);" class="nav-menu-item">Jobs<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a href="grid-style-1.html">Job List</a></li>
                                </ul>
                            </li>
                            <li><a href="JavaScript:Void(0);" class="nav-menu-item">Company<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a href="employer-grid-1.html">Company List</a></li>
                                </ul>
                            </li>
                            <li><a href="JavaScript:Void(0);" class="nav-menu-item">Candidates<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a>Candidate List</a></li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="nav-menu nav-menu-social align-to-right">
                            <li>
                                <a href="company-submit-job.jsp" class="post-job-btn">
                                    Post Job <i class="fas fa-arrow-up"></i>
                                </a>
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
                                    <li><a class="dropdown-item" href="JavaScript:Void(0);">Dashboard</a></li>
                                    <li><a class="dropdown-item" href="LogoutServlet""JavaScript:Void(0);">Logout</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <div class="clearfix"></div>
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
                            <li><a href="companyProfile.jsp"><i class="fa-regular fa-user me-2"></i>User Profile </a></li>
                            <li><a href="company-jobs"><i class="fa-solid fa-business-time me-2"></i>My Jobs</a></li>
                            <li class="active"><a href="employer-submit-job.jsp"><i class="fa-solid fa-pen-ruler me-2"></i>Submit Jobs</a></li>
                            <li><a href="employer-applicants-jobs.jsp"><i class="fa-solid fa-user-group me-2"></i>Applicants Jobs</a></li>
                            <li><a href="employer-shortlist-candidates.jsp"><i class="fa-solid fa-user-clock me-2"></i>Shortlisted Candidates</a></li>
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
                            <h1 class="mb-1 fs-3 fw-medium">Post Jobs</h1>
                            
                        </div>
                    </div>
                </div>
                <div class="dashboard-widg-bar d-block">
                    <div class="card">
                        <div class="card-header">
                            <h4>Basic Detail</h4>
                        </div>
                        <div class="card-body">
                            <form action="submitJob" method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                        <div class="dash-prf-start justify-content-start align-items-start mb-2">
                                            <div class="dash-prf-start-upper mb-2">
                                                <div class="dash-prf-start-thumb">
                                                    <figure class="mb-0"><img src="assets/img/l-5.png" class="img-fluid rounded" alt=""></figure>
                                                </div>
                                            </div>
                                            <div class="dash-prf-start-bottom">
                                                <div class="upload-btn-wrapper small">
                                                    <button class="btn">Hoang Quan</button>
                                                    <input type="file" name="companyLogo">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                        <div class="form-group">
                                            <label>Job Title</label>
                                            <input type="text" class="form-control" name="jobTitle" value="${param.jobTitle}">
                                        </div>
                                    </div>
                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                        <div class="form-group">
                                            <label>Job Description</label>
                                            <textarea class="form-control" name="jobDescription">${param.jobDescription}</textarea>
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Job Category</label>
                                            <div class="select-ops">
                                                <select name="jobCategory">
                                                    <option value="1" ${param.jobCategory == '1' ? 'selected' : ''}>Web & Application</option>
                                                    <option value="2" ${param.jobCategory == '2' ? 'selected' : ''}>Banking Services</option>
                                                    <option value="3" ${param.jobCategory == '3' ? 'selected' : ''}>UI/UX Design</option>
                                                    <option value="4" ${param.jobCategory == '4' ? 'selected' : ''}>IOS/App Application</option>
                                                    <option value="5" ${param.jobCategory == '5' ? 'selected' : ''}>Education</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Job Type</label>
                                            <div class="select-ops">
                                                <select name="jobType">
                                                    <option value="1" ${param.jobType == '1' ? 'selected' : ''}>Full Time</option>
                                                    <option value="2" ${param.jobType == '2' ? 'selected' : ''}>Part Time</option>
                                                    <option value="3" ${param.jobType == '3' ? 'selected' : ''}>Freelance</option>
                                                    <option value="4" ${param.jobType == '4' ? 'selected' : ''}>Internship</option>
                                                    <option value="5" ${param.jobType == '5' ? 'selected' : ''}>Contract</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Job Level</label>
                                            <div class="select-ops">
                                                <select name="jobLevel">
                                                    <option value="1" ${param.jobLevel == '1' ? 'selected' : ''}>Team Leader</option>
                                                    <option value="2" ${param.jobLevel == '2' ? 'selected' : ''}>Manager</option>
                                                    <option value="3" ${param.jobLevel == '3' ? 'selected' : ''}>Junior</option>
                                                    <option value="4" ${param.jobLevel == '4' ? 'selected' : ''}>Senior</option>
                                                    <option value="5" ${param.jobLevel == '5' ? 'selected' : ''}>Other</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Experience</label>
                                            <div class="select-ops">
                                                <select name="experience">
                                                    <option value="1" ${param.experience == '1' ? 'selected' : ''}>Fresher</option>
                                                    <option value="2" ${param.experience == '2' ? 'selected' : ''}>1+ Years</option>
                                                    <option value="3" ${param.experience == '3' ? 'selected' : ''}>2+ Years</option>
                                                    <option value="4" ${param.experience == '4' ? 'selected' : ''}>3+ Years</option>
                                                    <option value="5" ${param.experience == '5' ? 'selected' : ''}>4+ Years</option>
                                                    <option value="6" ${param.experience == '6' ? 'selected' : ''}>5+ Years</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Qualification</label>
                                            <div class="select-ops">
                                                <select name="qualification">
                                                    <option value="1" ${param.qualification == '1' ? 'selected' : ''}>10th Class</option>
                                                    <option value="2" ${param.qualification == '2' ? 'selected' : ''}>12th Class</option>
                                                    <option value="3" ${param.qualification == '3' ? 'selected' : ''}>Bachelor Degree</option>
                                                    <option value="4" ${param.qualification == '4' ? 'selected' : ''}>Master Degree</option>
                                                    <option value="5" ${param.qualification == '5' ? 'selected' : ''}>Post Graduate</option>
                                                    <option value="6" ${param.qualification == '6' ? 'selected' : ''}>Any Other</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Gender</label>
                                            <div class="select-ops">
                                                <select name="gender">
                                                    <option value="1" ${param.gender == '1' ? 'selected' : ''}>Male</option>
                                                    <option value="2" ${param.gender == '2' ? 'selected' : ''}>Female</option>
                                                    <option value="3" ${param.gender == '3' ? 'selected' : ''}>Other</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Min. Salary</label>
                                            <input type="text" class="form-control" name="minSalary" value="${param.minSalary}">
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Max. Salary</label>
                                            <input type="text" class="form-control" name="maxSalary" value="${param.maxSalary}">
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Job Expired Date</label>
                                            <input type="text" class="form-control" name="jobExpiredDate" value="${param.jobExpiredDate}">
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Job Fee Type</label>
                                            <div class="select-ops">
                                                <select name="jobFeeType">
                                                    <option value="1" ${param.jobFeeType == '1' ? 'selected' : ''}>Normal</option>
                                                    <option value="2" ${param.jobFeeType == '2' ? 'selected' : ''}>Premium</option>
                                                    <option value="3" ${param.jobFeeType == '3' ? 'selected' : ''}>Urgent</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                        <div class="form-group">
                                            <label>Skills, Use Commas for separate</label>
                                            <input type="text" class="form-control" name="skills" value="${param.skills}">
                                        </div>
                                    </div>
                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                        <div class="form-group">
                                            <label>Permanent Address</label>
                                            <input type="text" class="form-control" name="permanentAddress" value="${param.permanentAddress}">
                                        </div>
                                    </div>
                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                        <div class="form-group">
                                            <label>Temporary Address</label>
                                            <input type="text" class="form-control" name="temporaryAddress" value="${param.temporaryAddress}">
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Country</label>
                                            <div class="select-ops">
                                                <select name="country">
                                                    <option value="Vietnam" selected>Việt Nam</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>State/City</label>
                                            <div class="select-ops">
                                                <select name="stateCity">
                                                    <option value="Ha Noi">Hà Nội</option>
                                                    <option value="Ho Chi Minh">TP. Hồ Chí Minh</option>
                                                    <option value="Da Nang">Đà Nẵng</option>
                                                    <option value="Hai Phong">Hải Phòng</option>
                                                    <option value="Can Tho">Cần Thơ</option>
                                                    <option value="Hue">Huế</option>
                                                    <option value="Nha Trang">Nha Trang</option>
                                                    <option value="Vung Tau">Vũng Tàu</option>
                                                    <option value="Bien Hoa">Biên Hòa</option>
                                                    <option value="Buon Ma Thuot">Buôn Ma Thuột</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Latitude</label>
                                            <input type="text" class="form-control" name="latitude" value="${param.latitude}">
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Longitude</label>
                                            <input type="text" class="form-control" name="longitude" value="${param.longitude}">
                                        </div>
                                    </div>
                                    <div class="col-xl-12 col-lg-12">
                                        <div class="form-group">
                                            <label>Chọn vị trí trên bản đồ Việt Nam</label>
                                            <div id="map-main" style="width: 100%; height: 450px; border: 2px solid #ddd; border-radius: 8px;"></div>
                                            <small class="text-muted">Click vào bản đồ để chọn vị trí hoặc click vào marker để chọn thành phố</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">
                                        <button type="submit" class="btn ft-medium btn-primary">Post Job</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="py-3 text-center">© 2015 - 2023 Job Stock® Themezhub.</div>
                    </div>
                </div>
            </div>
        </div>
        <a id="back2Top" class="top-scroll" title="Back to top" href="#"><i class="ti-arrow-up"></i></a>
    </div>
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
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/rangeslider.js"></script>
    <script src="assets/js/jquery.nice-select.min.js"></script>
    <script src="assets/js/slick.js"></script>
    <script src="assets/js/counterup.min.js"></script>
    <script src="assets/js/custom.js"></script>
    <script src="assets/js/cl-switch.js"></script>
    <!-- Google Maps API -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCeD9p6ANG7bw6nT0EQHj1Wbyf7fcY_ctw&libraries=places"></script>
    <!-- Vietnam Map Helper Script -->
    <script src="assets/js/map/vietnam-map-helper.js"></script>
    <!-- Vietnam Map Script -->
    <script src="assets/js/map/vietnam-map.js"></script>
</body>
</html>