<%@page import="model.User"%>
<%@page import="connectDB.DBContext"%>
<%@page import="java.sql.*" %>

<!doctype html>
<html lang="en">

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/candidate-resume.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:38 GMT -->
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
            <div class="header header-transparent change-logo">
                <div class="container">
                    <nav id="navigation" class="navigation navigation-landscape">

                        <div class="nav-header">
                            <a class="nav-brand static-logo" href="#"><img src="assets/img/logo-light.png" class="logo" alt=""></a>
                            <a class="nav-brand fixed-logo" href="#"><img src="assets/img/logo.png" class="logo" alt=""></a>
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
                                <li ><a href="JavaScript:Void(0);">Home<span class="submenu-indicator"></span></a></li>
                                <li><a href="JavaScript:Void(0);">Jobs<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="SearchandView">Job List</a></li>
                                        <li><a href="grid-style-2.html">Suitable Jobs</a></li>
                                    </ul>
                                </li>
                                <li><a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="employer-grid-1.html">Company List</a></li>
                                    </ul>
                                </li>
                                <li><a href="JavaScript:Void(0);">Profile CV<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a>Create CV</a></li>
                                        <li><a>Manage CV</a></li>

                                    </ul>
                                </li>

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
                                    <a class="nav-link dropdown-toggle" href="#" id="accountLogoDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <img src="assets/img/logo-account.png" class="nav-logo" alt="aa">
                                    </a>
                                    <ul class="dropdown-menu" aria-labelledby="accountLogoDropdown">
                                        <li><a class="dropdown-item" href="dashboardcandidate.jsp">Dashboard</a></li>
                                        <li><a class="dropdown-item" href= "LogoutServlet">Logout</a></li>
                                    </ul>
                                </li>
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
                                    <a href="candidate-detail.html"><figure><img src="assets/img/team-2.jpg" class="img-fluid circle" alt=""></figure></a>
                                </div>
                            </div>
                            <div class="jbs-grid-usrs-caption mb-3">
                                <div class="jbs-kioyer">
                                    <div class="jbs-kioyer-groups">
                                        <span class="fa-solid fa-star active"></span>
                                        <span class="fa-solid fa-star active"></span>
                                        <span class="fa-solid fa-star active"></span>
                                        <span class="fa-solid fa-star active"></span>
                                        <span class="fa-solid fa-star"></span>
                                        <span class="aal-reveis">4.7</span>
                                    </div>
                                </div>
                                <div class="jbs-tiosk">
                                    <h4 class="jbs-tiosk-title"><a href="candidate-detail.html">Linda D. Strong</a></h4>
                                    <div class="jbs-tiosk-subtitle"><span>Front-End Developer</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="dashboard-inner">
                            <ul data-submenu-title="Main Navigation">
                                <li><a href="candidate-dashboard.html"><i class="fa-solid fa-gauge-high me-2"></i>User Dashboard</a></li>
                                <li><a href="candidate-profile.html"><i class="fa-regular fa-user me-2"></i>My Profile </a></li>
                                <li class="active"><a href="candidate-resume.html"><i class="fa-solid fa-file-pdf me-2"></i>My Resumes</a></li>
                                <li><a href="candidate-applied-jobs.html"><i class="fa-regular fa-paper-plane me-2"></i>Applied jobs</a></li>
                                <li><a href="candidate-alert-job.html"><i class="fa-solid fa-bell me-2"></i>Alert Jobs<span class="count-tag bg-warning">4</span></a></li>
                                <li><a href="candidate-saved-jobs.html"><i class="fa-solid fa-bookmark me-2"></i>Shortlist Jobs</a></li>
                                <li><a href="candidate-follow-employers.html"><i class="fa-solid fa-user-clock me-2"></i>Following Employers</a></li>
                                <li><a href="candidate-messages.html"><i class="fa-solid fa-comments me-2"></i>Messages<span class="count-tag">4</span></a></li>
                                <li><a href="candidate-change-password.html"><i class="fa-solid fa-unlock-keyhole me-2"></i>Change Password</a></li>
                                <li><a href="candidate-delete-account.html"><i class="fa-solid fa-trash-can me-2"></i>Delete Account</a></li>
                                <li><a href="index.html"><i class="fa-solid fa-power-off me-2"></i>Log Out</a></li>
                            </ul>
                        </div>					
                    </div>
                </div>

                <div class="dashboard-content">
                    <div class="dashboard-tlbar d-block mb-4">
                        <div class="row">
                            <div class="colxl-12 col-lg-12 col-md-12">
                                <h1 class="mb-1 fs-3 fw-medium">My Resume</h1>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-widg-bar d-block">

                        <!-- Row Start -->
                        <div class="card">

                            <div class="card-body">

                                <div class="row gx-4 gy-4">
                                    <div class="col-xl-12 col-lg-12 col-md-12">
                                        <div class="upload-btn-wrapper">        
                                            <label class="btn">
                                                <form action="UploadServlet" method="post" enctype="multipart/form-data" >                                                
                                                    Upload a file
                                                    <input type="file" name="resumeFile" accept=".pdf" style="display:none;" required onchange="this.form.submit()"> 
                                                </form>
                                            </label>

                                            <a href="CreateNewCV.jsp" class="btn">Create New CV</a>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>	
                        <!-- End Row -->
                        <!-- Tabs -->
                        <div class="card">
                            <div class="card-header">
                                <ul class="nav nav-tabs mb-3" id="resumeTabs" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="all-cv-tab" data-bs-toggle="tab" data-bs-target="#all-cv" type="button" role="tab">Uploaded CVs</button>
                                    </li>                               
                                </ul>
                            </div>
                            <!-- Tab Content -->
                            <div class="tab-content" id="resumeTabContent">
                                <!-- Uploaded CVs -->
                                <div class="tab-pane fade show active" id="all-cv" role="tabpanel">
                                    <div class="row gx-4 gy-4">
                                        <!-- CV Item -->
                                        <%
                                            User user = (User) session.getAttribute("user");
                                            int userId = user.getId();
                                            Connection conn = new DBContext().getConnection();

                                            // 
                                            int profileId = -1;
                                            PreparedStatement ps1 = conn.prepareStatement("SELECT id FROM candidate_profiles WHERE user_id = ?");
                                            ps1.setInt(1, userId);
                                            ResultSet rs1 = ps1.executeQuery();
                                            if (rs1.next()) {
                                                profileId = rs1.getInt("id");
                                            }
                                            rs1.close();
                                            ps1.close();

                                            // 
                                            String sql = "SELECT cc.*, jp.title AS job_title, jp.location AS job_location, "
                                                    + "CASE WHEN a.id IS NOT NULL THEN 1 ELSE 0 END AS is_used "
                                                    + "FROM candidate_cvs cc "
                                                    + "LEFT JOIN applications a ON cc.id = a.candidate_cv_id "
                                                    + "LEFT JOIN job_postings jp ON a.job_posting_id = jp.id "
                                                    + "WHERE cc.candidate_profile_id = ?";

                                            PreparedStatement ps2 = conn.prepareStatement(sql);
                                            ps2.setInt(1, profileId);
                                            ResultSet rs2 = ps2.executeQuery();


                                        %>

                                        <div class="row gx-4 gy-4">
                                            <% while (rs2.next()) {
                                                    boolean isUsed = rs2.getInt("is_used") == 1;
                                            %>

                                            <div class="col-xl-4 col-lg-4 col-md-6">
                                                <div class="cd-resume-wraps position-relative">
                                                    <div class="cd-resume-cancel">
                                                        <% if (isUsed) {%>

                                                        <a class="btn btn-md btn-secondary px-3 me-2 disabled">
                                                            <i class="fa-solid fa-xmark"></i>
                                                        </a>
                                                        <a href="<%= rs2.getString("cv_url")%>" target="_blank" class="btn btn-md btn-light-primary px-3">
                                                            <i class="fa-solid fa-eye"></i>
                                                        </a>

                                                        <div class="cd-resume-caption">
                                                            <div class="cd-resume-content">
                                                                <p><%= rs2.getString("cv_name")%></p>
                                                                <a class="text-danger mt-2">
                                                                    Please found this company in Applied jobs to delete CV:
                                                                    <%= rs2.getString("job_title") != null ? rs2.getString("job_title") : "Job N/A"%>,
                                                                    <%= rs2.getString("job_location") != null ? rs2.getString("job_location") : "Location N/A"%>
                                                                </a>
                                                            </div>
                                                            <div class="cd-resume-icon">
                                                                <i class="fa-solid fa-file-pdf text-danger"></i>
                                                            </div>
                                                        </div>
                                                        <% } else {%>

                                                        <a href="DeleteCVServlet?id=<%= rs2.getInt("id")%>" class="btn btn-md btn-light-danger px-3 me-2">
                                                            <i class="fa-solid fa-xmark"></i>
                                                        </a>
                                                        <a href="<%= rs2.getString("cv_url")%>" target="_blank" class="btn btn-md btn-light-primary px-3">
                                                            <i class="fa-solid fa-eye"></i>
                                                        </a>
                                                        <div class="cd-resume-caption">
                                                            <div class="cd-resume-content">
                                                                <p><%= rs2.getString("cv_name")%></p>
                                                                <h5>Uploaded</h5>
                                                            </div>
                                                            <div class="cd-resume-icon">
                                                                <i class="fa-solid fa-file-pdf text-danger"></i>
                                                            </div>
                                                        </div>
                                                        <% }%>

                                                    </div>

                                                </div>
                                            </div>
                                            <% }
                                                rs2.close();
                                                ps2.close();
                                                conn.close();%>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <ul class="nav nav-tabs mb-3" id="resumeTabs" role="tablist">                               
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="system-cv-tab" data-bs-toggle="tab" data-bs-target="#system-cv" type="button" role="tab">System CVs</button>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-pane fade show active" id="system-cv" role="tabpanel">
                                <div class="row gx-4 gy-4">
                                    <%

                                        Connection connSys = new DBContext().getConnection();

                                        PreparedStatement psSys = connSys.prepareStatement(
                                                "SELECT sc.*, jp.title AS job_title, jp.location AS job_location, "
                                                + "CASE WHEN a.id IS NOT NULL THEN 1 ELSE 0 END AS is_used "
                                                + "FROM system_cvs sc "
                                                + "LEFT JOIN applications a ON sc.id = a.system_cv_id "
                                                + "LEFT JOIN job_postings jp ON a.job_posting_id = jp.id "
                                                + "WHERE sc.user_id = ?"
                                        );
                                        psSys.setInt(1, user.getId());
                                        ResultSet rsSys = psSys.executeQuery();

                                        while (rsSys.next()) {
                                            boolean isUsed = rsSys.getInt("is_used") == 1;
                                    %>
                                    <div class="col-xl-4 col-lg-4 col-md-6">
                                        <div class="cd-resume-wraps position-relative">
                                            <div class="jbs-list-head-last">
                                                <% if (isUsed) {%>
                                                <a class="btn btn-md btn-secondary px-3 me-2 disabled">
                                                    <i class="fa-solid fa-xmark"></i>
                                                </a>
                                                <a class="btn btn-md btn-secondary px-3 me-2 disabled">
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </a>
                                                <div class="cd-resume-caption">
                                                    <div class="cd-resume-content">
                                                        <p><%= rsSys.getString("fullname")%> - <%= rsSys.getString("jobtitle")%></p>
                                                        <a class="text-danger mt-2">
                                                            Please found this company in Applied jobs to delete CV:
                                                            <%= rsSys.getString("job_title") != null ? rsSys.getString("job_title") : "Job N/A"%>,
                                                            <%= rsSys.getString("job_location") != null ? rsSys.getString("job_location") : "Location N/A"%>
                                                        </a>
                                                    </div>
                                                    <div class="cd-resume-icon">
                                                        <i class="fa-solid fa-file-pdf text-primary"></i>
                                                    </div>
                                                </div>
                                                <% } else {%>
                                                <a href="DeleteSystemCVServlet?id=<%= rsSys.getInt("id")%>"
                                                   class="btn btn-md btn-light-danger px-3 me-2">
                                                    <i class="fa-solid fa-xmark"></i>
                                                </a>
                                                <a href="EditSystemCVServlet?id=<%= rsSys.getInt("id")%>"
                                                   class="btn btn-md btn-light-warning px-3 ms-2">
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </a>
                                                <div class="cd-resume-caption">
                                                    <div class="cd-resume-content">
                                                        <p><%= rsSys.getString("fullname")%> - <%= rsSys.getString("jobtitle")%></p>
                                                        <h5>System CV</h5>
                                                    </div>
                                                    <div class="cd-resume-icon">
                                                        <i class="fa-solid fa-file-pdf text-primary"></i>
                                                    </div>
                                                </div>
                                                <% }%>
                                            </div>

                                        </div>
                                    </div>
                                    <%
                                        }
                                        rsSys.close();
                                        psSys.close();
                                        connSys.close();
                                    %>
                                </div>
                            </div>                       

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
            <!-- ======================= dashboard Detail End ======================== -->


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

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/candidate-resume.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:38 GMT -->
</html>