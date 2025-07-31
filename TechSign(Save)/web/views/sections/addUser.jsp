<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<script src="scripts/modal.js"></script>
<style>
    /* Modal background */
.modal {
    display: none;
    position: fixed;
    z-index: 999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
}

/* Modal content box */
.modal-content {
    background-color: #fff;
    margin: 8% auto;
    padding: 20px;
    border-radius: 10px;
    width: 500px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    position: relative;
}

/* Close button */
.close-btn {
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.modal-content h2 {
    margin-bottom: 20px;
    color: #1e3a8a;
}

.modal-content label {
    display: block;
    margin-top: 10px;
    font-weight: bold;
}

.modal-content input,
.modal-content select {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

.submit-btn {
    margin-top: 20px;
    background-color: #1e3a8a;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.submit-btn:hover {
    background-color: #162d6a;
}

</style>
<div id="addUserModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2>Thêm Người Dùng Mới</h2>
        <form action="AddUserServlet" method="post">
            <label for="fullname">Họ và Tên</label>
            <input type="text" id="fullname" name="fullname" placeholder="Nhập họ và tên..." required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Nhập email..." required>

            <label for="role">Vai Trò</label>
            <select id="role" name="role" required>
                <option value="">-- Chọn vai trò --</option>
                <option value="admin">Admin</option>
                <option value="user">Người dùng</option>
                <option value="moderator">Moderator</option>
            </select>

            <label for="status">Trạng Thái</label>
            <select id="status" name="status" required>
                <option value="active">Hoạt động</option>
                <option value="inactive">Khóa</option>
            </select>

            <button type="submit" class="submit-btn">Thêm tài khoản</button>
        </form>
    </div>
</div>


