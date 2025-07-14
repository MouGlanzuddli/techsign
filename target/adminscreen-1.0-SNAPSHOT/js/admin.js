// Global functions for user management
function setupSearchAndFilter() {
    const searchForm = document.getElementById('searchForm');
    const searchInput = document.getElementById('searchInput');
    const roleFilter = document.getElementById('roleFilter');
    const refreshBtn = document.getElementById('refreshBtn');
    const userCreateForm = document.querySelector('#user-add form');

    if (searchForm) {
        searchForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const search = searchInput ? searchInput.value : '';
            const role = roleFilter ? roleFilter.value : '';
            
            // Show loading spinner
            const loadingSpinner = document.querySelector('.loading-spinner');
            const userTable = document.getElementById('userTable');
            if (loadingSpinner) loadingSpinner.style.display = 'block';
            if (userTable) userTable.style.display = 'none';
            
            // Reload data with search parameters
            loadUserDataWithFilters(search, role);
        });
    }

    // Setup refresh button
    if (refreshBtn) {
        refreshBtn.addEventListener('click', function() {
            // Show loading spinner
            const loadingSpinner = document.querySelector('.loading-spinner');
            const userTable = document.getElementById('userTable');
            if (loadingSpinner) loadingSpinner.style.display = 'block';
            if (userTable) userTable.style.display = 'none';
            
            // Clear search inputs
            if (searchInput) searchInput.value = '';
            if (roleFilter) roleFilter.value = '';
            
            // Reload data without filters
            loadUserDataWithFilters('', '');
        });
    }

    // Setup user creation form
    if (userCreateForm) {
        userCreateForm.addEventListener('submit', function(e) {
            e.preventDefault();
            handleUserCreation(this);
        });
    }
}

function handleUserCreation(form) {
    const formData = new FormData(form);
    const basePath = getBasePath();
    
    // Show loading state
    const submitBtn = form.querySelector('button[type="submit"]');
    const originalText = submitBtn.textContent;
    submitBtn.textContent = 'Đang tạo...';
    submitBtn.disabled = true;

    fetch(basePath + 'UserServlet', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) throw new Error('HTTP error ' + response.status);
        return response.json();
    })
    .then(data => {
        if (data.success) {
            // Show success message
            showSuccessMessage(data.message);
            
            // Reset form
            form.reset();
            
            // Immediately add the new user to the table
            if (data.user) {
                addUserToTable(data.user);
                updateDashboardStats(parseInt(document.querySelector('.stats-cards .card-box:first-child .number')?.textContent || '0') + 1);
            }
        } else {
            showErrorMessage(data.message || 'Lỗi khi tạo người dùng');
        }
    })
    .catch(error => {
        console.error('Error creating user:', error);
        showErrorMessage('Lỗi khi tạo người dùng. Vui lòng thử lại.');
    })
    .finally(() => {
        // Reset button state
        submitBtn.textContent = originalText;
        submitBtn.disabled = false;
    });
}

function showSuccessMessage(message) {
    const messageContainer = document.getElementById('messageContainer');
    if (messageContainer) {
        const successDiv = document.createElement('div');
        successDiv.className = 'message message-success';
        successDiv.textContent = message;
        messageContainer.innerHTML = '';
        messageContainer.appendChild(successDiv);
        
        // Auto-hide after 5 seconds
        setTimeout(() => {
            successDiv.remove();
        }, 5000);
    }
}

function loadUserDataWithFilters(search, role) {
    const basePath = getBasePath();
    let url = basePath + 'UserServlet?action=getData';
    
    if (search) url += '&search=' + encodeURIComponent(search);
    if (role) url += '&role=' + encodeURIComponent(role);

    fetch(url)
        .then(response => {
            if (!response.ok) throw new Error('HTTP error ' + response.status);
            return response.json();
        })
        .then(data => {
            populateUserTable(data.users);
        })
        .catch(error => {
            console.error('Error loading filtered user data:', error);
            showErrorMessage('Lỗi khi tải dữ liệu người dùng');
            
            // Hide loading spinner on error
            const loadingSpinner = document.querySelector('.loading-spinner');
            if (loadingSpinner) loadingSpinner.style.display = 'none';
        });
}

function populateUserTable(users) {
    const tableBody = document.getElementById('userTableBody');
    const userTable = document.getElementById('userTable');
    const loadingSpinner = document.querySelector('.loading-spinner');
    
    if (!tableBody) return;

    // Hide loading spinner and show table
    if (loadingSpinner) loadingSpinner.style.display = 'none';
    if (userTable) userTable.style.display = 'table';

    if (!users || users.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="8" style="text-align: center;">Không tìm thấy người dùng nào.</td></tr>';
        return;
    }

    let html = '';
    users.forEach(user => {
        html += `
            <tr>
                <td>${user.id}</td>
                <td>${user.fullName}</td>
                <td>${user.email}</td>
                <td>${user.phone || '-'}</td>
                <td>${user.isEmailVerified ? 'Đã xác thực' : 'Chưa xác thực'}</td>
                <td>${user.isPhoneVerified ? 'Đã xác thực' : 'Chưa xác thực'}</td>
                <td>${getRoleText(user.roleId)}</td>
                <td>
                    <a href="#" class="btn-edit-user btn btn-sm btn-outline-primary me-1" data-user-id="${user.id}" title="Chỉnh sửa">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="UserServlet?action=delete&id=${user.id}" class="btn btn-sm btn-outline-danger btn-delete" title="Xóa"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
    attachDeleteListeners();
    attachEditListeners();
}

function getRoleText(roleId) {
    switch(roleId) {
        case 1: return 'Admin';
        default: return 'Người dùng';
    }
}

function getAdminVerificationStatus(user) {
    if (user.roleId === 1) {
        return user.isEmailVerified
            ? '<span style="color: #4CAF50;"><i class="fas fa-check-circle"></i> Verified</span>'
            : '<span style="color: #f44336;"><i class="fas fa-times-circle"></i> Not Verified</span>';
    } else {
        return '<span style="color: #888;">N/A</span>';
    }
}

function getStatusText(user) {
    if (user.status === 'online') {
        return '<span class="status-online">Online</span>';
    } else {
        return '<span class="status-offline">Offline</span>';
    }
}

function attachDeleteListeners() {
    document.querySelectorAll('.btn-delete').forEach(btn => {
        btn.addEventListener('click', function(e) {
            if (!confirm('Bạn có chắc chắn muốn xóa người dùng này?')) {
                e.preventDefault();
            }
        });
    });
}

function attachEditListeners() {
    document.querySelectorAll('.btn-edit-user').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            const userId = this.getAttribute('data-user-id');
            openEditUserModal(userId);
        });
    });
}

// Add this helper function
function isBootstrapLoaded() {
    return typeof bootstrap !== 'undefined' && bootstrap.Modal;
}

// And update the openEditUserModal function to use it
function openEditUserModal(userId) {
    const modalElement = document.getElementById('editUserModal');
    const modalContent = modalElement?.querySelector('.modal-content');
    
    if (!modalElement || !modalContent) {
        alert('Lỗi: Modal không tìm thấy');
        return;
    }

    // Show loading
    modalContent.innerHTML = '<div class="text-center p-4"><div class="spinner-border"></div></div>';
    
    const modal = new bootstrap.Modal(modalElement);
    modal.show();

    fetch(`UserServlet?action=edit&id=${userId}`)
        .then(response => {
            if (!response.ok) throw new Error(`HTTP ${response.status}`);
            return response.text();
        })
        .then(html => {
            modalContent.innerHTML = html;
        })
        .catch(error => {
            console.error('Error:', error);
            modalContent.innerHTML = `
                <div class="modal-header">
                    <h5 class="modal-title">Lỗi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-danger">Lỗi khi tải form: ${error.message}</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            `;
        });
}

function showErrorMessage(message) {
    const errorDiv = document.createElement('div');
    errorDiv.className = 'message message-error';
    errorDiv.textContent = message;
    errorDiv.style.margin = '10px 0';
    
    const sectionContent = document.getElementById('section-content');
    if (sectionContent) {
        sectionContent.insertBefore(errorDiv, sectionContent.firstChild);
    }
}

function updateDashboardStats(totalUsers) {
    // Update the dashboard stats if we're on the main page
    const userCountElement = document.querySelector('.stats-cards .card-box:first-child .number');
    if (userCountElement) {
        userCountElement.textContent = totalUsers.toLocaleString();
    }
}

function getBasePath() {
    // Get the base path for the app (context root)
    const path = window.location.pathname;
    const idx = path.indexOf('/', 1);
    return idx > 0 ? path.substring(0, idx + 1) : '/';
}

// Initialize when document is ready
document.addEventListener('DOMContentLoaded', function() {
    console.log('Admin panel initialized');
    
    // The section loader will handle all data loading
    // We only need to set up specific event listeners here
    // setupEventListeners(); 
});

// Role Assignment Modal Functions
function openRoleAssignmentModal(userId, userName, currentRoleId) {
    // Create modal HTML
    const modalHTML = `
        <div id="roleAssignmentModal" class="modal" style="display: flex;">
            <div class="modal-content" style="width: 450px;">
                <span class="close" onclick="closeRoleAssignmentModal()">&times;</span>
                <h2>Phân quyền cho người dùng</h2>
                <p><strong>Người dùng:</strong> ${userName}</p>
                <p><strong>Quyền hiện tại:</strong> ${getRoleText(currentRoleId)}</p>
                
                <form id="roleAssignmentForm">
                    <input type="hidden" id="assignUserId" value="${userId}">
                    <input type="hidden" id="assignAdminId" value="1"> <!-- Assuming admin ID is 1, you might want to get this from session -->
                    
                    <label for="newRoleId">Chọn quyền mới:</label>
                    <select id="newRoleId" required style="width: 100%; padding: 8px 10px; margin-bottom: 14px; border: 1px solid #ccc; border-radius: 5px; font-size: 15px;">
                        <option value="">Chọn quyền</option>
                        <option value="1">Admin</option>
                    </select>
                    
                    <div style="display: flex; gap: 10px; justify-content: flex-end;">
                        <button type="button" onclick="closeRoleAssignmentModal()" style="padding: 8px 16px; background: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer;">
                            Hủy
                        </button>
                        <button type="submit" style="padding: 8px 16px; background: #ff9800; color: white; border: none; border-radius: 4px; cursor: pointer;">
                            Gửi yêu cầu
                        </button>
                    </div>
                </form>
            </div>
        </div>
    `;
    
    // Add modal to body
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    // Setup form submission
    document.getElementById('roleAssignmentForm').addEventListener('submit', function(e) {
        e.preventDefault();
        submitRoleAssignment();
    });
}

function closeRoleAssignmentModal() {
    const modal = document.getElementById('roleAssignmentModal');
    if (modal) {
        modal.remove();
    }
}

function submitRoleAssignment() {
    const userId = document.getElementById('assignUserId').value;
    const newRoleId = document.getElementById('newRoleId').value;
    const adminId = document.getElementById('assignAdminId').value;
    
    if (!newRoleId) {
        alert('Vui lòng chọn quyền mới');
        return;
    }
    
    const basePath = getBasePath();
    const url = basePath + 'UserServlet?action=assignRole&userId=' + userId + '&roleId=' + newRoleId + '&adminId=' + adminId;
    
    // Show loading state
    const submitBtn = document.querySelector('#roleAssignmentForm button[type="submit"]');
    const originalText = submitBtn.textContent;
    submitBtn.textContent = 'Đang gửi...';
    submitBtn.disabled = true;
    
    fetch(url)
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.text();
            })
        .then(() => {
            showSuccessMessage('Yêu cầu phân quyền đã được gửi thành công! Email xác nhận đã được gửi đến người dùng.');
            closeRoleAssignmentModal();
            // Reload user data to show updated status
            loadUserDataWithFilters('', '');
        })
        .catch(error => {
            console.error('Error assigning role:', error);
            showErrorMessage('Lỗi khi gửi yêu cầu phân quyền. Vui lòng thử lại.');
        })
        .finally(() => {
            // Reset button state
            submitBtn.textContent = originalText;
            submitBtn.disabled = false;
        });
}

function addUserToTable(user) {
    const tableBody = document.getElementById('userTableBody');
    if (!tableBody) return;

    // Remove "no users found" message if it exists
    const noUsersRow = tableBody.querySelector('tr td[colspan="8"]');
    if (noUsersRow) {
        noUsersRow.parentElement.remove();
    }

    const roleText = getRoleText(user.roleId);
    const statusClass = getStatusText(user);
    
    // Only show role assignment button if user is not admin and not active
    const roleAssignmentButton = (user.roleId !== 1 && user.status !== 'active') ? 
        `<button onclick="openRoleAssignmentModal(${user.id}, '${user.fullName}', ${user.roleId})" 
                class="btn-assign-role" title="Phân quyền Admin" style="background: none; border: none; color: #ff9800; cursor: pointer;">
            <i class="fas fa-user-shield"></i>
        </button>` : 
        `<span title="${user.roleId === 1 ? 'Người dùng đã là Admin' : 'Người dùng đã active'}" style="color: #ccc; cursor: not-allowed;">
            <i class="fas fa-user-shield"></i>
        </span>`;
    
    const newRow = document.createElement('tr');
    newRow.style.animation = 'fadeIn 0.5s ease-in';
    newRow.innerHTML = `
        <td>${user.id}</td>
        <td>${user.fullName}</td>
        <td>${user.email}</td>
        <td>${user.phone || '-'}</td>
        <td>${user.isEmailVerified ? 'Đã xác thực' : 'Chưa xác thực'}</td>
        <td>${user.isPhoneVerified ? 'Đã xác thực' : 'Chưa xác thực'}</td>
        <td>${roleText}</td>
        <td class="${statusClass}">${user.status}</td>
        <td class="verification-status">${getAdminVerificationStatus(user)}</td>
        <td class="actions">
            <a href="#" class="btn-edit-user btn btn-sm btn-outline-primary me-1" data-user-id="${user.id}" title="Chỉnh sửa">
                <i class="fas fa-edit"></i>
            </a>
            <a href="UserServlet?action=delete&id=${user.id}" class="btn btn-sm btn-outline-danger btn-delete" title="Xóa"
               onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">
                <i class="fas fa-trash"></i>
            </a>
            ${roleAssignmentButton}
        </td>
    `;

    // Add the new row at the top of the table
    tableBody.insertBefore(newRow, tableBody.firstChild);
    
    // Add fade-in animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    `;
    document.head.appendChild(style);
    
    // Attach delete listeners to the new row
    attachDeleteListeners();
}

// Email testing functionality
function testEmail() {
    const email = document.getElementById('testEmail').value;
    const type = document.getElementById('testEmailType').value;
    const resultDiv = document.getElementById('emailTestResult');
    
    if (!email) {
        resultDiv.innerHTML = '<div class="alert alert-warning">Vui lòng nhập email để test.</div>';
        return;
    }
    
    if (!type) {
        resultDiv.innerHTML = '<div class="alert alert-warning">Vui lòng chọn loại email để test.</div>';
        return;
    }
    
    // Show loading
    resultDiv.innerHTML = '<div class="alert alert-info"><i class="fas fa-spinner fa-spin"></i> Đang gửi email test...</div>';
    
    // Make AJAX request
    fetch(`UserServlet?action=testEmail&email=${encodeURIComponent(email)}&type=${encodeURIComponent(type)}`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                resultDiv.innerHTML = `<div class="alert alert-success"><i class="fas fa-check"></i> ${data.message}</div>`;
            } else {
                resultDiv.innerHTML = `<div class="alert alert-danger"><i class="fas fa-times"></i> ${data.message}</div>`;
            }
        })
        .catch(error => {
            resultDiv.innerHTML = `<div class="alert alert-danger"><i class="fas fa-times"></i> Lỗi kết nối: ${error.message}</div>`;
        });
}

function toggleEmailDebug() {
    const debugInfo = `
        <div class="alert alert-info">
            <h5><i class="fas fa-info-circle"></i> Email Debug Information:</h5>
            <ul>
                <li><strong>SMTP Configuration:</strong> Check EmailUtil.java for SMTP settings</li>
                <li><strong>Server Logs:</strong> Check console/logs for email debug output</li>
                <li><strong>Common Issues:</strong>
                    <ul>
                        <li>SMTP server not configured properly</li>
                        <li>Firewall blocking SMTP port (usually 587 or 465)</li>
                        <li>Authentication credentials incorrect</li>
                        <li>Email provider blocking automated emails</li>
                    </ul>
                </li>
                <li><strong>Testing Steps:</strong>
                    <ol>
                        <li>Use a real email address (Gmail, Outlook, etc.)</li>
                        <li>Check spam/junk folder</li>
                        <li>Verify SMTP settings in EmailUtil.java</li>
                        <li>Check server console for debug output</li>
                    </ol>
                </li>
                <li><strong>Gmail Setup Instructions:</strong>
                    <ol>
                        <li>Enable 2-Factor Authentication on your Gmail account</li>
                        <li>Generate an App Password: <a href="https://myaccount.google.com/apppasswords" target="_blank">https://myaccount.google.com/apppasswords</a></li>
                        <li>Update EmailUtil.java with your Gmail and App Password</li>
                        <li>Restart the application</li>
                    </ol>
                </li>
                <li><strong>Current Configuration:</strong>
                    <ul>
                        <li>SMTP Host: smtp.gmail.com</li>
                        <li>SMTP Port: 587</li>
                        <li>Username: <code>your_gmail@gmail.com</code> (needs to be updated)</li>
                        <li>Password: <code>your_app_password</code> (needs to be updated)</li>
                    </ul>
                </li>
            </ul>
            <button onclick="testEmailConfiguration()" class="btn btn-sm btn-outline-primary">
                <i class="fas fa-cog"></i> Test Email Configuration
            </button>
        </div>
    `;
    
    const resultDiv = document.getElementById('emailTestResult');
    if (resultDiv.innerHTML.includes('Email Debug Information')) {
        resultDiv.innerHTML = '';
    } else {
        resultDiv.innerHTML = debugInfo;
    }
}

function testEmailConfiguration() {
    const resultDiv = document.getElementById('emailTestResult');
    resultDiv.innerHTML = '<div class="alert alert-info"><i class="fas fa-spinner fa-spin"></i> Testing email configuration...</div>';
    
    // Call the backend endpoint to test configuration
    fetch('UserServlet?action=testEmailConfig')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                resultDiv.innerHTML = `<div class="alert alert-success"><i class="fas fa-check"></i> ${data.message}</div>`;
            } else {
                resultDiv.innerHTML = `<div class="alert alert-danger"><i class="fas fa-times"></i> ${data.message}</div>`;
            }
        })
        .catch(error => {
            resultDiv.innerHTML = `<div class="alert alert-danger"><i class="fas fa-times"></i> Lỗi kết nối: ${error.message}</div>`;
        });
}

function loadEmailConfiguration() {
    fetch('UserServlet?action=getEmailConfig')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const config = data.config;
                document.getElementById('currentSmtpUsername').textContent = config.smtpUsername;
                document.getElementById('currentSmtpHost').textContent = config.smtpHost;
                document.getElementById('currentSmtpPort').textContent = config.smtpPort;
                document.getElementById('currentPasswordStatus').textContent = config.smtpPasswordConfigured ? 'Đã cấu hình' : 'Chưa cấu hình';
                document.getElementById('currentConfigStatus').textContent = config.configurationValid ? 'Hợp lệ' : 'Không hợp lệ';
                
                // Update status colors
                const passwordStatus = document.getElementById('currentPasswordStatus');
                const configStatus = document.getElementById('currentConfigStatus');
                
                if (config.smtpPasswordConfigured) {
                    passwordStatus.className = 'text-success';
                } else {
                    passwordStatus.className = 'text-danger';
                }
                
                if (config.configurationValid) {
                    configStatus.className = 'text-success';
                } else {
                    configStatus.className = 'text-danger';
                }
                
                // Show configuration file path if available
                if (config.configFilePath) {
                    const configPathElement = document.getElementById('currentConfigPath');
                    if (configPathElement) {
                        configPathElement.textContent = config.configFilePath;
                    }
                }
            }
        })
        .catch(error => {
            console.error('Error loading email configuration:', error);
        });
}

function reloadEmailConfiguration() {
    const resultDiv = document.getElementById('emailConfigResult');
    resultDiv.innerHTML = '<div class="alert alert-info"><i class="fas fa-spinner fa-spin"></i> Đang tải lại cấu hình...</div>';
    
    fetch('UserServlet?action=reloadEmailConfig')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                resultDiv.innerHTML = `<div class="alert alert-success"><i class="fas fa-check"></i> ${data.message}</div>`;
                // Reload configuration display
                loadEmailConfiguration();
            } else {
                resultDiv.innerHTML = `<div class="alert alert-danger"><i class="fas fa-times"></i> ${data.message}</div>`;
            }
        })
        .catch(error => {
            resultDiv.innerHTML = `<div class="alert alert-danger"><i class="fas fa-times"></i> Lỗi kết nối: ${error.message}</div>`;
        });
}

function updateEmailConfiguration() {
    const username = document.getElementById('newSmtpUsername').value;
    const password = document.getElementById('newSmtpPassword').value;
    const resultDiv = document.getElementById('emailConfigResult');
    
    if (!username) {
        resultDiv.innerHTML = '<div class="alert alert-warning">Vui lòng nhập SMTP username.</div>';
        return;
    }
    
    if (!password) {
        resultDiv.innerHTML = '<div class="alert alert-warning">Vui lòng nhập SMTP password.</div>';
        return;
    }
    
    resultDiv.innerHTML = '<div class="alert alert-info"><i class="fas fa-spinner fa-spin"></i> Đang cập nhật cấu hình email...</div>';
    
    const formData = new FormData();
    formData.append('smtpUsername', username);
    formData.append('smtpPassword', password);
    
    fetch('UserServlet?action=updateEmailConfig', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            resultDiv.innerHTML = `<div class="alert alert-success"><i class="fas fa-check"></i> ${data.message}</div>`;
            // Reload configuration display
            loadEmailConfiguration();
        } else {
            resultDiv.innerHTML = `<div class="alert alert-danger"><i class="fas fa-times"></i> ${data.message}</div>`;
        }
    })
    .catch(error => {
        resultDiv.innerHTML = `<div class="alert alert-danger"><i class="fas fa-times"></i> Lỗi kết nối: ${error.message}</div>`;
    });
}

// Table Population Functions for Different Sections

function populateJobPostingsTable(jobPostings) {
    const tableBody = document.getElementById('jobPostingsTableBody');
    if (!tableBody) return;

    if (!jobPostings || jobPostings.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="7" style="text-align: center;">Không tìm thấy tin tuyển dụng nào.</td></tr>';
        return;
    }

    let html = '';
    jobPostings.forEach(job => {
        const statusClass = job.status === 'active' ? 'status-active' : 'status-inactive';
        html += `
            <tr>
                <td>${job.id}</td>
                <td>${job.title}</td>
                <td>${job.company}</td>
                <td>${job.location}</td>
                <td>${job.salary || '-'}</td>
                <td class="${statusClass}">${job.status}</td>
                <td class="actions">
                    <a href="JobPostingServlet?action=edit&id=${job.id}" class="btn-edit" title="Chỉnh sửa">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="JobPostingServlet?action=delete&id=${job.id}" class="btn-delete" title="Xóa"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa tin tuyển dụng này?')">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
}

function populateRoleAssignmentsTable(assignments) {
    const tableBody = document.getElementById('roleAssignmentsTableBody');
    if (!tableBody) return;

    if (!assignments || assignments.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="6" style="text-align: center;">Không có yêu cầu phân quyền nào.</td></tr>';
        return;
    }

    let html = '';
    assignments.forEach(assignment => {
        const statusClass = assignment.status === 'pending' ? 'status-pending' : 
                           assignment.status === 'accepted' ? 'status-active' : 'status-rejected';
        html += `
            <tr>
                <td>${assignment.id}</td>
                <td>${assignment.userName}</td>
                <td>${assignment.oldRole}</td>
                <td>${assignment.newRole}</td>
                <td class="${statusClass}">${assignment.status}</td>
                <td>${assignment.requestDate}</td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
}

function populateCategoriesTable(categories) {
    const tableBody = document.getElementById('categoriesTableBody');
    if (!tableBody) return;

    if (!categories || categories.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="4" style="text-align: center;">Không có danh mục nào.</td></tr>';
        return;
    }

    let html = '';
    categories.forEach(category => {
        html += `
            <tr>
                <td>${category.id}</td>
                <td>${category.name}</td>
                <td>${category.description || '-'}</td>
                <td class="actions">
                    <a href="CategoryServlet?action=edit&id=${category.id}" class="btn-edit" title="Chỉnh sửa">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="CategoryServlet?action=delete&id=${category.id}" class="btn-delete" title="Xóa"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
}

function populateSearchVerifyTable(searchResults) {
    const tableBody = document.getElementById('searchVerifyTableBody');
    if (!tableBody) return;

    if (!searchResults || searchResults.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="5" style="text-align: center;">Không có kết quả tìm kiếm nào.</td></tr>';
        return;
    }

    let html = '';
    searchResults.forEach(result => {
        const verificationClass = result.verified ? 'status-active' : 'status-pending';
        html += `
            <tr>
                <td>${result.id}</td>
                <td>${result.name}</td>
                <td>${result.type}</td>
                <td class="${verificationClass}">${result.verified ? 'Đã xác minh' : 'Chưa xác minh'}</td>
                <td class="actions">
                    <button onclick="verifyItem(${result.id})" class="btn-verify" title="Xác minh">
                        <i class="fas fa-check"></i>
                    </button>
                </td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
}

function populateSupportRequestsTable(requests) {
    const tableBody = document.getElementById('supportRequestsTableBody');
    if (!tableBody) return;

    if (!requests || requests.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="6" style="text-align: center;">Không có yêu cầu hỗ trợ nào.</td></tr>';
        return;
    }

    let html = '';
    requests.forEach(request => {
        const priorityClass = request.priority === 'high' ? 'priority-high' : 
                             request.priority === 'medium' ? 'priority-medium' : 'priority-low';
        const statusClass = request.status === 'open' ? 'status-pending' : 
                           request.status === 'resolved' ? 'status-active' : 'status-inactive';
        html += `
            <tr>
                <td>${request.id}</td>
                <td>${request.userName}</td>
                <td>${request.subject}</td>
                <td class="${priorityClass}">${request.priority}</td>
                <td class="${statusClass}">${request.status}</td>
                <td class="actions">
                    <a href="SupportServlet?action=view&id=${request.id}" class="btn-view" title="Xem chi tiết">
                        <i class="fas fa-eye"></i>
                    </a>
                    <a href="SupportServlet?action=reply&id=${request.id}" class="btn-edit" title="Trả lời">
                        <i class="fas fa-reply"></i>
                    </a>
                </td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
}

function populateNotificationsTable(notifications) {
    const tableBody = document.getElementById('notificationsTableBody');
    if (!tableBody) return;

    if (!notifications || notifications.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="5" style="text-align: center;">Không có thông báo nào.</td></tr>';
        return;
    }

    let html = '';
    notifications.forEach(notification => {
        const statusClass = notification.status === 'sent' ? 'status-active' : 'status-pending';
        html += `
            <tr>
                <td>${notification.id}</td>
                <td>${notification.title}</td>
                <td>${notification.type}</td>
                <td class="${statusClass}">${notification.status}</td>
                <td class="actions">
                    <a href="NotificationServlet?action=edit&id=${notification.id}" class="btn-edit" title="Chỉnh sửa">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="NotificationServlet?action=delete&id=${notification.id}" class="btn-delete" title="Xóa"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa thông báo này?')">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
}

function populateAlertsTable(alerts) {
    const tableBody = document.getElementById('alertsTableBody');
    if (!tableBody) return;

    if (!alerts || alerts.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="5" style="text-align: center;">Không có cảnh báo nào.</td></tr>';
        return;
    }

    let html = '';
    alerts.forEach(alert => {
        const severityClass = alert.severity === 'high' ? 'alert-high' : 
                             alert.severity === 'medium' ? 'alert-medium' : 'alert-low';
        html += `
            <tr>
                <td>${alert.id}</td>
                <td>${alert.message}</td>
                <td class="${severityClass}">${alert.severity}</td>
                <td>${alert.createdDate}</td>
                <td class="actions">
                    <button onclick="dismissAlert(${alert.id})" class="btn-dismiss" title="Bỏ qua">
                        <i class="fas fa-times"></i>
                    </button>
                </td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
}

function populateAccountStats(stats) {
    const statsContainer = document.getElementById('accountStatsContainer');
    if (!statsContainer) return;

    let html = `
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Tổng số tài khoản</h3>
                <p class="stat-number">${stats.totalAccounts || 0}</p>
            </div>
            <div class="stat-card">
                <h3>Tài khoản mới (tháng này)</h3>
                <p class="stat-number">${stats.newAccountsThisMonth || 0}</p>
            </div>
            <div class="stat-card">
                <h3>Tài khoản active</h3>
                <p class="stat-number">${stats.activeAccounts || 0}</p>
            </div>
            <div class="stat-card">
                <h3>Tài khoản pending</h3>
                <p class="stat-number">${stats.pendingAccounts || 0}</p>
            </div>
        </div>
    `;

    statsContainer.innerHTML = html;
}

function populateAccessStats(stats) {
    const statsContainer = document.getElementById('accessStatsContainer');
    if (!statsContainer) return;

    let html = `
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Tổng số truy cập</h3>
                <p class="stat-number">${stats.totalAccess || 0}</p>
            </div>
            <div class="stat-card">
                <h3>Truy cập hôm nay</h3>
                <p class="stat-number">${stats.todayAccess || 0}</p>
            </div>
            <div class="stat-card">
                <h3>Truy cập tuần này</h3>
                <p class="stat-number">${stats.weekAccess || 0}</p>
            </div>
            <div class="stat-card">
                <h3>Người dùng online</h3>
                <p class="stat-number">${stats.onlineUsers || 0}</p>
            </div>
        </div>
    `;

    statsContainer.innerHTML = html;
}

function populateActivityReports(reports) {
    const reportsContainer = document.getElementById('activityReportsContainer');
    if (!reportsContainer) return;

    if (!reports || reports.length === 0) {
        reportsContainer.innerHTML = '<p>Không có báo cáo hoạt động nào.</p>';
        return;
    }

    let html = '<div class="reports-list">';
    reports.forEach(report => {
        html += `
            <div class="report-item">
                <h4>${report.title}</h4>
                <p>${report.description}</p>
                <div class="report-meta">
                    <span>Ngày tạo: ${report.createdDate}</span>
                    <span>Loại: ${report.type}</span>
                </div>
                <a href="StatisticsServlet?action=downloadReport&id=${report.id}" class="btn-download">
                    <i class="fas fa-download"></i> Tải xuống
                </a>
            </div>
        `;
    });
    html += '</div>';

    reportsContainer.innerHTML = html;
}

function populateJobPostingReports(reports) {
    const reportsContainer = document.getElementById('jobPostingReportsContainer');
    if (!reportsContainer) return;

    if (!reports || reports.length === 0) {
        reportsContainer.innerHTML = '<p>Không có báo cáo tuyển dụng nào.</p>';
        return;
    }

    let html = '<div class="reports-list">';
    reports.forEach(report => {
        html += `
            <div class="report-item">
                <h4>${report.title}</h4>
                <p>${report.description}</p>
                <div class="report-stats">
                    <span>Tổng tin tuyển dụng: ${report.totalJobPostings}</span>
                    <span>Tin active: ${report.activeJobPostings}</span>
                    <span>Ứng viên: ${report.totalApplications}</span>
                </div>
                <a href="StatisticsServlet?action=downloadJobReport&id=${report.id}" class="btn-download">
                    <i class="fas fa-download"></i> Tải xuống
                </a>
            </div>
        `;
    });
    html += '</div>';

    reportsContainer.innerHTML = html;
}

function populateApplicationAnalysis(analysis) {
    const analysisContainer = document.getElementById('applicationAnalysisContainer');
    if (!analysisContainer) return;

    let html = `
        <div class="analysis-grid">
            <div class="analysis-card">
                <h3>Phân tích ứng dụng</h3>
                <div class="analysis-item">
                    <span>Tổng số ứng dụng:</span>
                    <span class="number">${analysis.totalApplications || 0}</span>
                </div>
                <div class="analysis-item">
                    <span>Ứng dụng mới:</span>
                    <span class="number">${analysis.newApplications || 0}</span>
                </div>
                <div class="analysis-item">
                    <span>Tỷ lệ chấp nhận:</span>
                    <span class="number">${analysis.acceptanceRate || 0}%</span>
                </div>
                <div class="analysis-item">
                    <span>Thời gian xử lý trung bình:</span>
                    <span class="number">${analysis.avgProcessingTime || 0} ngày</span>
                </div>
            </div>
        </div>
    `;

    analysisContainer.innerHTML = html;
}

// Utility functions for different sections
function verifyItem(itemId) {
    if (confirm('Bạn có chắc chắn muốn xác minh mục này?')) {
        fetch(`SearchVerifyServlet?action=verify&id=${itemId}`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showSuccessMessage('Xác minh thành công!');
                    // Reload the search verify data
                    loadDataForSection('search-verify');
                } else {
                    showErrorMessage(data.message || 'Lỗi khi xác minh');
                }
            })
            .catch(error => {
                console.error('Error verifying item:', error);
                showErrorMessage('Lỗi khi xác minh');
            });
    }
}

function dismissAlert(alertId) {
    if (confirm('Bạn có chắc chắn muốn bỏ qua cảnh báo này?')) {
        fetch(`AlertServlet?action=dismiss&id=${alertId}`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showSuccessMessage('Đã bỏ qua cảnh báo!');
                    // Reload the alerts data
                    loadDataForSection('alerts');
                } else {
                    showErrorMessage(data.message || 'Lỗi khi bỏ qua cảnh báo');
                }
            })
            .catch(error => {
                console.error('Error dismissing alert:', error);
                showErrorMessage('Lỗi khi bỏ qua cảnh báo');
            });
    }
}

// Post Approval Functions
function populatePostApprovalTable(posts) {
    const tableBody = document.getElementById('postApprovalTableBody');
    if (!tableBody) return;

    if (!posts || posts.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="8" style="text-align: center;">Không có bài đăng nào.</td></tr>';
        return;
    }

    let html = '';
    posts.forEach(post => {
        const statusClass = getPostStatusClass(post.status);
        const statusText = getPostStatusText(post.status);
        const createdAt = post.createdAt ? new Date(post.createdAt).toLocaleDateString('vi-VN') : '';
        
        html += `
            <tr>
                <td>${post.id}</td>
                <td>${post.title}</td>
                <td>${post.author || '-'}</td>
                <td>${post.company || '-'}</td>
                <td>${post.category || '-'}</td>
                <td>${post.location || '-'}</td>
                <td class="${statusClass}">${statusText}</td>
                <td>${createdAt}</td>
                <td class="actions">
                    <button onclick="viewPostDetails(${post.id})" class="btn-view" title="Xem chi tiết">
                        <i class="fas fa-eye"></i>
                    </button>
                    ${post.status === 'pending' ? `
                        <button onclick="approvePost(${post.id})" class="btn-approve" title="Phê duyệt">
                            <i class="fas fa-check"></i>
                        </button>
                        <button onclick="rejectPost(${post.id})" class="btn-reject" title="Từ chối">
                            <i class="fas fa-times"></i>
                        </button>
                    ` : ''}
                    <button onclick="deletePost(${post.id})" class="btn-delete" title="Xóa">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
}

function getPostStatusClass(status) {
    switch(status) {
        case 'pending': return 'status-pending';
        case 'approved': return 'status-approved';
        case 'rejected': return 'status-rejected';
        case 'draft': return 'status-draft';
        default: return 'status-unknown';
    }
}

function getPostStatusText(status) {
    switch(status) {
        case 'pending': return 'Chờ phê duyệt';
        case 'approved': return 'Đã phê duyệt';
        case 'rejected': return 'Đã từ chối';
        case 'draft': return 'Bản nháp';
        default: return status;
    }
}

function viewPostDetails(postId) {
    const basePath = getBasePath();
    fetch(basePath + `post?action=getById&id=${postId}`)
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
    document.getElementById('postTitle').textContent = post.title;
    document.getElementById('postAuthor').textContent = post.author || 'N/A';
    document.getElementById('postCompany').textContent = post.company || 'N/A';
    document.getElementById('postCategory').textContent = post.category || 'N/A';
    document.getElementById('postLocation').textContent = post.location || 'N/A';
    document.getElementById('postSalary').textContent = post.salary || 'N/A';
    document.getElementById('postContent').textContent = post.content || 'N/A';
    document.getElementById('postRequirements').textContent = post.requirements || 'N/A';
    document.getElementById('postStatus').textContent = getPostStatusText(post.status);
    document.getElementById('postCreatedAt').textContent = post.createdAt ? new Date(post.createdAt).toLocaleString('vi-VN') : 'N/A';

    // Show modal
    modal.style.display = 'block';
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

    fetch(basePath + 'post', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) throw new Error('HTTP error ' + response.status);
        return response.json();
    })
    .then(data => {
        if (data.success) {
            showSuccessMessage(`Đã ${actionName.toLowerCase()} bài đăng thành công`);
            // Reload the post approval data
            loadDataForSection('post-approval');
        } else {
            showErrorMessage(data.message || `Lỗi khi ${actionName.toLowerCase()} bài đăng`);
        }
    })
    .catch(error => {
        console.error(`Error ${actionName.toLowerCase()} post:`, error);
        showErrorMessage(`Lỗi khi ${actionName.toLowerCase()} bài đăng`);
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

    fetch(basePath + 'post', {
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
            // Reload the post approval data
            loadDataForSection('post-approval');
        } else {
            showErrorMessage(data.message || 'Lỗi khi xóa bài đăng');
        }
    })
    .catch(error => {
        console.error('Error deleting post:', error);
        showErrorMessage('Lỗi khi xóa bài đăng');
    });
}

// Company Job Management Functions
function populateCompanySelect(companies) {
    const companySelect = document.getElementById('companySelect');
    if (!companySelect) return;

    let html = '<option value="">Chọn công ty</option>';
    companies.forEach(company => {
        html += `<option value="${company.id}">${company.companyName}</option>`;
    });
    companySelect.innerHTML = html;
}

function loadJobsByCompany() {
    const companyId = document.getElementById('companySelect').value;
    const status = document.getElementById('statusFilter').value;
    
    if (!companyId) {
        showErrorMessage('Vui lòng chọn công ty');
        return;
    }

    const basePath = getBasePath();
    let url = basePath + `JobPostingServlet?action=getJobsByCompany&companyId=${companyId}`;
    if (status) {
        url += `&status=${status}`;
    }

    fetch(url)
        .then(response => {
            if (!response.ok) throw new Error('HTTP error ' + response.status);
            return response.json();
        })
        .then(data => {
            populateCompanyJobsTable(data.jobs);
        })
        .catch(error => {
            console.error('Error loading company jobs:', error);
            showErrorMessage('Lỗi khi tải danh sách công việc');
        });
}

function populateCompanyJobsTable(jobs) {
    const tableBody = document.getElementById('companyJobsTableBody');
    if (!tableBody) return;

    if (!jobs || jobs.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="8" style="text-align: center;">Không có công việc nào.</td></tr>';
        return;
    }

    let html = '';
    jobs.forEach(job => {
        const statusClass = getJobStatusClass(job.status);
        const statusText = getJobStatusText(job.status);
        const postedAt = job.postedAt ? new Date(job.postedAt).toLocaleDateString('vi-VN') : '';
        const salary = job.salaryMin && job.salaryMax ? 
            `${job.salaryMin.toLocaleString()} - ${job.salaryMax.toLocaleString()}` : 'Thỏa thuận';
        
        html += `
            <tr>
                <td>${job.id}</td>
                <td>${job.title}</td>
                <td>${job.location || '-'}</td>
                <td>${job.jobType || '-'}</td>
                <td>${salary}</td>
                <td class="${statusClass}">${statusText}</td>
                <td>${postedAt}</td>
                <td class="actions">
                    <button onclick="viewJobDetails(${job.id})" class="btn-view" title="Xem chi tiết">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button onclick="editJob(${job.id})" class="btn-edit" title="Chỉnh sửa">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button onclick="updateJobStatus(${job.id}, '${job.status === 'open' ? 'closed' : 'open'}')" 
                            class="btn-toggle" title="${job.status === 'open' ? 'Đóng' : 'Mở'}">
                        <i class="fas fa-${job.status === 'open' ? 'lock' : 'unlock'}"></i>
                    </button>
                    <button onclick="deleteJob(${job.id})" class="btn-delete" title="Xóa">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            </tr>
        `;
    });

    tableBody.innerHTML = html;
}

function getJobStatusClass(status) {
    switch(status) {
        case 'open': return 'status-open';
        case 'closed': return 'status-closed';
        case 'draft': return 'status-draft';
        default: return 'status-unknown';
    }
}

function getJobStatusText(status) {
    switch(status) {
        case 'open': return 'Đang mở';
        case 'closed': return 'Đã đóng';
        case 'draft': return 'Bản nháp';
        default: return status;
    }
}

function viewJobDetails(jobId) {
    const basePath = getBasePath();
    fetch(basePath + `JobPostingServlet?action=getById&jobId=${jobId}`)
        .then(response => {
            if (!response.ok) throw new Error('HTTP error ' + response.status);
            return response.json();
        })
        .then(data => {
            if (data.success) {
                showJobDetailsModal(data.job);
            } else {
                showErrorMessage(data.message || 'Lỗi khi tải chi tiết công việc');
            }
        })
        .catch(error => {
            console.error('Error loading job details:', error);
            showErrorMessage('Lỗi khi tải chi tiết công việc');
        });
}

function showJobDetailsModal(job) {
    const modal = document.getElementById('jobDetailsModal');
    if (!modal) return;

    // Populate modal content
    document.getElementById('jobTitle').textContent = job.title;
    document.getElementById('jobCompany').textContent = job.companyName || 'N/A';
    document.getElementById('jobLocation').textContent = job.location || 'N/A';
    document.getElementById('jobType').textContent = job.jobType || 'N/A';
    document.getElementById('jobSalary').textContent = job.salaryMin && job.salaryMax ? 
        `${job.salaryMin.toLocaleString()} - ${job.salaryMax.toLocaleString()}` : 'Thỏa thuận';
    document.getElementById('jobDescription').textContent = job.description || 'N/A';
    document.getElementById('jobBenefits').textContent = job.benefits || 'N/A';
    document.getElementById('jobStatus').textContent = getJobStatusText(job.status);
    document.getElementById('jobPostedAt').textContent = job.postedAt ? new Date(job.postedAt).toLocaleString('vi-VN') : 'N/A';

    // Show modal
    modal.style.display = 'block';
}

function updateJobStatus(jobId, newStatus) {
    const basePath = getBasePath();
    const formData = new FormData();
    formData.append('action', 'updateStatus');
    formData.append('jobId', jobId);
    formData.append('status', newStatus);

    fetch(basePath + 'JobPostingServlet', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) throw new Error('HTTP error ' + response.status);
        return response.json();
    })
    .then(data => {
        if (data.success) {
            showSuccessMessage('Cập nhật trạng thái công việc thành công');
            // Reload the company jobs
            loadJobsByCompany();
        } else {
            showErrorMessage(data.message || 'Lỗi khi cập nhật trạng thái công việc');
        }
    })
    .catch(error => {
        console.error('Error updating job status:', error);
        showErrorMessage('Lỗi khi cập nhật trạng thái công việc');
    });
}

function deleteJob(jobId) {
    if (!confirm('Bạn có chắc chắn muốn xóa công việc này?')) {
        return;
    }

    const basePath = getBasePath();
    const formData = new FormData();
    formData.append('action', 'deleteJob');
    formData.append('jobId', jobId);

    fetch(basePath + 'JobPostingServlet', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) throw new Error('HTTP error ' + response.status);
        return response.json();
    })
    .then(data => {
        if (data.success) {
            showSuccessMessage('Đã xóa công việc thành công');
            // Reload the company jobs
            loadJobsByCompany();
        } else {
            showErrorMessage(data.message || 'Lỗi khi xóa công việc');
        }
    })
    .catch(error => {
        console.error('Error deleting job:', error);
        showErrorMessage('Lỗi khi xóa công việc');
    });
} 

// Add this function to the end of admin.js file
function populateUserManagementTable(loginHistory) {
    console.log('populateUserManagementTable called with:', loginHistory);
    
    const tableBody = document.getElementById('loginHistoryTableBody');
    const loadingSpinner = document.getElementById('loadingSpinner');
    const tableContainer = document.getElementById('tableContainer');
    
    if (!tableBody) {
        console.error('loginHistoryTableBody not found!');
        return;
    }
    
    // Hide loading spinner and show table
    if (loadingSpinner) {
        loadingSpinner.style.display = 'none';
        console.log('Loading spinner hidden');
    }
    
    if (tableContainer) {
        tableContainer.style.display = 'block';
        console.log('Table container shown');
    }
    
    // Clear existing data
    tableBody.innerHTML = '';
    
    if (loginHistory && loginHistory.length > 0) {
        console.log('Populating table with', loginHistory.length, 'records');
        
        loginHistory.forEach((history, index) => {
            const row = document.createElement('tr');
            
            // Format the login time
            let formattedTime = 'N/A';
            try {
                const loginTime = new Date(history.loginTime);
                formattedTime = loginTime.toLocaleString('vi-VN');
            } catch (e) {
                console.error('Error formatting date:', e);
                formattedTime = history.loginTime || 'N/A';
            }
            
            row.innerHTML = `
                <td>${history.id || '-'}</td>
                <td>${history.userId || '-'}</td>
                <td>${formattedTime}</td>
                <td>${history.ipAddress || '-'}</td>
                <td>${history.deviceInfo || '-'}</td>
            `;
            
            tableBody.appendChild(row);
        });
        
        console.log('Table populated successfully');
    } else {
        console.log('No login history data, showing empty message');
        // Show no data message
        const row = document.createElement('tr');
        row.innerHTML = '<td colspan="5" style="text-align:center;">Không có dữ liệu lịch sử truy cập.</td>';
        tableBody.appendChild(row);
    }
}
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('editUserForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(form);

            fetch(form.action, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json()) // Expect JSON from backend
            .then(data => {
                if (data.success) {
                    // Close modal
                    const modal = bootstrap.Modal.getInstance(document.getElementById('editUserModal'));
                    modal.hide();
                    // Reload user table (adjust as needed)
                    loadUserDataWithFilters('', '');
                } else {
                    alert(data.message || 'Lỗi khi cập nhật người dùng');
                }
            })
            .catch(() => alert('Lỗi khi cập nhật người dùng'));
        });
    }
});

 

