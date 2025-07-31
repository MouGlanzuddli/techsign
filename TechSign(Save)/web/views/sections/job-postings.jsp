<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Tuyển dụng theo Công ty</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="/assets/css/job-postings.css">
</head>
<body>
    <section id="company-jobs">
        <h2><i class="fas fa-building"></i> Quản lý Tuyển dụng theo Công ty</h2>

        <div class="stats-cards modern-stats-cards">
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

        <div class="company-selection modern-company-selection">
            <h3><i class="fas fa-hand-pointer"></i> Chọn công ty để xem tin tuyển dụng</h3>
            <div id="companiesContainer">
                <c:if test="${not empty companies}">
                    <select id="companySelect">
                        <option value="">-- Chọn công ty --</option>
                        <c:forEach var="company" items="${companies}">
                            <option value="${company.id}">${company.companyName}</option>
                        </c:forEach>
                    </select>
                </c:if>
                <c:if test="${empty companies}">
                    <div class="loading">
                        <i class="fas fa-spinner"></i>
                        <p>Đang tải danh sách công ty...</p>
                    </div>
                </c:if>
            </div>
        </div>

        <div id="jobFilterBar" class="filter-bar modern-filter-bar" style="display: none;">
            <select id="statusFilter" class="modern-select">
                <option value="">Tất cả trạng thái</option>
                <option value="active">Đang hoạt động</option>
                <option value="inactive">Không hoạt động</option>
                <option value="pending">Chờ duyệt</option>
            </select>
            <select id="locationFilter" class="modern-select">
                <option value="">Tất cả địa điểm</option>
                <option value="hanoi">Hà Nội</option>
                <option value="hcm">TP.HCM</option>
                <option value="danang">Đà Nẵng</option>
                <option value="remote">Làm việc từ xa</option>
            </select>
            <div class="search-input-wrapper">
                <input type="text" id="searchInput" placeholder="Tìm kiếm tin tuyển dụng..." class="modern-input">
                <i class="fas fa-search search-icon"></i>
            </div>
            <button onclick="applyJobFilters()" class="modern-btn">
                <i class="fas fa-filter"></i> Lọc
            </button>
            <button onclick="refreshJobs()" class="modern-btn">
                <i class="fas fa-sync-alt"></i> Làm mới
            </button>
        </div>

        <div id="jobsContainer" style="display: none;">
            <h3 id="selectedCompanyTitle">Tin tuyển dụng của <span id="companyNameSpan"></span></h3>
            <div id="jobsGrid" class="modern-jobs-grid">
                <div class="loading">
                    <i class="fas fa-spinner"></i>
                    <p>Đang tải tin tuyển dụng...</p>
                </div>
            </div>
        </div>

        
    </section>

    <script src="/assets/js/job-postings.js"></script>
</body>
</html>