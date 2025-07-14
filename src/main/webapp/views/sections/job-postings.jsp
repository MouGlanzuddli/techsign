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
    <link rel="stylesheet" href="/css/job-postings.css">
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

        <!-- Remove the static companySelect dropdown from here -->
        <!-- Only keep the job table below -->
        <table id="jobTable" border="1" style="margin-top:20px; width:100%;">
            <thead>
                <tr>
                    <th>Tiêu đề</th>
                    <th>Địa điểm</th>
                    <th>Trạng thái</th>
                    <th>Ngày đăng</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </section>

    <script src="/js/job-postings.js"></script>
</body>
</html>