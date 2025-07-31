function fetchSessions(userId) {
    fetch('SessionServlet?action=listByUser&userId=' + userId)
        .then(r => r.json())
        .then(data => {
            if (data.success) {
                renderSessionsTable(data.sessions);
            } else {
                showErrorMessage(data.message || 'Lỗi khi tải danh sách phiên');
            }
        });
}

function renderSessionsTable(sessions) {
    const tbody = document.getElementById('sessionsTableBody');
    const table = document.getElementById('sessionsTable');
    const emptyState = document.getElementById('sessionsEmptyState');
    if (!tbody) return;
    if (!sessions || sessions.length === 0) {
        table.style.display = 'none';
        emptyState.style.display = 'block';
        return;
    }
    table.style.display = 'table';
    emptyState.style.display = 'none';
    let html = '';
    sessions.forEach(session => {
        html += `<tr>
            <td>${escapeHtml(session.deviceInfo || '-')}</td>
            <td>${escapeHtml(session.ipAddress || '-')}</td>
            <td>${formatDateTime(session.loginTime)}</td>
            <td>${formatDateTime(session.lastActiveTime)}</td>
            <td>${session.isActive ? '<span class="badge bg-success">Active</span>' : '<span class="badge bg-secondary">Ended</span>'}</td>
            <td>${session.isActive ? `<button class="btn btn-sm btn-danger" onclick="forceLogout(${session.id})">Force Logout</button>` : '-'}</td>
        </tr>`;
    });
    tbody.innerHTML = html;
}

function forceLogout(sessionId) {
    if (confirm('Force logout this session?')) {
        fetch('SessionServlet?action=forceLogout&id=' + sessionId, { method: 'POST' })
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    alert('Session logged out!');
                    location.reload();
                } else {
                    alert('Failed to logout session.');
                }
            });
    }
}

function escapeHtml(text) {
    if (!text) return '';
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}
function formatDateTime(dt) {
    if (!dt || dt === 'null') return '-';
    return dt.replace('T', ' ').substring(0, 16);
}
// Example: fetch for current user (replace with actual userId)
document.addEventListener('DOMContentLoaded', function() {
    var userId = window.currentUserId || 1; // Set this dynamically
    fetchSessions(userId);
});


function fetchUserActivity(userId) {
    fetch('SessionServlet?action=listByUser&userId=' + userId)
        .then(r => r.json()).then(data => renderSessionsTable(data.sessions));
    fetch('SystemLogServlet?action=listByUser&userId=' + userId)
        .then(r => r.json()).then(data => renderSystemLogsTable(data.logs));
    fetch('AuditLogServlet?action=listByUser&userId=' + userId)
        .then(r => r.json()).then(data => renderAuditLogsTable(data.logs));
}

function renderSessionsTable(sessions) {
    const tbody = document.getElementById('sessionsTableBody');
    tbody.innerHTML = (sessions || []).map(session => `
        <tr>
            <td>${escapeHtml(session.deviceInfo || '-')}</td>
            <td>${escapeHtml(session.ipAddress || '-')}</td>
            <td>${formatDateTime(session.loginTime)}</td>
            <td>${formatDateTime(session.lastActiveTime)}</td>
            <td>${session.isActive ? '<span class="badge bg-success">Active</span>' : '<span class="badge bg-secondary">Ended</span>'}</td>
            <td>${session.isActive ? `<button class="btn btn-sm btn-danger" onclick="forceLogout(${session.id})">Force Logout</button>` : '-'}</td>
        </tr>
    `).join('');
}

function renderSystemLogsTable(logs) {
    const tbody = document.getElementById('systemLogsTableBody');
    tbody.innerHTML = (logs || []).map(log => `
        <tr>
            <td>${escapeHtml(log.action)}</td>
            <td>${escapeHtml(log.description)}</td>
            <td>${formatDateTime(log.createdAt)}</td>
        </tr>
    `).join('');
}

function renderAuditLogsTable(logs) {
    const tbody = document.getElementById('auditLogsTableBody');
    tbody.innerHTML = (logs || []).map(log => `
        <tr>
            <td>${escapeHtml(log.actionType)}</td>
            <td>${escapeHtml(log.entityType)}</td>
            <td>${log.entityId}</td>
            <td><pre>${escapeHtml(log.oldValue)}</pre></td>
            <td><pre>${escapeHtml(log.newValue)}</pre></td>
            <td>${escapeHtml(log.ipAddress)}</td>
            <td>${formatDateTime(log.timestamp)}</td>
        </tr>
    `).join('');
}

function forceLogout(sessionId) {
    if (confirm('Force logout this session?')) {
        fetch('SessionServlet?action=forceLogout&id=' + sessionId, { method: 'POST' })
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    alert('Session logged out!');
                    location.reload();
                } else {
                    alert('Failed to logout session.');
                }
            });
    }
}

function escapeHtml(text) {
    if (!text) return '';
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}
function formatDateTime(dt) {
    if (!dt || dt === 'null') return '-';
    return dt.replace('T', ' ').substring(0, 16);
}

document.addEventListener('DOMContentLoaded', function() {
    var userId = window.currentUserId || 1; // Set this dynamically
    fetchUserActivity(userId);
});

// === Merged Alerts ===
function fetchMergedAlerts(userId) {
    fetch('AuditLogServlet?action=mergeWithSession&userId=' + userId)
        .then(r => r.json())
        .then(data => {
            if (data.success) {
                renderMergedAlertsTable(data.alerts);
            } else {
                showErrorMessage(data.message || 'Lỗi khi tải cảnh báo');
            }
        });
}

function renderMergedAlertsTable(alerts) {
    const tbody = document.getElementById('alertsTableBody');
    if (!tbody) return;
    if (!alerts || alerts.length === 0) {
        tbody.innerHTML = '<tr><td colspan="11">Không có cảnh báo nào.</td></tr>';
        return;
    }
    function getSeverityBadge(severity) {
        if (severity === 'danger') return '<span class="badge bg-danger">Danger</span>';
        if (severity === 'warning') return '<span class="badge bg-warning text-dark">Warning</span>';
        return '<span class="badge bg-info text-dark">Info</span>';
    }
    tbody.innerHTML = alerts.map(alert => `
        <tr>
            <td>${escapeHtml(alert.actionType)}</td>
            <td>${escapeHtml(alert.entityType)}</td>
            <td>${alert.entityId}</td>
            <td><pre>${escapeHtml(alert.oldValue)}</pre></td>
            <td><pre>${escapeHtml(alert.newValue)}</pre></td>
            <td>${escapeHtml(alert.auditIpAddress)}</td>
            <td>${formatDateTime(alert.auditTimestamp)}</td>
            <td>${escapeHtml(alert.deviceInfo)}</td>
            <td>${formatDateTime(alert.loginTime)}</td>
            <td>${alert.isActive ? '<span class="badge bg-success">Active</span>' : '<span class="badge bg-secondary">Ended</span>'}</td>
            <td>${getSeverityBadge(alert.severity)}</td>
        </tr>
    `).join('');
}

// Gọi fetchMergedAlerts khi trang load
document.addEventListener('DOMContentLoaded', function() {
    var userId = window.currentUserId || 1; // Set this dynamically
    fetchMergedAlerts(userId);
});