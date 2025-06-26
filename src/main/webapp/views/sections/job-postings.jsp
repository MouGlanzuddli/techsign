<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mycompany.adminscreen.model.JobPosting" %>
<%@ page import="com.mycompany.adminscreen.model.CompanyProfile" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Tuyển dụng theo Công ty</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
            margin-bottom: 15px;
            font-weight: bold;
        }

        h2 { font-size: 2em; }
        h3 { font-size: 1.5em; }
        h4 { font-size: 1.2em; }

        /* Company Selection Section */
        .company-selection {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            padding: 25px;
            margin-bottom: 30px;
        }

        .company-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .company-card {
            background: #fff;
            border: 2px solid #e0e7ff;
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }

        .company-card:hover {
            border-color: #007bff;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.15);
        }

        .company-card.selected {
            border-color: #007bff;
            background-color: #f8f9ff;
        }

        .company-logo {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: #e0e7ff;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 24px;
            color: #007bff;
        }

        .company-name {
            font-size: 1.1em;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }

        .company-info {
            font-size: 0.9em;
            color: #666;
        }

        .job-count {
            background-color: #007bff;
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8em;
            font-weight: bold;
            margin-top: 10px;
            display: inline-block;
        }

        /* Filter Bar */
        .filter-bar {
            background-color: #fff;
            padding: 20px 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }

        .filter-bar select,
        .filter-bar input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1em;
        }

        .filter-bar button {
            background-color: #007bff;
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
            background-color: #0056b3;
        }

        /* Job Cards */
        .job-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }

        .job-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            padding: 20px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border: 2px solid transparent;
        }

        .job-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            border-color: #007bff;
        }

        .job-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .job-title {
            font-size: 1.3em;
            font-weight: bold;
            color: #1e3a8a;
            margin: 0;
            line-height: 1.3;
        }

        .job-id {
            font-size: 0.85em;
            color: #888;
            background: #f8f9fa;
            padding: 4px 8px;
            border-radius: 4px;
        }

        .job-meta {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            font-size: 0.9em;
            color: #666;
        }

        .job-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .job-description {
            margin-bottom: 15px;
            line-height: 1.5;
            color: #555;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .job-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-active {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .job-actions {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 8px 16px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9em;
            transition: all 0.2s ease;
        }

        .view-btn {
            background: #007bff;
            color: white;
        }

        .view-btn:hover {
            background: #0056b3;
        }

        .edit-btn {
            background: #28a745;
            color: white;
        }

        .edit-btn:hover {
            background: #218838;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
        }

        .delete-btn:hover {
            background: #c82333;
        }

        /* Stats Cards */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            padding: 20px;
            text-align: center;
        }

        .stat-card h4 {
            color: #1e3a8a;
            margin-bottom: 10px;
            font-size: 1.1em;
        }

        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #007bff;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 4em;
            color: #ddd;
            margin-bottom: 20px;
        }

        /* Loading State */
        .loading {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .loading i {
            font-size: 2em;
            color: #007bff;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <section id="company-jobs">
        <h2><i class="fas fa-building"></i> Quản lý Tuyển dụng theo Công ty</h2>

        <div class="stats-cards">
            <div class="stat-card">
                <h4>Tổng công ty</h4>
                <div class="stat-number" id="totalCompanies">0</div>
            </div>
            <div class="stat-card">
                <h4>Tổng tin tuyển dụng</h4>
                <div class="stat-number" id="totalJobs">0</div>
            </div>
            <div class="stat-card">
                <h4>Tin đang hoạt động</h4>
                <div class="stat-number" id="activeJobs">0</div>
            </div>
            <div class="stat-card">
                <h4>Công ty đã chọn</h4>
                <div class="stat-number" id="selectedCompany">-</div>
            </div>
        </div>

        <div class="company-selection">
            <h3><i class="fas fa-hand-pointer"></i> Chọn công ty để xem tin tuyển dụng</h3>
            <div id="companiesContainer">
                <div class="loading">
                    <i class="fas fa-spinner"></i>
                    <p>Đang tải danh sách công ty...</p>
                </div>
            </div>
        </div>

        <div id="jobFilterBar" class="filter-bar" style="display: none;">
            <select id="statusFilter">
                    <option value="">Tất cả trạng thái</option>
                    <option value="active">Đang hoạt động</option>
                <option value="inactive">Không hoạt động</option>
                    <option value="pending">Chờ duyệt</option>
            </select>
            <select id="locationFilter">
                <option value="">Tất cả địa điểm</option>
                <option value="hanoi">Hà Nội</option>
                <option value="hcm">TP.HCM</option>
                <option value="danang">Đà Nẵng</option>
                <option value="remote">Làm việc từ xa</option>
                </select>
            <input type="text" id="searchInput" placeholder="Tìm kiếm tin tuyển dụng...">
            <button onclick="applyJobFilters()">
                <i class="fas fa-filter"></i> Lọc
            </button>
            <button onclick="refreshJobs()">
                <i class="fas fa-sync-alt"></i> Làm mới
                </button>
        </div>

        <div id="jobsContainer" style="display: none;">
            <h3 id="selectedCompanyTitle">Tin tuyển dụng của <span id="companyNameSpan"></span></h3>
            <div id="jobsGrid">
                <div class="loading">
                    <i class="fas fa-spinner"></i>
                    <p>Đang tải tin tuyển dụng...</p>
                </div>
            </div>
        </div>
    </section>

    <script>
        // Global variables
        let allCompanies = [];
        let allJobs = [];
        let filteredJobs = [];
        let selectedCompanyId = null;

        // Load companies on page load
        document.addEventListener('DOMContentLoaded', function() {
            loadCompanies();
        });

        function loadCompanies() {
            const container = document.getElementById('companiesContainer');
            container.innerHTML = `
                <div class="loading">
                    <i class="fas fa-spinner"></i>
                    <p>Đang tải danh sách công ty...</p>
                </div>
            `;

            // Simulate API call - replace with actual fetch
            setTimeout(() => {
                // Mock data - replace with actual API call
                allCompanies = [
                    {
                        id: 1,
                        name: "TechCorp",
                        logo: "TC",
                        location: "Hà Nội",
                        industry: "Công nghệ",
                        jobCount: 5
                    },
                    {
                        id: 2,
                        name: "DesignStudio",
                        logo: "DS",
                        location: "TP.HCM",
                        industry: "Thiết kế",
                        jobCount: 3
                    },
                    {
                        id: 3,
                        name: "FinanceHub",
                        logo: "FH",
                        location: "Đà Nẵng",
                        industry: "Tài chính",
                        jobCount: 2
                    },
                    {
                        id: 4,
                        name: "MarketingPro",
                        logo: "MP",
                        location: "Hà Nội",
                        industry: "Marketing",
                        jobCount: 4
                    },
                    {
                        id: 5,
                        name: "EduTech",
                        logo: "ET",
                        location: "TP.HCM",
                        industry: "Giáo dục",
                        jobCount: 3
                    },
                    {
                        id: 6,
                        name: "HealthCare",
                        logo: "HC",
                        location: "Hà Nội",
                        industry: "Y tế",
                        jobCount: 2
                    }
                ];

                renderCompanies();
                updateStats();
            }, 1000);
        }

        function renderCompanies() {
            const container = document.getElementById('companiesContainer');
            
            if (allCompanies.length === 0) {
                container.innerHTML = `
                    <div class="empty-state">
                        <i class="fas fa-building"></i>
                        <h3>Không có công ty nào</h3>
                        <p>Chưa có công ty nào được đăng ký trong hệ thống.</p>
                    </div>
                `;
                return;
            }

            const companiesHTML = allCompanies.map(company => `
                <div class="company-card" onclick="selectCompany(${company.id})">
                    <div class="company-logo">${company.logo}</div>
                    <div class="company-name">${company.name}</div>
                    <div class="company-info">
                        <div><i class="fas fa-map-marker-alt"></i> ${company.location}</div>
                        <div><i class="fas fa-industry"></i> ${company.industry}</div>
                    </div>
                    <div class="job-count">${company.jobCount} tin tuyển dụng</div>
                </div>
            `).join('');

            container.innerHTML = `<div class="company-grid">${companiesHTML}</div>`;
        }

        function selectCompany(companyId) {
            // Remove previous selection
            document.querySelectorAll('.company-card').forEach(card => {
                card.classList.remove('selected');
            });

            // Add selection to clicked card
            const selectedCard = document.querySelector(`.company-card[onclick*="${companyId}"]`);
            if (selectedCard) {
                selectedCard.classList.add('selected');
            }

            selectedCompanyId = companyId;
            const company = allCompanies.find(c => c.id === companyId);
            
            if (company) {
                document.getElementById('selectedCompany').textContent = company.name;
                document.getElementById('companyNameSpan').textContent = company.name;
                document.getElementById('jobFilterBar').style.display = 'flex';
                document.getElementById('jobsContainer').style.display = 'block';
                
                loadJobsForCompany(companyId);
            }
        }

        function loadJobsForCompany(companyId) {
            const jobsGrid = document.getElementById('jobsGrid');
            jobsGrid.innerHTML = `
                <div class="loading">
                    <i class="fas fa-spinner"></i>
                    <p>Đang tải tin tuyển dụng...</p>
                </div>
            `;

            // Simulate API call - replace with actual fetch
            setTimeout(() => {
                // Mock data - replace with actual API call
                allJobs = [
                    {
                        id: 1,
                        companyId: 1,
                        title: "Developer Full-stack",
                        company: "TechCorp",
                        location: "Hà Nội",
                        salary: "20-30 triệu VND",
                        status: "active",
                        description: "Tìm kiếm Developer có kinh nghiệm với Java, Spring Boot, React...",
                        requirements: "3+ năm kinh nghiệm, Java, Spring Boot, React",
                        postedDate: "2024-01-15"
                    },
                    {
                        id: 2,
                        companyId: 1,
                        title: "UI/UX Designer",
                        company: "TechCorp",
                        location: "Hà Nội",
                        salary: "15-25 triệu VND",
                        status: "active",
                        description: "Thiết kế giao diện người dùng cho ứng dụng mobile và web...",
                        requirements: "2+ năm kinh nghiệm, Figma, Adobe XD",
                        postedDate: "2024-01-14"
                    },
                    {
                        id: 3,
                        companyId: 1,
                        title: "DevOps Engineer",
                        company: "TechCorp",
                        location: "Hà Nội",
                        salary: "25-35 triệu VND",
                        status: "pending",
                        description: "Quản lý infrastructure và deployment pipeline...",
                        requirements: "4+ năm kinh nghiệm, Docker, Kubernetes, AWS",
                        postedDate: "2024-01-13"
                    }
                ].filter(job => job.companyId === companyId);

                filteredJobs = [...allJobs];
                renderJobs();
                updateJobStats();
            }, 1000);
        }

        function renderJobs() {
            const jobsGrid = document.getElementById('jobsGrid');
            
            if (filteredJobs.length === 0) {
                jobsGrid.innerHTML = `
                    <div class="empty-state">
                <i class="fas fa-briefcase"></i>
                        <h3>Không có tin tuyển dụng nào</h3>
                        <p>Công ty này chưa có tin tuyển dụng nào.</p>
            </div>
                `;
                return;
            }

            const jobsHTML = filteredJobs.map(job => `
                <div class="job-card">
                    <div class="job-header">
                        <h4 class="job-title">${job.title}</h4>
                        <span class="job-id">#${job.id}</span>
    </div>
                    
                    <div class="job-meta">
                        <span><i class="fas fa-building"></i> ${job.company}</span>
                        <span><i class="fas fa-map-marker-alt"></i> ${job.location}</span>
                        <span><i class="fas fa-money-bill-wave"></i> ${job.salary}</span>
                        <span><i class="fas fa-calendar"></i> ${job.postedDate}</span>
                    </div>
                    
                    <div class="job-description">
                        ${job.description}
                    </div>
                    
                    <div class="job-footer">
                        <span class="status-badge status-${job.status}">
                            ${getStatusName(job.status)}
                        </span>
                        <div class="job-actions">
                            <button class="action-btn view-btn" onclick="viewJobDetails(${job.id})">
                                <i class="fas fa-eye"></i> Xem chi tiết
                            </button>
                            <button class="action-btn edit-btn" onclick="editJob(${job.id})">
                                <i class="fas fa-edit"></i> Chỉnh sửa
                            </button>
                            <button class="action-btn delete-btn" onclick="deleteJob(${job.id})">
                                <i class="fas fa-trash"></i> Xóa
                            </button>
        </div>
    </div>
</div>
            `).join('');

            jobsGrid.innerHTML = `<div class="job-grid">${jobsHTML}</div>`;
        }

        function viewJobDetails(jobId) {
            // Navigate to job details page
            window.location.href = `JobDetailServlet?action=view&id=${jobId}`;
        }

        function editJob(jobId) {
            // Navigate to job edit page
            window.location.href = `JobPostingServlet?action=edit&id=${jobId}`;
        }

        function deleteJob(jobId) {
            if (confirm('Bạn có chắc chắn muốn xóa tin tuyển dụng này?')) {
                // Simulate API call
                allJobs = allJobs.filter(job => job.id !== jobId);
                filteredJobs = [...allJobs];
                renderJobs();
                updateJobStats();
                showMessage('Tin tuyển dụng đã được xóa!', 'success');
            }
        }

        function applyJobFilters() {
            const statusFilter = document.getElementById('statusFilter').value;
            const locationFilter = document.getElementById('locationFilter').value;
            const searchInput = document.getElementById('searchInput').value.toLowerCase();

            filteredJobs = allJobs.filter(job => {
                const statusMatch = !statusFilter || job.status === statusFilter;
                const locationMatch = !locationFilter || job.location.toLowerCase().includes(locationFilter);
                const searchMatch = !searchInput || 
                    job.title.toLowerCase().includes(searchInput) ||
                    job.description.toLowerCase().includes(searchInput) ||
                    job.requirements.toLowerCase().includes(searchInput);

                return statusMatch && locationMatch && searchMatch;
            });

            renderJobs();
        }

        function refreshJobs() {
            if (selectedCompanyId) {
                loadJobsForCompany(selectedCompanyId);
            }
        }

        function updateStats() {
            document.getElementById('totalCompanies').textContent = allCompanies.length;
            const totalJobCount = allCompanies.reduce((sum, company) => sum + company.jobCount, 0);
            document.getElementById('totalJobs').textContent = totalJobCount;
        }

        function updateJobStats() {
            document.getElementById('activeJobs').textContent = allJobs.filter(job => job.status === 'active').length;
        }

        function getStatusName(status) {
            const statuses = {
                'active': 'Đang hoạt động',
                'inactive': 'Không hoạt động',
                'pending': 'Chờ duyệt'
            };
            return statuses[status] || status;
        }

        function showMessage(message, type) {
            // Create a simple message notification
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                border-radius: 6px;
                color: white;
                font-weight: bold;
                z-index: 1000;
                background-color: {type === 'success' ? '#28a745' : '#ffc107'};
            `;
            notification.textContent = message;
            document.body.appendChild(notification);
                                                                                
            setTimeout(() => {
                notification.remove();
            }, 3000);
        }
</script>
</body>
</html>