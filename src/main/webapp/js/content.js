// Global variables
let allPosts = [];
let filteredPosts = [];

// Initialize when page loads
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOMContentLoaded event fired');
    loadPosts();
});

// Load job postings
function loadPosts() {
    const basePath = getBasePath();
    console.log('Loading posts from:', basePath + 'job-posting?action=getAll');
    
    const loadingSpinner = document.querySelector('.loading-spinner');
    const postsGrid = document.getElementById('postsGrid');
    
    if (loadingSpinner) {
        loadingSpinner.style.display = 'block';
    }
    
    if (postsGrid) {
        postsGrid.style.display = 'none';
    }
    
    fetch(basePath + 'job-posting?action=getAll')
        .then(response => {
            if (!response.ok) {
                throw new Error('HTTP error ' + response.status + ' - ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log('Posts data:', data);
            if (data.success) {
                allPosts = data.data;
                filteredPosts = [...allPosts];
                renderPosts();
            } else {
                showErrorMessage(data.message || 'Lỗi khi tải dữ liệu bài đăng');
            }
        })
        .catch(error => {
            console.error('Error loading posts:', error);
            showErrorMessage('Lỗi khi tải dữ liệu bài đăng: ' + error.message);
        })
        .finally(() => {
            if (loadingSpinner) {
                loadingSpinner.style.display = 'none';
            }
        });
}

// Filter posts
function filterPosts() {
    const statusFilter = document.getElementById('statusFilter').value;
    const searchInput = document.getElementById('searchInput').value.toLowerCase();
    
    filteredPosts = allPosts.filter(post => {
        const matchesStatus = !statusFilter || post.status === statusFilter;
        const matchesSearch = !searchInput || 
            (post.title && post.title.toLowerCase().includes(searchInput));
        
        return matchesStatus && matchesSearch;
    });
    
    renderPosts();
}

// Render posts
function renderPosts() {
    const postsGrid = document.getElementById('postsGrid');
    if (!postsGrid) {
        console.log('Checking postsGrid:', postsGrid);
        console.error('postsGrid element not found');
        return;
    }
    if (filteredPosts.length === 0) {
        postsGrid.innerHTML = `
            <div class="no-posts">
                <i class="fas fa-inbox"></i>
                <h3>Không có bài đăng nào</h3>
                <p>Hiện tại không có bài đăng nào phù hợp với bộ lọc của bạn.</p>
            </div>
        `;
        return;
    }
    postsGrid.style.display = 'flex';
    let html = '';
    filteredPosts.forEach(post => {
        html += `
        <div class="job-card">
            <div class="job-card-image-dark">
                <i class="fas fa-image"></i>
            </div>
            <div class="job-card-content">
                <div class="job-card-top-row">
                    <span class="job-card-tag">${post.status ? getPostStatusText(post.status) : 'Tag'}</span>
                    <span class="job-card-fav"><i class="far fa-star"></i></span>
                </div>
                <div class="job-card-title">${post.title || 'Title'}</div>
                <div class="job-card-subtitle">${post.companyName || 'Subtitle'}</div>
                <div class="job-card-description">
                    ${post.description ? post.description.substring(0, 90) + (post.description.length > 90 ? '...' : '') : 'More information about the topic will come here within two to three lines.'}
                </div>
            </div>
            <div class="job-card-actions-row">
                <button class="btn btn-outline" onclick="event.stopPropagation();viewPostDetails(${post.id})">See Details</button>
                <button class="btn btn-filled" onclick="event.stopPropagation();approvePost(${post.id})">Approve</button>
            </div>
        </div>
        `;
    });
    postsGrid.innerHTML = html;
}

// Helper functions
function getPostStatusClass(status) {
    switch(status) {
        case 'pending': return 'status-pending';
        case 'approved': return 'status-approved';
        case 'rejected': return 'status-rejected';
        default: return 'status-pending';
    }
}

function getPostStatusText(status) {
    switch(status) {
        case 'pending': return 'Chờ duyệt';
        case 'approved': return 'Đã duyệt';
        case 'rejected': return 'Từ chối';
        default: return status;
    }
}

function refreshPosts() {
    loadPosts();
}

// Post actions
function viewPostDetails(postId) {
    const basePath = getBasePath();
    fetch(basePath + 'job-posting?action=getById&id=' + postId)
        .then(response => {
            if (!response.ok) throw new Error('HTTP error ' + response.status);
            return response.json();
        })
        .then(data => {
            if (data.success) {
                showPostDetailsModal(data.data);
            } else {
                showErrorMessage(data.message || 'Lỗi khi tải chi tiết bài đăng');
            }
        })
        .catch(error => {
            console.error('Error loading post details:', error);
            showErrorMessage('Lỗi khi tải chi tiết bài đăng');
        });
}

function showPostDetailsModal(post) {
    const modal = document.getElementById('postDetailsModal');
    if (!modal) return;

    // Populate modal content
    document.getElementById('postTitle').textContent = post.title || 'N/A';
    document.getElementById('postCompany').textContent = post.companyName || 'N/A';
    document.getElementById('postLocation').textContent = post.location || 'N/A';
    document.getElementById('postDescription').textContent = post.description || 'N/A';
    document.getElementById('postStatus').textContent = getPostStatusText(post.status);
    document.getElementById('postPostedAt').textContent = post.postedAt ? new Date(post.postedAt).toLocaleString('vi-VN') : 'N/A';

    // Show modal
    modal.style.display = 'block';
}

function closePostModal() {
    const modal = document.getElementById('postDetailsModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

function approvePost(postId) {
    updatePostStatus(postId, 'approved', 'Phê duyệt');
}

function rejectPost(postId) {
    updatePostStatus(postId, 'rejected', 'Từ chối');
}

function updatePostStatus(postId, status, actionName) {
    const basePath = getBasePath();
    const formData = new FormData();
    formData.append('action', 'updateStatus');
    formData.append('postId', postId);
    formData.append('status', status);

    fetch(basePath + 'job-posting', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) throw new Error('HTTP error ' + response.status);
        return response.json();
    })
    .then(data => {
        if (data.success) {
            showSuccessMessage('Đã ' + actionName.toLowerCase() + ' bài đăng thành công');
            loadPosts(); // Reload posts
        } else {
            showErrorMessage(data.message || 'Lỗi khi ' + actionName.toLowerCase() + ' bài đăng');
        }
    })
    .catch(error => {
        console.error('Error ' + actionName.toLowerCase() + ' post:', error);
        showErrorMessage('Lỗi khi ' + actionName.toLowerCase() + ' bài đăng');
    });
}

function deletePost(postId) {
    if (!confirm('Bạn có chắc chắn muốn xóa bài đăng này?')) {
        return;
    }

    const basePath = getBasePath();
    const formData = new FormData();
    formData.append('action', 'delete');
    formData.append('postId', postId);

    fetch(basePath + 'job-posting', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) throw new Error('HTTP error ' + response.status);
        return response.json();
    })
    .then(data => {
        if (data.success) {
            showSuccessMessage('Đã xóa bài đăng thành công');
            loadPosts(); // Reload posts
        } else {
            showErrorMessage(data.message || 'Lỗi khi xóa bài đăng');
        }
    })
    .catch(error => {
        console.error('Error deleting post:', error);
        showErrorMessage('Lỗi khi xóa bài đăng');
    });
}

function getBasePath() {
    return '/adminscreen/';
}

function showSuccessMessage(message) {
    const messageDiv = document.createElement('div');
    messageDiv.className = 'alert alert-success';
    messageDiv.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: #d4edda;
        color: #155724;
        padding: 15px 20px;
        border-radius: 4px;
        border: 1px solid #c3e6cb;
        z-index: 9999;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        max-width: 300px;
    `;
    messageDiv.textContent = message;
    
    document.body.appendChild(messageDiv);
    
    setTimeout(() => {
        if (messageDiv.parentNode) {
            messageDiv.parentNode.removeChild(messageDiv);
        }
    }, 3000);
}

function showErrorMessage(message) {
    const messageDiv = document.createElement('div');
    messageDiv.className = 'alert alert-danger';
    messageDiv.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: #f8d7da;
        color: #721c24;
        padding: 15px 20px;
        border-radius: 4px;
        border: 1px solid #f5c6cb;
        z-index: 9999;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        max-width: 300px;
    `;
    messageDiv.textContent = message;
    
    document.body.appendChild(messageDiv);
    
    setTimeout(() => {
        if (messageDiv.parentNode) {
            messageDiv.parentNode.removeChild(messageDiv);
        }
    }, 5000);
}

// Close modal when clicking outside
window.onclick = function(event) {
    const modal = document.getElementById('postDetailsModal');
    if (event.target === modal) {
        closePostModal();
    }
}

// Add a stub for flagPost if not present
if (typeof window.flagPost !== 'function') {
    window.flagPost = function(postId) {
        alert('Flag post ' + postId);
    };
}
