<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<h2>Hỗ trợ & Thông báo</h2>
<!-- Hỗ trợ người dùng -->
<section id="support-users">
    <h3>Hỗ trợ Người dùng</h3>
    <div class="form-container">
        <h4>Trả lời ticket hỗ trợ</h4>
        <label>Ticket ID</label>
        <input type="text" placeholder="Nhập ID ticket..." />
        <label>Nội dung trả lời</label>
        <textarea placeholder="Nhập nội dung trả lời..." rows="5"></textarea>
        <button>Gửi phản hồi</button>
    </div>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Người gửi</th>
                <th>Tiêu đề</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>T001</td>
                <td>Nguyễn Văn A</td>
                <td>Lỗi đăng nhập</td>
                <td>Chưa xử lý</td>
                <td>
                    <button class="action-btn edit-btn">Xem</button>
                    <button class="action-btn delete-btn">Đóng</button>
                </td>
            </tr>
        </tbody>
    </table>
</section>
<!-- Tạo thông báo -->
<section id="notifications">
    <h3>Tạo Thông báo</h3>
    <div class="form-container">
        <h4>Soạn thông báo</h4>
        <label>Tiêu đề</label>
        <input type="text" placeholder="Nhập tiêu đề thông báo..." />
        <label>Nội dung</label>
        <textarea placeholder="Nhập nội dung thông báo..." rows="5"></textarea>
        <label>Mức độ ưu tiên</label>
        <select>
            <option value="low">Thấp</option>
            <option value="medium">Trung bình</option>
            <option value="high">Cao</option>
        </select>
        <button>Gửi thông báo</button>
    </div>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tiêu đề</th>
                <th>Ngày gửi</th>
                <th>Mức độ</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>N001</td>
                <td>Bảo trì hệ thống</td>
                <td>2025-06-10</td>
                <td>Cao</td>
                <td>
                    <button class="action-btn edit-btn">Sửa</button>
                    <button class="action-btn delete-btn">Xóa</button>
                </td>
            </tr>
        </tbody>
    </table>
</section>
<!-- Cảnh báo -->
<section id="alerts">
    <h3>Cảnh báo</h3>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Người dùng</th>
                <th>Hoạt động</th>
                <th>Thời gian</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>A001</td>
                <td>Nguyễn Văn A</td>
                <td>Đăng nhập thất bại nhiều lần</td>
                <td>2025-06-14 08:00</td>
                <td>
                    <button class="action-btn edit-btn">Xem</button>
                    <button class="action-btn delete-btn">Xóa</button>
                </td>
            </tr>
        </tbody>
    </table>
</section> 