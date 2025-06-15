<!doctype html>
<html lang="en">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

    <!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/full-job-grid-1.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:58:57 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>TechSign - Responsive Job Portal Bootstrap Template | ThemezHub</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">

        <!-- Custom CSS -->
        <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">

        <!-- Colors CSS -->
        <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">       
    </head>

    <body class="green-theme">

        <!-- Main Wrapper -->

        <div id="main-wrapper">
            <!-- Top Header -->
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
                                <li class="active"><a href="index.jsp;">Home<span class="submenu-indicator"></span></a></li>
                                <li><a href="JavaScript:Void(0);">Jobs<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="JavaScript:Void(0);">Job List</a></li>
                                    </ul>
                                </li>
                                <li><a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="JavaScript:Void(0);">Company List</a></li>
                                    </ul>
                                </li>
                                <li><a href="JavaScript:Void(0);">Pages<span class="submenu-indicator"></span></a>
                                    <ul class="nav-dropdown nav-submenu">
                                        <li><a href="about-us.html">About Us</a></li>
                                        <li><a href="404.html">Error Page</a></li>
                                        <li><a href="checkout.html">Checkout</a></li>
                                        <li><a href="blog.html">Blogs Page</a></li>
                                        <li><a href="blog-detail.html">Blog Detail</a></li>
                                        <li><a href="privacy.html">Terms & Privacy</a></li>
                                        <li><a href="pricing.html">Pricing</a></li>
                                        <li><a href="faq.html">FAQ's</a></li>
                                        <li><a href="contact.html">Contacts</a></li>
                                    </ul>
                                </li>
                                <li><a href="#">Help</a></li>
                            </ul>
                            <ul class="nav-menu nav-menu-social align-to-right">
                                <li><a href="JavaScript:Void(0);" data-bs-toggle="modal" data-bs-target="#login"><i class="fas fa-sign-in-alt me-2"></i>Sign In</a></li>
                                <li class="list-buttons ms-2"><a href="signup.html"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Upload Resume</a></li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
            <div class="clearfix"></div>
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
								<li class="active"><a href="candidate-dashboard.html"><i class="fa-solid fa-gauge-high me-2"></i>User Dashboard</a></li>
								<li><a href="candidate-profile.html"><i class="fa-regular fa-user me-2"></i>My Profile </a></li>
								<li><a href="candidate-resume.html"><i class="fa-solid fa-file-pdf me-2"></i>My Resumes</a></li>
								<li><a href="candidate-applied-jobs.html"><i class="fa-regular fa-paper-plane me-2"></i>Applied jobs</a></li>
								<li><a href="candidate-alert-job.html"><i class="fa-solid fa-bell me-2"></i>Alert Jobs<span class="count-tag bg-warning">4</span></a></li>
								<li><a href="candidatesavejob.jsp"><i class="fa-solid fa-bookmark me-2"></i>Shortlist Jobs</a></li>
								<li><a href="cFe.jsp"><i class="fa-solid fa-user-clock me-2"></i>Favorite Employers</a></li>
								<li><a href="candidate-messages.html"><i class="fa-solid fa-comments me-2"></i>Messages<span class="count-tag">4</span></a></li>
								<li><a href="candidate-change-password.html"><i class="fa-solid fa-unlock-keyhole me-2"></i>Change Password</a></li>
								<li><a href="candidate-delete-account.html"><i class="fa-solid fa-trash-can me-2"></i>Delete Account</a></li>
								<li><a href="index.html"><i class="fa-solid fa-power-off me-2"></i>Log Out</a></li>
							</ul>
						</div>					
					</div>
				</div>
				
				<div class="dashboard-content">
					<div class="dashboard-tlbar d-block mb-5">
						<div class="row">
							<div class="colxl-12 col-lg-12 col-md-12">
								<h1 class="mb-1 fs-3 fw-medium">Candidate Dashboard</h1>
								<nav aria-label="breadcrumb">
									<ol class="breadcrumb">
										<li class="breadcrumb-item text-muted"><a href="#">Candidate</a></li>
										<li class="breadcrumb-item text-muted"><a href="#">Dashboard</a></li>
										<li class="breadcrumb-item"><a href="#" class="text-primary">Candidate Statistics</a></li>
									</ol>
								</nav>
							</div>
						</div>
					</div>
					
					<div class="dashboard-widg-bar d-block">
						
						<!-- Row Start -->
						<div class="row align-items-center gx-4 gy-4 mb-4">
							<div class="col-xl-3 col-lg-6 col-md-6 col-sm-6">
								<div class="dash-wrap-bloud">
									<div class="dash-wrap-bloud-icon">
										<div class="bloud-icon text-success bg-light-success">
											<i class="fa-solid fa-business-time"></i>	
										</div>
									</div>
									<div class="dash-wrap-bloud-caption">
										<div class="dash-wrap-bloud-content">
											<h5 class="ctr">523</h5>
											<p>Applied jobs</p>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-lg-6 col-md-6 col-sm-6">
								<div class="dash-wrap-bloud">
									<div class="dash-wrap-bloud-icon">
										<div class="bloud-icon text-warning bg-light-warning">
											<i class="fa-solid fa-bookmark"></i>	
										</div>
									</div>
									<div class="dash-wrap-bloud-caption">
										<div class="dash-wrap-bloud-content">
											<h5 class="ctr">523</h5>
											<p>Saved Jobs</p>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-lg-6 col-md-6 col-sm-6">
								<div class="dash-wrap-bloud">
									<div class="dash-wrap-bloud-icon">
										<div class="bloud-icon text-danger bg-light-danger">
											<i class="fa-solid fa-eye"></i>
										</div>
									</div>
									<div class="dash-wrap-bloud-caption">
										<div class="dash-wrap-bloud-content">
											<h5 class="ctr">523</h5>
											<p>Viewed Jobs</p>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-3 col-lg-6 col-md-6 col-sm-6">
								<div class="dash-wrap-bloud">
									<div class="dash-wrap-bloud-icon">
										<div class="bloud-icon text-info bg-light-info">
											<i class="fa-sharp fa-solid fa-comments"></i>
										</div>
									</div>
									<div class="dash-wrap-bloud-caption">
										<div class="dash-wrap-bloud-content">
											<h5 class="ctr">523</h5>
											<p>Total Review</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- Row End -->
						
						<!-- Row Start -->
						<div class="row gx-4 gy-4 mb-4">
							<div class="col-xl-8 col-lg-12 col-md-12 col-sm-12">
								<div class="card d-none d-lg-block">
									<div class="card-header">
										<h4 class="mb-0">Extra Area Chart</h4>
									</div>
									<div class="card-body">
										<ul class="list-inline text-center m-t-40">
											<li>
												<h5><i class="fa fa-circle me-1 text-warning"></i>Applied jobs</h5>
											</li>
											<li>
												<h5><i class="fa fa-circle me-1 text-danger"></i>Viewed Jobs</h5>
											</li>
											<li>
												<h5><i class="fa fa-circle me-1 text-success"></i>Saved jobs</h5>
											</li>
										</ul>
										<div class="chart full-width" id="line-chart" style="height:300px;"></div>
									</div>
								</div>
							</div>
							
							<div class="col-xl-4 col-lg-12 col-md-12 col-sm-12">
								<div class="card">
									<div class="card-header">
										<h4>Notifications</h4>
									</div>
									<div class="ground-list ground-list-hove">
										<div class="ground ground-single-list">
											<a href="JavaScript:Void(0);">
												<div class="btn-circle-40 text-warning bg-light-warning"><i class="fas fa-home"></i></div>
											</a>

											<div class="ground-content">
												<h6><a href="JavaScript:Void(0);"><strong>Kr. Shaury Preet</strong> Replied your message</a></h6>
												<span class="small">Just Now</span>
											</div>
										</div>
										
										<div class="ground ground-single-list">
											<a href="JavaScript:Void(0);">
												<div class="btn-circle-40 text-danger bg-light-danger"><i class="fa-solid fa-comments"></i></div>
											</a>

											<div class="ground-content">
												<h6><a href="JavaScript:Void(0);">Mortin Denver accepted your resume on <strong>Job Stock</strong></a></h6>
												<span class="small">20 min ago</span>
											</div>
										</div>
										
										<div class="ground ground-single-list">
											<a href="JavaScript:Void(0);">
												<div class="btn-circle-40 text-info bg-light-info"><i class="fa-solid fa-heart"></i></div>
											</a>

											<div class="ground-content">
												<h6><a href="JavaScript:Void(0);">Your job #456256 expired yesterday <strong>View More</strong></a></h6>
												<span class="small">1 day ago</span>
											</div>
										</div>
										
										<div class="ground ground-single-list">
											<a href="JavaScript:Void(0);">
												<div class="btn-circle-40 text-danger bg-light-danger"><i class="fa-solid fa-thumbs-up"></i></div>
											</a>

											<div class="ground-content">
												<h6><a href="JavaScript:Void(0);"><strong>Daniel Kurwa</strong> has been approved your resume!.</a></h6>
												<span class="small">10 days ago</span>
											</div>
										</div>
										
										<div class="ground ground-single-list">
											<a href="JavaScript:Void(0);">
												<div class="btn-circle-40 text-success bg-light-success"><i class="fa-solid fa-comment-dots"></i></div>
											</a>

											<div class="ground-content">
												<h6><a href="JavaScript:Void(0);">Khushi Verma left a review on <strong>Your Message</strong></a></h6>
												<span class="small">Just Now</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- Row End -->
						
						<!-- Row Start -->
						<div class="row">
							<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
								<div class="card">
									<div class="card-header">
										<h4 class="mb-0">Shortlisted Jobs</h4>
									</div>
									<div class="card-body px-4 py-4">
										<!-- Start All List -->
										<div class="row justify-content-start gx-3 gy-4">
									
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb jbs-verified"><a href="job-detail.html"><figure><img src="assets/img/l-1.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Full Time</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">Product Designer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Tripadvisor</span>.<span><i class="fa-solid fa-location-dot me-1"></i>California</span>.<span>07 Apr 2023</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$85K - 95K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb"><a href="job-detail.html"><figure><img src="assets/img/l-2.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Full Time</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">Product Designer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Pinterest</span>.<span><i class="fa-solid fa-location-dot me-1"></i>Allahabad</span>.<span>2 Apr 2023</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$90K - 100K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb"><a href="job-detail.html"><figure><img src="assets/img/l-3.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Full Time</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">Product Designer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Shopify</span>.<span><i class="fa-solid fa-location-dot me-1"></i>Canada, USA</span>.<span>15 March 2023</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$90K - 115K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb jbs-verified"><a href="job-detail.html"><figure><img src="assets/img/l-4.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Full Time</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">Jr. Laravel Developer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Dreezoo</span>.<span><i class="fa-solid fa-location-dot me-1"></i>Liverpool, UK</span>.<span>20 March 2023</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$85K - 110K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb"><a href="job-detail.html"><figure><img src="assets/img/l-5.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Enternship</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">Java & Python Developer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Photoshop</span>.<span><i class="fa-solid fa-location-dot me-1"></i>California</span>.<span>20 Feb 2023</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$90K - 120K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb"><a href="job-detail.html"><figure><img src="assets/img/l-6.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Full Time</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">Sr. Code Ignetor Developer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Firefox</span>.<span><i class="fa-solid fa-location-dot me-1"></i>Canada, USA</span>.<span>18 Feb 2023</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$80K - 90K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb"><a href="job-detail.html"><figure><img src="assets/img/l-7.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Part Time</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">Sr. Magento Developer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Airbnb</span>.<span><i class="fa-solid fa-location-dot me-1"></i>London, UK</span>.<span>15 Feb 2023</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$75K - 85K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb jbs-verified"><a href="job-detail.html"><figure><img src="assets/img/l-8.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Full Time</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">New Shopify Developer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Snapchat</span>.<span><i class="fa-solid fa-location-dot me-1"></i>Denver, USA</span>.<span>15 Feb 2023</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$70K - 95K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb"><a href="job-detail.html"><figure><img src="assets/img/l-9.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Full Time</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">Front-end Developer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Dribbble</span>.<span><i class="fa-solid fa-location-dot me-1"></i>New York, USA</span>.<span>7 March 2023</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$60K - 70K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
											<!-- Single Item -->
											<div class="col-xl-12 col-lg-12 col-md-12">
												<div class="jbs-list-box border">
													<div class="jbs-list-head">
														<div class="jbs-list-head-thunner">
															<div class="jbs-list-emp-thumb jbs-verified"><a href="job-detail.html"><figure><img src="assets/img/l-10.png" class="img-fluid" alt=""></figure></a></div>
															<div class="jbs-list-job-caption">
																<div class="jbs-job-types-wrap"><span class="label text-success bg-light-success">Full Time</span></div>
																<div class="jbs-job-title-wrap"><h4><a href="job-detail.html" class="jbs-job-title">Technical Content Writer</a></h4></div>
																<div class="jbs-job-mrch-lists">
																	<div class="single-mrch-lists">
																		<span>Skype</span>.<span><i class="fa-solid fa-location-dot me-1"></i>Canada, USA</span>.<span>10 March 2022</span>
																	</div>
																</div>
															</div>
														</div>
														<div class="jbs-list-head-middle">
															<div class="elsocrio-jbs"><div class="ilop-tr"><i class="fa-solid fa-sack-dollar"></i></div><h5 class="jbs-list-pack">$80K - 100K<span class="patype">\PA</span></h5></div>
														</div>
														<div class="jbs-list-head-last">
															<a href="job-detail.html" class="btn btn-md btn-outline-secondary px-3 me-2">View Detail</a>
															<a href="JavaScript:Void(0);" class="btn btn-md btn-primary px-3">Quick Apply</a>
														</div>
													</div>
												</div>
											</div>
											
										</div>
										<!-- End All Job List -->
									</div>
								</div>
							</div>
						</div>
						<!-- Row End -->
	
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
		
		<!-- Morris.js charts -->
		<script src="assets/js/raphael/raphael.min.js"></script>
		<script src="assets/js/morris.js/morris.min.js"></script>
		<!-- Custom Chart JavaScript -->
		<script src="assets/js/custom/dashboard.js"></script>
		<!-- ============================================================== -->
		<!-- This page plugins -->
		<!-- ============================================================== -->

	</body>

<!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/candidate-dashboard.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:19 GMT -->
</html>