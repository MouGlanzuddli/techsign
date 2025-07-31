// Global variable to track if system notifications are initialized
let systemNotificationsInitialized = false;

/**
 * Initialize system notifications when the section is loaded
 * This function is called from section-loader.js when the notifications section is loaded
 */
function initSystemNotifications() {
  console.log('[DEBUG] Initializing system notifications...');
  const section = document.getElementById('system-notifications');
  
  if (!section) {
    console.error('[DEBUG] #system-notifications section not found!');
    return false;
  }
  
  // Prevent double initialization
  if (systemNotificationsInitialized) {
    console.log('[DEBUG] System notifications already initialized');
    return true;
  }
  
  console.log('[DEBUG] System notifications section found, setting up...');

  // Bootstrap tab switching is handled by Bootstrap itself
  // No need for manual tab logic

  // Elements
  const form = section.querySelector('#createNotificationForm');
  const msgDiv = section.querySelector('#notificationCreateMsg');
  // Don't declare listContainer here, we'll use it in the functions that need it

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

  console.log('[DEBUG] System notifications initialization started');
  
  // First, ensure we're on the history tab
  console.log('[DEBUG] Activating history tab...');
  const historyTab = document.querySelector('#tab-history-tab');
  const historyTabContent = document.querySelector('#tab-history');
  const demoTab = document.querySelector('#tab-demo-tab');
  const demoContent = document.querySelector('#tab-demo');
  
  console.log('[DEBUG] Tab elements:', { 
    historyTab: !!historyTab, 
    historyTabContent: !!historyTabContent,
    demoContent: !!demoContent
  });
  
  if (historyTab && historyTabContent) {
    // Remove active classes from demo tab
    if (demoTab) demoTab.classList.remove('active', 'show');
    if (demoContent) demoContent.classList.remove('active', 'show');
    
    // Add active classes to history tab
    historyTab.classList.add('active');
    historyTab.setAttribute('aria-selected', 'true');
    historyTabContent.classList.add('active', 'show');
    
    // Force display style
    historyTabContent.style.display = 'block';
    if (demoContent) demoContent.style.display = 'none';
    
    console.log('[DEBUG] History tab activated');
  }
  
  // Add debug overlay
  function createDebugOverlay() {
    const overlay = document.createElement('div');
    overlay.id = 'notifications-debug-overlay';
    overlay.style.position = 'fixed';
    overlay.style.bottom = '10px';
    overlay.style.right = '10px';
    overlay.style.padding = '10px';
    overlay.style.backgroundColor = 'rgba(0,0,0,0.8)';
    overlay.style.color = '#fff';
    overlay.style.borderRadius = '5px';
    overlay.style.zIndex = '9999';
    overlay.style.fontFamily = 'monospace';
    overlay.style.fontSize = '12px';
    overlay.style.maxWidth = '300px';
    overlay.style.maxHeight = '200px';
    overlay.style.overflow = 'auto';
    document.body.appendChild(overlay);
    return overlay;
  }

  function updateDebugInfo() {
    let debugInfo = '';
    const container = document.querySelector('#notificationListContainer');
    const tab = document.querySelector('#tab-history');
    const tabButton = document.querySelector('#tab-history-tab');
    const tabContent = document.querySelector('.tab-content');
    
    debugInfo += '=== NOTIFICATIONS DEBUG ===\n';
    debugInfo += `Container found: ${!!container}\n`;
    
    if (container) {
      const style = window.getComputedStyle(container);
      debugInfo += '\n=== CONTAINER STYLES ===\n';
      debugInfo += `display: ${style.display}\n`;
      debugInfo += `visibility: ${style.visibility}\n`;
      debugInfo += `opacity: ${style.opacity}\n`;
      debugInfo += `width: ${style.width}\n`;
      debugInfo += `height: ${style.height}\n`;
      debugInfo += `position: ${style.position}\n`;
      debugInfo += `z-index: ${style.zIndex}\n`;
      debugInfo += `overflow: ${style.overflow}\n`;
      debugInfo += `Dimensions: ${container.offsetWidth}x${container.offsetHeight} (offset)\n`;
      debugInfo += `Client Rect: ${container.getBoundingClientRect().width}x${container.getBoundingClientRect().height} (bounding)\n`;
      debugInfo += `Has content: ${container.children.length > 0 ? 'Yes' : 'No'}\n`;
    }
    
    debugInfo += '\n=== TAB STATUS ===\n';
    debugInfo += `Tab button exists: ${!!tabButton}\n`;
    debugInfo += `Tab content exists: ${!!tab}\n`;
    debugInfo += `Tab content active: ${tab?.classList.contains('active')}\n`;
    debugInfo += `Tab button active: ${tabButton?.classList.contains('active')}\n`;
    debugInfo += `Tab aria-selected: ${tabButton?.getAttribute('aria-selected')}\n`;
    debugInfo += `Tab visible: ${tab?.offsetParent !== null}\n`;
    debugInfo += `Tab content display: ${tab ? window.getComputedStyle(tab).display : 'N/A'}\n`;
    debugInfo += `Tab content visibility: ${tab ? window.getComputedStyle(tab).visibility : 'N/A'}\n`;
    
    if (tabContent) {
      debugInfo += '\n=== TAB CONTENT ===\n';
      debugInfo += `Tab content class: ${tabContent.className}\n`;
      debugInfo += `Active tab: ${tabContent.querySelector('.active')?.id || 'None'}\n`;
    }
    
    const overlay = document.getElementById('notifications-debug-overlay') || createDebugOverlay();
    overlay.textContent = debugInfo;
    
    return debugInfo;
  }

  // Function to ensure tab is properly activated
  function ensureTabActive() {
    // First, find the tab button and content
    const tabButton = document.querySelector('#tab-history-tab');
    const tabContent = document.querySelector('#tab-history');
    
    if (tabButton && tabContent) {
      console.log('[DEBUG] Found tab elements, ensuring active state');
      
      // Remove active class from all tabs and panes
      document.querySelectorAll('.nav-link').forEach(tab => tab.classList.remove('active', 'show'));
      document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('active', 'show'));
      
      // Add active class to our tab
      tabButton.classList.add('active');
      tabButton.setAttribute('aria-selected', 'true');
      
      // Show our tab content
      tabContent.classList.add('active', 'show');
      tabContent.style.display = 'block';
      
      // Force a reflow to ensure styles are applied
      void tabContent.offsetWidth;
      
      console.log('[DEBUG] Tab should now be active');
      return true;
    }
    return false;
  }

  // Now find the container
  const listContainer = document.querySelector('#notificationListContainer');
  console.log('[DEBUG] Container found:', !!listContainer);
  
  // Initial debug info
  updateDebugInfo();
  
  // Function to initialize the notification system
  function initNotificationSystem() {
    // Ensure tab is active first
    const tabActivated = ensureTabActive();
    
    // Find the container again after tab activation
    const container = document.querySelector('#notificationListContainer');
    
    if (container) {
      console.log('[DEBUG] Container found after tab activation');
      // Add a visible border for debugging
      container.style.border = '3px solid red';
      container.style.padding = '20px';
      container.style.minHeight = '300px';
      
      // Load notifications
      loadNotifications();
    } else {
      console.error('[DEBUG] Container not found even after tab activation');
      // Try one more time after a short delay
      setTimeout(() => {
        const retryContainer = document.querySelector('#notificationListContainer');
        if (retryContainer) {
          console.log('[DEBUG] Container found after delay');
          retryContainer.style.border = '3px solid blue';
          retryContainer.style.padding = '20px';
          retryContainer.style.minHeight = '300px';
          loadNotifications();
        } else {
          console.error('[DEBUG] Could not find notification container');
        }
      }, 300);
    }
    
    updateDebugInfo();
  }
  
  // Function to load and display notifications
  function loadNotifications() {
    console.log('[DEBUG] 1. Starting loadNotifications function');
    const container = document.querySelector('#notificationListContainer');
    
    if (!container) {
      console.error('[DEBUG] 1a. Notification container not found');
      console.log('[DEBUG] 1b. Document body:', document.body ? 'Body exists' : 'No body');
      console.log('[DEBUG] 1c. Container HTML:', document.body ? document.body.innerHTML : 'No body');
      return;
    }
    
    console.log('[DEBUG] 2. Container found, making API request to notifications?action=ajax');
    
    // Show loading state
    container.innerHTML = '<div class="text-center py-5"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div><p class="mt-2">Đang tải thông báo...</p></div>';
    
    // Fetch notifications from the server
    console.log('[DEBUG] 3. Making fetch request to notifications?action=ajax');
    fetch('notifications?action=ajax')
      .then(response => {
        console.log('[DEBUG] 4. Received response, status:', response.status);
        if (!response.ok) {
          console.error('[DEBUG] 4a. Response not OK, status:', response.status);
          throw new Error('Network response was not ok: ' + response.status);
        }
        return response.json();
      })
      .then(data => {
        console.log('[DEBUG] 5. Parsed JSON data:', data);
        if (!data) {
          console.error('[DEBUG] 5a. No data received');
          throw new Error('No data received from server');
        }
        
        console.log('[DEBUG] 6. Processing notifications data');
        renderNotificationList(data);
        
        // Initialize tooltips
        const tooltipTriggerList = [].slice.call(container.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
          return new bootstrap.Tooltip(tooltipTriggerEl);
        });
        
        // Attach event listeners
        attachNotificationActions();
      })
      .catch(error => {
        console.error('[DEBUG] Error loading notifications:', error);
        container.innerHTML = `
          <div class="alert alert-danger">
            <i class="fas fa-exclamation-triangle me-2"></i>
            Đã xảy ra lỗi khi tải thông báo. 
            <button class="btn btn-sm btn-outline-danger ms-2" onclick="loadNotifications()">
              <i class="fas fa-sync-alt me-1"></i> Thử lại
            </button>
          </div>
        `;
      });
  }
  
  // Helper function to get badge class based on notification type
  function getNotificationBadgeClass(type) {
    const types = {
      'system': 'primary',
      'security': 'danger',
      'maintenance': 'warning',
      'update': 'info'
    };
    return types[type] || 'secondary';
  }
  
  // Helper function to get notification type text
  function getNotificationTypeText(type) {
    const types = {
      'system': 'Hệ thống',
      'security': 'Bảo mật',
      'maintenance': 'Bảo trì',
      'update': 'Cập nhật'
    };
    return types[type] || 'Khác';
  }
  
  // Add event listeners for notification actions
  function addNotificationEventListeners() {
    // Pin/Unpin
    document.querySelectorAll('.btn-pin').forEach(btn => {
      btn.addEventListener('click', function(e) {
        e.preventDefault();
        const notificationId = this.getAttribute('data-id');
        const isPinned = this.classList.contains('btn-warning');
        
        fetch('notifications', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: `action=${isPinned ? 'unpin' : 'pin'}&id=${notificationId}`
        })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            loadNotifications(); // Reload notifications
          } else {
            alert('Có lỗi xảy ra: ' + (data.message || 'Không thể cập nhật trạng thái ghim'));
          }
        })
        .catch(error => {
          console.error('Error:', error);
          alert('Có lỗi xảy ra khi kết nối đến máy chủ');
        });
      });
    });
    
    // Delete
    document.querySelectorAll('.delete-notification').forEach(btn => {
      btn.addEventListener('click', function(e) {
        e.preventDefault();
        if (confirm('Bạn có chắc chắn muốn xóa thông báo này?')) {
          const notificationId = this.getAttribute('data-id');
          
          fetch('notifications', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `action=delete&id=${notificationId}`
          })
          .then(response => response.json())
          .then(data => {
            if (data.success) {
              loadNotifications(); // Reload notifications
            } else {
              alert('Có lỗi xảy ra: ' + (data.message || 'Không thể xóa thông báo'));
            }
          })
          .catch(error => {
            console.error('Error:', error);
            alert('Có lỗi xảy ra khi kết nối đến máy chủ');
          });
        }
      });
    });
  }

  // Start initialization
  initNotificationSystem();
  
  // If we have a container, load notifications
  if (listContainer) {
    console.log('[DEBUG] Loading notifications...');
    loadNotifications();
  } else {
    console.error('[DEBUG] Could not find notification container!');
    console.log('[DEBUG] Document body:', document.body ? 'Exists' : 'Missing');
    console.log('[DEBUG] #system-notifications:', document.querySelector('#system-notifications') ? 'Exists' : 'Missing');
    console.log('[DEBUG] #tab-history:', document.querySelector('#tab-history') ? 'Exists' : 'Missing');
    
    // Last resort: try again after a delay
    console.log('[DEBUG] Will retry in 500ms...');
    setTimeout(() => {
      console.log('[DEBUG] Retrying notification load...');
      listContainer = document.querySelector('#notificationListContainer');
      if (listContainer) {
        console.log('[DEBUG] Found container on retry, loading notifications');
        loadNotifications();
      } else {
        console.error('[DEBUG] Still could not find container on retry');
      }
    }, 500);
  }

  function loadNotifications() {
    console.log('[DEBUG] loadNotifications called');
    console.log('[DEBUG] Making request to: notifications?action=ajax');
    
    fetch('notifications?action=ajax')
      .then(response => {
        console.log('[DEBUG] Response status:', response.status);
        if (!response.ok) {
          throw new Error('Network response was not ok: ' + response.status);
        }
        return response.text().then(text => {
          console.log('[DEBUG] Raw response text:', text);
          try {
            return JSON.parse(text);
          } catch (e) {
            console.error('[DEBUG] Failed to parse JSON:', e);
            throw new Error('Invalid JSON response');
          }
        });
      })
      .then(data => {
        console.log('[DEBUG] Parsed data:', JSON.stringify(data, null, 2));
        if (!data) {
          throw new Error('No data received');
        }
        if (!Array.isArray(data.notifications)) {
          console.error('[DEBUG] notifications is not an array:', data.notifications);
          data.notifications = [];
        }
        if (!Array.isArray(data.pinnedNotifications)) {
          console.error('[DEBUG] pinnedNotifications is not an array:', data.pinnedNotifications);
          data.pinnedNotifications = [];
        }
        
        console.log('[DEBUG] Before render - pinned count:', data.pinnedNotifications.length, 'regular count:', data.notifications.length);
        
        // Check if container exists before rendering
        const container = document.querySelector('#notificationListContainer');
        console.log('[DEBUG] Container found before render:', !!container);
        if (container) {
          console.log('[DEBUG] Container parent:', container.parentElement);
          console.log('[DEBUG] Container visibility:', window.getComputedStyle(container).display);
        }
        
        // Pass the data as a single object to maintain consistency
        renderNotificationList({
          pinnedNotifications: data.pinnedNotifications || [],
          notifications: data.notifications || []
        });
      })
      .catch(error => {
        console.error('[DEBUG] Error loading notifications:', error);
        const listContainer = document.querySelector('#notificationListContainer');
        if (listContainer) {
          listContainer.innerHTML = `
            <div class="alert alert-danger">
              <h5>Lỗi khi tải thông báo</h5>
              <p>${error.message}</p>
              <button class="btn btn-sm btn-outline-secondary mt-2" onclick="loadNotifications()">
                Thử lại
              </button>
            </div>`;
        }
      });
  }

  function renderNotificationList(arg1, arg2) {
    console.log('[DEBUG] 7. renderNotificationList called with:', { arg1, arg2 });
    
    // Handle both parameter formats:
    // 1. renderNotificationList(pinnedNotifications, notifications)
    // 2. renderNotificationList({ pinnedNotifications: [...], notifications: [...] })
    let pinnedNotifications, notifications;
    
    if (Array.isArray(arg1) && (arg2 === undefined || Array.isArray(arg2))) {
      // Format 1: Two arrays
      pinnedNotifications = arg1 || [];
      notifications = arg2 || [];
    } else if (arg1 && typeof arg1 === 'object') {
      // Format 2: Single object with pinnedNotifications and notifications properties
      const data = arg1;
      pinnedNotifications = Array.isArray(data.pinnedNotifications) ? data.pinnedNotifications : [];
      notifications = Array.isArray(data.notifications) ? data.notifications : [];
    } else {
      // Fallback to empty arrays if format is unexpected
      console.warn('[DEBUG] Unexpected parameter format in renderNotificationList');
      pinnedNotifications = [];
      notifications = [];
    }
    
    // Debug: Check if we have any notifications at all
    console.log('[DEBUG] 7a. Total notifications to render:', {
      pinned: pinnedNotifications.length,
      regular: notifications.length
    });
    
    // Debug: Log the first notification if available
    if (pinnedNotifications.length > 0) {
      console.log('[DEBUG] 7b. First pinned notification:', JSON.stringify(pinnedNotifications[0]));
    } else if (notifications.length > 0) {
    } else {
      console.log('[DEBUG] 7b. No notifications to display');
    }
    
    // Get the container
    const container = document.querySelector('#notificationListContainer');
    if (!container) {
      console.error('[DEBUG] Notification container not found');
      return;
    }
    
    // Clear the container
    container.innerHTML = '';
    
    // Add debug info
    const debugInfo = document.createElement('div');
    debugInfo.style.border = '2px dashed #dc3545';
    debugInfo.style.padding = '10px';
    debugInfo.style.marginBottom = '15px';
    debugInfo.style.borderRadius = '5px';
    debugInfo.style.backgroundColor = '#fff8f8';
    debugInfo.innerHTML = `
      <div style="color:#dc3545; font-weight:bold; margin-bottom:5px;">DEBUG INFO</div>
      <div><strong>Container found:</strong> Yes</div>
      <div><strong>Pinned notifications:</strong> ${pinnedNotifications.length}</div>
      <div><strong>Regular notifications:</strong> ${notifications.length}</div>
    `;
    container.appendChild(debugInfo);
    
    // Add notifications to the container
    if (pinnedNotifications.length === 0 && notifications.length === 0) {
      const noNotifications = document.createElement('div');
      noNotifications.className = 'alert alert-info';
      noNotifications.textContent = 'Không có thông báo nào.';
      container.appendChild(noNotifications);
      return;
    }
    
    // Function to create a notification card
    function createNotificationCard(notification, isPinned) {
      const card = document.createElement('div');
      card.className = `card mb-3 ${isPinned ? 'border-warning' : ''}`;
      if (isPinned) {
        card.innerHTML = `
          <div class="card-header bg-warning bg-opacity-10 d-flex justify-content-between align-items-center">
            <span><i class="fas fa-thumbtack text-warning me-2"></i>Đã ghim</span>
          </div>
        `;
      }
      
      const cardBody = document.createElement('div');
      cardBody.className = 'card-body';
      
      // Format the date
      let formattedDate = 'Chưa có ngày';
      if (notification.createdAt) {
        try {
          const date = new Date(notification.createdAt);
          formattedDate = date.toLocaleString('vi-VN');
        } catch (e) {
          console.error('Error formatting date:', e);
        }
      }
      
      // Set up the notification type
      let typeBadge = '';
      switch(notification.type) {
        case 'system':
          typeBadge = '<span class="badge bg-primary">Hệ thống</span>';
          break;
        case 'maintenance':
          typeBadge = '<span class="badge bg-warning text-dark">Bảo trì</span>';
          break;
        case 'security':
          typeBadge = '<span class="badge bg-danger">Bảo mật</span>';
          break;
        case 'update':
          typeBadge = '<span class="badge bg-success">Cập nhật</span>';
          break;
        default:
          typeBadge = `<span class="badge bg-secondary">${notification.type || 'Khác'}</span>`;
      }
      
      cardBody.innerHTML += `
        <div class="d-flex justify-content-between align-items-start">
          <h5 class="card-title mb-1">${notification.title || 'Không có tiêu đề'}</h5>
          <div class="dropdown">
            <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="dropdown" aria-expanded="false">
              <i class="fas fa-ellipsis-v"></i>
            </button>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item notif-edit-btn" href="#" data-id="${notification.id}">
                <i class="fas fa-edit me-2"></i>Chỉnh sửa
              </a></li>
              <li><a class="dropdown-item notif-delete-btn" href="#" data-id="${notification.id}">
                <i class="fas fa-trash me-2"></i>Xóa
              </a></li>
            </ul>
          </div>
        </div>
        <p class="card-text text-muted small mb-2">${formattedDate}</p>
        <p class="card-text">${notification.message || 'Không có nội dung'}</p>
        <div class="d-flex justify-content-between align-items-center">
          ${typeBadge}
          <button class="btn btn-sm ${isPinned ? 'btn-warning' : 'btn-outline-secondary'} btn-pin" 
                  data-id="${notification.id}">
            <i class="fas fa-thumbtack"></i> ${isPinned ? 'Bỏ ghim' : 'Ghim'}
          </button>
        </div>
      `;
      
      card.appendChild(cardBody);
      return card;
    }
    
    // Add pinned notifications section if there are any
    if (pinnedNotifications.length > 0) {
      const pinnedHeader = document.createElement('h5');
      pinnedHeader.className = 'mt-4 mb-3 text-warning';
      pinnedHeader.innerHTML = '<i class="fas fa-thumbtack me-2"></i>Thông báo đã ghim';
      container.appendChild(pinnedHeader);
      
      pinnedNotifications.forEach(notification => {
        container.appendChild(createNotificationCard(notification, true));
      });
    }
    
    // Add regular notifications section if there are any
    if (notifications.length > 0) {
      const regularHeader = document.createElement('h5');
      regularHeader.className = `mt-4 mb-3 ${pinnedNotifications.length > 0 ? '' : 'd-none'}`;
      regularHeader.innerHTML = '<i class="fas fa-bell me-2"></i>Tất cả thông báo';
      container.appendChild(regularHeader);
      
      notifications.forEach(notification => {
        container.appendChild(createNotificationCard(notification, false));
      });
    }
    
    let listContainer = document.querySelector('#notificationListContainer');
    console.log('[DEBUG] Container element found:', !!listContainer);
    
    if (listContainer) {
      console.log('[DEBUG] Container visibility:', window.getComputedStyle(listContainer).display);
      if (listContainer.parentElement) {
        console.log('[DEBUG] Container parent visibility:', window.getComputedStyle(listContainer.parentElement).display);
      }
    }

    if (!listContainer) {
      console.error('[DEBUG] Notification list container not found');
      console.log('[DEBUG] Retrying to find container...');
      listContainer = document.querySelector('#notificationListContainer');
      if (listContainer) {
        console.log('[DEBUG] Found container on retry, rendering notifications...');
        renderNotificationList(pinnedNotifications, notifications);
      } else {
        console.error('[DEBUG] Container still not found after retry');
        console.log('[DEBUG] Document body HTML:', document.body ? document.body.innerHTML : 'No body');
      }
      return;
    }
    
    // Clear the container and add debug info
    listContainer.innerHTML = `
      <div style="border:2px dashed #dc3545; padding:10px; margin-bottom:15px; border-radius:5px; background-color:#fff8f8;">
        <div style="color:#dc3545; font-weight:bold; margin-bottom:5px;">DEBUG INFO</div>
        <div><strong>Container found:</strong> Yes</div>
        <div><strong>Pinned notifications:</strong> ${pinnedNotifications.length}</div>
        <div><strong>Regular notifications:</strong> ${notifications.length}</div>
      </div>
    `;
    
    // Add notifications to the container
    if (pinnedNotifications.length === 0 && notifications.length === 0) {
      listContainer.innerHTML += '<div class="alert alert-info">Không có thông báo nào.</div>';
      return;
    }
    
    let html = '';
    if (pinnedNotifications.length > 0) {
      html += '<div class="mb-2 fw-bold text-primary">Đã ghim</div>';
      html += pinnedNotifications.map(n => notificationCardHTML(n, true)).join('');
    }
    if (notifications.length > 0) {
      html += '<div class="mb-2 fw-bold text-primary">Tất cả thông báo</div>';
      html += notifications.map(n => notificationCardHTML(n, false)).join('');
    }
    
    listContainer.innerHTML += html;
    attachNotificationActions();
  }

  function notificationCardHTML(n, pinned) {
    console.log('[DEBUG] Generating card for notification:', n);
    const typeMap = {
      'system': {icon: 'fa-info-circle', color: 'primary', label: 'Info'},
      'maintenance': {icon: 'fa-tools', color: 'warning', label: 'Maintenance'},
      'security': {icon: 'fa-shield-alt', color: 'danger', label: 'Security'},
      'update': {icon: 'fa-sync', color: 'success', label: 'Update'}
    };
    const t = typeMap[n.type] || typeMap['system'];
    console.log('[DEBUG] Notification type:', n.type, 'Mapped to:', t);
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
// Export the initialization function to be called by section-loader.js
window.initSystemNotifications = initSystemNotifications;

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