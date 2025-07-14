<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Listings - TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <!-- Colors CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #17ac6a;
            --primary-dark: #139756;
            --secondary-color: #28a745;
            --accent-color: #f8f9fa;
            --text-dark: #2d3748;
            --text-muted: #718096;
            --border-color: #e2e8f0;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
            --shadow-lg: 0 10px 25px rgba(0,0,0,0.1);
            --border-radius: 12px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f7fafc;
            color: var(--text-dark);
        }

        /* Enhanced Job Cards */
        .job-card {
            background: white;
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            transition: var(--transition);
            overflow: hidden;
            position: relative;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .job-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
            border-color: var(--primary-color);
        }

        .job-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            opacity: 0;
            transition: var(--transition);
        }

        .job-card:hover::before {
            opacity: 1;
        }

        .job-card-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        .job-card-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: rgba(255,255,255,0.1);
            transform: rotate(45deg);
            transition: var(--transition);
        }

        .job-card:hover .job-card-header::before {
            right: -30%;
        }

        .job-card-body {
            padding: 24px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .job-card-footer {
            padding: 20px 24px;
            background: var(--accent-color);
            border-top: 1px solid var(--border-color);
            margin-top: auto;
        }

        /* Company Logo Enhancement */
        .company-logo {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 18px;
            box-shadow: var(--shadow-sm);
            flex-shrink: 0;
        }

        /* Enhanced Filter Sidebar */
        .filter-content {
            background: white;
            border-radius: var(--border-radius);
            padding: 28px;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-color);
            position: sticky;
            top: 20px;
        }

        .filter-content h4 {
            color: var(--text-dark);
            font-weight: 600;
            margin-bottom: 24px;
            position: relative;
            padding-bottom: 12px;
        }

        .filter-content h4::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 2px;
        }

        .single-tabs-group {
            margin-bottom: 24px;
            padding: 20px;
            background: #f8fafc;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            transition: var(--transition);
        }

        .single-tabs-group:hover {
            border-color: var(--primary-color);
            background: #f0fff4;
        }

        .single-tabs-group-header h5 {
            color: var(--text-dark);
            font-weight: 600;
            margin-bottom: 12px;
            font-size: 16px;
        }

        /* Enhanced Form Controls */
        .form-control {
            border-radius: 8px;
            border: 2px solid var(--border-color);
            padding: 12px 16px;
            font-size: 14px;
            transition: var(--transition);
            background: white;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(23, 172, 106, 0.1);
            outline: none;
        }

        /* Enhanced Buttons */
        .btn-dark {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            font-weight: 600;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .btn-dark::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: var(--transition);
        }

        .btn-dark:hover::before {
            left: 100%;
        }

        .btn-dark:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Enhanced Hero Search Form - Horizontal Layout */
        .hero-search-wrap {
            background: white;
            border-radius: var(--border-radius);
            padding: 40px;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
            backdrop-filter: blur(10px);
            max-width: 100%;
            width: 100%;
        }

        .hero-search-content .row {
            align-items: end;
            gap: 65px; /* Tăng khoảng cách giữa các ô để tách rõ ràng hơn */
            max-width: 1200px;
            margin: 0 auto;
        }

        .hero-search-content .form-group {
            margin-bottom: 0;
            width: 100%; /* Đảm bảo mỗi ô chiếm toàn bộ cột */
        }

        .hero-search-content .form-label {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 8px;
            display: block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .hero-search-content .form-control {
            height: 60px;
            font-size: 16px;
            padding: 18px 20px;
            border: 3px solid var(--border-color);
            border-radius: 12px;
            font-weight: 500;
            background: #fafbfc;
            transition: all 0.3s ease;
            width: 100%;
            min-width: 250px;
        }

        .hero-search-content .form-control:focus {
            border-color: var(--primary-color);
            background: white;
            box-shadow: 0 0 0 4px rgba(23, 172, 106, 0.15);
            transform: translateY(-2px);
        }

        .hero-search-content .form-control option {
            padding: 12px;
            font-size: 16px;
        }

        .hero-search-content .btn {
            height: 60px;
            font-size: 18px;
            font-weight: 700;
            white-space: normal;
            padding: 18px 24px;
            border-radius: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(23, 172, 106, 0.3);
            width: 100%;
            min-width: 150px;
        }

        .hero-search-content .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(23, 172, 106, 0.4);
        }

        /* Search input with icon positioning */
        .input-with-icon {
            position: relative;
        }

        .input-with-icon img {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            opacity: 0.6;
            width: 20px;
            height: 20px;
        }

        .input-with-icon .form-control {
            padding-right: 50px;
        }

        /* Job Type Badges */
        .job-type-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .full-time { background: #dcfce7; color: #166534; }
        .part-time { background: #fef3c7; color: #92400e; }
        .freelanc { background: #e0e7ff; color: #3730a3; }
        .enternship { background: #fce7f3; color: #be185d; }

        /* Featured and Urgent Tags */
        .featured-text {
            background: #fbbf24;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            margin-right: 8px;
        }

        .urgent {
            background: #ef4444;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        /* Enhanced Job Title */
        .job-title {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 18px;
            line-height: 1.4;
            margin-bottom: 8px;
            transition: var(--transition);
        }

        .job-title:hover {
            color: var(--primary-color);
        }

        /* Salary Display */
        .salary-display {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 16px;
        }

        /* Stats Section */
        .stats-section {
            background: white;
            border-radius: var(--border-radius);
            padding: 24px;
            margin-bottom: 32px;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-color);
        }

        /* No Results State */
        .no-results {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
        }

        .no-results i {
            color: var(--text-muted);
            margin-bottom: 20px;
        }

        /* Responsive Improvements */
        @media (max-width: 1200px) {
            .hero-search-content .col-xl-4,
            .hero-search-content .col-xl-2 {
                flex: 0 0 100%;
                max-width: 100%;
                margin-bottom: 20px; /* Tăng khoảng cách khi xuống dòng */
            }
            
            .hero-search-content .btn {
                margin-top: 20px;
            }
            
            .hero-search-content .row {
                gap: 20px; /* Giảm gap trên màn hình nhỏ để vừa với layout */
                flex-direction: column;
            }
        }

        @media (max-width: 768px) {
            .filter-content {
                margin-bottom: 30px;
            }
            
            .job-card-body {
                padding: 20px;
            }
            
            .hero-search-wrap {
                padding: 30px 20px;
            }

            .hero-search-content .col-xl-4,
            .hero-search-content .col-xl-2 {
                flex: 0 0 100%;
                max-width: 100%;
                margin-bottom: 20px;
            }

            .hero-search-content .btn {
                margin-top: 0;
            }

            .hero-search-content .row {
                gap: 15px; /* Giảm thêm gap trên màn hình rất nhỏ */
            }
        }

        /* Loading Animation */
        .loading-shimmer {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: shimmer 2s infinite;
        }

        @keyframes shimmer {
            0% { background-position: -200% 0; }
            100% { background-position: 200% 0; }
        }

        /* Enhanced Footer */
        .footer {
            background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
            color: white;
        }

        /* Modal Enhancements */
        .modal-content {
            border-radius: var(--border-radius);
            border: none;
            box-shadow: var(--shadow-lg);
        }

        .modal-header {
            border-bottom: 1px solid var(--border-color);
            padding: 24px;
        }

        .modal-body {
            padding: 24px;
        }

        /* Pagination Enhancement */
        .pagination-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }
    </style>
</head>
<body class="green-theme">
    <!-- Preloader -->
    <div id="preloader"><div class="preloader"><span></span><span></span></div></div>

    <!-- Main wrapper -->
    <div id="main-wrapper">
        <!-- Navigation -->
        <div class="header header-transparent change-logo">
            <div class="container">
                <nav id="navigation" class="navigation navigation-landscape">
                    <div class="nav-header">
                        <a class="nav-brand static-logo" href="index.jsp"><img src="${pageContext.request.contextPath}/assets/img/logo-light.png" class="logo" alt="TechSign"></a>
                        <a class="nav-brand fixed-logo" href="index.jsp"><img src="${pageContext.request.contextPath}/assets/img/logo.png" class="logo" alt="TechSign"></a>
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
                            <li><a href="index.jsp">Home</a></li>
                            <li class="active"><a href="JobListServlet">Jobs</a></li>
                            <li><a href="companies.jsp">Company</a></li>
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
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                            <div class="d-flex align-items-center">
                                                <div class="company-logo me-2" style="width: 32px; height: 32px; font-size: 14px;">
                                                    ${sessionScope.user.fullName.substring(0,1).toUpperCase()}
                                                </div>
                                                ${sessionScope.user.fullName}
                                            </div>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user me-2"></i>Profile</a></li>
                                            <li><a class="dropdown-item" href="my-applications.jsp"><i class="fas fa-file-alt me-2"></i>My Applications</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="LogoutServlet"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                        </ul>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login"><i class="fas fa-sign-in-alt me-2"></i>Sign In</a></li>
                                    <li class="list-buttons ms-2"><a href="signup.jsp"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Upload Resume</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <div class="clearfix"></div>

        <!-- Enhanced Hero Section - MUCH BETTER Search Form -->
        <div class="image-cover hero-header primary-bg-dark" data-overlay="0">
            <div class="position-absolute top-0 end-0 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-3-soft-light.svg" alt="SVG" width="500">
            </div>
            <div class="position-absolute top-0 start-0 me-10 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-1-soft-light.svg" alt="SVG" width="250">
            </div>
            <div class="container d-flex flex-column justify-content-center position-relative zindex-2 pt-5">
                <div class="row justify-content-center">
                    <div class="col-xl-8 col-lg-9 col-md-10 text-center">
                        <h6 class="primary-2-cl fw-medium d-inline-flex align-items-center mb-3">
                            <span class="primary-2-bg w-10 h-05 me-2"></span>
                            Explore Job Opportunities
                        </h6>
                        <h1 class="mb-4 display-4 fw-bold">Discover Your Next <span style="color: #17ac6a;">Career Move</span></h1>
                        <p class="fs-5 mb-4">Browse thousands of job opportunities tailored to your skills and preferences. Find your dream job today!</p>
                        <div class="d-flex justify-content-center gap-3 mb-4">
                            <div class="text-center">
                                <h4 class="mb-0 text-white">${totalJobs}+</h4>
                                <small class="text-light">Active Jobs</small>
                            </div>
                            <div class="text-center">
                                <h4 class="mb-0 text-white">500+</h4>
                                <small class="text-light">Companies</small>
                            </div>
                            <div class="text-center">
                                <h4 class="mb-0 text-white">10K+</h4>
                                <small class="text-light">Job Seekers</small>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- IMPROVED Search Box Layout - Much Bigger and Clearer -->
                <div class="hero-search-wrap mt-4">
                    <div class="hero-search-content">
                        <form action="JobListServlet" method="get">
                            <div class="row g-4 align-items-end">
                                <div class="col-xl-4 col-lg-4 col-md-12 col-sm-12">
                                    <div class="form-group">
                                        <label class="form-label">Job Keywords</label>
                                        <div class="input-with-icon">
                                            <input type="text" class="form-control" name="search" placeholder="e.g. Software Engineer, Marketing Manager..." value="${searchKeyword}">
                                            <img src="${pageContext.request.contextPath}/assets/img/pin.svg" width="20" alt="">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-2 col-lg-2 col-md-6 col-sm-12">
                                    <div class="form-group">
                                        <label class="form-label">Category</label>
                                        <select class="form-control" name="category">
                                            <option value="">All Categories</option>
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat}" ${categoryFilter == cat ? 'selected' : ''}>${cat}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xl-2 col-lg-2 col-md-6 col-sm-12">
                                    <div class="form-group">
                                        <label class="form-label">Location</label>
                                        <select class="form-control" name="location">
                                            <option value="">All Locations</option>
                                            <c:forEach var="loc" items="${locations}">
                                                <option value="${loc}" ${locationFilter == loc ? 'selected' : ''}>${loc}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xl-2 col-lg-2 col-md-6 col-sm-12">
                                    <div class="form-group">
                                        <label class="form-label d-none d-xl-block">&nbsp;</label>
                                        <button type="submit" class="btn btn-dark full-width">
                                            <i class="fas fa-search me-2"></i>Search
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="position-absolute bottom-0 start-0 z-0">
                <img src="${pageContext.request.contextPath}/assets/img/shape-2-soft-light.svg" alt="SVG" width="400">
            </div>
        </div>

        <!-- Main Content -->
        <section class="py-5">
            <div class="container">
                <!-- Stats Section -->
                <div class="stats-section">
                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                        <div>
                            <h5 class="mb-1">
                                <strong>${totalJobs}</strong> Jobs Found
                            </h5>
                            <p class="text-muted mb-0">Showing the best opportunities for you</p>
                        </div>
                        <div class="text-muted">
                            <i class="fas fa-clock me-1"></i> 
                            Last updated: <span class="fw-semibold">Just now</span>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Enhanced Filters Sidebar -->
                    <div class="col-lg-3">
                        <div class="filter-content">
                            <h4>Refine Your Search</h4>
                            <form action="JobListServlet" method="get" id="filterForm">
                                <input type="hidden" name="search" value="${searchKeyword}">
                                
                                <div class="single-tabs-group">
                                    <div class="single-tabs-group-header">
                                        <h5>Job Type</h5>
                                    </div>
                                    <div class="single-tabs-group-content">
                                        <select class="form-control" name="jobType" onchange="this.form.submit()">
                                            <option value="">All Types</option>
                                            <option value="Full Time" ${jobTypeFilter == 'Full Time' ? 'selected' : ''}>Full Time</option>
                                            <option value="Part Time" ${jobTypeFilter == 'Part Time' ? 'selected' : ''}>Part Time</option>
                                            <option value="Contract" ${jobTypeFilter == 'Contract' ? 'selected' : ''}>Contract</option>
                                            <option value="Internship" ${jobTypeFilter == 'Internship' ? 'selected' : ''}>Internship</option>
                                            <option value="Remote" ${jobTypeFilter == 'Remote' ? 'selected' : ''}>Remote</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="single-tabs-group">
                                    <div class="single-tabs-group-header">
                                        <h5>Job Level</h5>
                                    </div>
                                    <div class="single-tabs-group-content">
                                        <select class="form-control" name="jobLevel" onchange="this.form.submit()">
                                            <option value="">All Levels</option>
                                            <option value="Intern" ${jobLevelFilter == 'Intern' ? 'selected' : ''}>Intern</option>
                                            <option value="Junior" ${jobLevelFilter == 'Junior' ? 'selected' : ''}>Junior</option>
                                            <option value="Mid" ${jobLevelFilter == 'Mid' ? 'selected' : ''}>Mid-Level</option>
                                            <option value="Senior" ${jobLevelFilter == 'Senior' ? 'selected' : ''}>Senior</option>
                                            <option value="Lead" ${jobLevelFilter == 'Lead' ? 'selected' : ''}>Lead</option>
                                            <option value="Manager" ${jobLevelFilter == 'Manager' ? 'selected' : ''}>Manager</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="single-tabs-group">
                                    <div class="single-tabs-group-header">
                                        <h5>Sort By</h5>
                                    </div>
                                    <div class="single-tabs-group-content">
                                        <select class="form-control" name="sortBy" onchange="this.form.submit()">
                                            <option value="newest" ${sortBy == 'newest' ? 'selected' : ''}>Newest First</option>
                                            <option value="oldest" ${sortBy == 'oldest' ? 'selected' : ''}>Oldest First</option>
                                            <option value="title" ${sortBy == 'title' ? 'selected' : ''}>Job Title A-Z</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="filt-buttons-updates">
                                    <a href="JobListServlet" class="btn btn-outline-secondary full-width mb-2">
                                        Clear Filters
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Enhanced Jobs List -->
                    <div class="col-lg-9">
                        <c:choose>
                            <c:when test="${empty jobs}">
                                <div class="no-results">
                                    <i class="fas fa-search fa-4x mb-4"></i>
                                    <h4 class="mb-3">No Jobs Found</h4>
                                    <p class="text-muted mb-4">We couldn't find any jobs matching your criteria. Try adjusting your search keywords or filters.</p>
                                    <div class="d-flex gap-3 justify-content-center">
                                        <a href="JobListServlet" class="btn btn-dark">View All Jobs</a>
                                        <a href="#" class="btn btn-outline-primary">Create Job Alert</a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="row g-4">
                                    <c:forEach var="job" items="${jobs}">
                                        <div class="col-xl-6 col-lg-12 col-md-6">
                                            <div class="job-card">
                                                <div class="job-card-header">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div class="left-tags-capt">
                                                            <c:if test="${job.featured}">
                                                                <span class="featured-text">Featured</span>
                                                            </c:if>
                                                            <c:if test="${job.urgent}">
                                                                <span class="urgent">Urgent</span>
                                                            </c:if>
                                                        </div>
                                                        <span class="job-type-badge ${job.jobType == 'Internship' ? 'enternship' : job.jobType == 'Freelance' ? 'freelanc' : job.jobType == 'Part Time' ? 'part-time' : 'full-time'}">
                                                            ${job.jobType}
                                                        </span>
                                                    </div>
                                                </div>
                                                
                                                <div class="job-card-body">
                                                    <div class="d-flex align-items-start mb-3">
                                                        <div class="company-logo me-3">
                                                            ${companies[job.companyId].fullName.substring(0,1).toUpperCase()}
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <h4 class="job-title mb-1">
                                                                <a href="JobDetailServlet?id=${job.id}" class="text-decoration-none">
                                                                    ${job.title}
                                                                </a>
                                                            </h4>
                                                            <p class="text-muted mb-0">${companies[job.companyId].fullName}</p>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <span class="badge bg-light text-dark me-2">${job.category}</span>
                                                    </div>
                                                    <div class="job-details text-muted small mb-3">
                                                        <div class="d-flex align-items-center mb-2">
                                                            <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                                                            <span>${job.location}</span>
                                                        </div>
                                                        <c:if test="${job.experienceRequired > 0}">
                                                            <div class="d-flex align-items-center">
                                                                <i class="fas fa-briefcase me-2 text-primary"></i>
                                                                <span>${job.experienceRequired} years experience</span>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="job-card-footer">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div class="salary-display">
                                                            <c:choose>
                                                                <c:when test="${not empty job.salaryMin and not empty job.salaryMax}">
                                                                    <fmt:formatNumber value="${job.salaryMin}" pattern="#,###"/> - <fmt:formatNumber value="${job.salaryMax}" pattern="#,###"/> M VND
                                                                </c:when>
                                                                <c:when test="${not empty job.salaryMin}">
                                                                    From <fmt:formatNumber value="${job.salaryMin}" pattern="#,###"/> M VND
                                                                </c:when>
                                                                <c:when test="${not empty job.salaryMax}">
                                                                    Up to <fmt:formatNumber value="${job.salaryMax}" pattern="#,###"/> M VND
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Salary Negotiable</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="text-muted small">
                                                            <fmt:formatDate value="${job.createdAt}" pattern="MMM dd, yyyy"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="pagination-wrapper">
                                    <nav aria-label="Job listings pagination">
                                        <ul class="pagination">
                                            <li class="page-item">
                                                <a class="page-link" href="#" aria-label="Previous">
                                                    <span aria-hidden="true">«</span>
                                                </a>
                                            </li>
                                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                                            <li class="page-item">
                                                <a class="page-link" href="#" aria-label="Next">
                                                    <span aria-hidden="true">»</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>

        <!-- Enhanced Footer -->
        <footer class="footer skin-dark-footer">
            <div class="py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="footer-widget">
                                <img src="${pageContext.request.contextPath}/assets/img/logo-light.png" class="img-footer mb-3" alt="TechSign">
                                <div class="footer-add mb-3">
                                    <p>+348888702</p>
                                    <p>Hoa Hai, Ngu Hanh Son, Da Nang, Viet Nam</p>
                                </div>
                                <div class="foot-socials">
                                    <ul class="list-unstyled d-flex">
                                        <li class="me-3">
                                            <a href="JavaScript:Void(0);" class="text-light">
                                                <i class="fa-brands fa-facebook fa-lg"></i>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="JavaScript:Void(0);" class="text-light">
                                                <i class="fa-brands fa-google-plus fa-lg"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="footer-widget">
                                <h4 class="widget-title mb-3">For Clients</h4>
                                <ul class="footer-menu list-unstyled">
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Talent Marketplace</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Payroll Services</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Direct Contracts</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Hire Worldwide</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">How to Hire</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="footer-widget">
                                <h4 class="widget-title mb-3">Our Resources</h4>
                                <ul class="footer-menu list-unstyled">
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Free Business tools</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Affiliate Program</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Success Stories</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Reviews</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Help & Support</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="footer-widget">
                                <h4 class="widget-title mb-3">The Company</h4>
                                <ul class="footer-menu list-unstyled">
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">About Us</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Leadership</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Contact Us</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Investor Relations</a></li>
                                    <li class="mb-2"><a href="JavaScript:Void(0);" class="text-light-50">Trust & Security</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom border-top border-secondary">
                <div class="container">
                    <div class="row py-3">
                        <div class="col-12 text-center">
                            <p class="mb-0">© 2025 TechSign® - All rights reserved.</p>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Enhanced Login Modal -->
        <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="loginmodal" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered login-pop-form" role="document">
                <div class="modal-content" id="loginmodal">
                    <span class="mod-close" data-bs-dismiss="modal" aria-hidden="true">
                        <i class="fas fa-times"></i>
                    </span>
                    <div class="modal-header text-center">
                        <div class="w-100">
                            <div class="mdl-thumb mb-3">
                                <img src="${pageContext.request.contextPath}/assets/img/ico.png" class="img-fluid" width="70" alt="TechSign">
                            </div>
                            <div class="mdl-title">
                                <h4 class="modal-header-title mb-2">Welcome Back!</h4>
                                <p class="text-muted">Sign in to access your account</p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger d-flex align-items-center">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        <div class="modal-login-form">
                            <form action="${pageContext.request.contextPath}/LoginServlet" method="POST">
                                <div class="form-floating mb-4">
                                    <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                                    <label>Email Address</label>
                                </div>
                                <div class="form-floating mb-4">
                                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                                    <label>Password</label>
                                </div>
                                <div class="form-group mb-4">
                                    <button type="submit" class="btn btn-dark full-width font--bold btn-lg">
                                        Sign In
                                    </button>
                                </div>
                                <div class="modal-flex-item mb-3">
                                    <div class="modal-flex-first">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" name="rem" id="savepassword" value="on">
                                            <label class="form-check-label" for="savepassword">Remember me</label>
                                        </div>
                                    </div>
                                    <div class="modal-flex-last">
                                        <a href="forgot-password.jsp" class="text-primary">Forgot Password?</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="social-login mt-4">
                            <div class="text-center mb-3">
                                <span class="text-muted">Or continue with</span>
                            </div>
                            <ul class="list-unstyled d-flex justify-content-center mb-0">
                                <li>
                                    <a href="https://accounts.google.com/o/oauth2/v2/auth?scope=email%20profile&access_type=online&include_granted_scopes=true&response_type=code&redirect_uri=http://localhost:8080/JobSearchManagement/LoginGoogleHandler&client_id=662818990560-8t0tkh07kp0kktc2mk7177k5gj8dvkdn.apps.googleusercontent.com" 
                                       class="btn btn-outline-danger full-width">
                                        <i class="fa-brands fa-google me-2"></i> Continue with Google
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="modal-footer text-center">
                        <p class="mb-0">Don't have an account? 
                            <a href="${pageContext.request.contextPath}/SignupServlet" class="text-primary font--bold">
                                Create Account
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/rangeslider.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/slick.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/counterup.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/custom.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/cl-switch.js"></script>
    
    <script>
        $(document).ready(function() {
            // Show login modal if there's an error
            <% if (request.getAttribute("error") != null) { %>
                $('#login').modal('show');
            <% } %>
            
            // Add loading animation to job cards
            $('.job-card').hover(function() {
                $(this).addClass('shadow-lg');
            }, function() {
                $(this).removeClass('shadow-lg');
            });
            
            // Smooth scroll for anchor links
            $('a[href^="#"]').on('click', function(event) {
                var target = $(this.getAttribute('href'));
                if( target.length ) {
                    event.preventDefault();
                    $('html, body').stop().animate({
                        scrollTop: target.offset().top - 100
                    }, 1000);
                }
            });
            
            // Auto-hide alerts after 5 seconds
            $('.alert').delay(5000).fadeOut();
        });
    </script>
</body>
</html>