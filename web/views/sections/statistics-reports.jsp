<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<h2>Thống kê & Báo cáo</h2>
<!-- Thống kê tài khoản -->
<section id="account-stats">
    <h3>Thống kê Tài khoản</h3>
    <div class="form-container">
        <h4>Lọc thống kê</h4>
        <label>Thời gian</label>
        <select>
            <option value="week">Tuần này</option>
            <option value="month">Tháng này</option>
            <option value="year">Năm nay</option>
        </select>
        <button>Xem thống kê</button>
    </div>
    <table>
        <thead>
            <tr>
                <th>Loại tài khoản</th>
                <th>Số lượng</th>
                <th>Tỷ lệ</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Admin</td>
                <td>10</td>
                <td>5%</td>
            </tr>
            <tr>
                <td>Người dùng</td>
                <td>190</td>
                <td>95%</td>
            </tr>
        </tbody>
    </table>
</section>
<!-- Thống kê truy cập -->
<section id="access-stats">
    <h3>Thống kê Truy cập</h3>
    <div class="form-container">
        <h4>Lọc thống kê</h4>
        <label>Thời gian</label>
        <select>
            <option value="week">Tuần này</option>
            <option value="month">Tháng này</option>
            <option value="year">Năm nay</option>
        </select>
        <button>Xem thống kê</button>
    </div>
    <table>
        <thead>
            <tr>
                <th>Ngày</th>
                <th>Lượt truy cập</th>
                <th>Người dùng hoạt động</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>2025-06-14</td>
                <td>1,234</td>
                <td>567</td>
            </tr>
        </tbody>
    </table>
</section>
<!-- Báo cáo hoạt động -->
<section id="activity-reports">
    <h3>Báo cáo Hoạt động</h3>
    <table>
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
            <tr>
                <td>2025-06-14 10:30:15</td>
                <td>admin@example.com</td>
                <td>Đăng nhập</td>
                <td>Đăng nhập thành công vào hệ thống quản trị</td>
                <td>192.168.1.100</td>
            </tr>
            <tr>
                <td>2025-06-14 10:35:01</td>
                <td>user@example.com</td>
                <td>Tạo tin tuyển dụng</td>
                <td>Đã tạo tin tuyển dụng "Lập trình viên Fullstack"</td>
                <td>203.0.113.5</td>
            </tr>
            <tr>
                <td>2025-06-14 10:45:20</td>
                <td>admin@example.com</td>
                <td>Cập nhật danh mục</td>
                <td>Đã thay đổi thứ tự danh mục "Lập trình Frontend"</td>
                <td>192.168.1.100</td>
            </tr>
            <tr>
                <td>2025-06-14 11:00:05</td>
                <td>user2@example.com</td>
                <td>Ứng tuyển</td>
                <td>Đã ứng tuyển vào vị trí "Thiết kế UI/UX"</td>
                <td>198.51.100.20</td>
            </tr>
            </tbody>
    </table>
</section>
<!-- Báo cáo tuyển dụng -->
<section id="job-posting-reports">
    <h3>Báo cáo Tuyển dụng theo Doanh nghiệp</h3>
    <div class="form-container">
        <h4>Tìm kiếm & Lọc</h4>
        <label for="business-search">Tìm kiếm Doanh nghiệp:</label>
        <input type="text" id="business-search" placeholder="Nhập tên doanh nghiệp..." />

        <label for="industry-filter">Ngành nghề:</label>
        <select id="industry-filter">
            <option value="">Tất cả</option>
            <option value="IT">Công nghệ thông tin</option>
            <option value="Marketing">Marketing</option>
            <option value="Finance">Tài chính</option>
            <option value="Healthcare">Y tế</option>
            </select>

        <label for="report-time-filter">Thời gian:</label>
        <select id="report-time-filter">
            <option value="week">Tuần này</option>
            <option value="month">Tháng này</option>
            <option value="quarter">Quý này</option>
            <option value="year">Năm nay</option>
        </select>
        
        <button>Áp dụng bộ lọc</button>
        </div>
    <table>
        <thead>
            <tr>
                <th>ID Doanh nghiệp</th>
                <th>Tên Doanh nghiệp</th>
                <th>Ngành nghề</th>
                <th>Tổng số tin tuyển dụng</th>
                <th>Tổng số ứng tuyển</th>
                <th>Tỷ lệ chuyển đổi (%)</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>B001</td>
                <td>ABC Tech Solutions</td>
                <td>Công nghệ thông tin</td>
                <td>15</td>
                <td>120</td>
                <td>8.00</td>
                <td>
                    <button class="action-btn view-btn">Xem chi tiết</button>
                </td>
            </tr>
            <tr>
                <td>B002</td>
                <td>Global Marketing Agency</td>
                <td>Marketing</td>
                <td>8</td>
                <td>70</td>
                <td>8.75</td>
                <td>
                    <button class="action-btn view-btn">Xem chi tiết</button>
                </td>
            </tr>
            <tr>
                <td>B003</td>
                <td>Future Finance Corp.</td>
                <td>Tài chính</td>
                <td>5</td>
                <td>30</td>
                <td>6.00</td>
                <td>
                    <button class="action-btn view-btn">Xem chi tiết</button>
                </td>
            </tr>
            </tbody>
    </table>
</section>
<!-- Phân tích ứng dụng -->
<section id="application-analysis">
    <h3>Phân tích Ứng dụng</h3>
    <div class="form-container">
        <h4>Lọc phân tích</h4>
        <label>Thời gian</label>
        <select>
            <option value="week">Tuần này</option>
            <option value="month">Tháng này</option>
            <option value="year">Năm nay</option>
        </select>
        <button>Xem phân tích</button>
    </div>
    <table>
        <thead>
            <tr>
                <th>Vị trí</th>
                <th>Số ứng tuyển</th>
                <th>Tỷ lệ chấp nhận</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Lập trình viên Java</td>
                <td>50</td>
                <td>20%</td>
            </tr>
        </tbody>
    </table>
</section> 