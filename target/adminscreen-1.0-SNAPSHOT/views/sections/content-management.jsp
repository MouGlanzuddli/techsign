<%@ page contentType="text/html; charset=UTF-8"%>


<div class="conpany-jobs" id="content-section">
    <div class="section-header">
        <h2><i class="fas fa-file-alt"></i> Quản lý bài đăng tuyển dụng</h2>
        <p>Xem và quản lý tất cả bài đăng tuyển dụng từ người dùng</p>
    </div>

    <!-- Filter Controls -->
    <div class="filter-controls">
        <div class="filter-group">
            <label for="statusFilter">Trạng thái:</label>
            <select id="statusFilter" onchange="filterPosts()">
                <option value="">Tất cả</option>
                <option value="pending">Chờ duyệt</option>
                <option value="approved">Đã duyệt</option>
                <option value="rejected">Đã từ chối</option>
            </select>
        </div>
        
        <div class="filter-group">
            <label for="searchInput">Tìm kiếm:</label>
            <input type="text" id="searchInput" placeholder="Tìm theo tiêu đề..." onkeyup="filterPosts()">
        </div>
        
        <div class="filter-group">
            <button onclick="refreshPosts()" class="btn btn-primary">
                <i class="fas fa-refresh"></i> Làm mới
            </button>
        </div>
    </div>

    <!-- Loading Spinner -->
    <div class="loading-spinner" id="loadingSpinner" style="display: none;">
        <div class="spinner"></div>
        <p>Đang tải dữ liệu...</p>
    </div>

    <!-- Posts Grid -->
    <div class="posts-grid" id="postsGrid">
        <!-- Posts will be loaded here via JavaScript -->
    </div>
</div>

<!-- Post Details Modal -->
<div id="postDetailsModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Chi tiết bài đăng</h3>
            <span class="close" onclick="closePostModal()">&times;</span>
        </div>
        <div class="modal-body">
            <div class="post-details">
                <div class="detail-row">
                    <label>Tiêu đề:</label>
                    <span id="postTitle"></span>
                </div>
                <div class="detail-row">
                    <label>Công ty:</label>
                    <span id="postCompany"></span>
                </div>
                <div class="detail-row">
                    <label>Địa điểm:</label>
                    <span id="postLocation"></span>
                </div>
                <div class="detail-row">
                    <label>Mô tả:</label>
                    <div id="postDescription" class="content-text"></div>
                </div>
                <div class="detail-row">
                    <label>Trạng thái:</label>
                    <span id="postStatus"></span>
                </div>
                <div class="detail-row">
                    <label>Ngày đăng:</label>
                    <span id="postPostedAt"></span>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button onclick="closePostModal()" class="btn btn-secondary">Đóng</button>
        </div>
    </div>
</div>

<!--<style>
.content-section {
    padding: 20px;
}

.section-header {
    margin-bottom: 30px;
}

.section-header h2 {
    color: #333;
    margin-bottom: 10px;
}

.section-header p {
    color: #666;
    margin: 0;
}

.filter-controls {
    display: flex;
    gap: 20px;
    margin-bottom: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
    flex-wrap: wrap;
}

.filter-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.filter-group label {
    font-weight: 500;
    color: #333;
    font-size: 14px;
}

.filter-group select,
.filter-group input {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    min-width: 150px;
}

.btn {
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

.btn-primary {
    background: #007bff;
    color: white;
}

.btn-primary:hover {
    background: #0056b3;
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

.loading-spinner {
    text-align: center;
    padding: 40px;
}

.spinner {
    border: 4px solid #f3f3f3;
    border-top: 4px solid #007bff;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    animation: spin 1s linear infinite;
    margin: 0 auto 20px;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.posts-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 32px;
    margin-top: 20px;
    justify-content: flex-start;
}

.job-card {
  background: #fff;
  border-radius: 18px;
  box-shadow: 0 4px 24px rgba(0,0,0,0.13);
  overflow: hidden;
  width: 350px;
  margin-bottom: 32px;
  display: flex;
  flex-direction: column;
  border: none;
  transition: box-shadow 0.2s, transform 0.2s;
}

.job-card:hover {
  box-shadow: 0 8px 32px rgba(0,0,0,0.18);
  transform: translateY(-2px);
}

.job-card-image-dark {
  background: #393939;
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.job-card-image-dark i {
  font-size: 44px;
  color: #fff;
  opacity: 0.7;
}

.job-card-content {
  padding: 20px 20px 0 20px;
  background: #fff;
}

.job-card-top-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.job-card-tag {
  background: #ededed;
  color: #444;
  font-size: 13px;
  border-radius: 8px;
  padding: 3px 12px;
  font-weight: 500;
}

.job-card-tag.pending {
  background: #fff3cd;
  color: #856404;
}

.job-card-tag.approved {
  background: #d4edda;
  color: #155724;
}

.job-card-tag.rejected {
  background: #f8d7da;
  color: #721c24;
}

.job-card-fav {
  color: #888;
  font-size: 20px;
  cursor: pointer;
}

.job-card-title {
  font-size: 1.35em;
  font-weight: bold;
  color: #222;
  margin-bottom: 2px;
}

.job-card-subtitle {
  font-size: 1em;
  color: #666;
  margin-bottom: 8px;
}

.job-card-description {
  color: #555;
  font-size: 0.98em;
  margin-bottom: 18px;
  min-height: 38px;
}

.job-card-actions-row {
  display: flex;
  gap: 12px;
  border-top: 1px solid #eee;
  background: #fff;
  padding: 16px 20px;
  justify-content: flex-end;
}

.btn-outline {
  background: #fff;
  color: #222;
  border: 1.5px solid #bbb;
  border-radius: 20px;
  padding: 7px 22px;
  font-size: 15px;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.18s, color 0.18s, border 0.18s;
}

.btn-outline:hover {
  background: #f5f5f5;
  border-color: #888;
}

.btn-filled {
  background: #222;
  color: #fff;
  border: 1.5px solid #222;
  border-radius: 20px;
  padding: 7px 22px;
  font-size: 15px;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.18s, color 0.18s, border 0.18s;
}

.btn-filled:hover {
  background: #444;
  border-color: #444;
}

.no-posts {
    text-align: center;
    padding: 60px 20px;
    color: #666;
}

.no-posts i {
    font-size: 48px;
    margin-bottom: 20px;
    color: #ccc;
}

.no-posts h3 {
    margin-bottom: 10px;
    color: #333;
}

.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
}

.modal-content {
    background-color: white;
    margin: 5% auto;
    padding: 0;
    border-radius: 8px;
    width: 80%;
    max-width: 600px;
    max-height: 80vh;
    overflow-y: auto;
}

.modal-header {
    padding: 20px;
    border-bottom: 1px solid #e0e0e0;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-header h3 {
    margin: 0;
    color: #333;
}

.close {
    color: #aaa;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover {
    color: #000;
}

.modal-body {
    padding: 20px;
}

.post-details {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.detail-row {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.detail-row label {
    font-weight: 600;
    color: #333;
    font-size: 14px;
}

.detail-row span {
    color: #666;
    font-size: 14px;
}

.content-text {
    background: #f8f9fa;
    padding: 12px;
    border-radius: 4px;
    white-space: pre-wrap;
    max-height: 200px;
    overflow-y: auto;
}

.modal-footer {
    padding: 20px;
    border-top: 1px solid #e0e0e0;
    display: flex;
    justify-content: flex-end;
    gap: 10px;
}
</style>-->



