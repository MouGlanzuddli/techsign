<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Người dùng</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
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
    </style>
</head>
<body>
    <div class="container py-4">
        <h2 class="mb-4"><i class="fas fa-history me-2"></i>Quản lý Người dùng</h2>
        <section id="user-management">
            <div class="d-flex align-items-center mb-3" style="gap: 16px;">
                <h2 class="section-title mb-0">
                    <i class="fas fa-history"></i> Lịch sử Truy cập
                </h2>
                <button class="btn btn-outline" id="reloadHistoryBtn" type="button" title="Tải lại lịch sử">
                    <i class="fas fa-sync"></i> Tải lại
                </button>
            </div>
            <div class="loading-spinner" id="loadingSpinner" style="display: none;">
                <div class="spinner"></div>
                <p>Đang tải dữ liệu lịch sử truy cập...</p>
            </div>
            <div class="table-container" id="tableContainer">
                <table class="access-history-table" id="loginHistoryTable">
                    <thead>
                            <tr>
                                <th>ID</th>
                                <th>User ID</th>
                                <th>Thời gian</th>
                                <th>IP Address</th>
                                <th>Device Info</th>
                            </tr>
                        </thead>
                        <tbody id="loginHistoryTableBody">
                        <!-- Rows here, server-side loop or JS render -->
                        </tbody>
                    </table>
            </div>
        </section>
    </div>
    <script>
        // Function to populate the login history table
        function populateUserManagementTable(loginHistory) {
            const tableBody = document.getElementById('loginHistoryTableBody');
            const loadingSpinner = document.getElementById('loadingSpinner');
            const tableContainer = document.getElementById('tableContainer');
            
            if (!tableBody) return;
            
            // Hide loading spinner and show table
            if (loadingSpinner) loadingSpinner.style.display = 'none';
            if (tableContainer) tableContainer.style.display = 'block';
            
            // Clear existing data
            tableBody.innerHTML = '';
            
            if (loginHistory && loginHistory.length > 0) {
                loginHistory.forEach(history => {
                    const row = document.createElement('tr');
                    
                    // Format the login time
                    const loginTime = new Date(history.loginTime);
                    const formattedTime = loginTime.toLocaleString('vi-VN');
                    
                    row.innerHTML = `
                        <td>${history.id}</td>
                        <td>${history.userId}</td>
                        <td>${formattedTime}</td>
                        <td>${history.ipAddress || '-'}</td>
                        <td>${history.deviceInfo || '-'}</td>
                    `;
                    
                    tableBody.appendChild(row);
                });
            } else {
                // Show no data message
                const row = document.createElement('tr');
                row.innerHTML = '<td colspan="5" style="text-align:center;">Không có dữ liệu lịch sử truy cập.</td>';
                tableBody.appendChild(row);
            }
        }
    </script>
    <script>
// Reload button handler for access history
const reloadBtn = document.getElementById('reloadHistoryBtn');
if (reloadBtn) {
  reloadBtn.addEventListener('click', function() {
    // Show spinner, hide table
    const spinner = document.getElementById('loadingSpinner');
    const tableContainer = document.getElementById('tableContainer');
    if (spinner) spinner.style.display = 'flex';
    if (tableContainer) tableContainer.style.display = 'none';
    // Use section loader if available
    if (window.sectionLoader && typeof sectionLoader.loadUserManagementData === 'function') {
      sectionLoader.loadUserManagementData();
    } else if (typeof loadUserManagementData === 'function') {
      loadUserManagementData();
    } else {
      // fallback: reload page
      window.location.reload();
    }
  });
        }
    </script>
</body>
</html>