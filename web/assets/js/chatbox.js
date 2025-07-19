// === WebSocket Chatbox Integration (with logging, clean) ===
let ws;
function connectWebSocket() {
  if (ws && ws.readyState === WebSocket.OPEN) {
    console.log('[Chatbox] WebSocket đã kết nối');
    return;
  }
  ws = new WebSocket("ws://localhost:8080/TechSign/chatbox");
  ws.onopen = function() {
    console.log('[Chatbox] WebSocket connected');
  };
  ws.onmessage = function(event) {
    console.log('[Chatbox] Nhận tin nhắn:', event.data);
    const messageText = event.data;
    const messageElement = document.createElement('div');
    messageElement.className = 'chatbox-msg-row';
    messageElement.innerHTML = `<div class="chatbox-msg-bubble">${messageText}</div><div class="chatbox-msg-time">${new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}</div>`;
    const msgBox = document.getElementById('chatbox-messages');
    if(msgBox) {
      msgBox.appendChild(messageElement);
      msgBox.scrollTop = msgBox.scrollHeight;
    }
  };
  ws.onclose = function() {
    console.log('[Chatbox] WebSocket closed, reconnecting in 2s...');
    setTimeout(connectWebSocket, 2000);
  };
  ws.onerror = function(e) {
    console.error('[Chatbox] WebSocket error', e);
  };
}

// Kết nối khi mở chatbox
const chatIcon = document.querySelector('.fa-comment');
if(chatIcon) {
  chatIcon.addEventListener('click', function() {
    console.log('[Chatbox] Bấm icon chat, mở chatbox và kết nối WebSocket');
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
    content = `<div class=\"chatbox-msg-bubble\"><a href='${messageText}' target='_blank' download><img src='${messageText}' /></a></div>`;
  } else if(messageText.match(/\.pdf$/i)) {
    const fileName = getDisplayFileName(messageText.split('/').pop());
    content = `<div class=\"chatbox-msg-bubble\"><a href='${messageText}' class='chatbox-file-link' target='_blank' download>${fileName}</a></div>`;
  } else if(messageText.startsWith(window.contextPath + '/uploads/')) {
    const fileName = getDisplayFileName(messageText.split('/').pop());
    content = `<div class=\"chatbox-msg-bubble\"><a href='${messageText}' class='chatbox-file-link' target='_blank' download>${fileName}</a></div>`;
  } else {
    content = `<div class=\"chatbox-msg-bubble\">${messageText}</div>`;
  }
  messageElement.innerHTML = `<div class=\"chatbox-msg-time self\">${new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}</div>${content}`;
  if(msgBox) {
    msgBox.appendChild(messageElement);
    msgBox.scrollTop = msgBox.scrollHeight;
  }
}

// Sửa gửi tin nhắn text
function sendWsMessage() {
  if(!ws) {
    console.warn('[Chatbox] WebSocket chưa khởi tạo!');
    return;
  }
  if(ws.readyState !== WebSocket.OPEN) {
    console.warn('[Chatbox] WebSocket chưa kết nối!');
    return;
  }
  if(chatboxInput.value.trim() === '') {
    console.warn('[Chatbox] Không có nội dung để gửi!');
    return;
  }
  console.log('[Chatbox] Gửi tin nhắn:', chatboxInput.value.trim());
  ws.send(chatboxInput.value.trim());
  renderSelfMessage(chatboxInput.value.trim());
  chatboxInput.value = '';
}
if(chatboxSend) chatboxSend.addEventListener('click', sendWsMessage);
if(chatboxInput) chatboxInput.addEventListener('keypress', function(e) {
  if(e.key === 'Enter') sendWsMessage();
});

// === User Search & Sidebar ===
const chatboxUserList = document.getElementById('chatbox-user-list');
const chatboxSearchInput = document.querySelector('#chatbox-search input');
let allUsers = [];
let currentChatUserId = null;

function renderUserList(users) {
  if (!chatboxUserList) return;
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
      <div class="chatbox-user-avatar">${user.avatarUrl ? `<img src='${user.avatarUrl}' style='width:32px;height:32px;border-radius:50%;'/>` : '<i class=\"fas fa-user\"></i>'}</div>
      <div class="chatbox-user-info">
        <div class="chatbox-user-name">${user.fullName || user.email}</div>
        <div class="chatbox-user-status">${user.email}</div>
      </div>
    `;
    div.addEventListener('click', function() {
      currentChatUserId = user.id;
      renderUserList(allUsers);
      // TODO: load lịch sử chat với user này, gửi tin nhắn riêng
      console.log('[Chatbox] Chọn user để chat:', user.fullName || user.email, user.id);
    });
    chatboxUserList.appendChild(div);
  });
}

function fetchUserList() {
  return fetch(window.contextPath + '/UserListServlet')
    .then(response => response.json())
    .then(data => {
      allUsers = data;
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
      (u.fullName && u.fullName.toLowerCase().includes(q)) ||
      (u.email && u.email.toLowerCase().includes(q))
    );
    renderUserList(filtered);
  });
}

// Gọi fetchUserList khi mở chatbox
const origShowChatbox = function() {
  var chatbox = document.getElementById('chatbox-container');
  if(chatbox) chatbox.style.display = (chatbox.style.display === 'none' ? 'flex' : 'none');
};
function showChatboxAndFetchUsers() {
  var chatbox = document.getElementById('chatbox-container');
  if(chatbox) {
    chatbox.style.display = 'flex';
  }
  fetchUserList().catch(e => {
    var chatbox = document.getElementById('chatbox-container');
    if(chatbox) chatbox.style.display = 'flex';
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

// Hiển thị file nhận được qua WebSocket
ws_onmessage_old = ws && ws.onmessage;
function handleWsMessage(event) {
  const messageText = event.data;
  const msgBox = document.getElementById('chatbox-messages');
  const messageElement = document.createElement('div');
  messageElement.className = 'chatbox-msg-row';
  let content = '';
  if(messageText.match(/\.(jpg|jpeg|png|gif|bmp|webp)$/i)) {
    content = `<div class=\"chatbox-msg-bubble\"><a href='${messageText}' target='_blank' download><img src='${messageText}' /></a></div>`;
  } else if(messageText.match(/\.pdf$/i)) {
    const fileName = getDisplayFileName(messageText.split('/').pop());
    content = `<div class=\"chatbox-msg-bubble\"><a href='${messageText}' class='chatbox-file-link' target='_blank' download>${fileName}</a></div>`;
  } else if(messageText.startsWith(window.contextPath + '/uploads/')) {
    const fileName = getDisplayFileName(messageText.split('/').pop());
    content = `<div class=\"chatbox-msg-bubble\"><a href='${messageText}' class='chatbox-file-link' target='_blank' download>${fileName}</a></div>`;
  } else {
    content = `<div class=\"chatbox-msg-bubble\">${messageText}</div>`;
  }
  messageElement.innerHTML = `${content}<div class=\"chatbox-msg-time\">${new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}</div>`;
  if(msgBox) {
    msgBox.appendChild(messageElement);
    msgBox.scrollTop = msgBox.scrollHeight;
  }
}

// Gắn lại ws.onmessage để xử lý file
function patchWsOnMessage() {
  if(ws) ws.onmessage = handleWsMessage;
}
patchWsOnMessage();
// Nếu ws reconnect thì gắn lại handler
const oldConnectWebSocket = connectWebSocket;
connectWebSocket = function() {
  oldConnectWebSocket.apply(this, arguments);
  setTimeout(patchWsOnMessage, 200);
};

const chatboxUpload = document.getElementById('chatbox-upload');
const chatboxFile = document.getElementById('chatbox-file');
if(chatboxUpload && chatboxFile) {
  chatboxUpload.addEventListener('click', function() {
    chatboxFile.click();
  });
  chatboxFile.addEventListener('change', function(e) {
    if(e.target.files && e.target.files[0]) {
      const file = e.target.files[0];
      console.log('[Chatbox] Chọn file:', file.name, file.type, file.size + ' bytes');
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
          // Gửi URL file qua WebSocket
          if(ws && ws.readyState === WebSocket.OPEN) {
            ws.send(data.url);
          }
          // Tự render message file vừa gửi (bên phải)
          renderSelfMessage(data.url);
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

// Đóng chatbox khi bấm dấu X
const chatboxClose = document.getElementById('chatbox-close');
if(chatboxClose) {
  chatboxClose.addEventListener('click', function() {
    var chatbox = document.getElementById('chatbox-container');
    if(chatbox) chatbox.style.display = 'none';
  });
}