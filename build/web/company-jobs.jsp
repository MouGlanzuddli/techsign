<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Stock - My Jobs</title>
    <link rel="icon" type="image/x-icon" href="assets/img/favicon.png">
    <link href="assets/css/styles.css" rel="stylesheet">
    <link href="assets/css/colors.css" rel="stylesheet">
    <style>
        .job-status-badge {
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 12px;
            font-weight: 500;
        }
        .status-active { background-color: #d4edda; color: #155724; }
        .status-expired { background-color: #f8d7da; color: #721c24; }
        .status-draft { background-color: #fff3cd; color: #856404; }
        .job-actions {
            display: flex;
            gap: 8px;
        }
        .attachment-count {
            font-size: 11px;
            background: #6c757d;
            color: white;
            padding: 2px 6px;
            border-radius: 10px;
            margin-left: 5px;
        }
        .debug-info {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            font-family: monospace;
            font-size: 12px;
        }
    </style>
</head>
<body class="green-theme">
    <div id="preloader"><div class="preloader"><span></span><span></span></div></div>
    <div id="main-wrapper">
        <!-- Header section -->
        <div class="header header-light head-fixed">
            <div class="container">
                <nav id="navigation" class="navigation navigation-landscape">
                    <div class="nav-header">
                        <a class="nav-brand" href="#">
                            <img src="assets/img/logo.png" class="logo" alt="">
                        </a>
                        <div class="nav-toggle"></div>
                    </div>
                    <div class="nav-menus-wrapper">
                        <ul class="nav-menu nav-menu-social align-to-right dhsbrd">
                            <li class="list-buttons ms-2">
                                <a href="company-submit-job.jsp"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Post Job</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <div class="clearfix"></div>
        
        <div class="dashboard-wrap bg-light">
            <!-- Sidebar navigation -->
            <a class="mobNavigation" data-bs-toggle="collapse" href="#MobNav" role="button" aria-expanded="false" aria-controls="MobNav">
                <i class="fas fa-bars mr-2"></i>Dashboard Navigation
            </a>
            <div class="collapse" id="MobNav">
                <div class="dashboard-nav">
                    <div class="dashboard-inner">
                        <ul data-submenu-title="Main Navigation">
                            <li><a href="employer-dashboard.jsp"><i class="fa-solid fa-gauge-high me-2"></i>Dashboard</a></li>
                            <li><a href="employer-profile.jsp"><i class="fa-regular fa-user me-2"></i>Profile</a></li>
                            <li class="active"><a href="CompanyJobsServlet"><i class="fa-solid fa-business-time me-2"></i>My Jobs</a></li>
                            <li><a href="company-submit-job.jsp"><i class="fa-solid fa-pen-ruler me-2"></i>Post Job</a></li>
                            <li><a href="employer-applicants-jobs.jsp"><i class="fa-solid fa-user-group me-2"></i>Applications</a></li>
                            <li><a href="employer-messages.jsp"><i class="fa-solid fa-comments me-2"></i>Messages</a></li>
                            <li><a href="LogoutServlet"><i class="fa-solid fa-power-off me-2"></i>Logout</a></li>
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
                                    <li class="breadcrumb-item text-muted"><a href="employer-dashboard.jsp">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="#" class="text-primary">My Jobs</a></li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>

                <!-- Debug Info (remove in production) -->
                <c:if test="${param.debug == 'true'}">
                    <div class="debug-info">
                        <strong>Debug Information:</strong><br>
                        Current User: ${currentUser.fullName} (ID: ${currentUser.id})<br>
                        Company: ${companyName}<br>
                        Total Jobs: ${jobCounts.all}<br>
                        Search Query: "${searchQuery}"<br>
                        Status Filter: "${statusFilter}"<br>
                        Sort By: "${sortBy}"<br>
                        Jobs in Display List: ${jobList.size()}
                    </div>
                </c:if>

                <!-- Success/Error Messages -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="dashboard-widg-bar d-block">
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                    <div class="_mp-inner-content elior">
                                        <div class="_mp-inner-first">
                                            <div class="search-inline">
                                                <form action="CompanyJobsServlet" method="get">
                                                    <input type="text" name="search" class="form-control" placeholder="Job title, Keywords etc." value="${empty param.search ? '' : param.search}">
                                                    <button type="submit" class="btn btn-primary">Search</button>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="_mp_inner-last">
                                            <div class="item-shorting-box-right">
                                                <div class="shorting-by me-2 small">
                                                    <form action="CompanyJobsServlet" method="get" id="sortForm">
                                                        <input type="hidden" name="search" value="${param.search}">
                                                        <select name="sort" onchange="document.getElementById('sortForm').submit()">
                                                            <option value="0" ${empty param.sort or param.sort == '0' ? 'selected' : ''}>Sort by (Default)</option>
                                                            <option value="1" ${param.sort == '1' ? 'selected' : ''}>Sort by (Featured)</option>
                                                            <option value="2" ${param.sort == '2' ? 'selected' : ''}>Sort by (Urgent)</option>
                                                            <option value="3" ${param.sort == '3' ? 'selected' : ''}>Sort by (Post Date)</option>
                                                        </select>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-xl-12 col-lg-12 col-md-12">
                                            <div class="duster-flex-row align-items-center d-flex justify-content-between">
                                                <div class="duster-flex-first">
                                                    <h6 class="mb-0">Package Status - ${daysLeft} Days Left</h6>
                                                </div>
                                                <div class="duster-flex-end">
                                                    <ul class="nav nav-pills nav-fill gap-2 p-1 small gray-simple rounded" id="pillNav2" role="tablist">
                                                        <li class="nav-item" role="presentation">
                                                            <a class="nav-link ${empty statusFilter || statusFilter == 'all' ? 'active' : ''} rounded" 
                                                               href="CompanyJobsServlet?status=all&search=${searchQuery}&sort=${sortBy}">
                                                               All: ${jobCounts.all}
                                                            </a>
                                                        </li>
                                                        <li class="nav-item" role="presentation">
                                                            <a class="nav-link ${statusFilter == 'active' ? 'active' : ''} rounded" 
                                                               href="CompanyJobsServlet?status=active&search=${searchQuery}&sort=${sortBy}">
                                                               Active: ${jobCounts.active}
                                                            </a>
                                                        </li>
                                                        <li class="nav-item" role="presentation">
                                                            <a class="nav-link ${statusFilter == 'expired' ? 'active' : ''} rounded" 
                                                               href="CompanyJobsServlet?status=expired&search=${searchQuery}&sort=${sortBy}">
                                                               Expired: ${jobCounts.expired}
                                                            </a>
                                                        </li>
                                                        <li class="nav-item" role="presentation">
                                                            <a class="nav-link ${statusFilter == 'draft' ? 'active' : ''} rounded" 
                                                               href="CompanyJobsServlet?status=draft&search=${searchQuery}&sort=${sortBy}">
                                                               Draft: ${jobCounts.draft}
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row justify-content-start gx-3 gy-4">
                                        <c:choose>
                                            <c:when test="${not empty jobList}">
                                                <c:forEach var="job" items="${jobList}" varStatus="status">
                                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                                        <div class="card mb-3">
                                                            <div class="card-body d-flex align-items-center justify-content-between">
                                                                <div>
                                                                    <h5 class="mb-1">${job.title}</h5>
                                                                    <div class="mb-1">
                                                                        <span class="job-status-badge status-${job.status}">${job.status}</span>
                                                                        <span class="ms-2"><i class="fa-solid fa-calendar-days me-1"></i>Posted: ${job.postedDate}</span>
                                                                        <span class="ms-2"><i class="fa-solid fa-calendar-xmark me-1"></i>Expires: ${job.expiryDate}</span>
                                                                    </div>
                                                                    <div class="mb-1">
                                                                        <span><i class="fa-solid fa-location-dot me-1"></i>${job.location}</span>
                                                                        <span class="ms-2"><i class="fa-solid fa-users me-1"></i>Applicants: ${job.applicants}</span>
                                                                        <span class="ms-2"><i class="fa-solid fa-paperclip me-1"></i>Attachments: ${job.attachmentCount}</span>
                                                                    </div>
                                                                </div>
                                                                <div class="job-actions">
                                                                    <a href="company-submit-job.jsp?editJobId=${job.id}" class="btn btn-sm btn-outline-primary">Edit</a>
                                                                    <form action="DeleteJobServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this job?');">
                                                                        <input type="hidden" name="jobId" value="${job.id}" />
                                                                        <button type="submit" class="btn btn-sm btn-outline-danger">Delete</button>
                                                                    </form>
                                                                    <a href="CandidateListServlet?jobId=${job.id}" class="btn btn-sm btn-outline-success">View Candidates</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="col-xl-12 col-lg-12 col-md-12">
                                                    <div class="text-center py-5">
                                                        <i class="fa-solid fa-briefcase fa-3x text-muted mb-3"></i>
                                                        <h5 class="text-muted">No jobs found</h5>
                                                        <c:choose>
                                                            <c:when test="${not empty searchQuery or (not empty statusFilter and statusFilter != 'all')}">
                                                                <p class="text-muted">No jobs match your current filters.</p>
                                                                <a href="CompanyJobsServlet" class="btn btn-outline-primary me-2">
                                                                    <i class="fa-solid fa-refresh me-2"></i>Clear Filters
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p class="text-muted">You haven't posted any jobs yet.</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <a href="company-submit-job.jsp" class="btn btn-primary">
                                                            <i class="fa-solid fa-plus me-2"></i>Post Your First Job
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
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
        </div>
        
        <a id="back2Top" class="top-scroll" title="Back to top" href="#"><i class="ti-arrow-up"></i></a>
    </div>

    <!-- Scripts -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>

    <script>
        function confirmDelete(jobId) {
            if (confirm('Are you sure you want to delete this job? This action cannot be undone.')) {
                window.location.href = 'DeleteJobServlet?id=' + jobId;
            }
        }

        // Debug function to check page load
        console.log('Company Jobs page loaded');
        console.log('Total jobs displayed: ${jobList.size()}');
        console.log('Job counts: All=${jobCounts.all}, Active=${jobCounts.active}, Expired=${jobCounts.expired}, Draft=${jobCounts.draft}');
        
        // Show success message if job was just posted
        <c:if test="${not empty sessionScope.successMessage}">
            console.log('Success message: ${sessionScope.successMessage}');
        </c:if>
    </script>
</body>
</html>
