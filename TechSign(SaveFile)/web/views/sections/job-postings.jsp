<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Tuyển dụng</title>
    <style>
        /* Global Styles & Body Reset */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f7f6;
            color: #333;
            line-height: 1.6;
        }

        h2, h3, h4 {
            color: #0056b3;
            margin-bottom: 15px; /* Consistent margin for headings */
            font-weight: bold;
        }

        h2 { font-size: 2em; }
        h3 { font-size: 1.5em; }
        h4 { font-size: 1.2em; }


        /* --- Reusable Card Styles (base-card) --- */
        .base-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            padding: 25px; /* Increased padding for more breathing room */
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .base-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
        }

        /* --- Form Container Styles (used within modal) --- */
        .form-container {
            width: 100%; /* Ensures it fills modal-content */
        }

        .form-container label {
            display: block;
            margin-bottom: 8px; /* Slightly more space */
            font-weight: bold;
            color: #555;
            font-size: 0.95em;
        }

        .form-container input[type="text"],
        .form-container input[type="date"],
        .form-container textarea,
        .filter-bar input[type="text"], /* Apply similar styles to filter inputs */
        .filter-bar select {
            width: calc(100% - 20px); /* Account for padding */
            padding: 10px;
            margin-bottom: 18px; /* Consistent margin */
            border: 1px solid #ddd;
            border-radius: 6px; /* Slightly more rounded corners */
            box-sizing: border-box;
            font-size: 1em;
        }

        .form-container textarea {
            resize: vertical;
            min-height: 100px; /* Minimum height for textareas */
        }

        .form-container .submit-btn {
            background-color: #28a745; /* Green for submit/add */
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }

        .form-container .submit-btn:hover {
            background-color: #218838;
            transform: translateY(-1px);
        }
        .form-container .submit-btn:active {
            transform: translateY(0);
        }

        /* --- Add New Job Button (outside modal) --- */
        .add-job-btn {
            background-color: #007bff; /* Primary blue for main action */
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px; /* More rounded */
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 30px; /* Space below the button */
            transition: background-color 0.3s ease, transform 0.1s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1); /* Subtle shadow */
        }

        .add-job-btn:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }
        .add-job-btn:active {
            transform: translateY(0);
        }

        /* --- Filter Bar Styles --- */
        .filter-bar {
            background-color: #fff;
            padding: 20px 25px; /* Consistent with base-card padding */
            border-radius: 12px; /* Consistent with base-card border-radius */
            box-shadow: 0 2px 8px rgba(0,0,0,0.08); /* Lighter shadow than card */
            margin-bottom: 30px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }

        .filter-bar button {
            background-color: #6c757d; /* Grey for filter apply button */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .filter-bar button:hover {
            background-color: #5a6268;
        }

        /* --- Card List Layout --- */
        .card-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); /* Slightly wider cards */
            gap: 25px; /* More space between cards */
            padding: 10px 0;
        }

        /* --- Individual Job Card Styles --- */
        .job-card {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: auto;
        }

        .card-header-flex {
            display: flex;
            justify-content: space-between;
            align-items: flex-start; /* Align to top if titles are long */
            margin-bottom: 10px;
            gap: 10px; /* Space between title and ID */
        }

        .job-card h5 {
            margin: 0;
            color: #007bff;
            font-size: 1.3em; /* Slightly larger title */
            line-height: 1.3;
        }

        .job-card .job-id {
            font-size: 0.85em;
            color: #888;
            font-weight: normal;
            flex-shrink: 0; /* Prevent ID from shrinking */
        }

        .job-card p {
            margin: 8px 0; /* More vertical space for paragraphs */
            color: #666;
            line-height: 1.5;
        }

        .job-card .detail-label {
            font-weight: bold;
            color: #444;
        }

        .job-card .job-description {
            max-height: 90px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 4;
            -webkit-box-orient: vertical;
            margin-top: 10px;
            margin-bottom: 15px; /* More space before actions */
            font-size: 0.95em;
        }

        /* --- Status Badge Styling --- */
        .status-badge {
            display: inline-block;
            padding: 6px 12px; /* Larger padding */
            border-radius: 6px;
            font-size: 0.8em; /* Slightly smaller font for badge */
            font-weight: bold;
            text-transform: uppercase;
            margin-top: 8px;
            margin-right: 8px;
            white-space: nowrap; /* Prevent badge text from wrapping */
        }

        /* Specific Status Colors (kept consistent) */
        .status-active { background-color: #d4edda; color: #155724; }
        .status-expired { background-color: #f8d7da; color: #721c24; }
        .status-draft { background-color: #cce5ff; color: #004085; }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-closed { background-color: #e2e3e5; color: #383d41; }


        /* --- Action Buttons (inside cards) --- */
        .actions {
            margin-top: auto; /* Pushes actions to the bottom of the flex container */
            padding-top: 15px; /* Space from content above */
            border-top: 1px solid #eee; /* Separator line */
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 9px 18px; /* Slightly larger buttons */
            border: none;
            border-radius: 6px; /* Consistent rounded corners */
            cursor: pointer;
            font-size: 0.9em;
            font-weight: bold;
            transition: background-color 0.2s ease, transform 0.1s ease;
        }

        .action-btn:active {
            transform: translateY(1px);
        }

        .edit-btn {
            background-color: #ffc107; /* Yellow for edit */
            color: #333;
        }
        .edit-btn:hover {
            background-color: #e0a800;
        }

        .delete-btn {
            background-color: #dc3545; /* Red for delete */
            color: white;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }

        .preview-btn {
            background-color: #007bff; /* Primary blue for preview */
            color: white;
        }
        .preview-btn:hover {
            background-color: #0056b3;
        }

        /* --- Image/Logo Placeholder for Job Cards --- */
        .job-card-thumbnail {
            width: 100%;
            height: 120px;
            background-color: #e9ecef;
            border-radius: 8px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 2.5em; /* Larger icon */
            overflow: hidden;
            object-fit: cover;
        }

        /* --- Modal (Popup) Styles --- */
        .modal {
            display: none; /* Hidden by default */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5); /* Darker overlay */
            display: flex;
            justify-content: center;
            align-items: center;
            animation: fadeInOverlay 0.3s ease-out; /* Overlay fade in */
        }

        .modal-content {
            background-color: #fefefe;
            padding: 30px;
            border: 1px solid #ccc; /* Lighter border */
            border-radius: 12px;
            width: 90%; /* Wider on smaller screens */
            max-width: 650px; /* Max width for larger screens */
            box-shadow: 0 8px 25px rgba(0,0,0,0.25); /* More prominent shadow */
            position: relative;
            animation: fadeInScale 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275); /* Springy animation */
        }

        .close-button {
            color: #888; /* Softer color */
            font-size: 32px; /* Larger close button */
            font-weight: normal; /* Lighter weight */
            position: absolute;
            top: 10px;
            right: 20px;
            cursor: pointer;
            transition: color 0.2s ease;
        }

        .close-button:hover,
        .close-button:focus {
            color: #333;
            text-decoration: none;
        }

        /* Keyframe for overlay fade-in */
        @keyframes fadeInOverlay {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Keyframe for content fade-in with scale */
        @keyframes fadeInScale {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .filter-bar {
                flex-direction: column; /* Stack filter items on small screens */
                align-items: stretch;
            }
            .filter-bar input[type="text"],
            .filter-bar select,
            .filter-bar button {
                width: 100%; /* Full width for filter elements */
            }
        }

        @media (max-width: 480px) {
            body {
                margin: 10px;
            }
            .base-card, .filter-bar, .modal-content {
                padding: 15px; /* Reduce padding on very small screens */
            }
            .card-list {
                grid-template-columns: 1fr; /* Single column layout for cards */
            }
        }

    </style>
</head>
<body>

<h2>Quản lý Tuyển dụng</h2>

<section id="job-postings">
    <h3>Quản lý Tin Tuyển dụng</h3>

    <button class="add-job-btn" onclick="openAddJobModal()">+ Thêm tin tuyển dụng mới</button>

    <div class="filter-bar">
        <input type="text" id="searchKeyword" placeholder="Tìm kiếm theo vị trí, công ty..." />
        <select id="filterStatus">
            <option value="">Tất cả trạng thái</option>
            <option value="active">Đang hoạt động</option>
            <option value="pending">Chờ duyệt</option>
            <option value="expired">Đã hết hạn</option>
            <option value="draft">Bản nháp</option>
        </select>
        <button onclick="applyFilters()">Áp dụng</button>
    </div>

    <h4>Danh sách Tin Tuyển dụng</h4>
    <div class="card-list">
        <div class="job-card base-card" data-status="active">
            <div class="job-card-thumbnail">
                <i class="fas fa-briefcase"></i> <%-- Font Awesome icon as placeholder --%>
            </div>
            <div class="card-header-flex">
                <h5>Lập trình viên Java</h5>
                <span class="job-id">ID: J001</span>
            </div>
            <p><span class="detail-label">Công ty:</span> Công ty ABC</p>
            <p><span class="detail-label">Hạn nộp:</span> 2025-07-01</p>
            <p><span class="detail-label">Trạng thái:</span> <span class="status-badge status-active">Đang hoạt động</span></p>
            <p><span class="detail-label">Ứng viên:</span> 15</p>
            <p class="job-description">
                Mô tả: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
            </p>
            <div class="actions">
                <button class="action-btn preview-btn">Xem trước</button>
                <button class="action-btn edit-btn">Sửa</button>
                <button class="action-btn delete-btn">Xóa</button>
            </div>
        </div>

        <div class="job-card base-card" data-status="pending">
            <div class="job-card-thumbnail">
                <i class="fas fa-briefcase"></i>
            </div>
            <div class="card-header-flex">
                <h5>Kỹ sư phần mềm Fullstack</h5>
                <span class="job-id">ID: J002</span>
            </div>
            <p><span class="detail-label">Công ty:</span> Tech Solutions Inc.</p>
            <p><span class="detail-label">Hạn nộp:</span> 2025-07-15</p>
            <p><span class="detail-label">Trạng thái:</span> <span class="status-badge status-pending">Chờ duyệt</span></p>
            <p><span class="detail-label">Ứng viên:</span> 0</p>
            <p class="job-description">
                Mô tả: Yêu cầu kinh nghiệm về Java, Spring Boot, React/Angular. Sẽ tham gia phát triển các dự án lớn. Tìm kiếm ứng viên có khả năng làm việc độc lập và làm việc nhóm hiệu quả.
            </p>
            <div class="actions">
                <button class="action-btn preview-btn">Xem trước</button>
                <button class="action-btn edit-btn">Sửa</button>
                <button class="action-btn delete-btn">Xóa</button>
            </div>
        </div>

        <div class="job-card base-card" data-status="expired">
            <div class="job-card-thumbnail">
                <i class="fas fa-briefcase"></i>
            </div>
            <div class="card-header-flex">
                <h5>Designer UX/UI</h5>
                <span class="job-id">ID: J003</span>
            </div>
            <p><span class="detail-label">Công ty:</span> Creative Solutions</p>
            <p><span class="detail-label">Hạn nộp:</span> 2025-05-30</p>
            <p><span class="detail-label">Trạng thái:</span> <span class="status-badge status-expired">Đã hết hạn</span></p>
            <p><span class="detail-label">Ứng viên:</span> 22</p>
            <p class="job-description">
                Mô tả: Chịu trách nhiệm thiết kế giao diện người dùng và trải nghiệm người dùng cho các sản phẩm web và di động.
            </p>
            <div class="actions">
                <button class="action-btn preview-btn">Xem trước</button>
                <button class="action-btn edit-btn">Sửa</button>
                <button class="action-btn delete-btn">Xóa</button>
            </div>
        </div>

        <div class="job-card base-card" data-status="draft">
            <div class="job-card-thumbnail">
                <i class="fas fa-briefcase"></i>
            </div>
            <div class="card-header-flex">
                <h5>Chuyên viên Marketing</h5>
                <span class="job-id">ID: J004</span>
            </div>
            <p><span class="detail-label">Công ty:</span> Global Brands</p>
            <p><span class="detail-label">Hạn nộp:</span> 2025-08-01</p>
            <p><span class="detail-label">Trạng thái:</span> <span class="status-badge status-draft">Bản nháp</span></p>
            <p><span class="detail-label">Ứng viên:</span> 0</p>
            <p class="job-description">
                Mô tả: Phát triển và triển khai các chiến lược marketing kỹ thuật số. Quản lý các chiến dịch quảng cáo trực tuyến.
            </p>
            <div class="actions">
                <button class="action-btn preview-btn">Xem trước</button>
                <button class="action-btn edit-btn">Sửa</button>
                <button class="action-btn delete-btn">Xóa</button>
            </div>
        </div>

        <%--
        <c:forEach var="job" items="${jobPostings}">
            <div class="job-card base-card" data-status="${job.status.toLowerCase()}">
                <div class="job-card-thumbnail">
                    <i class="fas fa-briefcase"></i>
                </div>
                <div class="card-header-flex">
                    <h5>${job.position}</h5>
                    <span class="job-id">ID: ${job.id}</span>
                </div>
                <p><span class="detail-label">Công ty:</span> ${job.company}</p>
                <p><span class="detail-label">Hạn nộp:</span> ${job.deadline}</p>
                <p><span class="detail-label">Trạng thái:</span> <span class="status-badge status-${job.status.toLowerCase()}">${job.statusDisplay}</span></p>
                <p><span class="detail-label">Ứng viên:</span> ${job.applicantCount}</p>
                <p class="job-description">${job.description}</p>
                <div class="actions">
                    <button class="action-btn preview-btn" onclick="location.href='<c:url value="/jobs/preview?id=${job.id}"/>'">Xem trước</button>
                    <button class="action-btn edit-btn" onclick="location.href='<c:url value="/jobs/edit?id=${job.id}"/>'">Sửa</button>
                    <button class="action-btn delete-btn" onclick="if(confirm('Bạn có chắc chắn muốn xóa tin tuyển dụng này?')) location.href='<c:url value="/jobs/delete?id=${job.id}"/>'">Xóa</button>
                </div>
            </div>
        </c:forEach>
        --%>
    </div>
</section>

<div id="addJobModal" class="modal">
    <div class="modal-content">
        <span class="close-button" onclick="closeAddJobModal()">&times;</span>
        <div class="form-container">
            <h4>Thêm tin tuyển dụng mới</h4>
            <label for="modalPosition">Vị trí</label>
            <input type="text" id="modalPosition" placeholder="Nhập vị trí tuyển dụng..." />

            <label for="modalCompany">Công ty</label>
            <input type="text" id="modalCompany" placeholder="Nhập tên công ty..." />

            <label for="modalDescription">Mô tả</label>
            <textarea id="modalDescription" placeholder="Nhập mô tả công việc..." rows="5"></textarea>

            <label for="modalDeadline">Hạn nộp</label>
            <input type="date" id="modalDeadline" />

            <button class="submit-btn">Đăng tin</button>
        </div>
    </div>
</div>


<script>
    // Simple JavaScript for client-side filtering demo
    function applyFilters() {
        const keyword = document.getElementById('searchKeyword').value.toLowerCase();
        const status = document.getElementById('filterStatus').value;
        const jobCards = document.querySelectorAll('.job-card');

        jobCards.forEach(card => {
            // Get text content of position (h5) and company (first p after h5)
            const positionText = card.querySelector('h5').textContent.toLowerCase();
            // Assuming company is always the first paragraph after h5, adjust if structure changes
            const companyElement = card.querySelector('p .detail-label') && card.querySelector('p .detail-label').textContent.includes('Công ty:') ? card.querySelector('p:nth-of-type(1)') : null;
            const companyText = companyElement ? companyElement.textContent.replace('Công ty:', '').trim().toLowerCase() : '';

            const cardStatus = card.dataset.status;

            const matchesKeyword = positionText.includes(keyword) || companyText.includes(keyword);
            const matchesStatus = (status === '' || cardStatus === status);

            if (matchesKeyword && matchesStatus) {
                card.style.display = 'flex'; // Show the card
            } else {
                card.style.display = 'none'; // Hide the card
            }
        });
    }

    // Modal JavaScript functions
    const addJobModal = document.getElementById('addJobModal');

    function openAddJobModal() {
        addJobModal.style.display = 'flex'; // Use flex to center the modal
    }

    function closeAddJobModal() {
        addJobModal.style.display = 'none';
    }

    // Close the modal if the user clicks outside of it
    window.onclick = function(event) {
        if (event.target == addJobModal) {
            closeAddJobModal();
        }
    }

    // Optional: Add Font Awesome for icons (if not already in your main admin.jsp)
    // You would typically include this in your overall admin.jsp header.
    // This ensures icons like the briefcase in job cards and the close button are displayed.
    const fontAwesomeLink = document.createElement('link');
    fontAwesomeLink.href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css";
    fontAwesomeLink.rel = "stylesheet";
    document.head.appendChild(fontAwesomeLink);
</script>

</body>
</html>