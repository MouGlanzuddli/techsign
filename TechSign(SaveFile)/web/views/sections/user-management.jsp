<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="addUser.jsp" />

<head>
<style>
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
</style>
</head>
<h2>Quản lý Người dùng</h2>

<!-- Quản lý tài khoản -->
<section id="user-accounts" class="user-management">
    <div class="header-bar">
    <input type="text" class="search-input" name="searchQuery" placeholder="Tìm tài khoản theo tên hoặc email" />
    <button class="btn-add" onclick="searchUser()">Tìm kiếm</button>
   <button class="btn-add" onclick="openModal()">+ Thêm tài khoản</button>

</div>

    <table class="user-table">
        <thead>
            <tr>
                <th>Tên nhân viên</th>
                <th>Quyền truy cập</th>
                <th>Trạng thái</th>
                <th>Ngày tạo</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <div class="user-info">
                        <div class="avatar bg-green">A</div>
                        <div>
                            <div class="name">Nguyễn Văn A</div>
                            <div class="email">nguyenvana@mail.com</div>
                        </div>
                    </div>
                </td>
                <td>Admin<br><span class="note">(trừ cài app, tạo nhân viên)</span></td>
                <td class="status-active">Hoạt động</td>
                <td>Hôm qua lúc 09:34 SA</td>
                <td class="actions">
                    <i class="fas fa-edit edit-btn"></i>
                    <i class="fas fa-trash delete-btn"></i>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="user-info">
                        <div class="avatar bg-blue">B</div>
                        <div>
                            <div class="name">Trần Thị B</div>
                            <div class="email">tranthib@mail.com</div>
                        </div>
                    </div>
                </td>
                <td>Người dùng</td>
                <td class="status-invite">Khóa</td>
                <td>27/10/2023 05:22 CH</td>
                <td class="actions">
                    <i class="fas fa-edit edit-btn"></i>
                    <i class="fas fa-trash delete-btn"></i>
                </td>
            </tr>
        </tbody>
    </table>
    
</section>
<script src="${pageContext.request.contextPath}/modal.js"></script>
<!-- Gán quyền tài khoản 
<section id="permissions">
    <h3>Gán Quyền Tài khoản</h3>
    <div class="form-container">
        <h4>Gán quyền cho người dùng</h4>
        <label>Chọn người dùng</label>
        <select>
            <option value="">Chọn người dùng...</option>
            <option value="1001">Nguyễn Văn A</option>
            <option value="1002">Trần Thị B</option>
        </select>
        <label>Quyền</label>
        <select multiple>
            <option value="read">Đọc</option>
            <option value="write">Ghi</option>
            <option value="admin">Quản trị</option>
            <option value="moderate">Kiểm duyệt</option>
        </select>
        <button>Gán quyền</button>
    </div>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Quyền</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1001</td>
                <td>Nguyễn Văn A</td>
                <td>Admin, Đọc, Ghi</td>
                <td>
                    <button class="action-btn edit-btn">Sửa</button>
                    <button class="action-btn delete-btn">Xóa</button>
                </td>
            </tr>
        </tbody>
    </table>
</section>-->
<!-- Lịch sử truy cập -->
<section id="access-history">
    <h3>Lịch sử Truy cập</h3>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên người dùng</th>
                <th>Thời gian</th>
                <th>IP</th>
                <th>Hoạt động</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1001</td>
                <td>Nguyễn Văn A</td>
                <td>2025-06-14 10:00</td>
                <td>192.168.1.1</td>
                <td>Đăng nhập</td>
            </tr>
            <tr>
                <td>1002</td>
                <td>Trần Thị B</td>
                <td>2025-06-14 09:45</td>
                <td>192.168.1.2</td>
                <td>Đăng xuất</td>
            </tr>
        </tbody>
    </table>
</section>
<!-- Hồ sơ cá nhân -->
<section id="profile">
    <h3>Hồ sơ cá nhân</h3>
    <!-- UI block for profile (placeholder) -->
    <p>Chức năng đang phát triển...</p>
</section>
<!-- Đăng nhập -->
<section id="login">
    <h3>Đăng nhập</h3>
    <!-- UI block for login (placeholder) -->
    <p>Chức năng đang phát triển...</p>
</section> 