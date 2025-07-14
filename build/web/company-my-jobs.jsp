<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My Jobs - Tech Sign</title>
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
                        <li class="active"><a href="MyJobsServlet"><i class="fa-solid fa-briefcase me-2"></i>My Jobs</a></li>
                        <li><a href="PostJobServlet"><i class="fa-solid fa-pen-ruler me-2"></i>Submit Jobs</a></li>
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
                        <h1 class="mb-1 fs-3 fw-medium">My Jobs</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="companyHome.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item active">My Jobs</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>

            <!-- Display Messages -->
            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <c:choose>
                        <c:when test="${param.success == 'job_posted'}">Job posted successfully!</c:when>
                        <c:when test="${param.success == 'activate'}">Job activated successfully!</c:when>
                        <c:when test="${param.success == 'deactivate'}">Job deactivated successfully!</c:when>
                        <c:when test="${param.success == 'delete'}">Job deleted successfully!</c:when>
                        <c:otherwise>Operation completed successfully!</c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    An error occurred. Please try again!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Jobs Statistics -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card bg-primary text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h4 class="mb-0">${totalJobs}</h4>
                                    <small>Total Jobs</small>
                                </div>
                                <i class="fas fa-briefcase fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-success text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h4 class="mb-0">${activeJobs}</h4>
                                    <small>Active Jobs</small>
                                </div>
                                <i class="fas fa-play-circle fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-info text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h4 class="mb-0">${totalViews}</h4>
                                    <small>Total Views</small>
                                </div>
                                <i class="fas fa-eye fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-warning text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h4 class="mb-0">${totalApplications}</h4>
                                    <small>Applications</small>
                                </div>
                                <i class="fas fa-users fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Jobs List -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4><i class="fas fa-list me-2"></i>Posted Jobs</h4>
                    <a href="PostJobServlet" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Post New Job
                    </a>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty jobs}">
                            <div class="text-center py-5">
                                <i class="fas fa-briefcase fa-3x text-muted mb-3"></i>
                                <h5>No jobs posted yet</h5>
                                <p class="text-muted">Start by posting your first job to attract candidates.</p>
                                <a href="PostJobServlet" class="btn btn-primary">Post Your First Job</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Job Title</th>
                                            <th>Category</th>
                                            <th>Type</th>
                                            <th>Status</th>
                                            <th>Applications</th>
                                            <th>Views</th>
                                            <th>Posted Date</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="job" items="${jobs}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div>
                                                            <h6 class="mb-0">${job.title}</h6>
                                                            <small class="text-muted">${job.location}</small>
                                                            <c:if test="${job.featured}">
                                                                <span class="badge bg-warning ms-1">Featured</span>
                                                            </c:if>
                                                            <c:if test="${job.urgent}">
                                                                <span class="badge bg-danger ms-1">Urgent</span>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${job.category}</td>
                                                <td>
                                                    <span class="badge bg-info">${job.jobType}</span>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${job.status == 'active'}">
                                                            <span class="badge bg-success">Active</span>
                                                        </c:when>
                                                        <c:when test="${job.status == 'inactive'}">
                                                            <span class="badge bg-secondary">Inactive</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning">${job.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <span class="badge bg-primary">${job.applicationsCount}</span>
                                                </td>
                                                <td>${job.viewsCount}</td>
                                                <td>
                                                    <fmt:formatDate value="${job.createdAt}" pattern="MMM dd, yyyy" />
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <button type="button" class="btn btn-sm btn-outline-primary dropdown-toggle" 
                                                                data-bs-toggle="dropdown">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <li><a class="dropdown-item" href="job-detail.jsp?id=${job.id}">
                                                                <i class="fas fa-eye me-2"></i>View
                                                            </a></li>
                                                            <li><a class="dropdown-item" href="edit-job.jsp?id=${job.id}">
                                                                <i class="fas fa-edit me-2"></i>Edit
                                                            </a></li>
                                                            <li><hr class="dropdown-divider"></li>
                                                            <c:choose>
                                                                <c:when test="${job.status == 'active'}">
                                                                    <li>
                                                                        <form action="MyJobsServlet" method="post" class="d-inline">
                                                                            <input type="hidden" name="action" value="deactivate">
                                                                            <input type="hidden" name="jobId" value="${job.id}">
                                                                            <button type="submit" class="dropdown-item text-warning">
                                                                                <i class="fas fa-pause me-2"></i>Deactivate
                                                                            </button>
                                                                        </form>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li>
                                                                        <form action="MyJobsServlet" method="post" class="d-inline">
                                                                            <input type="hidden" name="action" value="activate">
                                                                            <input type="hidden" name="jobId" value="${job.id}">
                                                                            <button type="submit" class="dropdown-item text-success">
                                                                                <i class="fas fa-play me-2"></i>Activate
                                                                            </button>
                                                                        </form>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <li><hr class="dropdown-divider"></li>
                                                            <li>
                                                                <form action="MyJobsServlet" method="post" class="d-inline" 
                                                                      onsubmit="return confirm('Are you sure you want to delete this job? This action cannot be undone.')">
                                                                    <input type="hidden" name="action" value="delete">
                                                                    <input type="hidden" name="jobId" value="${job.id}">
                                                                    <button type="submit" class="dropdown-item text-danger">
                                                                        <i class="fas fa-trash me-2"></i>Delete
                                                                    </button>
                                                                </form>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
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
</script>
</body>
</html>
