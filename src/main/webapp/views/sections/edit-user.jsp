<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mycompany.adminscreen.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        out.print("<div class='alert alert-danger'>Không tìm thấy thông tin người dùng.</div>");
        return;
    }
%>

<div class="modal-header">
    <h5 class="modal-title">Chỉnh sửa người dùng</h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>

<div class="modal-body">
    <form id="editUserForm" action="UserServlet?action=update" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= user.getId() %>">
        
        <div class="mb-3">
            <label for="fullName" class="form-label">Họ và tên</label>
            <input type="text" id="fullName" name="fullName" class="form-control" value="<%= user.getFullName() %>" required readonly>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control" value="<%= user.getEmail() %>" required readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Mật khẩu mới (để trống nếu không muốn thay đổi)</label>
            <div id="changePasswordSection">
                <button type="button" class="btn btn-sm btn-outline-primary" id="btnShowPasswordChange" onclick="showPasswordChange()">Đổi mật khẩu</button>
                <div id="passwordChangeFields" style="display:none; margin-top:10px;">
                    <div class="mb-2">
                        <label class="form-label">Câu hỏi bảo mật:</label>
                        <input type="text" class="form-control" value="<%= user.getSecurityQuestion() != null ? user.getSecurityQuestion() : "Chưa thiết lập" %>" readonly />
                    </div>
                    <div class="mb-2">
                        <label for="securityAnswer" class="form-label">Câu trả lời:</label>
                        <input type="text" id="securityAnswer" name="securityAnswer" class="form-control" placeholder="Nhập câu trả lời bảo mật" oninput="enablePasswordField()" />
                    </div>
                    <div class="mb-2">
                        <label for="password" class="form-label">Mật khẩu mới</label>
                        <input type="password" id="password" name="password" class="form-control" disabled />
                        <div class="form-text">Chỉ điền nếu muốn thay đổi mật khẩu</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại</label>
            <input type="tel" id="phone" name="phone" class="form-control" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" readonly>
        </div>

        <div class="mb-3">
            <label for="roleId" class="form-label">Vai trò</label>
            <select id="roleId" name="roleId" class="form-select" required>
                <option value="2" <%= user.getRoleId() == 2 ? "selected" : "" %>>Ứng viên</option>
                <option value="3" <%= user.getRoleId() == 3 ? "selected" : "" %>>Nhà tuyển dụng</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Trạng thái</label>
            <select id="status" name="status" class="form-select" required>
                <option value="active" <%= "active".equals(user.getStatus()) ? "selected" : "" %>>Hoạt động</option>
                <option value="inactive" <%= "inactive".equals(user.getStatus()) ? "selected" : "" %>>Khóa</option>
                <option value="pending" <%= "pending".equals(user.getStatus()) ? "selected" : "" %>>Chờ xác nhận</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="avatarUrl" class="form-label">URL ảnh đại diện</label>
            <input type="url" id="avatarUrl" name="avatarUrl" class="form-control" value="<%= user.getAvatarUrl() != null ? user.getAvatarUrl() : "" %>" readonly>
        </div>
    </form>
</div>

<div class="modal-footer">
    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
    <button type="submit" form="editUserForm" class="btn btn-primary">Lưu thay đổi</button>
</div>

<script>
function showPasswordChange() {
    document.getElementById('passwordChangeFields').style.display = 'block';
    document.getElementById('btnShowPasswordChange').style.display = 'none';
}

function enablePasswordField() {
    var answer = document.getElementById('securityAnswer').value;
    document.getElementById('password').disabled = (answer.trim() === '');
}

// Set up form submission for the modal
document.getElementById('editUserForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const formData = new FormData(this);
    
    fetch('UserServlet?action=update', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Close modal
            const modal = bootstrap.Modal.getInstance(document.getElementById('editUserModal'));
            modal.hide();
            
            // Show success message
            if (typeof showSuccessMessage === 'function') {
                showSuccessMessage(data.message);
            } else {
                alert(data.message);
            }
            
            // Reload user table
            if (typeof loadUserDataWithFilters === 'function') {
                loadUserDataWithFilters('', '');
            }
        } else {
            alert(data.message || 'Lỗi khi cập nhật người dùng');
        }
    })
    .catch(error => {
        console.error('Error updating user:', error);
        alert('Lỗi khi cập nhật người dùng');
    });
});
</script> 