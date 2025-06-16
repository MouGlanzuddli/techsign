<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Post a Job - TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    
    <style>
        .post-job-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }
        
        .job-form-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .form-header {
            background: linear-gradient(135deg, #17ac6a 0%, #15a85e 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .form-step {
            display: none;
        }
        
        .form-step.active {
            display: block;
        }
        
        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
        }
        
        .step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 10px;
            font-weight: bold;
            position: relative;
        }
        
        .step.active {
            background: #17ac6a;
            color: white;
        }
        
        .step.completed {
            background: #28a745;
            color: white;
        }
        
        .step::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 100%;
            width: 20px;
            height: 2px;
            background: #e9ecef;
            transform: translateY(-50%);
        }
        
        .step:last-child::after {
            display: none;
        }
        
        .step.completed::after {
            background: #28a745;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
            display: block;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #17ac6a;
            box-shadow: 0 0 0 0.2rem rgba(23, 172, 106, 0.25);
        }
        
        .skill-tag {
            display: inline-block;
            background: #17ac6a;
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            margin: 3px;
            font-size: 0.9rem;
        }
        
        .skill-tag .remove-skill {
            margin-left: 8px;
            cursor: pointer;
            opacity: 0.8;
        }
        
        .skill-tag .remove-skill:hover {
            opacity: 1;
        }
        
        .btn-step {
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .salary-range {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .salary-input {
            flex: 1;
        }
        
        .preview-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .alert {
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
        
        .alert-success {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .alert-danger {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
    </style>
</head>

<body class="green-theme">
    <div id="preloader"><div class="preloader"><span></span><span></span></div></div>
    
    <div id="main-wrapper">
        <!-- Navigation -->
        <div class="header header-light">
            <div class="container">
                <nav id="navigation" class="navigation navigation-landscape">
                    <div class="nav-header">
                        <a class="nav-brand" href="${pageContext.request.contextPath}/companyHome.jsp">
                            <img src="${pageContext.request.contextPath}/assets/img/logo.png" class="logo" alt="">
                        </a>
                        <div class="nav-toggle"></div>
                    </div>
                    <div class="nav-menus-wrapper">
                        <ul class="nav-menu">
                            <li><a href="${pageContext.request.contextPath}/companyHome.jsp">Dashboard</a></li>
                            <li><a href="${pageContext.request.contextPath}/manage-jobs.jsp">Manage Jobs</a></li>
                            <li class="active"><a href="${pageContext.request.contextPath}/post-job.jsp">Post Job</a></li>
                        </ul>
                        <ul class="nav-menu nav-menu-social align-to-right">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <img src="${pageContext.request.contextPath}/assets/img/logo-account.png" class="nav-logo" alt="">
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">Profile</a></li>
                                    <li><a class="dropdown-item" href="LogoutServlet">Logout</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>

        <!-- Post Job Form -->
        <section class="post-job-container">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-10 col-lg-12">
                        <div class="job-form-card">
                            <div class="form-header">
                                <h2><i class="fas fa-briefcase me-2"></i>Post a New Job</h2>
                                <p class="mb-0">Find the perfect candidate for your team</p>
                            </div>
                            
                            <div class="p-4">
                                <!-- Step Indicator -->
                                <div class="step-indicator">
                                    <div class="step active" data-step="1">1</div>
                                    <div class="step" data-step="2">2</div>
                                    <div class="step" data-step="3">3</div>
                                    <div class="step" data-step="4">4</div>
                                </div>

                                <!-- Alert Messages -->
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success">
                                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger">
                                        <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                                    </div>
                                </c:if>

                                <form id="postJobForm" action="${pageContext.request.contextPath}/PostJobServlet" method="POST">
                                    <!-- Step 1: Basic Information -->
                                    <div class="form-step active" id="step1">
                                        <h4 class="mb-4">Basic Job Information</h4>
                                        
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="form-group">
                                                    <label class="form-label">Job Title *</label>
                                                    <input type="text" name="title" class="form-control" 
                                                           placeholder="e.g. Senior Frontend Developer" required>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="form-label">Job Type *</label>
                                                    <select name="jobType" class="form-control" required>
                                                        <option value="">Select Type</option>
                                                        <option value="Full-time">Full-time</option>
                                                        <option value="Part-time">Part-time</option>
                                                        <option value="Contract">Contract</option>
                                                        <option value="Freelance">Freelance</option>
                                                        <option value="Internship">Internship</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="form-label">Location *</label>
                                                    <input type="text" name="location" class="form-control" 
                                                           placeholder="e.g. Da Nang, Vietnam or Remote" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="form-label">Category</label>
                                                    <select name="categoryId" class="form-control">
                                                        <option value="">Select Category</option>
                                                        <option value="1">Software Development</option>
                                                        <option value="2">Web Development</option>
                                                        <option value="3">Mobile Development</option>
                                                        <option value="4">Data Science</option>
                                                        <option value="5">DevOps</option>
                                                        <option value="6">UI/UX Design</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Job Description *</label>
                                            <textarea name="description" class="form-control" rows="6" 
                                                      placeholder="Describe the role, responsibilities, and what you're looking for..." required></textarea>
                                        </div>
                                    </div>

                                    <!-- Step 2: Requirements & Skills -->
                                    <div class="form-step" id="step2">
                                        <h4 class="mb-4">Requirements & Skills</h4>
                                        
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="form-label">Experience Level</label>
                                                    <select name="experienceLevel" class="form-control">
                                                        <option value="">Select Level</option>
                                                        <option value="Entry Level">Entry Level (0-1 years)</option>
                                                        <option value="Junior">Junior (1-3 years)</option>
                                                        <option value="Mid Level">Mid Level (3-5 years)</option>
                                                        <option value="Senior">Senior (5+ years)</option>
                                                        <option value="Lead">Lead/Manager (7+ years)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="form-label">Education Level</label>
                                                    <select name="educationLevel" class="form-control">
                                                        <option value="">Select Education</option>
                                                        <option value="High School">High School</option>
                                                        <option value="Associate">Associate Degree</option>
                                                        <option value="Bachelor">Bachelor's Degree</option>
                                                        <option value="Master">Master's Degree</option>
                                                        <option value="PhD">PhD</option>
                                                        <option value="Certification">Professional Certification</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Required Skills</label>
                                            <input type="text" id="skillInput" class="form-control" 
                                                   placeholder="Type a skill and press Enter (e.g. JavaScript, React, Node.js)">
                                            <div id="skillTags" class="mt-2"></div>
                                            <input type="hidden" name="skills" id="skillsHidden">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Additional Requirements</label>
                                            <textarea name="requirements" class="form-control" rows="4" 
                                                      placeholder="List any additional requirements, qualifications, or preferences..."></textarea>
                                        </div>
                                    </div>

                                    <!-- Step 3: Compensation & Benefits -->
                                    <div class="form-step" id="step3">
                                        <h4 class="mb-4">Compensation & Benefits</h4>
                                        
                                        <div class="form-group">
                                            <label class="form-label">Salary Range (USD/month)</label>
                                            <div class="salary-range">
                                                <div class="salary-input">
                                                    <input type="number" name="salaryMin" class="form-control" 
                                                           placeholder="Minimum" min="0" step="100">
                                                </div>
                                                <span>to</span>
                                                <div class="salary-input">
                                                    <input type="number" name="salaryMax" class="form-control" 
                                                           placeholder="Maximum" min="0" step="100">
                                                </div>
                                            </div>
                                            <small class="text-muted">Leave blank if you prefer not to disclose</small>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Benefits & Perks</label>
                                            <textarea name="benefits" class="form-control" rows="4" 
                                                      placeholder="Health insurance, flexible hours, remote work, professional development, etc."></textarea>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="form-label">Application Deadline</label>
                                                    <input type="date" name="expiresAt" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="form-label">Number of Positions</label>
                                                    <input type="number" name="positions" class="form-control" 
                                                           value="1" min="1" max="50">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Step 4: Preview & Publish -->
                                    <div class="form-step" id="step4">
                                        <h4 class="mb-4">Preview & Publish</h4>
                                        
                                        <div class="preview-section">
                                            <h5>Job Preview</h5>
                                            <div id="jobPreview">
                                                <!-- Preview content will be populated by JavaScript -->
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                                <label class="form-check-label" for="termsCheck">
                                                    I agree to the <a href="#" target="_blank">Terms of Service</a> and 
                                                    <a href="#" target="_blank">Privacy Policy</a>
                                                </label>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="isFeatured" id="featuredCheck">
                                                <label class="form-check-label" for="featuredCheck">
                                                    <strong>Make this job featured</strong> 
                                                    <span class="text-muted">(Additional $50 - increases visibility)</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Navigation Buttons -->
                                    <div class="d-flex justify-content-between mt-4">
                                        <button type="button" id="prevBtn" class="btn btn-outline-secondary btn-step" style="display: none;">
                                            <i class="fas fa-arrow-left me-2"></i>Previous
                                        </button>
                                        <button type="button" id="nextBtn" class="btn btn-primary btn-step">
                                            Next<i class="fas fa-arrow-right ms-2"></i>
                                        </button>
                                        <button type="submit" id="submitBtn" class="btn btn-success btn-step" style="display: none;">
                                            <i class="fas fa-paper-plane me-2"></i>Publish Job
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/custom.js"></script>

    <script>
        $(document).ready(function() {
            let currentStep = 1;
            const totalSteps = 4;
            let skills = [];

            // Step navigation
            function showStep(step) {
                $('.form-step').removeClass('active');
                $(`#step${step}`).addClass('active');
                
                // Update step indicators
                $('.step').removeClass('active completed');
                for (let i = 1; i <= step; i++) {
                    if (i < step) {
                        $(`.step[data-step="${i}"]`).addClass('completed');
                    } else if (i === step) {
                        $(`.step[data-step="${i}"]`).addClass('active');
                    }
                }
                
                // Update buttons
                $('#prevBtn').toggle(step > 1);
                $('#nextBtn').toggle(step < totalSteps);
                $('#submitBtn').toggle(step === totalSteps);
                
                if (step === totalSteps) {
                    updatePreview();
                }
            }

            $('#nextBtn').click(function() {
                if (validateStep(currentStep)) {
                    currentStep++;
                    showStep(currentStep);
                }
            });

            $('#prevBtn').click(function() {
                currentStep--;
                showStep(currentStep);
            });

            // Skills management
            $('#skillInput').keypress(function(e) {
                if (e.which === 13) {
                    e.preventDefault();
                    const skill = $(this).val().trim();
                    if (skill && !skills.includes(skill)) {
                        skills.push(skill);
                        updateSkillTags();
                        $(this).val('');
                    }
                }
            });

            function updateSkillTags() {
                const container = $('#skillTags');
                container.empty();
                skills.forEach(skill => {
                    const tag = $(`
                        <span class="skill-tag">
                            ${skill}
                            <span class="remove-skill" data-skill="${skill}">×</span>
                        </span>
                    `);
                    container.append(tag);
                });
                $('#skillsHidden').val(skills.join(','));
            }

            $(document).on('click', '.remove-skill', function() {
                const skill = $(this).data('skill');
                skills = skills.filter(s => s !== skill);
                updateSkillTags();
            });

            // Form validation
            function validateStep(step) {
                let isValid = true;
                const currentStepElement = $(`#step${step}`);
                
                currentStepElement.find('input[required], select[required], textarea[required]').each(function() {
                    if (!$(this).val().trim()) {
                        $(this).addClass('is-invalid');
                        isValid = false;
                    } else {
                        $(this).removeClass('is-invalid');
                    }
                });

                if (!isValid) {
                    alert('Please fill in all required fields.');
                }

                return isValid;
            }

            // Preview update
            function updatePreview() {
                const formData = new FormData($('#postJobForm')[0]);
                const preview = $('#jobPreview');
                
                const title = formData.get('title') || 'Job Title';
                const jobType = formData.get('jobType') || 'Not specified';
                const location = formData.get('location') || 'Not specified';
                const description = formData.get('description') || 'No description provided';
                const salaryMin = formData.get('salaryMin');
                const salaryMax = formData.get('salaryMax');
                
                let salaryText = 'Salary not disclosed';
                if (salaryMin && salaryMax) {
                    salaryText = `$${salaryMin} - $${salaryMax}/month`;
                } else if (salaryMin) {
                    salaryText = `From $${salaryMin}/month`;
                } else if (salaryMax) {
                    salaryText = `Up to $${salaryMax}/month`;
                }

                preview.html(`
                    <div class="job-preview-card">
                        <h5 class="text-primary">${title}</h5>
                        <p class="mb-2">
                            <i class="fas fa-briefcase me-2"></i>${jobType} • 
                            <i class="fas fa-map-marker-alt me-2"></i>${location}
                        </p>
                        <p class="mb-2">
                            <i class="fas fa-dollar-sign me-2"></i>${salaryText}
                        </p>
                        <div class="mb-3">
                            <strong>Description:</strong>
                            <p class="mt-1">${description.substring(0, 200)}${description.length > 200 ? '...' : ''}</p>
                        </div>
                        ${not empty skills ? '<div class="mb-2">
                                <strong>Required Skills:</strong><br>
                                <c:forEach var="skill" items="${skills}">
                                    <span class="badge bg-primary me-1">${skill}</span>
                                </c:forEach>
                            </div>' : ''}
                    </div>
                `);
            }

            // Form submission
            $('#postJobForm').submit(function(e) {
                if (!validateStep(4)) {
                    e.preventDefault();
                    return false;
                }
                
                if (!$('#termsCheck').is(':checked')) {
                    e.preventDefault();
                    alert('Please agree to the Terms of Service and Privacy Policy.');
                    return false;
                }
                
                // Show loading state
                $('#submitBtn').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Publishing...');
            });

            // Auto-save draft functionality
            setInterval(function() {
                const formData = $('#postJobForm').serialize();
                localStorage.setItem('jobDraft', formData);
            }, 30000); // Save every 30 seconds

            // Load draft on page load
            const savedDraft = localStorage.getItem('jobDraft');
            if (savedDraft && confirm('Would you like to restore your saved draft?')) {
                // Parse and populate form with saved data
                const params = new URLSearchParams(savedDraft);
                params.forEach((value, key) => {
                    $(`[name="${key}"]`).val(value);
                });
                
                // Restore skills
                const savedSkills = params.get('skills');
                if (savedSkills) {
                    skills = savedSkills.split(',').filter(s => s.trim());
                    updateSkillTags();
                }
            }
        });
    </script>
</body>
</html>
