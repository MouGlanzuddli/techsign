<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Người dùng</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"> 
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modal_styles.css"> 

    <style>
        /* Inline styles from your previous code */
        .header-bar {
            display: flex;
            align-items: center;
            gap: 10px;
            background-color: #f9fafb;
            padding: 16px;
            border-radius: 8px;
            max-width: 800px;
            margin: 20px auto;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .search-input {
            flex-grow: 1;
            padding: 10px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            outline: none;
            transition: border-color 0.2s;
        }

        .search-input:focus {
            border-color: #1e88e5;
        }

        .btn-add {
            background-color: #1e88e5;
            color: white;
            border: none;
            padding: 10px 16px;
            font-size: 14px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-add:hover {
            background-color: #1565c0;
        }

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
            <h3 class="mb-3">Lịch sử Truy cập</h3>
            <!-- Loading Spinner -->
            <div id="loadingSpinner" class="d-flex flex-column align-items-center justify-content-center py-5 text-secondary">
                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                <p class="mb-0">Đang tải dữ liệu lịch sử truy cập...</p>
            </div>
            <!-- Table Container -->
            <div id="tableContainer" style="display: none;">
                <div class="table-responsive">
                    <table id="loginHistoryTable" class="table table-bordered table-hover align-middle">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>User ID</th>
                                <th>Thời gian</th>
                                <th>IP Address</th>
                                <th>Device Info</th>
                            </tr>
                        </thead>
                        <tbody id="loginHistoryTableBody">
                            <!-- Data will be populated by JavaScript -->
                        </tbody>
                    </table>
                </div>
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
</body>
</html>