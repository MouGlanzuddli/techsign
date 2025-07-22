// Wait for #system-notifications to exist before running logic
function initSystemNotifications() {
  const section = document.getElementById('system-notifications');
  if (!section) return false;

  // Bootstrap tab switching is handled by Bootstrap itself
  // No need for manual tab logic

  // Elements
  const form = section.querySelector('#createNotificationForm');
  const msgDiv = section.querySelector('#notificationCreateMsg');
  const listContainer = section.querySelector('#notificationListContainer');

  // Form submit
  if (form) {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      msgDiv.innerHTML = '';
      const formData = new FormData(form);
      const params = new URLSearchParams();
      for (let [k, v] of formData.entries()) {
        params.append(k, v);
      }
      fetch('notifications', {
        method: 'POST',
        body: params
      })
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          msgDiv.innerHTML = '<div class="alert alert-success mb-2"><i class="fas fa-check-circle"></i> Thông báo đã được tạo thành công!</div>';
          form.reset();
          loadNotifications();
          // Switch to history tab after creation
          const historyTabBtn = document.getElementById('tab-history-tab');
          if (historyTabBtn) {
            new bootstrap.Tab(historyTabBtn).show();
          }
        } else {
          msgDiv.innerHTML = '<div class="alert alert-danger mb-2"><i class="fas fa-times-circle"></i> Lỗi: ' + (data.message || 'Không thể tạo thông báo') + '</div>';
        }
      })
      .catch(err => {
        msgDiv.innerHTML = '<div class="alert alert-danger mb-2"><i class="fas fa-times-circle"></i> Lỗi kết nối máy chủ.</div>';
      });
    });
  }

  // Demo notification buttons
  const demoBtns = section.querySelectorAll('.demo-notification-buttons button');
  demoBtns.forEach(btn => {
    btn.addEventListener('click', function() {
      let type, title, message;
      if (btn.classList.contains('btn-success')) {
        type = 'system'; title = 'Thành Công'; message = 'Đây là thông báo thành công!';
      } else if (btn.classList.contains('btn-danger')) {
        type = 'security'; title = 'Lỗi Hệ Thống'; message = 'Đã xảy ra lỗi hệ thống!';
      } else if (btn.classList.contains('btn-warning')) {
        type = 'maintenance'; title = 'Cảnh Báo'; message = 'Đây là cảnh báo bảo trì!';
      } else if (btn.classList.contains('btn-info')) {
        type = 'update'; title = 'Thông Tin'; message = 'Đây là thông báo thông tin.';
      }
      if (type) {
        fetch('notifications', {
          method: 'POST',
          body: new URLSearchParams({
            title: title,
            message: message,
            type: type,
            auto_dismiss: 'on',
            duration_ms: 5000
          })
        })
        .then(res => res.json())
        .then(data => {
          if (data.success) {
            loadNotifications();
          }
        });
      }
    });
  });

  // Initial load
  loadNotifications();

  function loadNotifications() {
    fetch('notifications?action=ajax')
      .then(res => res.json())
      .then(data => {
        renderNotificationList(data.pinnedNotifications || [], data.notifications || []);
      });
  }

  function renderNotificationList(pinned, notifications) {
    if (!listContainer) {
      console.error('notificationListContainer not found!');
      return;
    }
    let html = '';
    if (pinned.length > 0) {
      html += '<div class="mb-2 fw-bold text-primary">Đã ghim</div>';
      html += pinned.map(n => notificationCardHTML(n, true)).join('');
    }
    if (notifications.length > 0) {
      html += '<div class="mb-2 fw-bold text-primary">Tất cả thông báo</div>';
      html += notifications.map(n => notificationCardHTML(n, false)).join('');
    }
    if (!html) html = '<div class="text-center text-muted">Không có thông báo nào.</div>';
    listContainer.innerHTML = html;
    attachNotificationActions();
  }

  function notificationCardHTML(n, pinned) {
    const typeMap = {
      'system': {icon: 'fa-info-circle', color: 'primary', label: 'Info'},
      'maintenance': {icon: 'fa-tools', color: 'warning', label: 'Maintenance'},
      'security': {icon: 'fa-shield-alt', color: 'danger', label: 'Security'},
      'update': {icon: 'fa-sync', color: 'success', label: 'Update'}
    };
    const t = typeMap[n.type] || typeMap['system'];
    return `<div class="card mb-3 ${pinned ? 'border-primary' : ''}">
      <div class="card-body d-flex align-items-center gap-3">
        <i class="fas ${t.icon} text-${t.color} fs-4"></i>
        <div class="flex-grow-1">
          <div class="fw-semibold">${n.title}</div>
          <div class="text-muted small mt-1">${n.message}</div>
        </div>
        <span class="badge bg-${t.color} me-2">${t.label}</span>
        <div class="btn-group ms-2" role="group">
          <button class="btn btn-outline-secondary btn-sm notif-edit-btn" data-id="${n.id}" title="Sửa"><i class="fas fa-edit"></i></button>
          <button class="btn btn-outline-danger btn-sm notif-delete-btn" data-id="${n.id}" title="Xóa"><i class="fas fa-trash-alt"></i></button>
        </div>
      </div>
    </div>`;
  }

  function attachNotificationActions() {
    // Hàm an toàn để gán giá trị cho input
    function safeSetValue(id, value) {
      const el = document.getElementById(id);
      if (el) {
        console.log('[DEBUG] Gán giá trị cho', id, '->', value);
        el.value = value;
      } else {
        console.warn('[DEBUG] Không tìm thấy element với id:', id);
      }
    }
    function safeSetChecked(id, checked) {
      const el = document.getElementById(id);
      if (el) {
        console.log('[DEBUG] Gán checked cho', id, '->', checked);
        el.checked = checked;
      } else {
        console.warn('[DEBUG] Không tìm thấy element với id:', id);
      }
    }
    const listContainer = document.getElementById('notificationListContainer');
    if (listContainer) {
      listContainer.addEventListener('click', function(event) {
        // Edit button
        if (event.target.closest('.notif-edit-btn')) {
          const btn = event.target.closest('.notif-edit-btn');
          let card = btn.closest('.card');
          if (!card) return;
          const id = btn.getAttribute('data-id');
          const title = card.querySelector('.fw-semibold')?.textContent || '';
          const message = card.querySelector('.text-muted.small')?.textContent || '';
          const badge = card.querySelector('.badge');
          let type = 'system';
          if (badge) {
            const label = badge.textContent.trim();
            if (label === 'Info') type = 'system';
            else if (label === 'Maintenance') type = 'maintenance';
            else if (label === 'Security') type = 'security';
            else if (label === 'Update') type = 'update';
          }
          console.log('[DEBUG] (Delegation) Mở modal sửa thông báo:', {id, title, message, type});
          safeSetValue('edit-noti-id', id);
          safeSetValue('edit-noti-title', title);
          safeSetValue('edit-noti-type', type);
          safeSetValue('edit-noti-message', message);
          safeSetChecked('edit-noti-auto-dismiss', true);
          safeSetValue('edit-noti-duration', 5000);
          safeSetChecked('edit-noti-pinned', card.classList.contains('border-primary'));
          const msgDiv = document.getElementById('editNotificationMsg');
          if (msgDiv) msgDiv.innerHTML = '';
          else console.warn('[DEBUG] Không tìm thấy element với id: editNotificationMsg');
          const modalEl = document.getElementById('editNotificationModal');
          if (!modalEl) {
            console.error('[DEBUG] Không tìm thấy modal editNotificationModal trong DOM!');
          } else {
            console.log('[DEBUG] Đã tìm thấy modal editNotificationModal, chuẩn bị show modal.');
          }
          const modal = new bootstrap.Modal(modalEl);
          modal.show();
        }
        // Delete button
        if (event.target.closest('.notif-delete-btn')) {
          const btn = event.target.closest('.notif-delete-btn');
          const id = btn.getAttribute('data-id');
          if (confirm('Bạn có chắc chắn muốn xóa thông báo này?')) {
            fetch('notifications', {
              method: 'POST',
              body: new URLSearchParams({ action: 'delete', id })
            })
            .then(res => res.json())
            .then(data => {
              if (data.success) {
                loadNotifications();
              } else {
                alert('Xóa thất bại: ' + (data.message || 'Lỗi không xác định'));
              }
            })
            .catch(() => alert('Lỗi kết nối máy chủ.'));
          }
        }
      });
    }

    // Xử lý submit form sửa thông báo
    const editForm = document.getElementById('editNotificationForm');
    if (editForm) {
      editForm.onsubmit = function(e) {
        e.preventDefault();
        const msgDiv = document.getElementById('editNotificationMsg');
        msgDiv.innerHTML = '';
        const formData = new FormData(editForm);
        const params = new URLSearchParams();
        for (let [k, v] of formData.entries()) {
          params.append(k, v);
        }
        params.append('action', 'edit');
        fetch('notifications', {
          method: 'POST',
          body: params
        })
        .then(res => res.json())
        .then(data => {
          if (data.success) {
            msgDiv.innerHTML = '<div class="alert alert-success mb-2"><i class="fas fa-check-circle"></i> Đã cập nhật thông báo!</div>';
            setTimeout(() => {
              bootstrap.Modal.getInstance(document.getElementById('editNotificationModal')).hide();
              loadNotifications();
            }, 800);
          } else {
            msgDiv.innerHTML = '<div class="alert alert-danger mb-2"><i class="fas fa-times-circle"></i> ' + (data.message || 'Không thể cập nhật') + '</div>';
          }
        })
        .catch(() => {
          msgDiv.innerHTML = '<div class="alert alert-danger mb-2"><i class="fas fa-times-circle"></i> Lỗi kết nối máy chủ.</div>';
        });
      };
    }
  }
  return true;
}
function waitForSystemNotificationsInit() {
  if (initSystemNotifications()) return;
  const observer = new MutationObserver(() => {
    if (initSystemNotifications()) observer.disconnect();
  });
  observer.observe(document.body, { childList: true, subtree: true });
}
document.addEventListener('DOMContentLoaded', waitForSystemNotificationsInit);

// Expose a global function for section loader
window.loadNotificationsData = function() {
  const section = document.getElementById('system-notifications');
  if (!section) return;
  const listContainer = section.querySelector('#notificationListContainer');
  fetch('notifications?action=ajax')
    .then(res => {
      if (!res.ok) throw new Error('HTTP error ' + res.status);
      return res.json();
    })
    .then(data => {
      renderNotificationList(data.pinnedNotifications || [], data.notifications || []);
    })
    .catch(error => {
      console.error('Error loading notifications:', error);
      if (listContainer) {
        listContainer.innerHTML = '<div class="alert alert-danger">Lỗi khi tải thông báo</div>';
      }
    });
}

// DEBUG: Kiểm tra modal và các input trong DOM
(function() {
  const modalEl = document.getElementById('editNotificationModal');
  if (modalEl) {
    console.log('[CHECK] Modal editNotificationModal đã tồn tại trong DOM.');
  } else {
    console.error('[CHECK] Modal editNotificationModal KHÔNG tồn tại trong DOM!');
  }
  const ids = [
    'edit-noti-id',
    'edit-noti-title',
    'edit-noti-type',
    'edit-noti-message',
    'edit-noti-auto-dismiss',
    'edit-noti-duration',
    'edit-noti-pinned'
  ];
  ids.forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      console.log(`[CHECK] Element với id: ${id} đã tồn tại.`);
    } else {
      console.error(`[CHECK] Element với id: ${id} KHÔNG tồn tại!`);
    }
  });
})(); 