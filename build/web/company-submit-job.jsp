<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Post a Job - Tech Sign</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
<link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
</head>

<body class="green-theme">
<div id="preloader"><div class="preloader"><span></span><span></span></div></div>

<div id="main-wrapper">
    <!-- Top header -->
    <div class="header header-light head-fixed">
        <div class="container">
            <nav id="navigation" class="navigation navigation-landscape">
                <div class="nav-header">
                    <a class="nav-brand" href="#">
                        <img src="${pageContext.request.contextPath}/assets/img/logo.png" class="logo" alt="">
                    </a>
                    <div class="nav-toggle"></div>
                    <div class="mobile_nav">
                        <ul>
                            <li class="list-buttons">
                                <a href="LogoutServlet"><i class="fas fa-sign-out-alt me-2"></i>Log Out</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="nav-menus-wrapper">
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
                                    <img src="${pageContext.request.contextPath}/assets/img/user-5.png" class="img-fluid circle" alt="">
                                </button>
                                <div class="dropdown-menu pull-right animated flipInX">
                                    <div class="drp_menu_headr bg-primary">
                                        <h4>Hello, <c:out value="${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'User'}" /></h4>
                                        <div class="drp_menu_headr-right">
                                            <a href="LogoutServlet" class="btn btn-whites">Log out</a>
                                        </div>
                                    </div>
                                    <ul>
                                        <li><a href="companyHome.jsp"><i class="fa fa-tachometer-alt"></i>Dashboard</a></li>                                  
                                        <li><a href="companyProfile.jsp"><i class="fa fa-user-tie"></i>Company Profile</a></li>                                 
                                        <li><a href="MyJobsServlet"><i class="fa fa-file"></i>My Jobs</a></li>
                                        <li><a href="PostJobServlet"><i class="fa fa-plus"></i>Post Job</a></li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>
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
                            <a href="#">
                                <figure><img src="${pageContext.request.contextPath}/assets/img/l-12.png" class="img-fluid circle" alt=""></figure>
                            </a>
                        </div>
                    </div>
                    <div class="jbs-grid-usrs-caption mb-3">
                        <div class="jbs-kioyer">
                            <span class="label text-light theme-bg">Tech Company</span>
                        </div>
                        <div class="jbs-tiosk">
                            <h4 class="jbs-tiosk-title"><a href="#">${sessionScope.user.fullName}</a></h4>
                            <div class="jbs-tiosk-subtitle"><span><i class="fa-solid fa-location-dot me-2"></i>Vietnam</span></div>
                        </div>
                    </div>
                </div>
                <div class="dashboard-inner">
                    <ul data-submenu-title="Main Navigation">
                        <li><a href="companyHome.jsp"><i class="fa-solid fa-gauge-high me-2"></i>User Dashboard</a></li>
                        <li><a href="companyProfile.jsp"><i class="fa-regular fa-user me-2"></i>User Profile</a></li>
                        <li><a href="MyJobsServlet"><i class="fa-solid fa-briefcase me-2"></i>My Jobs</a></li>
                        <li class="active"><a href="PostJobServlet"><i class="fa-solid fa-pen-ruler me-2"></i>Submit Jobs</a></li>
                        <li><a href="#"><i class="fa-solid fa-user-group me-2"></i>Applicants Jobs</a></li>
                        <li><a href="CandidateViewListServlet"><i class="fa-solid fa-chart-line me-2"></i>Candidate Analytics</a></li>
                        <li><a href="#"><i class="fa-solid fa-user-clock me-2"></i>Shortlisted Candidates</a></li>
                        <li><a href="#"><i class="fa-solid fa-wallet me-2"></i>Package</a></li>
                        <li><a href="#"><i class="fa-solid fa-comments me-2"></i>Messages</a></li>
                        <li><a href="#"><i class="fa-solid fa-unlock-keyhole me-2"></i>Change Password</a></li>
                        <li><a href="#"><i class="fa-solid fa-trash-can me-2"></i>Delete Account</a></li>
                        <li><a href="LogoutServlet"><i class="fa-solid fa-power-off me-2"></i>Log Out</a></li>
                    </ul>
                </div>					
            </div>
        </div>
        
        <div class="dashboard-content">
            <div class="dashboard-tlbar d-block mb-4">
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12">
                        <h1 class="mb-1 fs-3 fw-medium">Post a Job</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="companyHome.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item active">Post Job</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>

            <!-- Display Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Job Form -->
            <div class="card">
                <div class="card-header">
                    <h4><i class="fas fa-plus-circle me-2"></i>Job Information</h4>
                </div>
                <div class="card-body">
                    <form action="PostJobServlet" method="post">
                        <div class="row">
                            <!-- Basic Information Section -->
                            <div class="col-12 mb-4">
                                <h5 class="text-primary border-bottom pb-2">
                                    <i class="fas fa-info-circle me-2"></i>Basic Information
                                </h5>
                            </div>

                            <div class="col-xl-12 col-lg-12 col-md-12">
                                <div class="form-group">
                                    <label>Job Title <span class="text-danger">*</span></label>
                                    <input type="text" name="title" class="form-control" 
                                           placeholder="e.g. Senior Java Developer" required>
                                </div>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <label>Job Category</label>
                                    <select name="category" class="form-control">
                                        <option value="">Select Category</option>
                                        <option value="Software & Application">Software & Application</option>
                                        <option value="Banking Services">Banking Services</option>
                                        <option value="UI/UX Design">UI/UX Design</option>
                                        <option value="IOS/App Application">IOS/App Application</option>
                                        <option value="Education">Education</option>
                                        <option value="Marketing">Marketing</option>
                                        <option value="Sales">Sales</option>
                                        <option value="Finance">Finance</option>
                                        <option value="Human Resources">Human Resources</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <label>Job Type</label>
                                    <select name="jobType" class="form-control">
                                        <option value="">Select Type</option>
                                        <option value="Full Time">Full Time</option>
                                        <option value="Part Time">Part Time</option>
                                        <option value="Contract">Contract</option>
                                        <option value="Internship">Internship</option>
                                        <option value="Freelance">Freelance</option>
                                        <option value="Remote">Remote</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-xl-12 col-lg-12 col-md-12">
                                <div class="form-group">
                                    <label>Job Description <span class="text-danger">*</span></label>
                                    <textarea name="description" class="form-control" rows="6" required
                                              placeholder="Describe the job responsibilities, duties, and what the role involves..."></textarea>
                                </div>
                            </div>

                            <div class="col-xl-12 col-lg-12 col-md-12">
                                <div class="form-group">
                                    <label>Requirements</label>
                                    <textarea name="requirements" class="form-control" rows="5"
                                              placeholder="List the required skills, qualifications, and experience..."></textarea>
                                </div>
                            </div>

                            <div class="col-xl-12 col-lg-12 col-md-12">
                                <div class="form-group">
                                    <label>Benefits</label>
                                    <textarea name="benefits" class="form-control" rows="4"
                                              placeholder="List the benefits and perks offered..."></textarea>
                                </div>
                            </div>

                            <!-- Job Details Section -->
                            <div class="col-12 mb-4 mt-4">
                                <h5 class="text-primary border-bottom pb-2">
                                    <i class="fas fa-cogs me-2"></i>Job Details
                                </h5>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <label>Job Level</label>
                                    <select name="jobLevel" class="form-control">
                                        <option value="">Select Level</option>
                                        <option value="Intern">Intern</option>
                                        <option value="Junior">Junior Level</option>
                                        <option value="Mid">Mid Level</option>
                                        <option value="Senior">Senior Level</option>
                                        <option value="Lead">Team Lead</option>
                                        <option value="Manager">Manager</option>
                                        <option value="Director">Director</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <label>Experience Required (Years)</label>
                                    <input type="number" name="experience" class="form-control" 
                                           min="0" max="20" placeholder="e.g. 3">
                                </div>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <label>Minimum Salary ($)</label>
                                    <input type="number" name="salaryMin" class="form-control" 
                                           min="0" step="100" placeholder="e.g. 1500">
                                </div>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <label>Maximum Salary ($)</label>
                                    <input type="number" name="salaryMax" class="form-control" 
                                           min="0" step="100" placeholder="e.g. 2500">
                                </div>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <label>Location</label>
                                    <input type="text" name="location" class="form-control" 
                                           placeholder="e.g. Ho Chi Minh City, Vietnam">
                                </div>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <label>Application Deadline</label>
                                    <input type="date" name="applicationDeadline" class="form-control">
                                </div>
                            </div>

                            <!-- Additional Options Section -->
                            <div class="col-12 mb-4 mt-4">
                                <h5 class="text-primary border-bottom pb-2">
                                    <i class="fas fa-star me-2"></i>Additional Options
                                </h5>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="isFeatured" id="featured">
                                        <label class="form-check-label" for="featured">
                                            <i class="fas fa-star text-warning me-1"></i>Featured Job
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <div class="form-group">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="isUrgent" id="urgent">
                                        <label class="form-check-label" for="urgent">
                                            <i class="fas fa-exclamation-triangle text-danger me-1"></i>Urgent Hiring
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-12 col-lg-12 col-md-12">
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane me-2"></i>Post Job
                                    </button>
                                    <a href="MyJobsServlet" class="btn btn-secondary ms-2">
                                        <i class="fas fa-times me-2"></i>Cancel
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- footer -->
            <div class="row">
                <div class="col-md-12">
                    <div class="py-3 text-center">© 2015 - 2023 Job Stock® Themezhub.</div>
                </div>
            </div>
        </div>
    </div>

    <a id="back2Top" class="top-scroll" title="Back to top" href="#"><i class="ti-arrow-up"></i></a>
</div>

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/custom.js"></script>

<script>
    // Set minimum date to today
    document.addEventListener('DOMContentLoaded', function() {
        var deadlineInput = document.querySelector('input[name="applicationDeadline"]');
        if (deadlineInput) {
            var today = new Date().toISOString().split('T')[0];
            deadlineInput.min = today;
        }
        
        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var closeBtn = alert.querySelector('.btn-close');
                if (closeBtn) {
                    closeBtn.click();
                }
            });
        }, 5000);
    });
</script>
</body>
</html>
