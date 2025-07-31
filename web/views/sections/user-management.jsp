<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Người dùng</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="/assets/css/admin.css"> 
    <link rel="stylesheet" href="/assets/css/modal_styles.css"> 
    <link rel="stylesheet" href="/assets/css/ui-common.css"> 

    <style>
        /* Inline styles from your previous code */
        .loading-spinner {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .loading-spinner i {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #2563eb;
            color: white;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        /* Search and filter styles */
        .search-filter-container {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #e9ecef;
        }

        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: end;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-group label {
            font-weight: 600;
            margin-bottom: 5px;
            color: #495057;
        }

        .filter-actions {
            display: flex;
            gap: 10px;
            align-items: end;
        }

        .btn-filter {
            background: #2563eb;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-filter:hover {
            background: #1d4ed8;
        }

        .btn-clear {
            background: #6c757d;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-clear:hover {
            background: #5a6268;
        }

        .pagination-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            gap: 10px;
        }

        .pagination-info {
            color: #6c757d;
            font-size: 14px;
        }

        .table-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .table-header {
            background: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-title {
            font-size: 18px;
            font-weight: 600;
            color: #495057;
        }

        .table-actions {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="container py-4">
        <h2 class="mb-4"><i class="fas fa-history me-2"></i>Lịch sử Truy cập</h2>
        
        <!-- Search and Filter Bar -->
        <div class="search-filter-container">
            <h5 class="mb-3"><i class="fas fa-search me-2"></i>Tìm kiếm & Lọc</h5>
            <form id="searchFilterForm">
                <div class="filter-row">
                    <div class="filter-group">
                        <label for="searchTerm">Từ khóa tìm kiếm</label>
                        <input type="text" id="searchTerm" name="searchTerm" class="form-control" 
                               placeholder="Tìm theo tên, email, IP, thiết bị...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="userId">Người dùng</label>
                        <select id="userId" name="userId" class="form-select">
                            <option value="">Tất cả người dùng</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="dateFrom">Từ ngày</label>
                        <input type="date" id="dateFrom" name="dateFrom" class="form-control">
                    </div>
                    
                    <div class="filter-group">
                        <label for="dateTo">Đến ngày</label>
                        <input type="date" id="dateTo" name="dateTo" class="form-control">
                    </div>
                    
                    <div class="filter-group">
                        <label for="ipAddress">Địa chỉ IP</label>
                        <select id="ipAddress" name="ipAddress" class="form-select">
                            <option value="">Tất cả IP</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="deviceInfo">Thiết bị</label>
                        <input type="text" id="deviceInfo" name="deviceInfo" class="form-control" 
                               placeholder="Nhập thông tin thiết bị...">
                    </div>
                    
                    <div class="filter-actions">
                        <button type="submit" class="btn btn-filter">
                            <i class="fas fa-search me-1"></i>Tìm kiếm
                        </button>
                        <button type="button" class="btn btn-clear" onclick="clearFilters()">
                            <i class="fas fa-times me-1"></i>Xóa bộ lọc
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <section id="user-management">
            <div class="table-container">
                <div class="table-header">
                    <div class="table-title">
                        <i class="fas fa-history me-2"></i>Lịch sử Truy cập
                    </div>
                    <div class="table-actions">
                        <button class="btn btn-outline-secondary" id="reloadHistoryBtn" type="button" title="Tải lại lịch sử">
                            <i class="fas fa-sync"></i> Tải lại
                        </button>
                        <button class="btn btn-outline-primary" id="exportBtn" type="button" title="Xuất dữ liệu">
                            <i class="fas fa-download"></i> Xuất
                        </button>
                    </div>
                </div>
                
                <div class="loading-spinner" id="loadingSpinner" style="display: none;">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2">Đang tải dữ liệu lịch sử truy cập...</p>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover" id="loginHistoryTable">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Người dùng</th>
                                <th>Email</th>
                                <th>Thời gian đăng nhập</th>
                                <th>IP Address</th>
                                <th>Thiết bị</th>
                            </tr>
                        </thead>
                        <tbody id="loginHistoryTableBody">
                            <!-- Data will be loaded dynamically -->
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <div class="pagination-container" id="paginationContainer" style="display: none;">
                    <div class="pagination-info" id="paginationInfo"></div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination" id="pagination">
                            <!-- Pagination will be generated dynamically -->
                        </ul>
                    </nav>
                </div>
            </div>
        </section>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Global variables
        let currentPage = 1;
        let pageSize = 20;
        let totalPages = 1;
        let totalCount = 0;
        let currentFilters = {};

        // Initialize when document is ready
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Access history page initialized');
            
            // Load filter options
            loadFilterOptions();
            
            // Load initial data
            loadAccessHistory();
            
            // Set up event listeners
            setupEventListeners();
        });

        function setupEventListeners() {
            // Search form submission
            const searchForm = document.getElementById('searchFilterForm');
            if (searchForm) {
                searchForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    currentPage = 1; // Reset to first page
                    loadAccessHistory();
                });
            }

            // Reload button
            const reloadBtn = document.getElementById('reloadHistoryBtn');
            if (reloadBtn) {
                reloadBtn.addEventListener('click', function() {
                    loadAccessHistory();
                });
            }

            // Export button
            const exportBtn = document.getElementById('exportBtn');
            if (exportBtn) {
                exportBtn.addEventListener('click', function() {
                    exportData();
                });
            }
        }

        function loadFilterOptions() {
            const basePath = getBasePath();
            
            fetch(`${basePath}LoginHistoryServlet?action=getFilterOptions`)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        populateUserDropdown(data.users);
                        populateIPDropdown(data.ipAddresses);
                    }
                })
                .catch(error => {
                    console.error('Error loading filter options:', error);
                });
        }

        function populateUserDropdown(users) {
            const userSelect = document.getElementById('userId');
            if (userSelect && users) {
                users.forEach(user => {
                    const option = document.createElement('option');
                    option.value = user.split(' - ')[0]; // Get user ID
                    option.textContent = user;
                    userSelect.appendChild(option);
                });
            }
        }

        function populateIPDropdown(ipAddresses) {
            const ipSelect = document.getElementById('ipAddress');
            if (ipSelect && ipAddresses) {
                ipAddresses.forEach(ip => {
                    const option = document.createElement('option');
                    option.value = ip;
                    option.textContent = ip;
                    ipSelect.appendChild(option);
                });
            }
        }

        function loadAccessHistory() {
            showLoading();
            
            const formData = new FormData(document.getElementById('searchFilterForm'));
            formData.append('page', currentPage);
            formData.append('pageSize', pageSize);
            
            const basePath = getBasePath();
            
            fetch(`${basePath}LoginHistoryServlet?action=searchAndFilter`, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    populateTable(data.loginHistory);
                    updatePagination(data);
                    hideLoading();
                } else {
                    showError(data.message || 'Lỗi khi tải dữ liệu');
                }
            })
            .catch(error => {
                console.error('Error loading access history:', error);
                showError('Lỗi kết nối mạng');
            });
        }

        function populateTable(loginHistory) {
            const tableBody = document.getElementById('loginHistoryTableBody');
            if (!tableBody) return;

            tableBody.innerHTML = '';

            if (loginHistory && loginHistory.length > 0) {
                loginHistory.forEach(history => {
                    const row = document.createElement('tr');
                    
                    // Format the login time
                    const loginTime = new Date(history.loginTime);
                    const formattedTime = loginTime.toLocaleString('vi-VN');
                    
                    row.innerHTML = `
                        <td>${history.id}</td>
                        <td>${history.userName || 'N/A'}</td>
                        <td>${history.userEmail || 'N/A'}</td>
                        <td>${formattedTime}</td>
                        <td>${history.ipAddress || '-'}</td>
                        <td>${history.deviceInfo || '-'}</td>
                    `;
                    
                    tableBody.appendChild(row);
                });
            } else {
                const row = document.createElement('tr');
                row.innerHTML = '<td colspan="6" class="text-center py-4">Không có dữ liệu lịch sử truy cập.</td>';
                tableBody.appendChild(row);
            }
        }

        function updatePagination(data) {
            currentPage = data.currentPage;
            pageSize = data.pageSize;
            totalPages = data.totalPages;
            totalCount = data.totalCount;

            const paginationContainer = document.getElementById('paginationContainer');
            const paginationInfo = document.getElementById('paginationInfo');
            const pagination = document.getElementById('pagination');

            if (totalPages > 1) {
                paginationContainer.style.display = 'flex';
                
                // Update pagination info
                const start = (currentPage - 1) * pageSize + 1;
                const end = Math.min(currentPage * pageSize, totalCount);
                paginationInfo.textContent = `Hiển thị ${start}-${end} trong tổng số ${totalCount} bản ghi`;

                // Generate pagination buttons
                pagination.innerHTML = '';
                
                // Previous button
                const prevLi = document.createElement('li');
                prevLi.className = `page-item ${currentPage === 1 ? 'disabled' : ''}`;
                prevLi.innerHTML = `<a class="page-link" href="#" onclick="changePage(${currentPage - 1})">Trước</a>`;
                pagination.appendChild(prevLi);

                // Page numbers
                for (let i = 1; i <= totalPages; i++) {
                    if (i === 1 || i === totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) {
                        const li = document.createElement('li');
                        li.className = `page-item ${i === currentPage ? 'active' : ''}`;
                        li.innerHTML = `<a class="page-link" href="#" onclick="changePage(${i})">${i}</a>`;
                        pagination.appendChild(li);
                    } else if (i === currentPage - 3 || i === currentPage + 3) {
                        const li = document.createElement('li');
                        li.className = 'page-item disabled';
                        li.innerHTML = '<span class="page-link">...</span>';
                        pagination.appendChild(li);
                    }
                }

                // Next button
                const nextLi = document.createElement('li');
                nextLi.className = `page-item ${currentPage === totalPages ? 'disabled' : ''}`;
                nextLi.innerHTML = `<a class="page-link" href="#" onclick="changePage(${currentPage + 1})">Sau</a>`;
                pagination.appendChild(nextLi);
            } else {
                paginationContainer.style.display = 'none';
            }
        }

        function changePage(page) {
            if (page >= 1 && page <= totalPages) {
                currentPage = page;
                loadAccessHistory();
            }
        }

        function clearFilters() {
            document.getElementById('searchFilterForm').reset();
            currentPage = 1;
            loadAccessHistory();
        }

        function showLoading() {
            const spinner = document.getElementById('loadingSpinner');
            const table = document.getElementById('loginHistoryTable');
            if (spinner) spinner.style.display = 'block';
            if (table) table.style.display = 'none';
        }

        function hideLoading() {
            const spinner = document.getElementById('loadingSpinner');
            const table = document.getElementById('loginHistoryTable');
            if (spinner) spinner.style.display = 'none';
            if (table) table.style.display = 'table';
        }

        function showError(message) {
            const tableBody = document.getElementById('loginHistoryTableBody');
            if (tableBody) {
                tableBody.innerHTML = `
                    <tr>
                        <td colspan="6" class="text-center text-danger py-4">
                            <i class="fas fa-exclamation-circle me-2"></i>${message}
                        </td>
                    </tr>
                `;
            }
            hideLoading();
        }

        function exportData() {
            const formData = new FormData(document.getElementById('searchFilterForm'));
            formData.append('export', 'true');
            
            const basePath = getBasePath();
            
            fetch(`${basePath}LoginHistoryServlet?action=searchAndFilter`, {
                method: 'POST',
                body: formData
            })
            .then(response => response.blob())
            .then(blob => {
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = 'access_history.csv';
                document.body.appendChild(a);
                a.click();
                window.URL.revokeObjectURL(url);
                document.body.removeChild(a);
            })
            .catch(error => {
                console.error('Error exporting data:', error);
                alert('Lỗi khi xuất dữ liệu');
            });
        }

        function getBasePath() {
            const path = window.location.pathname;
            const idx = path.indexOf('/', 1);
            return idx > 0 ? path.substring(0, idx + 1) : '/';
        }
    </script>
</body>
</html>