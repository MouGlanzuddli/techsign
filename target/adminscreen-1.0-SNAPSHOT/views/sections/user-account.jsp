<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Người dùng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS - Load first -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modal_styles.css">

    <style>
        /* Your existing styles remain the same */
        #user-accounts {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            padding: 24px;
            border-radius: 12px;
            margin-bottom: 24px;
        }
        
        /* Ensure modal appears above everything */
        .modal {
            z-index: 1055 !important;
        }
        
        .modal-backdrop {
            z-index: 1050 !important;
        }
        
        /* Debug styles - remove after testing */
        .debug-modal {
            border: 2px solid red !important;
        }
    </style>
</head>

    <section id="user-accounts">
        <div class="container-fluid py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0"><i class="fas fa-users-cog me-2"></i>Quản lý Người dùng</h2>
            </div>
            <form id="searchForm" class="row g-3 mb-3 align-items-center">
                <div class="col-md-4">
                    <input id="searchInput" name="search" type="text" class="form-control" placeholder="Tìm kiếm theo tên, email..." />
                </div>
                <div class="col-md-3">
                    <select id="roleFilter" name="role" class="form-select">
                        <option value="">Tất cả vai trò</option>
                        <option value="2">Ứng viên</option>
                        <option value="3">Nhà tuyển dụng</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-info w-100"><i class="fas fa-search"></i> Tìm kiếm</button>
                </div>
                <div class="col-md-2">
                    <button type="button" id="refreshBtn" class="btn btn-secondary w-100">
                        <i class="fas fa-sync-alt"></i> Làm mới
                    </button>
                </div>
                <div class="col-md-1 d-flex justify-content-end">
                    <button class="btn btn-primary w-100" id="addUserBtn" type="button">
                        <i class="fas fa-plus me-1"></i> Thêm Người dùng
                    </button>
                </div>
            </form>
            
            <%-- Remove the hardcoded table and include the user-list-table.jsp --%>
            <jsp:include page="/views/sections/user-list-table.jsp" />
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
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <!-- AJAX-loaded content goes here -->
        </div>
      </div>
    </div>
    
</section>

    <!-- Load jQuery first -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    
</html>