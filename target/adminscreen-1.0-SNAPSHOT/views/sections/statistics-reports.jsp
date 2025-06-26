<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê & Báo cáo</title>
    <style>
        /* General Section Styling */
        #statistics-reports-container section {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            padding: 24px;
            border-radius: 12px;
            margin-bottom: 24px;
            border: 1px solid #e9ecef;
        }

        .section-header {
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid #dee2e6;
        }

        .section-header h3 {
            font-size: 24px;
            font-weight: 600;
            color: #343a40;
            margin: 0;
        }

        /* Filter Controls */
        .filter-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            margin-bottom: 24px;
        }

        .filter-container h4 {
            font-size: 18px;
            font-weight: 600;
            color: #495057;
            margin-top: 0;
            margin-bottom: 16px;
        }

        .filter-group {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            align-items: flex-end; /* Align items to the bottom */
        }

        .filter-item {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .filter-item label {
            font-size: 14px;
            font-weight: 500;
            color: #0056b3;
        }
        
        .filter-item select, .filter-item input[type="text"] {
            padding: 10px 14px;
            font-size: 14px;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            min-width: 200px;
            background-color: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .filter-item select:focus, .filter-item input[type="text"]:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0,123,255,0.25);
            outline: none;
        }

        .btn-filter {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: 500;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.1s;
        }

        .btn-filter:hover {
            background-color: #0056b3;
            transform: translateY(-1px);
        }

        /* Modern Table Styling */
        .report-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            border-radius: 8px;
            overflow: hidden;
        }

        .report-table th, .report-table td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }

        .report-table thead th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .report-table tbody tr {
            transition: background-color 0.2s;
        }

        .report-table tbody tr:last-child td {
            border-bottom: none;
        }

        .report-table tbody tr:hover {
            background-color: #f1f3f5;
        }
        
        .action-btn {
             background-color: #17a2b8;
             color: white;
             border: none;
             padding: 8px 14px;
             font-size: 13px;
             border-radius: 6px;
             cursor: pointer;
             transition: background-color 0.3s;
        }
        .action-btn:hover {
            background-color: #138496;
        }
    </style>
</head>
<body>

<div id="statistics-reports-container">

    <!-- Thống kê tài khoản -->
    <section id="account-stats">
        <div class="section-header"><h3>Thống kê Tài khoản</h3></div>
        <div class="filter-container">
            <h4>Lọc thống kê</h4>
            <div class="filter-group">
                <div class="filter-item">
                    <label for="time-filter-account">Thời gian</label>
                    <select id="time-filter-account">
                        <option value="week">Tuần này</option>
                        <option value="month">Tháng này</option>
                        <option value="year">Năm nay</option>
                    </select>
                </div>
                <button class="btn-filter">Xem thống kê</button>
            </div>
        </div>
        <table class="report-table">
            <thead>
                <tr>
                    <th>Loại tài khoản</th>
                    <th>Số lượng</th>
                    <th>Tỷ lệ</th>
                </tr>
            </thead>
            <tbody>
                <tr><td>Admin</td><td>10</td><td>5%</td></tr>
                <tr><td>Người dùng</td><td>190</td><td>95%</td></tr>
            </tbody>
        </table>
    </section>

    <!-- Thống kê truy cập -->
    <section id="access-stats">
        <div class="section-header"><h3>Thống kê Truy cập</h3></div>
        <div class="filter-container">
            <h4>Lọc thống kê</h4>
            <div class="filter-group">
                <div class="filter-item">
                    <label for="time-filter-access">Thời gian</label>
                    <select id="time-filter-access">
                        <option value="week">Tuần này</option>
                        <option value="month">Tháng này</option>
                        <option value="year">Năm nay</option>
                    </select>
                </div>
                <button class="btn-filter">Xem thống kê</button>
            </div>
        </div>
        <table class="report-table">
            <thead>
                <tr>
                    <th>Ngày</th>
                    <th>Lượt truy cập</th>
                    <th>Người dùng hoạt động</th>
                </tr>
            </thead>
            <tbody>
                <tr><td>2025-06-14</td><td>1,234</td><td>567</td></tr>
            </tbody>
        </table>
    </section>

    <!-- Báo cáo hoạt động -->
    <section id="activity-reports">
        <div class="section-header"><h3>Báo cáo Hoạt động</h3></div>
        <table class="report-table">
            <thead>
                <tr>
                    <th>Thời gian</th>
                    <th>Người dùng</th>
                    <th>Hành động</th>
                    <th>Mô tả</th>
                    <th>Địa chỉ IP</th>
                </tr>
            </thead>
            <tbody>
                <tr><td>2025-06-14 10:30:15</td><td>admin@example.com</td><td>Đăng nhập</td><td>Đăng nhập thành công vào hệ thống quản trị</td><td>192.168.1.100</td></tr>
                <tr><td>2025-06-14 10:35:01</td><td>user@example.com</td><td>Tạo tin tuyển dụng</td><td>Đã tạo tin tuyển dụng "Lập trình viên Fullstack"</td><td>203.0.113.5</td></tr>
            </tbody>
        </table>
    </section>

    <!-- Báo cáo tuyển dụng -->
    <section id="job-posting-reports">
        <div class="section-header"><h3>Báo cáo Tuyển dụng theo Doanh nghiệp</h3></div>
        <div class="filter-container">
            <h4>Tìm kiếm & Lọc</h4>
            <div class="filter-group">
                <div class="filter-item">
                    <label for="business-search">Tìm kiếm Doanh nghiệp</label>
                    <input type="text" id="business-search" placeholder="Nhập tên doanh nghiệp..." />
                </div>
                <div class="filter-item">
                    <label for="industry-filter">Ngành nghề</label>
                    <select id="industry-filter">
                        <option value="">Tất cả</option>
                        <option value="IT">Công nghệ thông tin</option>
                    </select>
                </div>
                <div class="filter-item">
                    <label for="report-time-filter">Thời gian</label>
                    <select id="report-time-filter">
                        <option value="week">Tuần này</option>
                        <option value="month">Tháng này</option>
                    </select>
                </div>
                <button class="btn-filter">Áp dụng bộ lọc</button>
            </div>
        </div>
        <table class="report-table">
            <thead>
                <tr>
                    <th>ID Doanh nghiệp</th>
                    <th>Tên Doanh nghiệp</th>
                    <th>Tổng số tin</th>
                    <th>Tổng ứng tuyển</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <tr><td>B001</td><td>ABC Tech Solutions</td><td>15</td><td>120</td><td><button class="action-btn view-btn">Xem chi tiết</button></td></tr>
                <tr><td>B002</td><td>Global Marketing</td><td>8</td><td>70</td><td><button class="action-btn view-btn">Xem chi tiết</button></td></tr>
            </tbody>
        </table>
    </section>

    <!-- Phân tích ứng dụng -->
    <section id="application-analysis">
        <div class="section-header"><h3>Phân tích Ứng dụng</h3></div>
        <div class="filter-container">
            <h4>Lọc phân tích</h4>
            <div class="filter-group">
                <div class="filter-item">
                    <label>Thời gian</label>
                    <select><option value="week">Tuần này</option></select>
                </div>
                <button class="btn-filter">Xem phân tích</button>
            </div>
        </div>
        <table class="report-table">
            <thead>
                <tr>
                    <th>Vị trí</th>
                    <th>Số ứng tuyển</th>
                    <th>Tỷ lệ chấp nhận</th>
                </tr>
            </thead>
            <tbody>
                <tr><td>Lập trình viên Java</td><td>50</td><td>20%</td></tr>
            </tbody>
        </table>
    </section>

</div>

</body>
</html> 