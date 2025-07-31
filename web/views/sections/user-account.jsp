<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<section id="user-accounts">
    <div class="container-fluid py-4">
        <form id="searchForm" class="header-bar user-header-bar" onsubmit="return false;">
            <input class="search-input" id="searchInput" type="text" placeholder="Tìm kiếm theo tên, email...">
            <select class="role-filter" id="roleFilter">
                <option value="">Tất cả vai trò</option>
                <option value="1">Admin</option>
                <option value="2">Ứng viên</option>
                <option value="3">Nhà tuyển dụng</option>
            </select>
            <button class="btn" id="searchBtn" type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
            <button class="btn btn-outline" id="refreshBtn" type="button"><i class="fas fa-sync"></i> Làm mới</button>
            <button class="btn-add" id="addUserBtn" type="button" style="margin-left:auto;"><i class="fas fa-plus"></i> Thêm Người dùng</button>
        </form>

        <div class="table-container">
            <div class="loading-spinner" style="display: none; text-align: center; padding: 40px;">
                <div class="spinner-border" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mt-2">Đang tải dữ liệu...</p>
            </div>
            <table class="user-table" id="userTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ và tên</th>
                        <th>Email</th>
                        <th>Điện thoại</th>
                        <th>Email xác thực</th>
                        <th>Điện thoại xác thực</th>
                        <th>Vai trò</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody id="userTableBody">
                    <!-- Data will be loaded dynamically via JavaScript -->
                    <tr>
                        <td colspan="8" class="text-center">
                            <div class="spinner-border" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div> 

    <!-- Fixed Bootstrap Modal -->
    <div class="modal fade" id="userAddModal" tabindex="-1" aria-labelledby="userAddModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="userAddModalLabel">Thêm Người Dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="addUserForm" action="UserServlet?action=create" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="fullname" class="form-label">Họ và tên</label>
                            <input id="fullname" type="text" name="fullName" class="form-control" required />
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input id="email" type="email" name="email" class="form-control" required />
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <input id="password" type="password" name="password" class="form-control" required />
                        </div>
                        <div class="mb-3">
                            <label for="roleId" class="form-label">Vai trò</label>
                            <select id="roleId" name="roleId" class="form-select" required>
                                <option value="2">Ứng viên</option>
                                <option value="3">Nhà tuyển dụng</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Số điện thoại (tùy chọn)</label>
                            <input id="phone" type="text" name="phone" class="form-control" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Thêm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit User Modal (AJAX content will be loaded here) -->
    <div class="modal fade" id="editUserModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <!-- AJAX-loaded content goes here -->
        </div>
      </div>
    </div>
</section>