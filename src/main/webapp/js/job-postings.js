// job-postings.js
// Global variables
let allCompanies = [];
let allJobs = [];
let filteredJobs = [];
let selectedCompanyId = null;

// Load companies on page load
if (typeof document !== 'undefined') {
    document.addEventListener('DOMContentLoaded', function() {
        loadCompanies();
    });
}

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
            { id: 1, name: "TechCorp", logo: "TC", location: "Hà Nội", jobCount: 5 },
            { id: 2, name: "DesignStudio", logo: "DS", location: "TP.HCM", jobCount: 3 },
            { id: 3, name: "FinanceHub", logo: "FH", location: "Đà Nẵng", jobCount: 2 },
            { id: 4, name: "MarketingPro", logo: "MP", location: "Hà Nội", jobCount: 4 },
            { id: 5, name: "EduTech", logo: "ET", location: "TP.HCM", jobCount: 3 },
            { id: 6, name: "HealthCare", logo: "HC", location: "Hà Nội", jobCount: 2 }
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
        <div class="company-card${selectedCompanyId === company.id ? ' selected' : ''}" onclick="selectCompany(${company.id})">
            <div class="company-logo">${company.companyName ? company.companyName[0] : (company.name ? company.name[0] : '')}</div>
            <div class="company-name">${company.companyName || company.name || 'Không có tên'}</div>
            <div class="company-info">${company.location || ''}</div>
            <div class="job-count">${company.jobCount || 0} tin tuyển dụng</div>
        </div>
    `).join('');
    container.innerHTML = `<div class="company-grid">${companiesHTML}</div>`;
}

function selectCompany(companyId) {
    selectedCompanyId = companyId;
    renderCompanies(); // update selected state visually
    const company = allCompanies.find(c => c.id === companyId);
    if (company) {
        document.getElementById('selectedCompany').textContent = company.companyName || company.name || '-';
        document.getElementById('companyNameSpan').textContent = company.companyName || company.name || '-';
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
    setTimeout(() => {
        allJobs = [
            { id: 1, companyId: 1, title: "Developer Full-stack", company: "TechCorp", location: "Hà Nội", salary: "20-30 triệu VND", status: "active", description: "Tìm kiếm Developer có kinh nghiệm với Java, Spring Boot, React...", requirements: "3+ năm kinh nghiệm, Java, Spring Boot, React", postedDate: "2024-01-15" },
            { id: 2, companyId: 1, title: "UI/UX Designer", company: "TechCorp", location: "Hà Nội", salary: "15-25 triệu VND", status: "active", description: "Thiết kế giao diện người dùng cho ứng dụng mobile và web...", requirements: "2+ năm kinh nghiệm, Figma, Adobe XD", postedDate: "2024-01-14" },
            { id: 3, companyId: 1, title: "DevOps Engineer", company: "TechCorp", location: "Hà Nội", salary: "25-35 triệu VND", status: "pending", description: "Quản lý infrastructure và deployment pipeline...", requirements: "4+ năm kinh nghiệm, Docker, Kubernetes, AWS", postedDate: "2024-01-13" }
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
    window.location.href = `JobDetailServlet?action=view&id=${jobId}`;
}

function editJob(jobId) {
    window.location.href = `JobPostingServlet?action=edit&id=${jobId}`;
}

function deleteJob(jobId) {
    if (confirm('Bạn có chắc chắn muốn xóa tin tuyển dụng này?')) {
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
        background-color: ${type === 'success' ? '#28a745' : '#ffc107'};
    `;
    notification.textContent = message;
    document.body.appendChild(notification);
    setTimeout(() => {
        notification.remove();
    }, 3000);
} 