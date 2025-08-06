<%@page import="connectDB.DBContext"%>
<%@page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<<%@page import="model.User"%>  
<!doctype html>
<html lang="en">

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:57:49 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>TechSign - Responsive Job Portal Bootstrap Template | ThemezHub</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">

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
            <!-- ============================================================== -->
            <!-- Top header  -->
            <!-- ============================================================== -->

            <!-- ============================ Header Top Start================================== -->
            <section class="bg-cover bg-dark position-relative py-4">
                <div class="position-absolute end-0 top-0 bottom-0 d-lg-block d-none">
                    <img src="assets/img/banner-1.jpg" class="img-fluid rounded-start-pill h-100" alt="">
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-xl-6 col-lg-9 col-md-12">
                            <div class="jbs-head-bodys-top my-5">
                                <div class="jbs-roots-y1 flex-column justify-content-start align-items-start">
                                    <div class="jbs-roots-y1-last">
                                        <div class="jbs-urt mb-2">
                                            <span class="label text-light primary-2-bg">${job.jobType}</span>
                                        </div>
                                        <div class="jbs-title-iop mb-1">
                                            <h2 class="m-0 fs-2 text-light">${job.title}</h2>
                                        </div>
                                    </div>
                                    <div class="jbs-roots-y6 py-3">
                                        <p class="text-light">${job.description}</p>
                                    </div>
                                    <div class="jbs-roots-y6 py-3">
                                        <p class="text-light">We are looking for a experienced Senior Front-End Developer with an advanced level of english to design UI/UX interface for web and mobile apps.</p>
                                    </div>
                                    <div class="jbs-roots-y6 py-3">
                                        <c:choose>
                                            <c:when test="${sessionScope.user == null}">
                                                <!-- user not access -->

                                                <a data-bs-toggle="modal" data-bs-target="#login" class="btn btn-primary fw-medium px-lg-5 px-4 me-3">Apply Job</a>
                                                <a data-bs-toggle="modal" data-bs-target="#login" class="btn btn-whites fw-medium px-lg-5 px-4">Save Job</a>
                                            </c:when>

                                            <c:otherwise>
                                                <!-- Đã đăng nhập -->
                                                <input type="hidden" name="jobId" value="${job.id}"/>



                                                <!-- ========== APPLY JOB ========== -->

                                                <c:choose>

                                                    <c:when test="${applied}">
                                                        <button class="btn btn-secondary fw-medium px-lg-5 px-4 me-3"
                                                                type="button" disabled>
                                                            Waiting from Company
                                                        </button>
                                                    </c:when>

                                                    <c:when test="${job.status == 'Closed'}">
                                                        <button class="btn btn-danger fw-medium px-lg-5 px-4 me-3" type="button" disabled>Closed</button>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <button class="btn btn-primary fw-medium px-lg-5 px-4 me-3"
                                                                type="button" data-bs-toggle="modal" data-bs-target="#applyjob">
                                                            Apply Job
                                                        </button>
                                                    </c:otherwise>

                                                </c:choose>

                                                <!-- SAVE JOB (Form riêng) -->
                                                <form method="post" action="SaveJobServlet" style="display:inline;">
                                                    <input type="hidden" name="jobId" value="${job.id}" />
                                                    <c:choose>
                                                        <c:when test="${saved}">
                                                            <button class="btn btn-secondary fw-medium px-lg-5 px-4" type="button" disabled>Saved Job</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="btn btn-outline-primary fw-medium px-lg-5 px-4" type="submit">Save Job</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>   

                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <div class="explot-info-details d-inline-flex flex-wrap">
                        <div class="single-explot d-flex align-items-center me-md-5 me-3 my-2">
                            <div class="single-explot-first">
                                <i class="fa-solid fa-business-time text-primary fs-1"></i>
                            </div>
                            <div class="single-explot-last ps-2">
                                <span class="text-light opacity-75">Department</span>
                                <p class="text-light fw-bold fs-6 m-0">Software</p>
                            </div>
                        </div>
                        <div class="single-explot d-flex align-items-center me-md-5 me-3 my-2">
                            <div class="single-explot-first">
                                <i class="fa-solid fa-location-dot text-primary fs-1"></i>
                            </div>
                            <div class="single-explot-last ps-2">
                                <span class="text-light opacity-75">Location</span>                            
                                <p class="text-light fw-bold fs-6 m-0">${job.location}</p>
                            </div>
                        </div>
                        <div class="single-explot d-flex align-items-center">
                            <div class="single-explot-first">
                                <i class="fa-solid fa-sack-dollar text-primary fs-1"></i>
                            </div>
                            <div class="single-explot-last ps-2">
                                <span class="text-light opacity-75">Salary</span>
                                <p class="text-light fw-bold fs-6 m-0">
                                    <fmt:formatNumber value="${job.salaryMin}" type="number" maxFractionDigits="0" /><a>$</a> -
                                    <fmt:formatNumber value="${job.salaryMax}" type="number" maxFractionDigits="0" /><a>$</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <!-- ============================ Header Top End ================================== -->

        <!-- ================================  Job Detail ========================== -->
        <section class="gray-simple">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-md-12">

                        <div class="jbs-blocs style_03 b-0 mb-md-4 mb-sm-4">
                            <div class="jbs-blocs-body px-4 py-4">
                                <div class="jbs-content mb-4">
                                    <h5>Job Description</h5>
                                    <p>Themezhub Web provides equal employment opportunities to all qualified individuals without regard to race, color, religion, sex, gender identity, sexual orientation, pregnancy, age, national origin, physical or mental disability, military or veteran status, genetic information, or any other protected classification. Equal employment opportunity includes, but is not limited to, hiring, training, promotion, demotion, transfer, leaves of absence, and termination. Thynk Web takes allegations of discrimination, harassment, and retaliation seriously, and will promptly investigate when such behavior is reported.</p>
                                    <p>Our company is seeking to hire a skilled Web Developer to help with the development of our current projects. Your duties will primarily revolve around building software by writing code, as well as modifying software to fix errors, adapt it to new hardware, improve its performance, or upgrade interfaces. You will also be involved in directing system testing and validation procedures, and also working with customers or departments on technical issues including software system design and maintenance.</p>
                                    <p class="m-0">We are looking for a Senior Web Developer to build and maintain functional web pages and applications. Senior Web Developer will be leading junior developers, refining website specifications, and resolving technical issues. He/She should have extensive experience building web pages from scratch and in-depth knowledge of at least one of the following programming languages: Javascript, Ruby, or PHP. He/She will ensure our web pages are up and running and cover both internal and customer needs.</p>
                                </div>
                                <div class="jbs-content-body mb-4">
                                    <h5 class="mb-3">Job Requirements</h5>
                                    <div class="jbs-content mb-3">
                                        <h6>Requirements:</h6>
                                        <ul class="simple-list">
                                            <li>Candidate must have a Bachelors or Masters degree in Computer. (B.tech, Bsc or BCA/MCA)</li>
                                            <li>Candidate must have a good working knowledge of Javascript and Jquery.</li>
                                            <li>Good knowledge of HTML and CSS is required.</li>
                                            <li>Experience in Word press is an advantage</li>
                                            <li>Jamshedpur, Jharkhand: Reliably commute or planning to relocate before starting work (Required)</li>
                                        </ul>
                                    </div>

                                    <div class="jbs-content mb-4">
                                        <h6>Responsibilities:</h6>
                                        <ul class="simple-list">
                                            <li>Write clean, maintainable and efficient code.</li>
                                            <li>Design robust, scalable and secure features.</li>
                                            <li>Collaborate with team members to develop and ship web applications within tight timeframes.</li>
                                            <li>Work on bug fixing, identifying performance issues and improving application performance</li>
                                            <li>Write unit and functional testcases.</li>
                                            <li>Continuously discover, evaluate, and implement new technologies to maximise development efficiency. Handling complex technical iss</li>
                                        </ul>
                                    </div>

                                    <div class="jbs-content">
                                        <h6>Qualifications and Skills</h6>
                                        <ul class="colored-list">
                                            <li>Bachelor's degree</li>
                                            <li>BCA/MCA</li>
                                            <li>BSC IT/Msc IT</li>
                                            <li>Or any other equivalent degree</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="jbs-blox-footer">
                                <div class="blox-first-footer">
                                    <div class="ftr-share-block">
                                        <ul>
                                            <li><strong>Share This Job:</strong></li>
                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-facebook"></i></a></li>
                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-linkedin"></i></a></li>
                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-google-plus"></i></a></li>
                                            <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-twitter"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <%
                        Connection conn = new connectDB.DBContext().getConnection();
                        User user = (User) session.getAttribute("user");

                        int userId = -1;
                        int profileId = -1;

                        ResultSet rsCandidateCV = null;
                        ResultSet rsSystemCV = null;

                        if (user != null) {
                            userId = user.getId();

                            // Lấy profileId
                            String sqlProfile = "SELECT id FROM candidate_profiles WHERE user_id = ?";
                            PreparedStatement psProfile = conn.prepareStatement(sqlProfile);
                            psProfile.setInt(1, userId);
                            ResultSet rsProfile = psProfile.executeQuery();
                            if (rsProfile.next()) {
                                profileId = rsProfile.getInt("id");
                            }
                            rsProfile.close();
                            psProfile.close();

                            // Lấy Candidate CVs
                            String sqlCandidateCV = "SELECT * FROM candidate_cvs WHERE candidate_profile_id = ?";
                            PreparedStatement psCandidateCV = conn.prepareStatement(sqlCandidateCV);
                            psCandidateCV.setInt(1, profileId);
                            rsCandidateCV = psCandidateCV.executeQuery();

                            // Lấy System CVs
                            String sqlSystemCV = "SELECT * FROM system_cvs WHERE user_id = ?";
                            PreparedStatement psSystemCV = conn.prepareStatement(sqlSystemCV);
                            psSystemCV.setInt(1, userId);
                            rsSystemCV = psSystemCV.executeQuery();
                        }
                    %>
                    <!-- Apply Job Modal -->
                    <div class="modal fade" id="applyjob" tabindex="-1" role="dialog" aria-labelledby="applyjobs" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered applyjob-pop-form" role="document">
                            <div class="modal-content" id="applyjobs">
                                <span class="mod-close" data-bs-dismiss="modal" aria-hidden="true"><i class="fas fa-close"></i></span>

                                <div class="modal-body">
                                    <div class="detail-side-heads mb-2 mt-4">
                                        <h3>Ready To Apply?</h3>
                                    </div>

                                    <% if (user != null) { %>
                                    <form action="UploadCVforjobdetailServlet" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="jobId" value="${job.id}" />

                                        <div class="detail-side-middle">
                                            <!-- Cover Letter -->
                                            <h6>Why do you want to join my company? (optional):</h6>
                                            <div class="form-floating mb-3">
                                                <input type="text" name="coverLetter" class="form-control">
                                            </div>

                                            <!-- Option select -->
                                            <div class="form-group mb-3">
                                                <label><strong>Select how you want to apply:</strong></label><br>
                                                <input type="radio" name="applyOption" id="uploadOption" value="upload" checked onclick="toggleApplyOption()"> Upload new Resume
                                                &nbsp;&nbsp;
                                                <input type="radio" name="applyOption" id="selectOption" value="select" onclick="toggleApplyOption()"> Use existing CV
                                            </div>

                                            <!-- Upload file -->
                                            <div id="uploadSection">
                                                <div class="upload-btn-wrapper full-width mb-2">
                                                    <button id="uploadBtn" type="button" class="btn full-width"
                                                            onclick="document.getElementById('resumeFile').click();">
                                                        Upload Resume
                                                    </button>
                                                    <input type="file" name="resumeFile" id="resumeFile" accept="application/pdf" style="display:none;"
                                                           onchange="displayFileName()">
                                                </div>

                                                <p id="fileName" style="margin-top: 10px; color: #333;"></p>
                                                <iframe id="pdfPreview"
                                                        style="width:100%; height:400px; display:none; border:1px solid #ccc;"></iframe>
                                                <p id="fileError" style="color: red; display: none;">Please upload a PDF file only.</p>
                                            </div>

                                            <!-- Select CV -->
                                            <div id="selectSection" style="display:none;">
                                                <label><strong>Select which CV to use:</strong></label><br>

                                                <!-- Candidate CV -->
                                                <div id="candidateBlock">
                                                    <input type="radio" name="cvChoice" value="candidate" checked onclick="toggleCVSelect()">
                                                    Your Candidate CV
                                                    <select name="candidateCvId" id="candidateCvSelect" class="form-control mb-3">
                                                        <option value="">-- Choose your uploaded CV --</option>
                                                        <% if (rsCandidateCV != null) {
                          while (rsCandidateCV.next()) {%>
                                                        <option value="<%= rsCandidateCV.getInt("id")%>">
                                                            <%= rsCandidateCV.getString("cv_name")%>
                                                        </option>
                                                        <% }
                      } %>
                                                    </select>
                                                </div>

                                                <!-- System CV -->
                                                <div id="systemBlock">
                                                    <input type="radio" name="cvChoice" value="system" onclick="toggleCVSelect()">
                                                    Or System CV
                                                    <select name="systemCvId" id="systemCvSelect" class="form-control">
                                                        <option value="">-- Choose your system CV --</option>
                                                        <% if (rsSystemCV != null) {
                          while (rsSystemCV.next()) {%>
                                                        <option value="<%= rsSystemCV.getInt("id")%>">
                                                            <%= rsSystemCV.getString("fullname")%> - <%= rsSystemCV.getString("jobtitle")%>
                                                        </option>
                                                        <% }
                      } %>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group mt-3">
                                                <button type="submit" class="btn btn-primary full-width fw-medium font-sm">Submit Application</button>
                                            </div>
                                        </div>
                                    </form>

                                    <% } else { %>
                                    <!-- Nếu chưa login -->
                                    <div class="alert alert-warning">
                                        Please <a href="login.jsp" class="text-primary">login</a> to apply for this job.
                                    </div>
                                    <% } %>
                                </div>

                                <div class="modal-footer">
                                    <p>Don't have an account yet?<a href="signup.jsp" class="text-primary font--bold ms-1">Sign Up</a></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <% conn.close(); %>
                    <!-- End Modal -->

                    <div class="col-lg-4 col-md-12">


                        <div class="side-jbs-info-blox bg-white mb-4">
                            <div class="side-jbs-info-header">
                                <div class="side-jbs-info-thumbs">
                                    <figure><img src="assets/img/l-12.png" class="img-fluid" alt=""></figure>
                                </div>
                                <div class="side-jbs-info-captionyo ps-3">
                                    <div class="sld-info-title">
                                        <h5 class="rtls-title mb-1">Google Inc.</h5>
                                        <div class="jbs-locat-oiu text-sm-muted">
                                            <span class="me-1"><i class="fa-solid fa-location-dot me-1"></i>California, USA</span>.<span class="ms-1">Software & Consultancy</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="side-jbs-info-middle">
                                <div class="side-full-info-groups">
                                    <div class="single-side-info">
                                        <span class="text-sm-muted sld-subtitle">Company Founder:</span>
                                        <h6 class="sld-title">Mr. Daniel Mark</h6>
                                    </div>
                                    <div class="single-side-info">
                                        <span class="text-sm-muted sld-subtitle">Industry:</span>
                                        <h6 class="sld-title">Technology</h6>
                                    </div>
                                    <div class="single-side-info">
                                        <span class="text-sm-muted sld-subtitle">Founded:</span>
                                        <h6 class="sld-title">1997</h6>
                                    </div>
                                    <div class="single-side-info">
                                        <span class="text-sm-muted sld-subtitle">Head Office:</span>
                                        <h6 class="sld-title">London, UK</h6>
                                    </div>
                                    <div class="single-side-info">
                                        <span class="text-sm-muted sld-subtitle">Revenue</span>
                                        <h6 class="sld-title">$70B+</h6>
                                    </div>
                                    <div class="single-side-info">
                                        <span class="text-sm-muted sld-subtitle">Company Size:</span>
                                        <h6 class="sld-title">20,000+ Emp.</h6>
                                    </div>
                                    <div class="single-side-info">
                                        <span class="text-sm-muted sld-subtitle">Min Exp.</span>
                                        <h6 class="sld-title">02 Years</h6>
                                    </div>
                                    <div class="single-side-info">
                                        <span class="text-sm-muted sld-subtitle">Openings</span>
                                        <h6 class="sld-title">06 Openings</h6>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="side-rtl-jbs-block">



                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>

<div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="loginmodal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered login-pop-form" role="document">
        <div class="modal-content" id="loginmodal">
            <span class="mod-close" data-bs-dismiss="modal" aria-hidden="true"><i class="fas fa-close"></i></span>
            <div class="modal-header">
                <div class="mdl-thumb">
                    <img src="assets/img/ico.png" class="img-fluid" width="70" alt="">
                </div>
                <div class="mdl-title">
                    <h4 class="modal-header-title">Hello, Again</h4>
                </div>
            </div>
            <div class="modal-body">
                <% if (request.getAttribute("error") != null) {%>
                <div class="alert alert-danger">
                    <%= request.getAttribute("error")%>
                </div>
                <% }%>
                <div class="modal-login-form">
                    <form action="${pageContext.request.contextPath}/LoginServlet" method="POST">
                        <div class="form-floating mb-4">
                            <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                            <label>Email</label>
                        </div>
                        <div class="form-floating mb-4">
                            <input type="password" name="password" class="form-control" placeholder="Password" required>
                            <label>Password</label>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary full-width font--bold btn-lg">Log In</button>
                        </div>
                        <div class="modal-flex-item mb-3">
                            <div class="modal-flex-first">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="checkbox" name="rem" id="savepassword" value="on">
                                    <label class="form-check-label" for="savepassword">Save Password</label>
                                </div>
                            </div>
                            <div class="modal-flex-last">
                                <a href="JavaScript:Void(0);">Forget Password?</a>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Social login with Google centered and styled -->
                <div class="social-login mt-3">
                    <ul class="list-unstyled d-flex justify-content-center mb-0">
                        <li><a href="https://accounts.google.com/o/oauth2/v2/auth?scope=email%20profile&access_type=online&include_granted_scopes=true&response_type=code&redirect_uri=http://localhost:8080/JobSearchManagement/LoginGoogleHandler&client_id=662818990560-8t0tkh07kp0kktc2mk7177k5gj8dvkdn.apps.googleusercontent.com">Login With Google
                            </a>
                            "JavaScript:Void(0);" class="btn connect-google">
                            <i class="fa-brands fa-google"></i> Google+
                            </a>
                        </li>
                    </ul>
                </div>

            </div>
            <div class="modal-footer">
                <p>Don't have an account yet?
                    <a href="${pageContext.request.contextPath}/SignupServlet" class="text-primary font--bold ms-1">Sign Up</a>
                </p>
            </div>
        </div>
    </div>
</div>

<footer class="footer skin-light-footer">

    <div>
        <div class="container">
            <div class="row">

                <div class="col-lg-3 col-md-4">
                    <div class="footer-widget">
                        <img src="assets/img/logo.png" class="img-footer" alt="">
                        <div class="footer-add">
                            <p>Collins Street West, Victoria Near Bank Road<br>Australia QHR12456.</p>
                        </div>
                        <div class="foot-socials">
                            <ul>
                                <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-facebook"></i></a></li>
                                <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-linkedin"></i></a></li>
                                <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-google-plus"></i></a></li>
                                <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-twitter"></i></a></li>
                                <li><a href="JavaScript:Void(0);"><i class="fa-brands fa-dribbble"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>		
                <div class="col-lg-2 col-md-4">
                    <div class="footer-widget">
                        <h4 class="widget-title text-primary">For Clients</h4>
                        <ul class="footer-menu">
                            <li><a href="JavaScript:Void(0);">Talent Marketplace</a></li>
                            <li><a href="JavaScript:Void(0);">Payroll Services</a></li>
                            <li><a href="JavaScript:Void(0);">Direct Contracts</a></li>
                            <li><a href="JavaScript:Void(0);">Hire Worldwide</a></li>
                            <li><a href="JavaScript:Void(0);">Hire in the USA</a></li>
                            <li><a href="JavaScript:Void(0);">How to Hire</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-2 col-md-4">
                    <div class="footer-widget">
                        <h4 class="widget-title text-primary">Our Resources</h4>
                        <ul class="footer-menu">
                            <li><a href="JavaScript:Void(0);">Free Business tools</a></li>
                            <li><a href="JavaScript:Void(0);">Affiliate Program</a></li>
                            <li><a href="JavaScript:Void(0);">Success Stories</a></li>
                            <li><a href="JavaScript:Void(0);">Upwork Reviews</a></li>
                            <li><a href="JavaScript:Void(0);">Resources</a></li>
                            <li><a href="JavaScript:Void(0);">Help & Support</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-2 col-md-6">
                    <div class="footer-widget">
                        <h4 class="widget-title text-primary">The Company</h4>
                        <ul class="footer-menu">
                            <li><a href="JavaScript:Void(0);">About Us</a></li>
                            <li><a href="JavaScript:Void(0);">Leadership</a></li>
                            <li><a href="JavaScript:Void(0);">Contact Us</a></li>
                            <li><a href="JavaScript:Void(0);">Investor Relations</a></li>
                            <li><a href="JavaScript:Void(0);">Trust, Safety & Security</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="footer-widget">
                        <h4 class="widget-title text-primary">Download Apps</h4>	
                        <div class="app-wrap">
                            <p><a href="JavaScript:Void(0);"><img src="assets/img/light-play.png" class="img-fluid" alt=""></a></p>
                            <p><a href="JavaScript:Void(0);"><img src="assets/img/light-ios.png" class="img-fluid" alt=""></a></p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <div class="container">
            <div class="row align-items-center justify-content-center">

                <div class="col-xl-12 col-lg-12 col-md-12">
                    <p class="mb-0 text-center">© 2015 - 2023 Job Stock® Themezhub.</p>
                </div>

            </div>
        </div>
    </div>              
</footer>
<a id="back2Top" class="top-scroll" title="Back to top" href="#"><i class="ti-arrow-up"></i></a>


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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/reviewbeforeupload.js"></script>
<script src="assets/js/custom.js"></script>
<script src="assets/js/cl-switch.js"></script>
<!-- ============================================================== -->
<!-- This page plugins -->
<!-- ============================================================== -->

</body>

</html>