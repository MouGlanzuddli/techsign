<!doctype html>
<html lang="en">
	
<!-- Mirrored from shreethemes.net/jobstock-landing-2.2/jobstock/candidate-dashboard.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 06 Jun 2024 11:59:16 GMT -->
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
													<div class="ntf-list-groups-caption"><p class="small"><strong>Kr. Shaury Preet</strong> Replied Your Message</p></div>
												</div>
												<div class="ntf-list-groups-single">
													<div class="ntf-list-groups-icon text-warning"><i class="fa-solid fa-envelope"></i></div>
													<div class="ntf-list-groups-caption"><p class="small">Mortin Denver Accepted Your Resume <strong class="text-success">On Job Stock</strong></p></div>
												</div>
												<div class="ntf-list-groups-single">
													<div class="ntf-list-groups-icon text-success"><i class="fa-solid fa-sack-dollar"></i></div>
													<div class="ntf-list-groups-caption"><p class="small">Your Job #456256 Expired Yesterday <strong>View job</strong></p></div>
												</div>
												<div class="ntf-list-groups-single">
													<div class="ntf-list-groups-icon text-danger"><i class="fa-solid fa-comments"></i></div>
													<div class="ntf-list-groups-caption"><p class="small"><strong>Daniel kurwa</strong> Has Been Approved Your Resume!.</p></div>
												</div>
												<div class="ntf-list-groups-single">
													<div class="ntf-list-groups-icon text-info"><i class="fa-solid fa-circle-dollar-to-slot"></i></div>
													<div class="ntf-list-groups-caption"><p class="small">Khushi Verma Left A Review On <strong class="text-danger">Your Message</strong></p></div>
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
												<h4>Hi, Dhananjay</h4>
												<div class="drp_menu_headr-right"><button type="button" class="btn btn-whites">Logout</button></div>
											</div>
											<ul>
												<li><a href="candidate-dashboard.html"><i class="fa fa-tachometer-alt"></i>Dashboard<span class="notti_coun style-1">4</span></a></li>                                  
												<li><a href="candidate-profile.html"><i class="fa fa-user-tie"></i>My Profile</a></li>                                 
												<li><a href="candidate-resume.html"><i class="fa fa-file"></i>My Resume<span class="notti_coun style-2">7</span></a></li>
												<li><a href="candidate-saved-jobs.html"><i class="fa-solid fa-bookmark"></i>Saved Resume</a></li>
												<li><a href="candidate-messages.html"><i class="fa fa-envelope"></i>Messages<span class="notti_coun style-3">3</span></a></li>
												<li><a href="candidate-change-password.html"><i class="fa fa-unlock-alt"></i>Change Password</a></li>
												<li><a href="candidate-delete-account.html"><i class="fa-solid fa-trash-can"></i>Delete Account</a></li>
											</ul>
										</div>
									</div>
								</li>
							</ul>
						</div>
						<div class="nav-menus-wrapper">
                                                    <ul class="nav-menu">
                                                        <li class="active"><a href="JavaScript:Void(0);">Home<span class="submenu-indicator"></span></a></li>
                                                        <li><a href="JavaScript:Void(0);">Jobs<span class="submenu-indicator"></span></a>
                                                            <ul class="nav-dropdown nav-submenu">
                                                                <li><a href="JobListServlet">Job List</a></li>

                                                            </ul>
                                                        </li>
                                                        <li><a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
                                                            <ul class="nav-dropdown nav-submenu">
                                                                <li><a href="CompanyListServlet">Company List</a></li>
                                                            </ul>
                                                        </li>
                                                        <li><a href="JavaScript:Void(0);">Candidates<span class="submenu-indicator"></span></a>
                                                            <ul class="nav-dropdown nav-submenu">
                                                                <li><a href="${pageContext.request.contextPath}/company-candidate-list.jsp">Candidate List</a></li>


                                                            </ul>
                                                        </li>

                                                    </ul>
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
													<div class="ntf-list-groups-icon text-purple"><i class="fa-solid fa-house-medical-circle-check"></i></div>
													<div class="ntf-list-groups-caption"><p class="small"><strong>Kr. Shaury Preet</strong> Replied Your Message</p></div>
												</div>
												<div class="ntf-list-groups-single">
													<div class="ntf-list-groups-icon text-warning"><i class="fa-solid fa-envelope"></i></div>
													<div class="ntf-list-groups-caption"><p class="small">Mortin Denver Accepted Your Resume <strong class="text-success">On Job Stock</strong></p></div>
												</div>
												<div class="ntf-list-groups-single">
													<div class="ntf-list-groups-icon text-success"><i class="fa-solid fa-sack-dollar"></i></div>
													<div class="ntf-list-groups-caption"><p class="small">Your Job #456256 Expired Yesterday <strong>View job</strong></p></div>
												</div>
												<div class="ntf-list-groups-single">
													<div class="ntf-list-groups-icon text-danger"><i class="fa-solid fa-comments"></i></div>
													<div class="ntf-list-groups-caption"><p class="small"><strong>Daniel kurwa</strong> Has Been Approved Your Resume!.</p></div>
												</div>
												<div class="ntf-list-groups-single">
													<div class="ntf-list-groups-icon text-info"><i class="fa-solid fa-circle-dollar-to-slot"></i></div>
													<div class="ntf-list-groups-caption"><p class="small">Khushi Verma Left A Review On <strong class="text-danger">Your Message</strong></p></div>
												</div>
												<div class="ntf-list-groups-single">
													<a href="#" class="ntf-more">View All Notifications</a>
												</div>
											</div>
										</div>
									</div>
								</li>
								
								<li class="list-buttons ms-2">
									<a href="employer-submit-job.html"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Post Job</a>
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
									<img src="${avatarUrl}" class="img-fluid circle" alt="">
								</div>
							</div>
							<div class="jbs-grid-usrs-caption mb-3">
								
								<div class="jbs-tiosk">
									<h4 class="jbs-tiosk-title"><a href="candidate-detail.html">${fullName}</a></h4>
									<div class="jbs-tiosk-subtitle"><span>${jobTitle}</span></div>
								</div>
							</div>
						</div>
						<div class="dashboard-inner">
							<ul data-submenu-title="Main Navigation">
								<li class="active"><a href="CompanyDashboardServlet"><i class="fa-solid fa-gauge-high me-2"></i>User Dashboard</a></li>
								<li><a href="CompanyProfilesServlet"><i class="fa-regular fa-user me-2"></i>Company Profile </a></li>
								<li><a href="employer-jobs.html"><i class="fa-solid fa-business-time me-2"></i>My Jobs</a></li>
								<li><a href="employer-submit-job.html"><i class="fa-solid fa-pen-ruler me-2"></i>Submit Jobs</a></li>
								<li><a href="employer-applicants-jobs.html"><i class="fa-solid fa-user-group me-2"></i>Applicants Jobs</a></li>
								<li><a href="employer-shortlist-candidates.html"><i class="fa-solid fa-user-clock me-2"></i>Shortlisted Candidates</a></li>
								<li><a href="employer-package.html"><i class="fa-solid fa-wallet me-2"></i>Package</a></li>
								<li><a href="employer-messages.html"><i class="fa-solid fa-comments me-2"></i>Messages</a></li>
								<li><a href="ChangepasswordServlet"><i class="fa-solid fa-unlock-keyhole me-2"></i>Change Password</a></li>
								<li><a href="#" data-bs-toggle="modal" data-bs-target="#deleteAccountModal"><i class="fa-solid fa-trash-can me-2"></i>Delete Account</a></li>
                                                                
								<li><a href="LogoutServlet">
									<i class="fa-solid fa-power-off"></i> Log Out
								</a></li>
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
											<h5 class="ctr"></h5>
											<p>Applications</p>
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
											<h5 class="ctr"></h5>
											<p>Post Jobs</p>
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
											<h5 class="ctr"></h5>
											<p>Notifications</p>
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
							<div class="py-3 text-center">? 2015 - 2023 Job Stock? Themezhub.</div>
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
		<!-- Modal xác nh?n xóa tài kho?n -->
		<div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
			  <div class="modal-header">
				<h5 class="modal-title" id="deleteAccountModalLabel">Confirm Account Deletion</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			  </div>
			  <div class="modal-body">
				Are you sure you want to delete your account? This action cannot be undone!
			  </div>
			  <div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				<form action="DeleteCompanyAccount" method="post" style="display:inline;">
				  <button type="submit" class="btn btn-danger">Confirm</button>
				</form>
			  </div>
			</div>
		  </div>
		</div>
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