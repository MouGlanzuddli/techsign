<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Test Job Display</title>
    <link href="assets/css/styles.css" rel="stylesheet">
    <link href="assets/css/colors.css" rel="stylesheet">
    <style>
        .job-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            background: white;
        }
        .job-title {
            font-size: 18px;
            font-weight: bold;
            color: #016551;
            margin-bottom: 10px;
        }
        .job-details {
            color: #666;
            margin-bottom: 5px;
        }
        .job-status {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        .status-open { background-color: #d4edda; color: #155724; }
        .status-draft { background-color: #fff3cd; color: #856404; }
        .status-expired { background-color: #f8d7da; color: #721c24; }
        .debug-info {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            padding: 15px;
            margin: 20px 0;
            border-radius: 5px;
            font-family: monospace;
            font-size: 12px;
        }
    </style>
</head>
<body class="green-theme">
    <div id="main-wrapper">
        <div class="dashboard-wrap bg-light">
            <div class="dashboard-content">
                <div class="dashboard-tlbar d-block mb-4">
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12">
                            <h1 class="mb-1 fs-3 fw-medium">Test Job Display</h1>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="CompanyJobsServlet">My Jobs</a></li>
                                    <li class="breadcrumb-item active">Test Display</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>

                <!-- Debug Information -->
                <div class="debug-info">
                    <strong>Debug Information:</strong><br>
                    Current User: ${currentUser.fullName} (ID: ${currentUser.id})<br>
                    Company: ${companyName}<br>
                    Total Jobs: ${totalJobs}<br>
                    Jobs in List: ${jobList.size()}
                </div>

                <!-- Error Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Job List -->
                <div class="dashboard-widg-bar d-block">
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4>Jobs for ${companyName}</h4>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${not empty jobList}">
                                            <c:forEach var="job" items="${jobList}" varStatus="status">
                                                <div class="job-card">
                                                    <div class="job-title">
                                                        ${job.title}
                                                        <span class="job-status status-${job.status}">${job.status}</span>
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>ID:</strong> ${job.id}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Description:</strong> ${job.description}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Location:</strong> ${job.location}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Job Type:</strong> ${job.jobType}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Skills:</strong> ${job.skills}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Country:</strong> ${job.country}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>State/City:</strong> ${job.stateCity}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Posted:</strong> 
                                                        <fmt:formatDate value="${job.postedAt}" pattern="MMM dd, yyyy HH:mm"/>
                                                    </div>
                                                    <c:if test="${not empty job.expiresAt}">
                                                        <div class="job-details">
                                                            <strong>Expires:</strong> 
                                                            <fmt:formatDate value="${job.expiresAt}" pattern="MMM dd, yyyy"/>
                                                        </div>
                                                    </c:if>
                                                    <div class="job-details">
                                                        <strong>Salary:</strong> 
                                                        <c:if test="${not empty job.salaryMin}">${job.salaryMin}</c:if>
                                                        <c:if test="${not empty job.salaryMin and not empty job.salaryMax}"> - </c:if>
                                                        <c:if test="${not empty job.salaryMax}">${job.salaryMax}</c:if>
                                                        <c:if test="${empty job.salaryMin and empty job.salaryMax}">Not specified</c:if>
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Category:</strong> ${job.jobCategory}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Level:</strong> ${job.jobLevel}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Experience:</strong> ${job.experience}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Qualification:</strong> ${job.qualification}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Gender:</strong> ${job.gender}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Fee Type:</strong> ${job.jobFeeType}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Permanent Address:</strong> ${job.permanentAddress}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Temporary Address:</strong> ${job.temporaryAddress}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Zip Code:</strong> ${job.zipCode}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Video URL:</strong> ${job.videoUrl}
                                                    </div>
                                                    <div class="job-details">
                                                        <strong>Coordinates:</strong> ${job.latitude}, ${job.longitude}
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center py-5">
                                                <i class="fa-solid fa-briefcase fa-3x text-muted mb-3"></i>
                                                <h5 class="text-muted">No jobs found</h5>
                                                <p class="text-muted">You haven't posted any jobs yet.</p>
                                                <a href="company-submit-job.jsp" class="btn btn-primary">
                                                    <i class="fa-solid fa-plus me-2"></i>Post Your First Job
                                                </a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Navigation -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <a href="CompanyJobsServlet" class="btn btn-outline-primary me-2">
                            <i class="fa-solid fa-arrow-left me-2"></i>Back to My Jobs
                        </a>
                        <a href="company-submit-job.jsp" class="btn btn-primary">
                            <i class="fa-solid fa-plus me-2"></i>Post New Job
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>

    <script>
        console.log('Test Job Display page loaded');
        console.log('Total jobs: ${totalJobs}');
        console.log('Jobs in list: ${jobList.size()}');
        
        // Log each job for debugging
        <c:forEach var="job" items="${jobList}" varStatus="status">
            console.log('Job ${status.index + 1}: ${job.title} (ID: ${job.id}, Status: ${job.status})');
        </c:forEach>
    </script>
</body>
</html> 