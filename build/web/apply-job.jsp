<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ứng tuyển - ${job.title} | TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .apply-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .job-summary {
            background: linear-gradient(135deg, #17ac6a, #28a745);
            color: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            display: block;
        }
        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #17ac6a;
            box-shadow: 0 0 0 3px rgba(23, 172, 106, 0.1);
            outline: none;
        }
        .btn-apply {
            background: linear-gradient(135deg, #17ac6a, #28a745);
            border: none;
            padding: 15px 40px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 8px;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-apply:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(23, 172, 106, 0.3);
        }
        .requirements-note {
            background: #f8f9fa;
            border-left: 4px solid #17ac6a;
            padding: 15px;
            margin: 20px 0;
            border-radius: 5px;
        }
        
        /* File Upload Styles */
        .file-upload-container {
            position: relative;
            border: 2px dashed #e2e8f0;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            background: #fafafa;
        }
        
        .file-upload-container:hover {
            border-color: #17ac6a;
            background: #f0f9f4;
        }
        
        .file-upload-container.dragover {
            border-color: #17ac6a;
            background: #f0f9f4;
            transform: scale(1.02);
        }
        
        .file-upload-input {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        
        .file-upload-icon {
            font-size: 48px;
            color: #17ac6a;
            margin-bottom: 15px;
        }
        
        .file-upload-text {
            font-size: 16px;
            color: #2d3748;
            margin-bottom: 10px;
        }
        
        .file-upload-hint {
            font-size: 14px;
            color: #718096;
        }
        
        .file-selected {
            background: #f0f9f4;
            border-color: #17ac6a;
            padding: 20px;
            border-radius: 8px;
            margin-top: 15px;
        }
        
        .file-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .file-details {
            display: flex;
            align-items: center;
        }
        
        .file-icon {
            font-size: 24px;
            color: #17ac6a;
            margin-right: 10px;
        }
        
        .file-name {
            font-weight: 600;
            color: #2d3748;
        }
        
        .file-size {
            color: #718096;
            font-size: 14px;
        }
        
        .file-remove {
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .file-remove:hover {
            background: #c82333;
            transform: scale(1.1);
        }
        
        .upload-progress {
            width: 100%;
            height: 6px;
            background: #e2e8f0;
            border-radius: 3px;
            margin-top: 10px;
            overflow: hidden;
        }
        
        .upload-progress-bar {
            height: 100%;
            background: linear-gradient(90deg, #17ac6a, #28a745);
            width: 0%;
            transition: width 0.3s ease;
        }
        
        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
        
        .success-message {
            color: #28a745;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="apply-container">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="JobListServlet">Danh sách việc làm</a></li>
                    <li class="breadcrumb-item"><a href="JobDetailServlet?id=${job.id}">Chi tiết công việc</a></li>
                    <li class="breadcrumb-item active">Ứng tuyển</li>
                </ol>
            </nav>

            <!-- Job Summary -->
            <div class="job-summary">
                <h2 class="mb-3">${job.title}</h2>
                <div class="d-flex flex-wrap gap-3">
                    <span><i class="fas fa-building me-2"></i>${company.fullName}</span>
                    <span><i class="fas fa-map-marker-alt me-2"></i>${job.location}</span>
                    <span><i class="fas fa-briefcase me-2"></i>${job.jobType}</span>
                    <c:if test="${not empty job.salaryMin or not empty job.salaryMax}">
                        <span><i class="fas fa-dollar-sign me-2"></i>
                            <c:choose>
                                <c:when test="${not empty job.salaryMin and not empty job.salaryMax}">
                                    <fmt:formatNumber value="${job.salaryMin}" pattern="#,###"/> - <fmt:formatNumber value="${job.salaryMax}" pattern="#,###"/> M VND
                                </c:when>
                                <c:when test="${not empty job.salaryMin}">
                                    Từ <fmt:formatNumber value="${job.salaryMin}" pattern="#,###"/> M VND
                                </c:when>
                                <c:when test="${not empty job.salaryMax}">
                                    Lên đến <fmt:formatNumber value="${job.salaryMax}" pattern="#,###"/> M VND
                                </c:when>
                            </c:choose>
                        </span>
                    </c:if>
                </div>
            </div>

            <!-- Error Messages -->
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <c:choose>
                        <c:when test="${param.error == 'file_too_large'}">
                            <strong>Lỗi!</strong> File CV quá lớn. Vui lòng chọn file nhỏ hơn 10MB.
                        </c:when>
                        <c:when test="${param.error == 'invalid_file_type'}">
                            <strong>Lỗi!</strong> Chỉ chấp nhận file PDF, DOC, DOCX.
                        </c:when>
                        <c:when test="${param.error == 'upload_failed'}">
                            <strong>Lỗi!</strong> Upload file thất bại. Vui lòng thử lại.
                        </c:when>
                        <c:otherwise>Có lỗi xảy ra. Vui lòng thử lại!</c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Application Form -->
            <form action="ApplyJobServlet" method="post" id="applyForm" enctype="multipart/form-data">
                <input type="hidden" name="jobId" value="${job.id}">
                
                <h4 class="mb-4"><i class="fas fa-paper-plane me-2 text-primary"></i>Thông tin ứng tuyển</h4>
                
                <!-- Candidate Info -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" value="${user.fullName}" readonly>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" value="${user.email}" readonly>
                        </div>
                    </div>
                </div>

                <!-- CV Upload -->
                <div class="form-group">
                    <label class="form-label" for="cvFile">
                        Upload CV <span class="text-danger">*</span>
                    </label>
                    <div class="file-upload-container" id="fileUploadContainer">
                        <input type="file" class="file-upload-input" id="cvFile" name="cvFile" 
                               accept=".pdf,.doc,.docx" required>
                        <div class="file-upload-content">
                            <div class="file-upload-icon">
                                <i class="fas fa-cloud-upload-alt"></i>
                            </div>
                            <div class="file-upload-text">
                                Kéo thả file CV vào đây hoặc <strong>click để chọn file</strong>
                            </div>
                            <div class="file-upload-hint">
                                Chấp nhận file PDF, DOC, DOCX (tối đa 10MB)
                            </div>
                        </div>
                    </div>
                    
                    <!-- File Selected Display -->
                    <div class="file-selected" id="fileSelected" style="display: none;">
                        <div class="file-info">
                            <div class="file-details">
                                <div class="file-icon">
                                    <i class="fas fa-file-pdf"></i>
                                </div>
                                <div>
                                    <div class="file-name" id="fileName"></div>
                                    <div class="file-size" id="fileSize"></div>
                                </div>
                            </div>
                            <button type="button" class="file-remove" id="fileRemove">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                        <div class="upload-progress" id="uploadProgress" style="display: none;">
                            <div class="upload-progress-bar" id="uploadProgressBar"></div>
                        </div>
                    </div>
                    
                    <div class="error-message" id="fileError"></div>
                    <div class="success-message" id="fileSuccess"></div>
                </div>

                <!-- Cover Letter -->
                <div class="form-group">
                    <label class="form-label" for="coverLetter">
                        Thư xin việc <span class="text-danger">*</span>
                    </label>
                    <textarea class="form-control" id="coverLetter" name="coverLetter" rows="8" 
                              placeholder="Hãy viết một thư xin việc ngắn gọn để giới thiệu bản thân và lý do bạn phù hợp với vị trí này..." required></textarea>
                    <small class="text-muted">Tối thiểu 50 ký tự, tối đa 1000 ký tự</small>
                </div>

                <!-- Requirements Note -->
                <div class="requirements-note">
                    <h6><i class="fas fa-info-circle me-2"></i>Lưu ý quan trọng:</h6>
                    <ul class="mb-0">
                        <li>File CV phải có định dạng PDF, DOC hoặc DOCX</li>
                        <li>Kích thước file không được vượt quá 10MB</li>
                        <li>Thư xin việc nên thể hiện rõ động lực và khả năng phù hợp với công việc</li>
                        <li>Sau khi nộp đơn, bạn có thể theo dõi trạng thái ứng tuyển trong mục "Đơn ứng tuyển của tôi"</li>
                    </ul>
                </div>

                <!-- Action Buttons -->
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="JobDetailServlet?id=${job.id}" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                    <button type="submit" class="btn btn-apply" id="submitBtn">
                        <i class="fas fa-paper-plane me-2"></i>Nộp đơn ứng tuyển
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            const fileInput = $('#cvFile');
            const fileUploadContainer = $('#fileUploadContainer');
            const fileSelected = $('#fileSelected');
            const fileName = $('#fileName');
            const fileSize = $('#fileSize');
            const fileRemove = $('#fileRemove');
            const fileError = $('#fileError');
            const fileSuccess = $('#fileSuccess');
            const submitBtn = $('#submitBtn');
            
            let selectedFile = null;
            const maxFileSize = 10 * 1024 * 1024; // 10MB
            const allowedTypes = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
            
            // Drag and drop events
            fileUploadContainer.on('dragover', function(e) {
                e.preventDefault();
                $(this).addClass('dragover');
            });
            
            fileUploadContainer.on('dragleave', function(e) {
                e.preventDefault();
                $(this).removeClass('dragover');
            });
            
            fileUploadContainer.on('drop', function(e) {
                e.preventDefault();
                $(this).removeClass('dragover');
                
                const files = e.originalEvent.dataTransfer.files;
                if (files.length > 0) {
                    handleFileSelect(files[0]);
                }
            });
            
            // File input change
            fileInput.on('change', function() {
                if (this.files.length > 0) {
                    handleFileSelect(this.files[0]);
                }
            });
            
            // Remove file
            fileRemove.on('click', function() {
                clearFileSelection();
            });
            
            // Handle file selection
            function handleFileSelect(file) {
                // Reset messages
                hideMessages();
                
                // Validate file
                if (!validateFile(file)) {
                    return;
                }
                
                selectedFile = file;
                displaySelectedFile(file);
                showSuccess('File đã được chọn thành công!');
            }
            
            // Validate file
            function validateFile(file) {
                // Check file size
                if (file.size > maxFileSize) {
                    showError('File quá lớn. Vui lòng chọn file nhỏ hơn 10MB.');
                    return false;
                }
                
                // Check file type
                if (!allowedTypes.includes(file.type)) {
                    showError('Chỉ chấp nhận file PDF, DOC, DOCX.');
                    return false;
                }
                
                return true;
            }
            
            // Display selected file
            function displaySelectedFile(file) {
                const sizeInMB = (file.size / (1024 * 1024)).toFixed(2);
                
                fileName.text(file.name);
                fileSize.text(sizeInMB + ' MB');
                
                // Set appropriate icon
                const fileIcon = fileSelected.find('.file-icon i');
                if (file.type === 'application/pdf') {
                    fileIcon.removeClass().addClass('fas fa-file-pdf');
                } else {
                    fileIcon.removeClass().addClass('fas fa-file-word');
                }
                
                fileUploadContainer.hide();
                fileSelected.show();
            }
            
            // Clear file selection
            function clearFileSelection() {
                selectedFile = null;
                fileInput.val('');
                fileSelected.hide();
                fileUploadContainer.show();
                hideMessages();
            }
            
            // Show error message
            function showError(message) {
                fileError.text(message).show();
                fileSuccess.hide();
            }
            
            // Show success message
            function showSuccess(message) {
                fileSuccess.text(message).show();
                fileError.hide();
            }
            
            // Hide messages
            function hideMessages() {
                fileError.hide();
                fileSuccess.hide();
            }
            
            // Validate cover letter length
            $('#coverLetter').on('input', function() {
                const length = $(this).val().length;
                const minLength = 50;
                const maxLength = 1000;
                
                if (length < minLength) {
                    $(this).removeClass('is-valid').addClass('is-invalid');
                    $(this).next('.text-muted').text(`Cần thêm ${minLength - length} ký tự nữa`).addClass('text-danger');
                } else if (length > maxLength) {
                    $(this).removeClass('is-valid').addClass('is-invalid');
                    $(this).next('.text-muted').text(`Vượt quá ${length - maxLength} ký tự`).addClass('text-danger');
                } else {
                    $(this).removeClass('is-invalid').addClass('is-valid');
                    $(this).next('.text-muted').text(`${length}/${maxLength} ký tự`).removeClass('text-danger').addClass('text-success');
                }
            });

            // Form validation
            $('#applyForm').on('submit', function(e) {
                const coverLetter = $('#coverLetter').val().trim();
                
                // Validate cover letter
                if (coverLetter.length < 50 || coverLetter.length > 1000) {
                    e.preventDefault();
                    alert('Thư xin việc phải có độ dài từ 50 đến 1000 ký tự!');
                    $('#coverLetter').focus();
                    return;
                }
                
                // Validate file selection
                if (!selectedFile) {
                    e.preventDefault();
                    alert('Vui lòng chọn file CV!');
                    return;
                }
                
                // Show loading state
                submitBtn.prop('disabled', true);
                submitBtn.html('<i class="fas fa-spinner fa-spin me-2"></i>Đang nộp đơn...');
            });
        });
    </script>
</body>
</html>
