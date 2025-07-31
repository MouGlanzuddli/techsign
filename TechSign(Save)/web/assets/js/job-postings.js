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

// --- MOCK DATA FOR DEMO PURPOSES ---
// If the fetch to the backend returns an empty array, use mock data instead.

// [REMOVED useMockCompaniesAndJobs and all related mock data]

// Patch loadCompanies to use mock data if fetch fails or returns empty
function loadCompanies() {
    const container = document.getElementById('companiesContainer');
    container.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Đang tải danh sách công ty...</p>
        </div>
    `

    // Try to fetch real data (replace with your actual API call if needed)
    fetch('/TechSign/CompanyPostingServlet?action=getCompanies')
        .then(response => response.json())
        .then(data => {
            if (data.companies && data.companies.length > 0) {
                allCompanies = data.companies;
                renderCompanies();
                updateStats();
            } else {
                allCompanies = [];
                renderCompanies();
                updateStats();
            }
        })
        .catch(() => {
            allCompanies = [];
            renderCompanies();
            updateStats();
        });
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

// Patch loadJobsForCompany to use mock data if fetch fails or returns empty
function loadJobsForCompany(companyId) {
    const jobsGrid = document.getElementById('jobsGrid');
    jobsGrid.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner"></i>
            <p>Đang tải tin tuyển dụng...</p>
        </div>
    `;
    fetch(`/TechSign/CompanyPostingServlet?action=getJobsByCompany&companyId=${companyId}`)
        .then(response => response.json())
        .then(data => {
            if (data.jobs && data.jobs.length > 0) {
                allJobs = data.jobs;
                filteredJobs = [...allJobs];
                renderJobs();
                updateJobStats();
            } else {
                allJobs = [];
                filteredJobs = [];
                renderJobs();
                updateJobStats();
            }
        })
        .catch(() => {
            allJobs = [];
            filteredJobs = [];
            renderJobs();
            updateJobStats();
        });
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
    // Add dropdown menu CSS/JS if not already present
    if (!document.getElementById('job-list-dropdown-style')) {
        const style = document.createElement('style');
        style.id = 'job-list-dropdown-style';
        style.innerHTML = `
        .job-row-menu { position: relative; display: inline-block; }
        .job-row-menu-btn { background: none; border: none; font-size: 1.3rem; cursor: pointer; padding: 4px 8px; border-radius: 50%; transition: background 0.2s; }
        .job-row-menu-btn:hover { background: #f3f4f6; }
        .job-row-dropdown { display: none; position: absolute; right: 0; top: 28px; min-width: 120px; background: #fff; box-shadow: 0 2px 8px rgba(0,0,0,0.08); border-radius: 8px; z-index: 10; }
        .job-row-dropdown.show { display: block; }
        .job-row-dropdown button { width: 100%; background: none; border: none; padding: 10px 16px; text-align: left; font-size: 1rem; cursor: pointer; transition: background 0.2s; }
        .job-row-dropdown button:hover { background: #f3f4f6; }
        `;
        document.head.appendChild(style);
    }
    // Dropdown JS: close on click outside
    if (!window.__jobRowDropdownListener) {
        window.addEventListener('click', function(e) {
            document.querySelectorAll('.job-row-dropdown.show').forEach(dd => dd.classList.remove('show'));
        });
        window.__jobRowDropdownListener = true;
    }
    const jobsHTML = `<div class="job-list-modern" style="box-shadow:0 2px 8px rgba(0,0,0,0.08);border:1px solid #e5e7eb;border-radius:14px;background:#fff;overflow:hidden;padding:24px 32px;">${filteredJobs.map((job, idx) => {
        let salary = '';
        if (job.salaryMin !== undefined && job.salaryMax !== undefined && job.salaryMin !== null && job.salaryMax !== null) {
            salary = `${job.salaryMin} - ${job.salaryMax} triệu VND`;
        } else if (job.salaryMin !== undefined && job.salaryMin !== null) {
            salary = `Từ ${job.salaryMin} triệu VND`;
        } else if (job.salaryMax !== undefined && job.salaryMax !== null) {
            salary = `Đến ${job.salaryMax} triệu VND`;
        } else {
            salary = job.salary || 'Thương lượng';
        }
        const companyName = job.companyName || job.company || '';
        const postedDate = (job.postedAt || job.postedDate || '').toString().split('T')[0];
        const statusClass = `status-badge status-${job.status}`;
        const statusText = getStatusName(job.status);
        const menuId = `job-row-menu-${idx}`;
        return `
        <div class="job-list-row" style="display:flex;align-items:center;justify-content:space-between;padding:20px 0;border-bottom:1px solid #e5e7eb;">
            <div style="flex:1;min-width:0;">
                <div style="font-size:1.15rem;font-weight:600;line-height:1.2;">${job.title}</div>
                <div style="color:#666;font-size:0.98rem;display:flex;align-items:center;gap:12px;margin-top:2px;">
                    <span><i class="fas fa-building"></i> ${companyName}</span>
                </div>
                <div style="color:#444;font-size:0.97rem;display:flex;align-items:center;gap:18px;margin-top:4px;">
                    <span><i class="fas fa-map-marker-alt"></i> ${job.location}</span>
                    <span><i class="fas fa-money-bill-wave"></i> ${salary}</span>
                    <span><i class="fas fa-calendar"></i> ${postedDate}</span>
                </div>
            </div>
            <div style="display:flex;align-items:center;gap:24px;">
                <span class="${statusClass}" style="font-size:0.98rem;min-width:60px;text-align:center;">${statusText}</span>
                <div class="job-row-menu">
                    <button class="job-row-menu-btn" onclick="event.stopPropagation();document.getElementById('${menuId}').classList.toggle('show');">&#8942;</button>
                    <div class="job-row-dropdown" id="${menuId}">
                        <button onclick="viewJobDetails(${job.id}); event.stopPropagation();">View Details</button>
                        <button onclick="deleteJob(${job.id}); event.stopPropagation();">Delete</button>
                    </div>
                </div>
            </div>
        </div>
        `;
    }).join('')}</div>`;
    jobsGrid.innerHTML = jobsHTML;
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

function updateJobStatus(jobId, status) {
    // Tìm job theo id
    const job = allJobs.find(j => j.id === jobId);
    if (!job) return;
    // Nếu duyệt thì chuyển sang active
    if (status === 'active') {
        job.status = 'active';
        // Kiểm tra nếu đã hết hạn thì chuyển thành inactive
        const now = new Date();
        if (job.expiredAt && new Date(job.expiredAt) < now) {
            job.status = 'inactive';
        }
    } else {
        job.status = status;
    }
    renderJobs();
    updateJobStats();
    showMessage('Cập nhật trạng thái thành công!', 'success');
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