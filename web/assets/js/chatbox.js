// === WebSocket Chatbox Integration (with logging, clean) ===
let ws;
function connectWebSocket() {
  if (ws && ws.readyState === WebSocket.OPEN) {
    return;
  }
  ws = new WebSocket("ws://localhost:8080/TechSign/chatbox");
  ws.onopen = function() {
  };
  ws.onmessage = function(event) {
    const messageText = event.data;
    const messageElement = document.createElement('div');
    messageElement.className = 'chatbox-msg-row';
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
    const msgBox = document.getElementById('chatbox-messages');
    if(msgBox) {
      msgBox.appendChild(messageElement);
      msgBox.scrollTop = msgBox.scrollHeight;
    }
  };
  ws.onclose = function() {
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
  
  fetch(window.contextPath + '/ChatHistoryServlet?receiver_id=' + receiverId)
    .then(response => response.json())
    .then(messages => {
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
        // Nếu là ảnh, hiển thị ảnh preview, click phóng to, có nút tải về bên dưới
        content = `
          <div style='display:flex;flex-direction:column;align-items:flex-start;'>
            <img src='${message.content}' class='chatbox-img-preview' style='max-width:160px;max-height:160px;border-radius:10px;box-shadow:0 2px 8px #0001;cursor:pointer;margin-bottom:4px;' onclick='window.__showChatboxImgModal && window.__showChatboxImgModal(\'${message.content}\')' />
            <a href='${message.content}' download style='font-size:13px;color:#2196f3;text-decoration:none;display:inline-block;margin-top:2px;'>⬇ Tải ảnh</a>
          </div>
        `;
      } else {
        // Nếu là file khác, hiển thị icon file và tên file
        content = `<span style='font-size:18px;margin-right:6px;'>📄</span> <a href='${message.content}' class='chatbox-file-link' target='_blank' download>${fileName} (Tải xuống)</a>`;
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
    return;
  }
  if(chatboxInput.value.trim() === '') {
    return;
  }
  
  const messageData = {
    receiver_id: currentChatUserId,
    content: chatboxInput.value.trim(),
    message_type: 'text'
  };
  
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
    if (data && data.success) {
      // Render tin nhắn mới
      const messageElement = document.createElement('div');
      messageElement.className = 'chatbox-msg-row self';
      const time = new Date(data.sentAt).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
      messageElement.innerHTML = `<div class=\"chatbox-msg-bubble\"><div class=\"message-text\">${data.content}</div><div class=\"chatbox-msg-time\">${time}</div></div>`;
      
      const msgBox = document.getElementById('chatbox-messages');
      if(msgBox) {
        msgBox.appendChild(messageElement);
        msgBox.scrollTop = msgBox.scrollHeight;
      }
      
      chatboxInput.value = '';
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

// === User Search & Sidebar ===
const chatboxUserList = document.getElementById('chatbox-user-list');
const chatboxSearchInput = document.querySelector('#chatbox-search input');
let allUsers = [];
let currentChatUserId = null;

// Gán currentUserId từ backend nếu chưa có hoặc là NaN
if (typeof window.currentUserId === 'undefined' || window.currentUserId == null || isNaN(window.currentUserId)) {
  try {
    window.currentUserId = parseInt(document.documentElement.getAttribute('data-current-user-id'));
  } catch (e) {}
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
      currentChatUserId = user.id;
      renderUserList(allUsers);
      loadChatHistory(user.id);
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
  fetchUserList();
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
  let data;
  try {
    data = JSON.parse(event.data);
  } catch (e) {
    // fallback: nếu không phải JSON thì giữ nguyên cũ
    data = { content: event.data };
  }
  console.log('[WS] Received:', data, 'currentUserId:', window.currentUserId, 'currentChatUserId:', currentChatUserId);
  // Nếu có senderId/receiverId thì xử lý realtime
  if (data.senderId && data.receiverId) {
    // Nếu đang chat với đúng user (bạn là sender hoặc receiver)
    if (
      (currentChatUserId && data.senderId == currentChatUserId && data.receiverId == window.currentUserId) ||
      (currentChatUserId && data.receiverId == currentChatUserId && data.senderId == window.currentUserId)
    ) {
      console.log('[WS] Realtime: loadChatHistory', currentChatUserId);
      loadChatHistory(currentChatUserId);
    } else {
      console.log('[WS] Not current chat, fetchUserList');
      fetchUserList();
    }
    return;
  }
  // fallback: nếu chỉ có content (tin nhắn cũ)
  const msgBox = document.getElementById('chatbox-messages');
  const messageElement = document.createElement('div');
  messageElement.className = 'chatbox-msg-row';
  let content = '';
  if(data.content && data.content.match && data.content.match(/\.(jpg|jpeg|png|gif|bmp|webp)$/i)) {
    content = `<a href='${data.content}' target='_blank' download><img src='${data.content}' /></a>`;
  } else if(data.content && data.content.match && data.content.match(/\.pdf$/i)) {
    const fileName = getDisplayFileName(data.content.split('/').pop());
    content = `<a href='${data.content}' class='chatbox-file-link' target='_blank' download>📄 ${fileName} (Tải xuống)</a>`;
  } else if(data.content && data.content.startsWith && data.content.startsWith(window.contextPath + '/uploads/')) {
    const fileName = getDisplayFileName(data.content.split('/').pop());
    content = `<a href='${data.content}' class='chatbox-file-link' target='_blank' download>📄 ${fileName} (Tải xuống)</a>`;
  } else {
    content = data.content || '';
  }
  const time = new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
  messageElement.innerHTML = `<div class=\"chatbox-msg-bubble\"><div class=\"message-text\">${content}</div><div class=\"chatbox-msg-time\">${time}</div></div>`;
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
              // Render file message
              const messageElement = document.createElement('div');
              messageElement.className = 'chatbox-msg-row self';
              const fileName = getDisplayFileName(data.url);
              const time = new Date(result.sentAt).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
              messageElement.innerHTML = `<div class=\"chatbox-msg-bubble\"><div class=\"message-text\"><a href='${data.url}' class='chatbox-file-link' target='_blank' download>📄 ${fileName} (Tải xuống)</a></div><div class=\"chatbox-msg-time\">${time}</div></div>`;
              
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

// Đóng chatbox khi bấm dấu X
const chatboxClose = document.getElementById('chatbox-close');
if(chatboxClose) {
  chatboxClose.addEventListener('click', function() {
    var chatbox = document.getElementById('chatbox-container');
    if(chatbox) chatbox.style.display = 'none';
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