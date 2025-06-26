const chatLauncher = document.getElementById('chatLauncher');
const chatboxContainer = document.getElementById('chatboxContainer');
const chatCloseBtn = document.getElementById('chatCloseBtn');

const chatTabs = document.querySelectorAll('.chatbox-tab');
const tabContents = document.querySelectorAll('.tab-content');

const newChatMessages = document.getElementById('newChatMessages'); // For the "New Chat" tab
const newChatInput = document.getElementById('newChatInput');
const newChatSendBtn = document.getElementById('newChatSendBtn');

const chatHistoryList = document.getElementById('chatHistoryList'); // For the "History" tab

// --- Chatbox Open/Close Logic ---
if (chatLauncher && chatboxContainer) {
    chatLauncher.addEventListener('click', () => {
        chatboxContainer.classList.toggle('open');
        // Ensure "New Chat" tab is active by default when opening
        activateTab('newChatTab');
    });
}

if (chatCloseBtn && chatboxContainer) {
    chatCloseBtn.addEventListener('click', () => {
        chatboxContainer.classList.remove('open');
    });
}

// --- Tab Switching Logic ---
chatTabs.forEach(tab => {
    tab.addEventListener('click', () => {
        activateTab(tab.id);
    });
});

function activateTab(tabId) {
    chatTabs.forEach(tab => tab.classList.remove('active'));
    tabContents.forEach(content => content.classList.remove('active'));

    document.getElementById(tabId).classList.add('active');
    document.getElementById(tabId.replace('Tab', 'Content')).classList.add('active');

    // Scroll chat messages to bottom when switching to a chat view
    if (tabId === 'newChatTab') {
        newChatMessages.scrollTop = newChatMessages.scrollHeight;
    }
    // For specific history chat, you'd load messages and scroll
}

// --- New Chat Message Sending (Demo) ---
if (newChatSendBtn && newChatInput && newChatMessages) {
    newChatSendBtn.addEventListener('click', () => {
        sendNewChatMessage();
    });

    newChatInput.addEventListener('keypress', (event) => {
        if (event.key === 'Enter') {
            sendNewChatMessage();
        }
    });
}

function sendNewChatMessage() {
    const messageText = newChatInput.value.trim();
    if (messageText !== '') {
        const messageElement = document.createElement('p');
        messageElement.classList.add('message-user');
        messageElement.textContent = messageText;
        newChatMessages.appendChild(messageElement);
        newChatInput.value = '';

        newChatMessages.scrollTop = newChatMessages.scrollHeight;

        // Simulate agent response after a short delay
        setTimeout(() => {
            const agentResponse = document.createElement('p');
            agentResponse.classList.add('message-agent');
            agentResponse.textContent = "Cảm ơn bạn đã gửi yêu cầu. Chúng tôi đã tạo một ticket cho bạn (#TKT-001). Vui lòng đợi phản hồi từ chuyên viên hỗ trợ.";
            newChatMessages.appendChild(agentResponse);
            newChatMessages.scrollTop = newChatMessages.scrollHeight;
            // In a real app, this is where you'd update the history list
            addHistoryItem({
                id: 'TKT-001',
                subject: messageText.substring(0, 30) + (messageText.length > 30 ? '...' : ''),
                lastUpdate: new Date().toLocaleDateString('vi-VN'),
                status: 'OPEN'
            });
        }, 1000);
    }
}

// --- Chat History Demo Data ---
const dummyHistoryTickets = [
    { id: 'TKT-003', subject: 'Lỗi đăng nhập tài khoản Admin', lastUpdate: '10/06/2025', status: 'CLOSED' },
    { id: 'TKT-002', subject: 'Không tải được hồ sơ ứng viên', lastUpdate: '08/06/2025', status: 'IN_PROGRESS' },
    { id: 'TKT-001', subject: 'Hướng dẫn sử dụng tính năng X', lastUpdate: '05/06/2025', status: 'PENDING_USER' }
];

function renderHistoryTickets() {
    chatHistoryList.innerHTML = ''; // Clear previous items
    dummyHistoryTickets.forEach(ticket => {
        addHistoryItem(ticket);
    });
}

function addHistoryItem(ticket) {
    const item = document.createElement('div');
    item.classList.add('history-item');
    item.innerHTML = `
        <h5>Ticket #${ticket.id} - ${ticket.subject}</h5>
        <p>Cập nhật cuối: ${ticket.lastUpdate}</p>
        <span class="status-badge status-${ticket.status.toLowerCase().replace(' ', '-')}">${ticket.status.replace(/_/g, ' ')}</span>
    `;
    // Attach click listener to load chat history for this ticket (for real app)
    item.addEventListener('click', () => {
        alert('Trong hệ thống thực tế, bạn sẽ tải lịch sử trò chuyện của Ticket ' + ticket.id + ' vào đây.');
        // Here you would typically switch to a specific chat view for this ticket ID
        // and fetch its messages from the backend.
    });
    chatHistoryList.prepend(item); // Add to the top
}

// Initial render of history tickets when JS loads
renderHistoryTickets();