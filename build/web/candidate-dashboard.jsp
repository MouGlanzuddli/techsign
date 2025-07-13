<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Candidate Profile</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
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
								
							</ul>
						</div>
						<div class="nav-menus-wrapper">
							<ul class="nav-menu">
							
								<li class="active"><a href="JavaScript:Void(0);">Home<span class="submenu-indicator"></span></a>
									<ul class="nav-dropdown nav-submenu">
										<li><a class="active" href="index.html">Home Layout</a></li>
										
									</ul>
								</li>
								
								<li><a href="JavaScript:Void(0);">For Candidate<span class="submenu-indicator"></span></a>
									<ul class="nav-dropdown nav-submenu">
										
										<li>
											<a href="candidate-dashboard.html">Candidate Dashboard<span class="new-update">New</span></a>                                
										</li>
									</ul>
								</li>
								
								<li><a href="JavaScript:Void(0);">Company<span class="submenu-indicator"></span></a>
									<ul class="nav-dropdown nav-submenu">
										
										<li>
											<a href="employer-dashboard.html">Company Dashboard<span class="new-update">New</span></a>                                
										</li>
									</ul>
								</li>
								
								<li><a href="JavaScript:Void(0);">Pages<span class="submenu-indicator"></span></a>
									<ul class="nav-dropdown nav-submenu">
										<li><a href="about-us.html">About Us</a></li> 
										
										<li><a href="contact.html">Contacts</a></li>
									</ul>
								</li>
								
								<li><a href="#">Help</a></li>
								
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
									<a href="candidate-detail.html"><figure><img src="assets/img/team-2.jpg" class="img-fluid circle" alt=""></figure></a>
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
								<li><a href="UpdateCandidateProfile"><i class="fa-solid fa-gauge-high me-2"></i>Dashboard</a></li>
								<li class="active"><a href="UpdateCandidateProfile"><i class="fa-regular fa-user me-2"></i>My Profile </a></li>
								<li><a href="candidate-resume.html"><i class="fa-solid fa-file-pdf me-2"></i>My CV</a></li>
								<li><a href="candidate-applied-jobs.html"><i class="fa-regular fa-paper-plane me-2"></i>Applied jobs</a></li>
								<li><a href="candidate-alert-job.html"><i class="fa-solid fa-bell me-2"></i>Alert Jobs<span class="count-tag bg-warning">4</span></a></li>
								<li><a href="candidate-saved-jobs.html"><i class="fa-solid fa-bookmark me-2"></i>Shortlist Jobs</a></li>
								<li><a href="candidate-follow-employers.html"><i class="fa-solid fa-user-clock me-2"></i>Following Company</a></li>
								<li><a href="candidate-messages.html"><i class="fa-solid fa-comments me-2"></i>Messages<span class="count-tag">4</span></a></li>
								<li><a href="candidate-change-password.html"><i class="fa-solid fa-unlock-keyhole me-2"></i>Change Password</a></li>
								<li><a href="#" data-bs-toggle="modal" data-bs-target="#deleteAccountModal"><i class="fa-solid fa-trash-can me-2"></i>Delete Account</a></li>
								<li><a href="LogoutServlet">
									<i class="fa-solid fa-power-off"></i> Log Out
								</a></li>
							</ul>
						</div>					
					</div>
				</div>
				
				<div class="dashboard-content">
					<div class="dashboard-tlbar d-block mb-4">
						<div class="row">
							<div class="colxl-12 col-lg-12 col-md-12">
								<h1 class="mb-1 fs-3 fw-medium">Candidate Profile</h1>
								
							</div>
						</div>
					</div>
					
					<div class="dashboard-widg-bar d-block">
					
						<div class="dashboard-profle-wrapper mb-4">
							<div class="dash-prf-start">
								<div class="dash-prf-start-upper">
									<div class="dash-prf-start-thumb">
										<figure><img src="assets/img/team-1.jpg" class="img-fluid circle" alt=""></figure>
									</div>
								</div>
								<div class="dash-prf-start-bottom">
									<div class="upload-btn-wrapper small">
										<button class="btn">Change Avatar</button>
										<input type="file" name="myfile">
									</div>
								</div>
							</div>
							<div class="dash-prf-end">
                                                            <div class="dash-prfs-caption emplyer">
								<div class="dash-prfs-caption">
									<div class="dash-prfs-title">
										<h4>${fullName}</h4>
									</div>
									<div class="dash-prfs-subtitle">
										<div class="jbs-job-mrch-lists">
											<div class="single-mrch-lists">
												<span>${jobTitle}</span> · <span><i class="fa-solid fa-location-dot me-1"></i>${address}</span>
											</div>
										</div>
									</div>
									
								</div>
                                                                <div class="dash-prfs-flexends">
									<form action="ToggleCandidateProfileVisibility" method="post" style="display:inline;">
									<input type="hidden" name="toggle" value="1" />
										<div class="form-check form-switch">
											<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" name="isSearchable" value="on" <%= (request.getAttribute("isSearchable") != null && (Boolean)request.getAttribute("isSearchable")) ? "checked" : "" %> onchange="this.form.submit();">
										<label class="form-check-label" for="flexSwitchCheckChecked">Allow search and view my profile</label>
										</div>	
									</form>
								</div> 
                                                            </div>
								<div class="dash-prf-caption-end">
									<div class="dash-prf-infos">
										<div class="single-dash-prf-infos">
											<div class="single-dash-prf-infos-icons"><i class="fa-solid fa-envelope-open-text"></i></div>
											<div class="single-dash-prf-infos-caption">
												<p class="text-sm-muted mb-0">Email</p>
												<h5>${email}</h5>
											</div>
										</div>
										<div class="single-dash-prf-infos">
											<div class="single-dash-prf-infos-icons"><i class="fa-solid fa-phone-volume"></i></div>
											<div class="single-dash-prf-infos-caption">
												<p class="text-sm-muted mb-0">Call</p>
												<h5>${phone}</h5>
											</div>
										</div>
										<div class="single-dash-prf-infos">
											<div class="single-dash-prf-infos-icons"><i class="fa-solid fa-briefcase"></i></div>
											<div class="single-dash-prf-infos-caption">
												<p class="text-sm-muted mb-0">Exp.</p>
												<h5>${experienceYears} Years</h5>
											</div>
										</div>
									</div>
									<div class="dash-prf-completion">
										<p class="text-sm-muted">Profile Completed</p>
										<div class="progress" role="progressbar" aria-label="Example Success with label" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
											<div class="progress-bar bg-success" style="width: 75%">75%</div>
										</div>
									</div>
								</div>
							</div>
						
						</div>
						
						<!-- Card Row -->
						<div class="card">
							<div class="card-header">
								<h4>My Profile</h4>
							</div>
							<div class="card-body">
								<% if (request.getAttribute("error") != null) { %>
									<div class="alert alert-danger" style="margin: 1px;">
										${error}
									</div>
								<% } %>
								<% if (request.getAttribute("success") != null) { %>
									<div class="alert alert-success" style="margin: 1px;">
										${success}
									</div>
								<% } %>
								<script>
								function validateProfileForm() {
									// Không chặn submit, chỉ rely vào backend để hiển thị lỗi
									return true;
								}
								</script>
								<form action="UpdateCandidateProfile" method="post" onsubmit="return validateProfileForm()">
									<div class="row">
									
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Your Name</label>
												<input type="text" class="form-control" name="candidateName" value="${fullName}" required>
											</div>
										</div>
										
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Job Title</label>
												<input type="text" class="form-control" name="jobTitle" value="${jobTitle}">
											</div>
										</div>
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Email</label>
												<input type="email" class="form-control" name="email" value="${email}" required>
											</div>
										</div>
										
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Phone Number</label>
												<input type="text" class="form-control" name="phone" value="${phoneInput != null ? phoneInput : phone}">
											</div>
										</div>
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Experience</label>
												<div class="select-ops">
													<select name="experienceYears">
														<option value="0" ${experienceYears == 0 ? 'selected' : ''}>Fresher</option>
														<option value="1" ${experienceYears == 1 ? 'selected' : ''}>1+ Year</option>
														<option value="5" ${experienceYears == 5 ? 'selected' : ''}>5+ Years</option>
														<option value="15" ${experienceYears == 15 ? 'selected' : ''}>10+ Years</option>
													</select>
												</div>
											</div>
										</div>
										
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Education</label>
												<div class="select-ops">
													<select name="educationLevel">
														<option value="High School" ${educationLevel == 'High School' ? 'selected' : ''}>High School</option>
														<option value="Intermediate" ${educationLevel == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
														<option value="Bachelor Degree" ${educationLevel == 'Bachelor Degree' ? 'selected' : ''}>Bachelor Degree</option>
														<option value="Master Degree" ${educationLevel == 'Master Degree' ? 'selected' : ''}>Master Degree</option>
														<option value="Post Graduate" ${educationLevel == 'Post Graduate' ? 'selected' : ''}>Post Graduate</option>
														<option value="PhD" ${educationLevel == 'PhD' ? 'selected' : ''}>PhD</option>
													</select>
												</div>
											</div>
										</div>
										
										<div class="col-xl-12 col-lg-12 col-md-12">
											<div class="form-group">
												<label>Address</label>
												<input type="text" class="form-control" name="address" value="${address}" required>
											</div>
										</div>
										
									</div>
									<div class="row">
										<div class="col-xl-12 col-lg-6 col-md-12">
											<button type="submit" class="btn ft--medium btn-primary">Update Profile</button>
										</div>
									</div>
								</form>
							</div>
						</div>
						<!-- Card Row End -->
						
						
						
					</div>
					
					<!-- footer -->
					<div class="row">
						<div class="col-md-12">
							<div class="py-1 text-center" style="font-size:10px; padding-top:2px; padding-bottom:2px;">© Job Stock® Themezhub.</div>
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
		<!-- ============================================================== -->
		<!-- This page plugins -->
		<!-- ============================================================== -->

		<!-- Modal xác nhận xóa tài khoản -->
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
				<form action="DeleteCandidateAccount" method="post" style="display:inline;">
				  <button type="submit" class="btn btn-danger">Confirm</button>
				</form>
			  </div>
			</div>
		  </div>
		</div>

	</body>
</html> 