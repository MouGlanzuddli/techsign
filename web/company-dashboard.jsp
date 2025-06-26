<%
    String companyName = request.getAttribute("companyName") != null ? (String)request.getAttribute("companyName") : "";
    String email = request.getAttribute("email") != null ? (String)request.getAttribute("email") : "";
    String phone = request.getAttribute("phone") != null ? (String)request.getAttribute("phone") : "";
    String website = request.getAttribute("website") != null ? (String)request.getAttribute("website") : "";
    Integer industryId = request.getAttribute("industryId") != null ? (Integer)request.getAttribute("industryId") : null;
    String address = request.getAttribute("address") != null ? (String)request.getAttribute("address") : "";
    String avatarUrl = request.getAttribute("avatarUrl") != null ? (String)request.getAttribute("avatarUrl") : "assets/img/default-avatar.png";
    String[] industries = {"", "Web & Application", "Banking Services", "UI/UX Design", "IOS/App Application", "Education"};
    String industryName = (industryId != null && industryId > 0 && industryId < industries.length) ? industries[industryId] : "";
    boolean missingInfo = companyName.trim().isEmpty() || email.trim().isEmpty() || phone.trim().isEmpty() || website.trim().isEmpty() || industryName.trim().isEmpty() || address.trim().isEmpty();
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Company Profile</title>
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
								
								<li><a href="JavaScript:Void(0);">Candidate<span class="submenu-indicator"></span></a>
									<ul class="nav-dropdown nav-submenu">
										
										<li><a href="advance-search.html">Advance Search</a></li>
										<li>
											<a href="candidate-dashboard.html">Candidate Dashboard<span class="new-update">New</span></a>                                
										</li>
									</ul>
								</li>
								
								<li><a href="JavaScript:Void(0);">Employer<span class="submenu-indicator"></span></a>
									<ul class="nav-dropdown nav-submenu">
										
										<li>
											<a href="employer-dashboard.html">Employer Dashboard<span class="new-update">New</span></a>                                
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
									<a href="candidate-detail.html"><figure><img src="<%= avatarUrl %>" class="img-fluid rounded" alt=""></figure></a>
								</div>
							</div>
							<div class="jbs-grid-usrs-caption mb-3">
								<div class="jbs-kioyer">
									<span class="label text-light theme-bg">05 Openings</span>
								</div>
								<div class="jbs-tiosk">
									<h4 class="jbs-tiosk-title"><%= companyName %></h4>
									<div class="jbs-tiosk-subtitle"><span><i class="fa-solid fa-location-dot me-2"></i><%= address %></span></div>
								</div>
							</div>
						</div>
						<div class="dashboard-inner">
							<ul data-submenu-title="Main Navigation">
								<li><a href="employer-dashboard.html"><i class="fa-solid fa-gauge-high me-2"></i>User Dashboard</a></li>
								<li class="active"><a href="employer-profile.html"><i class="fa-regular fa-user me-2"></i>My Profile </a></li>
								<li><a href="employer-jobs.html"><i class="fa-solid fa-business-time me-2"></i>My Jobs</a></li>
								<li><a href="employer-submit-job.html"><i class="fa-solid fa-pen-ruler me-2"></i>Submit Jobs</a></li>
								<li><a href="employer-applicants-jobs.html"><i class="fa-solid fa-user-group me-2"></i>Applicants Jobs</a></li>
								<li><a href="employer-shortlist-candidates.html"><i class="fa-solid fa-user-clock me-2"></i>Shortlisted Candidates</a></li>
								<li><a href="employer-package.html"><i class="fa-solid fa-wallet me-2"></i>Package</a></li>
								<li><a href="employer-messages.html"><i class="fa-solid fa-comments me-2"></i>Messages</a></li>
								<li><a href="employer-change-password.html"><i class="fa-solid fa-unlock-keyhole me-2"></i>Change Password</a></li>
								<li><a href="employer-delete-account.html"><i class="fa-solid fa-trash-can me-2"></i>Delete Account</a></li>
								<li><a href="index.html"><i class="fa-solid fa-power-off me-2"></i>Log Out</a></li>
							</ul>
						</div>					
					</div>
				</div>
				
				<div class="dashboard-content">
					<div class="dashboard-tlbar d-block mb-4">
						<div class="row">
							<div class="colxl-12 col-lg-12 col-md-12">
								<h1 class="mb-1 fs-3 fw-medium">Update Profile</h1>
							</div>
						</div>
					</div>
					
					<div class="dashboard-widg-bar d-block">
					
						<div class="dashboard-profle-wrapper mb-4">
							<div class="dash-prf-start">
								<div class="dash-prf-start-upper mb-2">
									<div class="dash-prf-start-thumb jbs-verified">
										<figure class="mb-0"><img src="<%= avatarUrl %>" class="img-fluid rounded" alt=""></figure>
									</div>
								</div>
								<div class="dash-prf-start-bottom">
									<div class="upload-btn-wrapper small">
										<button class="btn">Change Profile</button>
										<input type="file" name="myfile">
									</div>
								</div>
							</div>
							<div class="dash-prf-end">
								<div class="dash-prfs-caption emplyer">
									<div class="dash-prfs-flexfirst">
										<div class="dash-prfs-title">
											<h4><%= companyName %></h4>	
										</div>
										<div class="dash-prfs-subtitle">
											<div class="jbs-job-mrch-lists">
												<div class="single-mrch-lists">
													<span><%= industryName %></span>.<span><i class="fa-solid fa-location-dot me-1"></i><%= address %></span>
												</div>
											</div>
										</div>
										<div class="jbs-kioyer mt-1">
											<div class="jbs-kioyer-groups justify-content-start">
												<span class="fa-solid fa-star active"></span>
												<span class="fa-solid fa-star active"></span>
												<span class="fa-solid fa-star active"></span>
												<span class="fa-solid fa-star active"></span>
												<span class="fa-solid fa-star"></span>
												<span class="aal-reveis">4.8</span>
											</div>
										</div>
									</div>
									<div class="dash-prfs-flexends">
										<div class="form-check form-switch">
											<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" checked>
											<label class="form-check-label" for="flexSwitchCheckChecked">Show Profile</label>
										</div>	
									</div>
								</div>
								<div class="dash-prf-caption-end">
									<div class="dash-prf-infos">
										<div class="single-dash-prf-infos">
											<div class="single-dash-prf-infos-icons"><i class="fa-solid fa-envelope-open-text"></i></div>
											<div class="single-dash-prf-infos-caption">
												<p class="text-sm-muted mb-0">Email</p>
												<h5><%= email %></h5>
											</div>
										</div>
										<div class="single-dash-prf-infos">
											<div class="single-dash-prf-infos-icons"><i class="fa-solid fa-phone-volume"></i></div>
											<div class="single-dash-prf-infos-caption">
												<p class="text-sm-muted mb-0">Call</p>
												<h5><%= request.getAttribute("phoneTop") != null ? request.getAttribute("phoneTop") : phone %></h5>
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
						
						
						<!-- Card Row: My Profile (Create) -->
						<div class="card">
							<div class="card-header">
								<h4>My Profile</h4>
							</div>
							<div class="card-body">
								<% if (request.getAttribute("error") != null) { %>
									<div class="alert alert-danger" style="margin: 1px;">
										<%= request.getAttribute("error") %>
									</div>
								<% } %>
								<% if (missingInfo) { %>
									<div class="alert alert-warning" style="margin: 1px;">
										Please fill out the company profile information completely!
									</div>
								<% } %>
                                                            <script>
                                                            function validateProfileForm() {
                                                                var email = document.querySelector('input[name="email"]').value.trim();
                                                                var phone = document.querySelector('input[name="phone"]').value.trim();
                                                                var emailPattern = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
                                                                var phonePattern = /^0\d{9}$/;
                                                                var valid = true;
                                                                var msg = "";
                                                                if (!emailPattern.test(email)) {
                                                                    msg += "Email must be in @gmail.com format!\n";
                                                                    valid = false;
                                                                }
                                                                if (!phonePattern.test(phone)) {
                                                                    msg += "Phone number must be 10 digits and start with 0!\n";
                                                                    valid = false;
                                                                }
                                                                if (!valid) {
                                                                    alert(msg);
                                                                }
                                                                return valid;
                                                            }
                                                            </script>
                                                            <form action="UpdateCompanyProfile" method="post">

									<div class="row">
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Company Name</label>
												<input type="text" name="companyName" class="form-control" value="<%= companyName %>" required>
											</div>
										</div>
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Email</label>
												<input type="email" name="email" class="form-control" value="<%= email %>" required>
											</div>
										</div>
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Phone Number</label>
												<input type="text" name="phone" class="form-control" value="<%= phone %>" required>
											</div>
										</div>
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Website</label>
												<input type="text" name="website" class="form-control" value="<%= website %>" required>
											</div>
										</div>
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Company Category</label>
												<select name="industryId" class="form-control" required>
													<option value="1" <%= (industryId != null && industryId == 1) ? "selected" : "" %>>Web & Application</option>
													<option value="3" <%= (industryId != null && industryId == 3) ? "selected" : "" %>>UI/UX Design</option>
													<option value="4" <%= (industryId != null && industryId == 4) ? "selected" : "" %>>IOS/App Application</option>
												</select>
											</div>
										</div>
										<div class="col-xl-6 col-lg-6 col-md-12">
											<div class="form-group">
												<label>Address</label>
												<input type="text" name="address" class="form-control" value="<%= address %>" required>
											</div>
										</div>
										<div class="col-xl-12 col-lg-12 col-md-12">
											<div class="form-group">
												<label>Description</label>
												<textarea name="description" class="form-control" required><%= request.getAttribute("description") != null ? (String)request.getAttribute("description") : "" %></textarea>
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
							<div class="py-3 text-center">Job Stock</div>
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

	</body>
</html> 
