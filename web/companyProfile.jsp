<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>Job Stock - Employer Profile | ThemezHub</title>
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
                                            <div class="ntf-list-groups-single">
                                                <div class="ntf-list-groups-icon text-purple"><i class="fa-solid fa-house-medical-circle-check"></i></div>
                                                <div class="ntf-list-groups-caption"><p class="small"><strong>Kr. Shaury Preet</strong> Has replied to your message</p></div>
                                            </div>
                                            <div class="ntf-list-groups-single">
                                                <div class="ntf-list-groups-icon text-warning"><i class="fa-solid fa-envelope"></i></div>
                                                <div class="ntf-list-groups-caption"><p class="small">Mortin Denver has accepted your CV <strong class="text-success">On Job Stock</strong></p></div>
                                            </div>
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
                                            <h4>Hello, <c:out value="${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'User'}" /></h4>
                                            <div class="drp_menu_headr-right">
                                                <form action="logout" method="post" style="display: inline;">
                                                    <button type="submit" class="btn btn-whites">Log out</button>
                                                </form>
                                            </div>
                                        </div>
                                        <ul>
                                            <li><a href="companyHome.jsp"><i class="fa fa-tachometer-alt"></i>User Dashboard</a></li>                                  
                                            <li><a href="employer-profile.jsp"><i class="fa fa-user-tie"></i>User Profile</a></li>                                 
                                            <li><a href="employer-jobs.jsp"><i class="fa fa-file"></i>My Jobs</a></li>
                                            <li><a href="employer-messages.jsp"><i class="fa fa-envelope"></i>Messages</a></li>
                                            <li><a href="employer-change-password.jsp"><i class="fa fa-unlock-alt"></i>Change Password</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="nav-menus-wrapper">
                        <ul class="nav-menu">
                            <li class="active"><a href="JavaScript:Void(0);">Home<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a class="active" href="index.jsp">Home 1</a></li>
                                    <li><a href="home-2.jsp">Home 2</a></li>
                                    <li><a href="home-3.jsp">Home 3</a></li>
                                </ul>
                            </li>
                            
                            <li><a href="JavaScript:Void(0);">For Candidates<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a href="grid-style-1.jsp">Find Jobs</a></li>
                                    <li><a href="advance-search.jsp">Advanced Search</a></li>
                                    <li><a href="candidate-dashboard.jsp">Candidate Dashboard</a></li>
                                </ul>
                            </li>
                            
                            <li><a href="JavaScript:Void(0);">For Employers<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a href="companyHome.jsp">Employer Dashboard</a></li>
                                </ul>
                            </li>
                            
                            <li><a href="JavaScript:Void(0);">Pages<span class="submenu-indicator"></span></a>
                                <ul class="nav-dropdown nav-submenu">
                                    <li><a href="about-us.jsp">About Us</a></li> 
                                    <li><a href="contact.jsp">Contact</a></li>
                                </ul>
                            </li>
                            
                            <li><a href="#">Help</a></li>
                        </ul>
                        
                        <ul class="nav-menu nav-menu-social align-to-right dhsbrd">
                            <li class="list-buttons ms-2">
                                <a href="employer-submit-job.jsp"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Post a Job</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <!-- End Navigation -->
        <div class="clearfix"></div>
        
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
                                <a href="employer-detail.jsp">
                                    <figure><img src="assets/img/l-12.png" class="img-fluid circle" alt=""></figure>
                                </a>
                            </div>
                        </div>
                        <div class="jbs-grid-usrs-caption mb-3">
                            <div class="jbs-kioyer">
                                <span class="label text-light theme-bg">05 Job Openings</span>
                            </div>
                            <div class="jbs-tiosk">
                                <h4 class="jbs-tiosk-title"><a href="employer-detail.jsp">ABC Company</a></h4>
                                <div class="jbs-tiosk-subtitle"><span><i class="fa-solid fa-location-dot me-2"></i>Vietnam</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="dashboard-inner">
                        <ul data-submenu-title="Main Navigation">
                            <li><a href="companyHome.jsp"><i class="fa-solid fa-gauge-high me-2"></i>Dashboard</a></li>
                            <li class="active"><a href="employer-profile.jsp"><i class="fa-regular fa-user me-2"></i>User Profile</a></li>
                            <li><a href="employer-jobs.jsp"><i class="fa-solid fa-business-time me-2"></i>My Jobs</a></li>
                            <li><a href="employer-submit-job.jsp"><i class="fa-solid fa-pen-ruler me-2"></i>Post a Job</a></li>
                            <li><a href="employer-applicants-jobs.jsp"><i class="fa-solid fa-user-group me-2"></i>Job Applicants</a></li>
                            <li><a href="employer-shortlist-candidates.jsp"><i class="fa-solid fa-user-clock me-2"></i>Shortlisted Candidates</a></li>
                            <li><a href="employer-package.jsp"><i class="fa-solid fa-wallet me-2"></i>Service Packages</a></li>
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
                            <h1 class="mb-1 fs-3 fw-medium">Update Profile</h1>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item text-muted"><a href="#">Employer</a></li>
                                    <li class="breadcrumb-item text-muted"><a href="#">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="#" class="text-primary">My Profile</a></li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                
                <div class="dashboard-widg-bar d-block">
                
                    <div class="dashboard-profle-wrapper mb-4">
                        <div class="dash-prf-start">
                            <div class="dash-prf-start-upper mb-2">
                                <div class="dash-prf-start-thumb jbs-verified">
                                    <figure class="mb-0"><img src="assets/img/l-5.png" class="img-fluid rounded" alt=""></figure>
                                </div>
                            </div>
                            <div class="dash-prf-start-bottom">
                                <div class="upload-btn-wrapper small">
                                    <button class="btn">Change Profile Picture</button>
                                    <input type="file" name="profileImage" id="profileImage">
                                </div>
                            </div>
                        </div>
                        <div class="dash-prf-end">
                            <div class="dash-prfs-caption emplyer">
                                <div class="dash-prfs-flexfirst">
                                    <div class="dash-prfs-title">
                                        <h4>Adobe Photoshop</h4>	
                                    </div>
                                    <div class="dash-prfs-subtitle">
                                        <div class="jbs-job-mrch-lists">
                                            <div class="single-mrch-lists">
                                                <span>Software & Applications</span>.<span><i class="fa-solid fa-location-dot me-1"></i>Canada, USA</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="jbs-kioyer mt-1">
                                        <div class="jbs-kioyer-groups justify-content-start">
                                            <span class="fa-solid fa-star active"></span>
                                            <span class="fa-solid fa-star active"></span>
                                            <span class="fa-solid fa-star active"></span>
                                            <span class="fa-solid fa-star active"></span>
                                            <span class="fa-solid fa-star"></span>
                                            <span class="aal-reveis">4.8</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="dash-prfs-flexends">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" checked>
                                        <label class="form-check-label" for="flexSwitchCheckChecked">Show Profile</label>
                                    </div>	
                                </div>
                            </div>
                            <div class="dash-prf-caption-end">
                                <div class="dash-prf-infos">
                                    <div class="single-dash-prf-infos">
                                        <div class="single-dash-prf-infos-icons"><i class="fa-solid fa-envelope-open-text"></i></div>
                                        <div class="single-dash-prf-infos-caption">
                                            <p class="text-sm-muted mb-0">Email</p>
                                            <h5>Themezhub@gmail.com</h5>
                                        </div>
                                    </div>
                                    <div class="single-dash-prf-infos">
                                        <div class="single-dash-prf-infos-icons"><i class="fa-solid fa-phone-volume"></i></div>
                                        <div class="single-dash-prf-infos-caption">
                                            <p class="text-sm-muted mb-0">Phone</p>
                                            <h5>+84 256 356 8547</h5>
                                        </div>
                                    </div>
                                    <div class="single-dash-prf-infos">
                                        <div class="single-dash-prf-infos-icons"><i class="fa-solid fa-briefcase"></i></div>
                                        <div class="single-dash-prf-infos-caption">
                                            <p class="text-sm-muted mb-0">Employees</p>
                                            <h5>2000 - 5000</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="dash-prf-completion">
                                    <p class="text-sm-muted">Profile Completion</p>
                                    <div class="progress" role="progressbar" aria-label="Profile Completion" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
                                        <div class="progress-bar bg-success" style="width: 75%">75%</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Display success/error message -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    
                    <!-- Card Row -->
                    <div class="card">
                        <div class="card-header">
                            <h4>Basic Information</h4>
                        </div>
                        <div class="card-body">
                            <form action="updateEmployerProfile" method="post" enctype="multipart/form-data">
                                <div class="row">
                                
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Employer Name</label>
                                            <input type="text" name="companyName" class="form-control" value="" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Email</label>
                                            <input type="email" name="email" class="form-control" value="" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Phone Number</label>
                                            <input type="text" name="phone" class="form-control" value="">
                                        </div>
                                    </div>
                                    
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Website</label>
                                            <input type="url" name="website" class="form-control" value="">
                                        </div>
                                    </div>
                                    
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Founded Year</label>
                                            <input type="number" name="foundedYear" class="form-control" value="" min="1800" max="2024">
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Company Category</label>
                                            <div class="select-ops">
                                                <select name="category" required>
                                                    <option value="">Select Category</option>
                                                    <option value="Web & Application">Web & Applications</option>
                                                    <option value="Banking Services">Banking Services</option>
                                                    <option value="UI/UX Design">UI/UX Design</option>
                                                    <option value="IOS/App Application">IOS/App Applications</option>
                                                    <option value="Education">Education</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Company Size</label>
                                            <input type="text" name="companySize" class="form-control" value="">
                                        </div>
                                    </div>
                                    <div class="col-xl-6 col-lg-6 col-md-12">
                                        <div class="form-group">
                                            <label>Introduction Video</label>
                                            <input type="url" name="videoUrl" class="form-control" value="">
                                        </div>
                                    </div>
                                    
                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                        <div class="form-group">
                                            <label>About Company</label>
                                            <textarea name="aboutCompany" class="form-control ht-80"></textarea>
                                        </div>
                                    </div>
                                    
                                </div> 
                        </div>
                    </div>
                    <!-- Card Row End -->
                    
                    <!-- Row Start -->
                    <div class="card">
                        <div class="card-header">
                            <h4>Awards</h4>
                        </div>
                        <div class="card-body">
                            <!-- Single Award Wrap -->
                            <div class="single-edc-wrap">
                                <div class="single-edc-box">
                                    <div class="single-edc-remove-box">
                                        <div class="cd-resume-cancel">
                                            <a href="javascript:void(0);" class="cancel-link">
                                                <i class="fa-solid fa-xmark"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="single-edc-title-box">
                                        <a class="btn btn-collapse" data-bs-toggle="collapse" href="#award1" role="button" aria-expanded="false" aria-controls="award1">
                                            BCPIL Award
                                        </a>
                                    </div>
                                </div>
                                <div class="single-edc-caption">
                                    <div class="collapse" id="award1">
                                        <div class="card card-body">
                                            <div class="row mb-3">
                                                <label class="col-md-2 col-form-label">Award Name</label>
                                                <div class="col-md-10">
                                                    <input type="text" name="awardTitle_1" class="form-control" value="BCPIL Award">
                                                </div>
                                            </div> 
                                            <div class="row mb-3">
                                                <label class="col-md-2 col-form-label">Award Year</label>
                                                <div class="col-md-10">
                                                    <input type="date" name="awardYear_1" class="form-control" value="2012-12-01">
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <label class="col-md-2 col-form-label">Description</label>
                                                <div class="col-md-10">
                                                    <textarea name="awardDescription_1" class="form-control ht-80">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="single-edc-wrap">
                                <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#award" class="add-light-btn">Add Award</a>
                            </div>
                        </div>
                    </div>	
                    <!-- End Row -->
                    
                    <!-- Card Row -->
                    <div class="card">
                        <div class="card-header">
                            <h4>Contact Information</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                            
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Contact Email</label>
                                        <input type="email" name="contactEmail" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Contact Phone</label>
                                        <input type="text" name="contactPhone" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Temporary Address</label>
                                        <input type="text" name="tempAddress" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Address</label>
                                        <input type="text" name="address" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Address 2</label>
                                        <input type="text" name="address2" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Country</label>
                                        <div class="select-ops">
                                            <select name="country">
                                                <option value="">Select Country</option>
                                                <option value="Vietnam">Vietnam</option>
                                                <option value="United States">United States</option>
                                                <option value="United Kingdom">United Kingdom</option>
                                                <option value="Australia">Australia</option>
                                                <option value="Canada">Canada</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>State/City</label>
                                        <div class="select-ops">
                                            <select name="state">
                                                <option value="">Select State/City</option>
                                                <option value="Ho Chi Minh">Ho Chi Minh</option>
                                                <option value="Ha Noi">Hanoi</option>
                                                <option value="Da Nang">Da Nang</option>
                                                <option value="Can Tho">Can Tho</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Postal Code</label>
                                        <input type="text" name="zipCode" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Latitude</label>
                                        <input type="text" name="latitude" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Longitude</label>
                                        <input type="text" name="longitude" class="form-control" value="">
                                    </div>
                                </div>
                                
                            </div> 
                        </div>
                    </div>
                    <!-- Card Row End -->
                    
                    <!-- Card Row -->
                    <div class="card">
                        <div class="card-header">
                            <h4>Social Media</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                            
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Facebook</label>
                                        <input type="url" name="facebook" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Twitter</label>
                                        <input type="url" name="twitter" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Instagram</label>
                                        <input type="url" name="instagram" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>LinkedIn</label>
                                        <input type="url" name="linkedin" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>YouTube</label>
                                        <input type="url" name="youtube" class="form-control" value="">
                                    </div>
                                </div>
                                
                                <div class="col-xl-6 col-lg-6 col-md-12">
                                    <div class="form-group">
                                        <label>Google Plus</label>
                                        <input type="url" name="googleplus" class="form-control" value="">
                                    </div>
                                </div>
                                
                            </div> 
                        </div>
                    </div>
                    <!-- Card Row End -->
                    
                    <!-- Submit Button -->
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <button type="submit" class="btn ft--medium btn-primary">Save Profile</button>
                        </div>	
                    </div>
                    </form>

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
        
        <!-- Award Modal -->
        <div class="modal fade" id="award" tabindex="-1" role="dialog" aria-labelledby="awardModal" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered award-pop-form" role="document">
                <div class="modal-content" id="awardmodal">
                    <span class="mod-close" data-bs-dismiss="modal" aria-hidden="true"><i class="fas fa-close"></i></span>
                    <div class="modal-body">
                        <div class="text-center">
                            <h4 class="mb-3">Add Award</h4>
                        </div>
                        <div class="added-form">
                            <form action="addAward" method="post">
                                <div class="row mb-3">
                                    <label class="col-md-12 col-form-label">Award Name</label>
                                    <div class="col-md-12">
                                        <input type="text" name="awardTitle" class="form-control" required>
                                    </div>
                                </div> 
                                <div class="row mb-3">
                                    <label class="col-md-12 col-form-label">Award Date</label>
                                    <div class="col-md-12">
                                        <input type="date" name="awardDate" class="form-control" required>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="col-md-12 col-form-label">Description</label>
                                    <div class="col-md-12">
                                        <textarea name="awardDescription" class="form-control ht-80"></textarea>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <button type="submit" class="btn full-width btn-primary">Save Award</button>
                                    </div>
                                </div>
                            </form>
                        </div>
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
    <script src="assets/js/custom.js"></script>
    <script src="assets/js/cl-switch.js"></script>

</body>
</html>