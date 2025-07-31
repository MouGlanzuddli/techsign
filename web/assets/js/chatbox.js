// === WebSocket Chatbox Integration (with logging, clean) ===
let ws;
function connectWebSocket() {
  if (ws && ws.readyState === WebSocket.OPEN) {
    console.log('[Chatbox] WebSocket already connected');
    return;
  }
  
  console.log('[Chatbox] Connecting to WebSocket...');
  ws = new WebSocket("ws://localhost:8080/TechSign/chatbox");
  
  ws.onopen = function() {
    console.log('[Chatbox] WebSocket connected successfully');
  };
  
  ws.onmessage = function(event) {
    console.log('[Chatbox] Received WebSocket message:', event.data);
    
    // Xử lý tin nhắn WebSocket đơn giản
    try {
      const data = JSON.parse(event.data);
      console.log('[Chatbox] Parsed JSON:', data);
      
      // Nếu là tin nhắn mới từ SendMessageServlet
      if (data.success && data.content) {
        console.log('[Chatbox] Processing message from SendMessageServlet');
        // Hiển thị tin nhắn mới
        displayWebSocketMessage(data);
      }
    } catch (e) {
      console.log('[Chatbox] Plain text message:', event.data);
      // Xử lý tin nhắn text đơn giản
      displaySimpleTextMessage(event.data);
    }
  };
  
  ws.onclose = function() {
    console.log('[Chatbox] WebSocket disconnected, retrying...');
    setTimeout(connectWebSocket, 2000);
  };
  
  ws.onerror = function(e) {
    console.error('[Chatbox] WebSocket error', e);
  };
}

// Hiển thị tin nhắn từ WebSocket
function displayWebSocketMessage(data) {
  const msgBox = document.getElementById('chatbox-messages');
  if (!msgBox) {
    console.log('[Chatbox] No message box found');
    return;
  }
  
  console.log('[Chatbox] Checking message relevance:', {
    currentChatUserId: currentChatUserId,
    senderId: data.senderId,
    receiverId: data.receiverId,
    windowCurrentUserId: window.currentUserId
  });
  
  // Kiểm tra nếu tin nhắn này liên quan đến cuộc trò chuyện hiện tại
  if (currentChatUserId && 
      ((data.senderId == currentChatUserId && data.receiverId == window.currentUserId) ||
       (data.receiverId == currentChatUserId && data.senderId == window.currentUserId))) {
    
    // KHÔNG hiển thị tin nhắn từ chính mình (tránh echo)
    if (data.senderId == window.currentUserId) {
      console.log('[Chatbox] Message from self, skipping to prevent echo');
      return;
    }
    
    console.log('[Chatbox] Message is relevant, displaying...');
    
    const messageElement = document.createElement('div');
    const isSelf = data.senderId == window.currentUserId;
    messageElement.className = 'chatbox-msg-row' + (isSelf ? ' self' : '');
    
    let content = data.content || '';
    if (data.messageType === 'file' || content.match(/\.(jpg|jpeg|png|gif|bmp|webp|pdf|doc|docx|xls|xlsx|txt|zip|rar)$/i)) {
      const fileName = getDisplayFileName(content);
      if (content.match(/\.(jpg|jpeg|png|gif|bmp|webp)$/i)) {
        // Hiển thị ảnh preview với khả năng phóng to
        content = `
          <div class="chatbox-file-container">
            <div class="chatbox-file-info">
              <div class="chatbox-file-name">${fileName}</div>
            </div>
            <img src='${content}' class='chatbox-img-preview' onclick='showImageModal(\'${content}\')' />
            <div class="chatbox-file-info">
              <a href='${content}' download class='chatbox-file-download'>⬇ Tải ảnh</a>
            </div>
          </div>
        `;
      } else {
        // File khác với icon và style đẹp
        const fileIcon = getFileIcon(content);
        const fileType = getFileType(content);
        content = `
          <div class="chatbox-file-container">
            <div class="chatbox-file-icon">${fileIcon}</div>
            <div class="chatbox-file-info">
              <div class="chatbox-file-name">${fileName}</div>
              <div class="chatbox-file-type">${fileType}</div>
              <a href='${content}' class='chatbox-file-download' target='_blank' download>⬇ Tải xuống</a>
            </div>
          </div>
        `;
      }
    }
    
    const time = new Date(data.sentAt).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
    messageElement.innerHTML = `<div class="chatbox-msg-bubble"><div class="message-text">${content}</div><div class="chatbox-msg-time">${time}</div></div>`;
    
    msgBox.appendChild(messageElement);
    msgBox.scrollTop = msgBox.scrollHeight;
    console.log('[Chatbox] Message displayed successfully');
  } else {
    console.log('[Chatbox] Message not relevant to current chat');
  }
}

// Hiển thị tin nhắn text đơn giản
function displaySimpleTextMessage(messageText) {
  const msgBox = document.getElementById('chatbox-messages');
  if (!msgBox) return;
  
  const messageElement = document.createElement('div');
  messageElement.className = 'chatbox-msg-row';
  
  let content = '';
  if(messageText.match(/\.(jpg|jpeg|png|gif|bmp|webp)$/i)) {
    // Hiển thị ảnh preview
    const fileName = getDisplayFileName(messageText);
    content = `
      <div class="chatbox-file-container">
        <img src='${messageText}' class='chatbox-img-preview' onclick='showImageModal(\'${messageText}\')' />
        <div class="chatbox-file-info">
          <div class="chatbox-file-name">${fileName}</div>
          <a href='${messageText}' download class='chatbox-file-download'>⬇ Tải ảnh</a>
        </div>
      </div>
    `;
  } else if(messageText.match(/\.(pdf|doc|docx|xls|xlsx|txt|zip|rar)$/i)) {
    // File khác với icon và style đẹp
    const fileName = getDisplayFileName(messageText);
    const fileIcon = getFileIcon(messageText);
    const fileType = getFileType(messageText);
    content = `
      <div class="chatbox-file-container">
        <div class="chatbox-file-icon">${fileIcon}</div>
        <div class="chatbox-file-info">
          <div class="chatbox-file-name">${fileName}</div>
          <div class="chatbox-file-type">${fileType}</div>
          <a href='${messageText}' class='chatbox-file-download' target='_blank' download>⬇ Tải xuống</a>
        </div>
      </div>
    `;
  } else {
    content = messageText;
  }
  
  const time = new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
  messageElement.innerHTML = `<div class="chatbox-msg-bubble"><div class="message-text">${content}</div><div class="chatbox-msg-time">${time}</div></div>`;
  
  msgBox.appendChild(messageElement);
  msgBox.scrollTop = msgBox.scrollHeight;
}

// Hàm lấy icon cho từng loại file
function getFileIcon(filePath) {
  const extension = filePath.split('.').pop().toLowerCase();
  switch (extension) {
    case 'pdf':
      return '📄';
    case 'doc':
    case 'docx':
      return '📝';
    case 'xls':
    case 'xlsx':
      return '📊';
    case 'txt':
      return '📃';
    case 'zip':
    case 'rar':
      return '📦';
    case 'ppt':
    case 'pptx':
      return '📽️';
    case 'mp3':
    case 'wav':
      return '🎵';
    case 'mp4':
    case 'avi':
      return '🎬';
    default:
      return '📎';
  }
}

// Hàm lấy tên loại file
function getFileType(filePath) {
  const extension = filePath.split('.').pop().toLowerCase();
  switch (extension) {
    case 'pdf':
      return 'PDF Document';
    case 'doc':
      return 'Word Document';
    case 'docx':
      return 'Word Document';
    case 'xls':
      return 'Excel Spreadsheet';
    case 'xlsx':
      return 'Excel Spreadsheet';
    case 'txt':
      return 'Text File';
    case 'zip':
      return 'ZIP Archive';
    case 'rar':
      return 'RAR Archive';
    case 'ppt':
    case 'pptx':
      return 'PowerPoint Presentation';
    case 'mp3':
    case 'wav':
      return 'Audio File';
    case 'mp4':
    case 'avi':
      return 'Video File';
    default:
      return 'File';
  }
}

// Hàm hiển thị modal ảnh
function showImageModal(imageSrc) {
  const modal = document.getElementById('chatbox-img-modal');
  const modalImg = document.getElementById('chatbox-img-modal-img');
  if (modal && modalImg) {
    modalImg.src = imageSrc;
    modal.style.display = 'flex';
  }
}

// Đóng modal khi click nút X hoặc click bên ngoài
document.addEventListener('DOMContentLoaded', function() {
  const modal = document.getElementById('chatbox-img-modal');
  const modalClose = document.getElementById('chatbox-img-modal-close');
  
  if (modal && modalClose) {
    modalClose.onclick = function() {
      modal.style.display = 'none';
    };
    
    modal.onclick = function(e) {
      if (e.target === modal) {
        modal.style.display = 'none';
      }
    };
  }
});

// Kết nối WebSocket khi trang load
document.addEventListener('DOMContentLoaded', function() {
  console.log('[Chatbox] Page loaded, connecting WebSocket...');
  connectWebSocket();
});

// Kết nối khi mở chatbox
const chatIcon = document.querySelector('.fa-comment');
if(chatIcon) {
  chatIcon.addEventListener('click', function() {
    console.log('[Chatbox] Chat icon clicked, connecting WebSocket...');
    connectWebSocket();
  });
}

// Gửi tin nhắn qua WebSocket khi bấm gửi hoặc Enter
const chatboxInput = document.getElementById('chatbox-input');
const chatboxSend = document.getElementById('chatbox-send');
function getDisplayFileName(fileName) {
  // Nếu tên file có dạng 1752934119001_Black Modern Professional Resume.pdf thì chỉ lấy phần sau dấu _
  const idx = fileName.indexOf('_');
  if(idx > 0 && idx < fileName.length-1) return fileName.substring(idx+1);
  return fileName;
}

function renderSelfMessage(messageText) {
  const msgBox = document.getElementById('chatbox-messages');
  const messageElement = document.createElement('div');
  messageElement.className = 'chatbox-msg-row self';
  let content = '';
  if(messageText.match(/\.(jpg|jpeg|png|gif|bmp|webp)$/i)) {
    content = `<a href='${messageText}' target='_blank' download><img src='${messageText}' /></a>`;
  } else if(messageText.match(/\.pdf$/i)) {
    const fileName = getDisplayFileName(messageText.split('/').pop());
    content = `<a href='${messageText}' class='chatbox-file-link' target='_blank' download>📄 ${fileName} (Tải xuống)</a>`;
  } else if(messageText.startsWith(window.contextPath + '/uploads/')) {
    const fileName = getDisplayFileName(messageText.split('/').pop());
    content = `<a href='${messageText}' class='chatbox-file-link' target='_blank' download>📄 ${fileName} (Tải xuống)</a>`;
  } else {
    content = messageText;
  }
  const time = new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
  messageElement.innerHTML = `<div class=\"chatbox-msg-bubble\"><div class=\"message-text\">${content}</div><div class=\"chatbox-msg-time\">${time}</div></div>`;
  if(msgBox) {
    msgBox.appendChild(messageElement);
    msgBox.scrollTop = msgBox.scrollHeight;
  }
}

// Load lịch sử chat
function loadChatHistory(receiverId) {
  if (!receiverId) return;
  
  console.log('[Chatbox] Loading chat history for user:', receiverId);
  
  fetch(window.contextPath + '/ChatHistoryServlet?receiver_id=' + receiverId)
    .then(response => response.json())
    .then(messages => {
      console.log('[Chatbox] Loaded', messages.length, 'messages');
      renderChatHistory(messages);
    })
    .catch(e => {
      console.error('[Chatbox] Lỗi load chat history:', e);
    });
}

// Render lịch sử chat
function renderChatHistory(messages) {
  const msgBox = document.getElementById('chatbox-messages');
  if (!msgBox) return;
  
  msgBox.innerHTML = '';
  
  // Kiểm tra messages có hợp lệ không
  if (!messages || !Array.isArray(messages)) {
    return;
  }
  
  // Tìm id lớn nhất của message self có isRead=true
  let lastReadSelfMsgId = null;
  for (let i = 0; i < messages.length; i++) {
    if (messages[i].isSelf && messages[i].isRead) {
      lastReadSelfMsgId = messages[i].id;
    }
  }
  // Kiểm tra sau đó có message nào từ phía người nhận gửi lại không
  let hasReplyAfterRead = false;
  if (lastReadSelfMsgId !== null) {
    for (let i = 0; i < messages.length; i++) {
      if (!messages[i].isSelf && messages[i].id > lastReadSelfMsgId) {
        hasReplyAfterRead = true;
        break;
      }
    }
  }
  messages.forEach(message => {
    if (!message || typeof message !== 'object') {
      return;
    }
    const messageElement = document.createElement('div');
    messageElement.className = 'chatbox-msg-row' + (message.isSelf ? ' self' : '');
    let content = '';
    if (message.messageType === 'file' || (message.content && message.content.match(/\.(jpg|jpeg|png|gif|bmp|webp)$/i))) {
      const fileName = getDisplayFileName(message.content);
      if (message.content && message.content.match(/\.(jpg|jpeg|png|gif|bmp|webp)$/i)) {
        // Hiển thị ảnh preview với khả năng phóng to
        content = `
          <div class="chatbox-file-container">
            <div class="chatbox-file-info">
              <div class="chatbox-file-name">${fileName}</div>
            </div>
            <img src='${message.content}' class='chatbox-img-preview' onclick='showImageModal(\'${message.content}\')' />
            <div class="chatbox-file-info">
              <a href='${message.content}' download class='chatbox-file-download'>⬇ Tải ảnh</a>
            </div>
          </div>
        `;
      } else {
        // File khác với icon và style đẹp
        const fileIcon = getFileIcon(message.content);
        const fileType = getFileType(message.content);
        content = `
          <div class="chatbox-file-container">
            <div class="chatbox-file-icon">${fileIcon}</div>
            <div class="chatbox-file-info">
              <div class="chatbox-file-name">${fileName}</div>
              <div class="chatbox-file-type">${fileType}</div>
              <a href='${message.content}' class='chatbox-file-download' target='_blank' download>⬇ Tải xuống</a>
            </div>
          </div>
        `;
      }
    } else {
      content = message.content;
    }
    const time = new Date(message.sentAt).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
    let readHtml = '';
    if (message.isSelf && message.id === lastReadSelfMsgId && !hasReplyAfterRead) {
      readHtml = `<span class='chatbox-msg-read'>Đã xem</span>`;
    }
    messageElement.innerHTML = `<div class=\"chatbox-msg-bubble\"><div class=\"message-text\">${content}</div><div class=\"chatbox-msg-meta\">${readHtml}<span class=\"chatbox-msg-time\">${time}</span></div></div>`;
    msgBox.appendChild(messageElement);
  });
  msgBox.scrollTop = msgBox.scrollHeight;
}

// Gửi tin nhắn riêng
function sendPrivateMessage() {
  if (!currentChatUserId) {
    console.log('[Chatbox] No receiver selected');
    return;
  }
  if(chatboxInput.value.trim() === '') {
    return;
  }
  
  console.log('[Chatbox] Sending message to user:', currentChatUserId);
  
  const messageText = chatboxInput.value.trim();
  const messageData = {
    receiver_id: currentChatUserId,
    content: messageText,
    message_type: 'text'
  };
  
  // Hiển thị tin nhắn ngay lập tức cho người gửi
  const messageElement = document.createElement('div');
  messageElement.className = 'chatbox-msg-row self';
  const time = new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
  messageElement.innerHTML = `<div class="chatbox-msg-bubble"><div class="message-text">${messageText}</div><div class="chatbox-msg-time">${time}</div></div>`;
  
  const msgBox = document.getElementById('chatbox-messages');
  if(msgBox) {
    msgBox.appendChild(messageElement);
    msgBox.scrollTop = msgBox.scrollHeight;
  }
  
  // Clear input
  chatboxInput.value = '';
  
  // Gửi qua SendMessageServlet
  fetch(window.contextPath + '/SendMessageServlet', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: new URLSearchParams(messageData)
  })
  .then(response => {
    if (!response.ok) {
      throw new Error('HTTP ' + response.status);
    }
    return response.json();
  })
  .then(data => {
    console.log('[Chatbox] SendMessageServlet response:', data);
    if (data && data.success) {
      console.log('[Chatbox] Message sent successfully');
    } else {
      console.error('[Chatbox] Lỗi gửi tin nhắn:', data ? data.message : 'Response data is null');
    }
  })
  .catch(err => {
    console.error('[Chatbox] Lỗi gửi tin nhắn:', err);
  });
}
if(chatboxSend) chatboxSend.addEventListener('click', sendPrivateMessage);
if(chatboxInput) chatboxInput.addEventListener('keypress', function(e) {
  if(e.key === 'Enter') sendPrivateMessage();
});

// === File Upload ===
const chatboxUpload = document.getElementById('chatbox-upload');
const chatboxFile = document.getElementById('chatbox-file');

if(chatboxUpload && chatboxFile) {
  chatboxUpload.addEventListener('click', function() {
    console.log('[Chatbox] File upload button clicked');
    chatboxFile.click();
  });
  
  chatboxFile.addEventListener('change', function(e) {
    if(e.target.files && e.target.files[0]) {
      const file = e.target.files[0];
      console.log('[Chatbox] File selected:', file.name);
      
      // Upload file lên server
      const formData = new FormData();
      formData.append('file', file);
      
      fetch(window.contextPath + '/UploadFileServlet', {
        method: 'POST',
        body: formData
      })
      .then(res => res.json())
      .then(data => {
        if(data.url) {
          console.log('[Chatbox] File uploaded successfully:', data.url);
          
          // Gửi file qua SendMessageServlet
          const fileData = {
            receiver_id: currentChatUserId || 1, // Fallback nếu chưa chọn user
            content: data.url,
            message_type: 'file',
            file_url: data.url
          };
          
          fetch(window.contextPath + '/SendMessageServlet', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams(fileData)
          })
          .then(response => response.json())
          .then(result => {
            if (result.success) {
              console.log('[Chatbox] File message sent successfully');
              
              // Hiển thị file message ngay lập tức cho người gửi
              const messageElement = document.createElement('div');
              messageElement.className = 'chatbox-msg-row self';
              const fileName = getDisplayFileName(data.url);
              const time = new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
              
              // Kiểm tra nếu là ảnh thì hiển thị preview
              let fileContent = '';
              if (data.url.match(/\.(jpg|jpeg|png|gif|bmp|webp)$/i)) {
                fileContent = `
                  <div class="chatbox-file-container">
                    <div class="chatbox-file-info">
                      <div class="chatbox-file-name">${fileName}</div>
                    </div>
                    <img src='${data.url}' class='chatbox-img-preview' onclick='showImageModal(\'${data.url}\')' />
                    <div class="chatbox-file-info">
                      <a href='${data.url}' download class='chatbox-file-download'>⬇ Tải ảnh</a>
                    </div>
                  </div>
                `;
              } else {
                // File khác với icon và style đẹp
                const fileIcon = getFileIcon(data.url);
                const fileType = getFileType(data.url);
                fileContent = `
                  <div class="chatbox-file-container">
                    <div class="chatbox-file-icon">${fileIcon}</div>
                    <div class="chatbox-file-info">
                      <div class="chatbox-file-name">${fileName}</div>
                      <div class="chatbox-file-type">${fileType}</div>
                      <a href='${data.url}' class='chatbox-file-download' target='_blank' download>⬇ Tải xuống</a>
                    </div>
                  </div>
                `;
              }
              
              messageElement.innerHTML = `<div class="chatbox-msg-bubble"><div class="message-text">${fileContent}</div><div class="chatbox-msg-time">${time}</div></div>`;
              
              const msgBox = document.getElementById('chatbox-messages');
              if(msgBox) {
                msgBox.appendChild(messageElement);
                msgBox.scrollTop = msgBox.scrollHeight;
              }
            } else {
              console.error('[Chatbox] Lỗi gửi file:', result ? result.message : 'Response data is null');
            }
          })
          .catch(err => {
            console.error('[Chatbox] Lỗi gửi file:', err);
          });
        } else {
          alert('Lỗi upload file!');
        }
      })
      .catch(err => {
        alert('Lỗi upload file!');
        console.error(err);
      });
    }
  });
}

// === User Search & Sidebar ===
const chatboxUserList = document.getElementById('chatbox-user-list');
const chatboxSearchInput = document.querySelector('#chatbox-search input');
let allUsers = [];
let currentChatUserId = null;
let currentChatUser = null; // Thêm biến lưu thông tin user hiện tại

// Gán currentUserId từ backend nếu chưa có hoặc là NaN
if (typeof window.currentUserId === 'undefined' || window.currentUserId == null || isNaN(window.currentUserId)) {
  try {
    window.currentUserId = parseInt(document.documentElement.getAttribute('data-current-user-id'));
    console.log('[Chatbox] Set currentUserId from DOM:', window.currentUserId);
  } catch (e) {
    console.log('[Chatbox] Could not get currentUserId from DOM');
  }
}

// Hàm cập nhật header chat với thông tin user
function updateChatHeader(user) {
  const headerAvatar = document.getElementById('chatbox-header-avatar');
  const headerName = document.getElementById('chatbox-header-name');
  const headerStatus = document.getElementById('chatbox-header-status');
  
  if (!headerAvatar || !headerName || !headerStatus) return;
  
  if (user) {
    // Cập nhật avatar
    if (user.avatarUrl && user.avatarUrl !== 'a') {
      headerAvatar.innerHTML = `<img src='${user.avatarUrl}' style='width:38px;height:38px;border-radius:50%;object-fit:cover;'/>`;
    } else {
      headerAvatar.innerHTML = '<i class="fas fa-user"></i>';
    }
    
    // Cập nhật tên
    headerName.textContent = user.fullName || user.email || 'Unknown User';
    
    // Cập nhật status (có thể thêm logic online/offline sau)
    headerStatus.textContent = 'Online';
  } else {
    // Reset về mặc định
    headerAvatar.innerHTML = '<i class="fas fa-user"></i>';
    headerName.textContent = 'Select a user to chat';
    headerStatus.textContent = '';
  }
}

function renderUserList(users) {
  if (!chatboxUserList) return;
  if (window.currentUserId) {
    users = users.filter(u => u && u.id !== window.currentUserId);
  }
  chatboxUserList.innerHTML = '';
  if (users.length === 0) {
    chatboxUserList.innerHTML = '<div style="padding:12px;color:#888;">Không tìm thấy user nào</div>';
    return;
  }
  users.forEach(user => {
    if (!user || typeof user.id === 'undefined' || user.id === null) return;
    const div = document.createElement('div');
    div.className = 'chatbox-user' + (user.id === currentChatUserId ? ' active' : '');
    div.innerHTML = `
      <div class="chatbox-user-avatar">${user.avatarUrl && user.avatarUrl !== 'a' ? `<img src='${user.avatarUrl}' style='width:38px;height:38px;border-radius:50%;object-fit:cover;'/>` : '<i class=\"fas fa-user\"></i>'}</div>
      <div class="chatbox-user-info">
        <div class="chatbox-user-name">${user.fullName || user.email}</div>
        <div class="chatbox-user-status">${user.email}</div>
      </div>
    `;
    div.addEventListener('click', function() {
      if (user.id === window.currentUserId) return;
      
      // Luôn luôn cập nhật user hiện tại khi click
      currentChatUserId = user.id;
      currentChatUser = user;
      console.log('[Chatbox] Selected user:', currentChatUserId, currentChatUser);
      
      // Cập nhật header với thông tin user
      updateChatHeader(currentChatUser);
      
      // Load chat history cho user này
      loadChatHistory(user.id);
      
      // Re-render user list để highlight user được chọn
      renderUserList(allUsers);
    });
    chatboxUserList.appendChild(div);
  });
}

function fetchUserList() {
  return fetch(window.contextPath + '/UserListServlet')
    .then(response => response.json())
    .then(data => {
      allUsers = data;
      console.log('[Chatbox] Fetched', data.length, 'users');
      renderUserList(data);
    })
    .catch(e => {
      console.error('[Chatbox] Lỗi fetch user list:', e);
    });
}

if(chatboxSearchInput) {
  chatboxSearchInput.addEventListener('input', function() {
    const q = chatboxSearchInput.value.trim().toLowerCase();
    if (!q) {
      renderUserList(allUsers);
      return;
    }
    const filtered = allUsers.filter(u =>
      u && ((u.fullName && u.fullName.toLowerCase().includes(q)) ||
      (u.email && u.email.toLowerCase().includes(q)))
    );
    renderUserList(filtered);
  });
}

// Luôn fetch lại user list mỗi lần mở chatbox
function showChatboxAndFetchUsers() {
  var chatbox = document.getElementById('chatbox-container');
  if(chatbox) {
    chatbox.style.display = 'flex';
  }
  console.log('[Chatbox] Opening chatbox and fetching users...');
  
  // Cập nhật header dựa trên trạng thái hiện tại
  if (!currentChatUser) {
    updateChatHeader(null);
  } else {
    updateChatHeader(currentChatUser);
  }
  
  // Fetch user list và render
  fetchUserList().then(() => {
    // Sau khi fetch xong, re-render để đảm bảo active state đúng
    if (currentChatUser) {
      renderUserList(allUsers);
    }
  });
}
// Gắn lại sự kiện cho tất cả <a> chứa icon chat
const chatLinks = Array.from(document.querySelectorAll('a')).filter(a => a.querySelector('.fa-comment'));
chatLinks.forEach(function(link) {
  link.addEventListener('click', function(e) {
    e.preventDefault();
    showChatboxAndFetchUsers();
  });
});

// Đóng chatbox khi bấm dấu X
const chatboxClose = document.getElementById('chatbox-close');
if(chatboxClose) {
  chatboxClose.addEventListener('click', function() {
    var chatbox = document.getElementById('chatbox-container');
    if(chatbox) {
      chatbox.style.display = 'none';
      // KHÔNG reset currentChatUser khi đóng chatbox
      // Giữ nguyên để khi mở lại vẫn còn thông tin user
    }
  });
}

// Preview ảnh lớn khi click vào ảnh trong bubble
if (typeof window.__chatbox_img_modal_init === 'undefined') {
  window.__chatbox_img_modal_init = true;
  document.addEventListener('click', function(e) {
    if (e.target.tagName === 'IMG' && e.target.closest('.chatbox-msg-bubble')) {
      const src = e.target.getAttribute('src');
      const modal = document.getElementById('chatbox-img-modal');
      const modalImg = document.getElementById('chatbox-img-modal-img');
      if (modal && modalImg && src) {
        modalImg.src = src;
        modal.style.display = 'flex';
      }
    }
  });
  const modal = document.getElementById('chatbox-img-modal');
  const modalClose = document.getElementById('chatbox-img-modal-close');
  if (modal && modalClose) {
    modalClose.onclick = function() { modal.style.display = 'none'; }
    modal.onclick = function(e) { if (e.target === modal) modal.style.display = 'none'; }
  }
}

// Hàm hỗ trợ phóng to ảnh
window.__showChatboxImgModal = function(src) {
  const modal = document.getElementById('chatbox-img-modal');
  const modalImg = document.getElementById('chatbox-img-modal-img');
  if (modal && modalImg && src) {
    modalImg.src = src;
    modal.style.display = 'flex';
  }
}