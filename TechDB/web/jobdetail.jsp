<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="en">

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:57:49 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>TechSign - Responsive Job Portal Bootstrap Template | ThemezHub</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">

        <!-- Colors CSS -->
        <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">

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

                                <li class="active"><a href="JavaScript:Void(0);">Home<span class="submenu-indicator"></span></a>

                                </li>

                                <li><a href="">Jobs<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="SearchandView">Job List<span class="submenu-indicator"></span></a>	
                                        </li>


                                    </ul>
                                </li>

                                <li><a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="dm.jsp">Company list<span class="submenu-indicator"></span></a>

                                        </li>

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
                                    <a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login"><i class="fas fa-sign-in-alt me-2"></i>Sign In</a>
                                </li>
                                <li class="list-buttons ms-2">
                                    <a href="signup.html"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Upload Resume</a>
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
                                        <div class="jbs-locat-oiu text-sm-muted text-light d-flex align-items-center">
                                            <span><i class="fa-solid fa-location-dot opacity-75 me-1"></i>${job.location}</span>
                                        </div>
                                    </div>
                                    <div class="jbs-roots-y6 py-3">
                                        <p class="text-light">${job.description}</p>
                                    </div>
                                    <div class="jbs-roots-y6 py-3">
                                        <p class="text-light">We are looking for a experienced Senior Front-End Developer with an advanced level of english to design UI/UX interface for web and mobile apps.</p>
                                    </div>
                                    <div class="jbs-roots-y6 py-3">
                                        <button class="btn btn-primary fw-medium px-lg-5 px-4 me-3" type="button" data-bs-toggle="modal" data-bs-target="#applyjob">Apply Job</button>
                                        <button class="btn btn-whites fw-medium px-lg-5 px-4" type="button">Save job</button>
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

                    <!-- Apply Job Modal -->
                    <div class="modal fade" id="applyjob" tabindex="-1" role="dialog" aria-labelledby="applyjobs" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered applyjob-pop-form" role="document">
                            <div class="modal-content" id="applyjobs">
                                <span class="mod-close" data-bs-dismiss="modal" aria-hidden="true"><i class="fas fa-close"></i></span>
                                <div class="modal-body">
                                    <div class="detail-side-heads mb-2 mt-4">
                                        <h3>Ready To Apply?</h3>
                                        <p>Complete the eligibities checklist now and get started with your online application</p>
                                    </div>
                                    <form action="UploadServlet" method="post" enctype="multipart/form-data">
                                    <div class="detail-side-middle">
                                        <div class="form-floating mb-3">
                                            <input ttype="text" name="name" class="form-control" required>
                                            <label>Name:</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input type="text"  name="email" class="form-control" required>
                                            <label>Email:</label>
                                        </div>
                                        <div class="form-group">
                                            <div class="upload-btn-wrapper full-width">
                                                <button class="btn full-width">Upload Resume</button>
                                                <input type="file" name="cv"" id="resumeFile" onchange="displayFileName()">                        
                                            </div>
                                            <p id="fileName" style="margin-top: 10px; color: #333;"></p>
                                        </div>
                                        <div class="form-group">
                                            <div class="elsoci"><label>Are you authorised to work in India?</label></div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workindia" id="wyes" value="option1">
                                                <label class="form-check-label" for="wyes">Yes</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workindia" id="wno" value="option1">
                                                <label class="form-check-label" for="wno">No</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="elsoci"><label>Do you have master degree?</label></div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="degree" id="dyed" value="option1">
                                                <label class="form-check-label" for="dyed">Yes</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="degree" id="dno" value="option1">
                                                <label class="form-check-label" for="dno">No</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="jobalert" value="option1">
                                                <label class="form-check-label" for="jobalert">Create Job Alert</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <button type="submit" value="SubmitApplication" class="btn btn-primary full-width fw-medium font-sm">Submit Application</button>
                                        </div>
                                    </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <p>Don't have an account yet?<a href="signup.html" class="text-primary font--bold ms-1">Sign Up</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Modal -->

                    <div class="col-lg-4 col-md-12">
                        <div class="detail-side-block bg-white mb-4">
                            <div class="detail-side-heads mb-2">
                                <h3>Ready To Apply?</h3>
                                <p>Complete the eligibities checklist now and get started with your online application</p>
                            </div>
                            <div class="detail-side-middle">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" placeholder="">
                                    <label>Name:</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" placeholder="">
                                    <label>Email:</label>
                                </div>
                                <div class="form-group">
                                    <div class="upload-btn-wrapper full-width">
                                        <button class="btn full-width">Upload Resume</button>
                                        <input type="file" name="myfile">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="elsoci"><label>Are you authorised to work in India?</label></div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="workindia" id="wyes" value="option1">
                                        <label class="form-check-label" for="wyes">Yes</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="workindia" id="wno" value="option1">
                                        <label class="form-check-label" for="wno">No</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="elsoci"><label>Do you have master degree?</label></div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="degree" id="dyed" value="option1">
                                        <label class="form-check-label" for="dyed">Yes</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="degree" id="dno" value="option1">
                                        <label class="form-check-label" for="dno">No</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" id="jobalert" value="option1">
                                        <label class="form-check-label" for="jobalert">Create Job Alert</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="button" class="btn btn-primary full-width fw-medium font-sm">Submit Application</button>
                                </div>
                            </div>
                        </div>

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
                            <div class="side-rtl-jbs-head">
                                <h5 class="side-jbs-titles">Related Jobs</h5>
                            </div>
                            <div class="side-rtl-jbs-body">
                                <div class="side-rtl-jbs-groups">

                                    <div class="single-side-rtl-jbs">
                                        <div class="single-fliox">
                                            <div class="single-rtl-jbs-thumb">
                                                <a href="job-detail.html"><figure><img src="assets/img/l-1.png" class="img-fluid" alt=""></figure></a>
                                            </div>
                                            <div class="single-rtl-jbs-caption">
                                                <div class="hjs-rtls-titles">
                                                    <div class="jbs-types mb-1"><span class="label text-success bg-light-success">Full Time</span></div>
                                                    <h5 class="rtls-title"><a href="joob-detail.html">Sr. Front-end Designer</a></h5>
                                                    <div class="jbs-locat-oiu text-sm-muted">
                                                        <span><i class="fa-solid fa-location-dot me-1"></i>California, USA</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="single-rtl-jbs-hot">
                                            <div class="single-tag-rtls"><span class="label text-warning bg-light-warning"><i class="fa-brands fa-hotjar me-1"></i>New</span></div>
                                            <div class="single-tag-rtls"><span class="label text-success bg-light-success"><i class="fa-solid fa-star me-1"></i>Featured</span></div>
                                        </div>
                                    </div>

                                    <div class="single-side-rtl-jbs">
                                        <div class="single-fliox">
                                            <div class="single-rtl-jbs-thumb">
                                                <a href="job-detail.html"><figure><img src="assets/img/l-2.png" class="img-fluid" alt=""></figure></a>
                                            </div>
                                            <div class="single-rtl-jbs-caption">
                                                <div class="hjs-rtls-titles">
                                                    <div class="jbs-types mb-1"><span class="label text-success bg-light-success">Full Time</span></div>
                                                    <h5 class="rtls-title"><a href="joob-detail.html">Jr. PHP Developer</a></h5>
                                                    <div class="jbs-locat-oiu text-sm-muted">
                                                        <span><i class="fa-solid fa-location-dot me-1"></i>Canada, USA</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="single-rtl-jbs-hot">
                                            <div class="single-tag-rtls"><span class="label text-success bg-light-success"><i class="fa-solid fa-star me-1"></i>Featured</span></div>
                                        </div>
                                    </div>

                                    <div class="single-side-rtl-jbs">
                                        <div class="single-fliox">
                                            <div class="single-rtl-jbs-thumb">
                                                <a href="job-detail.html"><figure><img src="assets/img/l-3.png" class="img-fluid" alt=""></figure></a>
                                            </div>
                                            <div class="single-rtl-jbs-caption">
                                                <div class="hjs-rtls-titles">
                                                    <div class="jbs-types mb-1"><span class="label text-danger bg-light-danger">Internship</span></div>
                                                    <h5 class="rtls-title"><a href="joob-detail.html">Project Manager For PHP</a></h5>
                                                    <div class="jbs-locat-oiu text-sm-muted">
                                                        <span><i class="fa-solid fa-location-dot me-1"></i>Liverpool, UK</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="single-rtl-jbs-hot">
                                            <div class="single-tag-rtls"><span class="label text-warning bg-light-warning"><i class="fa-brands fa-hotjar me-1"></i>New</span></div>
                                            <div class="single-tag-rtls"><span class="label text-success bg-light-success"><i class="fa-solid fa-star me-1"></i>Featured</span></div>
                                        </div>
                                    </div>

                                    <div class="single-side-rtl-jbs">
                                        <div class="single-fliox">
                                            <div class="single-rtl-jbs-thumb">
                                                <a href="job-detail.html"><figure><img src="assets/img/l-5.png" class="img-fluid" alt=""></figure></a>
                                            </div>
                                            <div class="single-rtl-jbs-caption">
                                                <div class="hjs-rtls-titles">
                                                    <div class="jbs-types mb-1"><span class="label text-warning bg-light-warning">Full Time</span></div>
                                                    <h5 class="rtls-title"><a href="joob-detail.html">Sr. Magento Developer 2.0</a></h5>
                                                    <div class="jbs-locat-oiu text-sm-muted">
                                                        <span><i class="fa-solid fa-location-dot me-1"></i>California, USA</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="single-rtl-jbs-hot">
                                            <div class="single-tag-rtls"><span class="label text-success bg-light-success"><i class="fa-solid fa-star me-1"></i>Featured</span></div>
                                        </div>
                                    </div>

                                    <div class="single-side-rtl-jbs">
                                        <div class="single-fliox">
                                            <div class="single-rtl-jbs-thumb">
                                                <a href="job-detail.html"><figure><img src="assets/img/l-6.png" class="img-fluid" alt=""></figure></a>
                                            </div>
                                            <div class="single-rtl-jbs-caption">
                                                <div class="hjs-rtls-titles">
                                                    <div class="jbs-types mb-1"><span class="label text-danger bg-light-danger">Internship</span></div>
                                                    <h5 class="rtls-title"><a href="joob-detail.html">Shopify Developer Fresher</a></h5>
                                                    <div class="jbs-locat-oiu text-sm-muted">
                                                        <span><i class="fa-solid fa-location-dot me-1"></i>New York, USA</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="single-rtl-jbs-hot">
                                            <div class="single-tag-rtls"><span class="label text-warning bg-light-warning"><i class="fa-brands fa-hotjar me-1"></i>New</span></div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </section>
        <!-- =============================== Job Detail ================================== -->



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
        <script>
            function displayFileName() {
                const input = document.getElementById('resumeFile');
                const fileNameDisplay = document.getElementById('fileName');
                if (input.files.length > 0) {
                    fileNameDisplay.textContent = "Selected file: " + input.files[0].name;
                } else {
                    fileNameDisplay.textContent = "";
                }
            }
        </script>
        <script src="assets/js/custom.js"></script><script src="assets/js/cl-switch.js"></script>
        <!-- ============================================================== -->
        <!-- This page plugins -->
        <!-- ============================================================== -->

    </body>

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/job-detail.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:32 GMT -->
</html>