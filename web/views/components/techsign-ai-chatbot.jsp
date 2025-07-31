<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<style>
    .techsign-ai-chatbot {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 1000;
    }

    .chatbot-toggle {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background: linear-gradient(135deg, #1b5e20 0%, #43ea7c 100%);
        border: none;
        color: white;
        font-size: 24px;
        cursor: pointer;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        z-index: 1000;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .chatbot-toggle:hover {
        transform: scale(1.1);
        box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
        background: linear-gradient(135deg, #0d4a14 0%, #2dd65f 100%);
    }

    .chatbot-container {
        position: fixed;
        bottom: 100px;
        right: 20px;
        width: 380px;
        height: 500px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.2);
        display: none;
        flex-direction: column;
        overflow: hidden;
        z-index: 1000;
    }

    .chatbot-header {
        background: linear-gradient(135deg, #1b5e20, #43ea7c);
        color: white;
        padding: 15px 20px;
        text-align: center;
        font-weight: bold;
        font-size: 16px;
        position: relative;
    }

    .chatbot-header::before {
        content: "🤖";
        margin-right: 8px;
    }

    .close-btn {
        position: absolute;
        top: 12px;
        right: 15px;
        background: none;
        border: none;
        color: white;
        font-size: 20px;
        cursor: pointer;
        padding: 0;
        width: 30px;
        height: 30px;
        border-radius: 50%;
        transition: background 0.3s;
    }

    .close-btn:hover {
        background: rgba(255,255,255,0.2);
    }

    .chatbot-messages {
        flex: 1;
        padding: 20px;
        overflow-y: auto;
        background: #f8f9fa;
        max-height: 380px;
    }

    .message {
        margin-bottom: 15px;
        padding: 12px 16px;
        border-radius: 18px;
        max-width: 85%;
        word-wrap: break-word;
        line-height: 1.4;
        position: relative;
    }

    .message.user {
        background: linear-gradient(135deg, #1b5e20, #43ea7c);
        color: white;
        margin-left: auto;
        border-bottom-right-radius: 6px;
        box-shadow: 0 2px 8px rgba(27,94,32,0.3);
    }

    .message.bot {
        background: white;
        color: #333;
        border: 1px solid #e0e0e0;
        border-bottom-left-radius: 6px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .message.bot a {
        color: #1b5e20;
        text-decoration: none;
        font-weight: 500;
    }

    .message.bot a:hover {
        text-decoration: underline;
    }

    .typing-indicator {
        display: none;
        padding: 12px 16px;
        background: white;
        border: 1px solid #e0e0e0;
        border-radius: 18px;
        border-bottom-left-radius: 6px;
        max-width: 85%;
        margin-bottom: 15px;
    }

    .typing-dots {
        display: flex;
        gap: 4px;
    }

    .typing-dot {
        width: 8px;
        height: 8px;
        background: #1b5e20;
        border-radius: 50%;
        animation: typing 1.4s infinite ease-in-out;
    }

    .typing-dot:nth-child(1) { animation-delay: -0.32s; }
    .typing-dot:nth-child(2) { animation-delay: -0.16s; }

    @keyframes typing {
        0%, 80%, 100% { transform: scale(0.8); opacity: 0.5; }
        40% { transform: scale(1); opacity: 1; }
    }

    .chatbot-input {
        padding: 20px;
        border-top: 1px solid #e0e0e0;
        background: white;
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .chatbot-input input {
        flex: 1;
        padding: 12px 16px;
        border: 2px solid #e0e0e0;
        border-radius: 25px;
        outline: none;
        font-size: 14px;
        transition: border-color 0.3s;
    }

    .chatbot-input input:focus {
        border-color: #1b5e20;
    }

    .chatbot-input button {
        background: linear-gradient(135deg, #1b5e20, #43ea7c);
        color: white;
        border: none;
        padding: 12px 20px;
        border-radius: 25px;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.3s;
        min-width: 80px;
    }

    .chatbot-input button:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(27,94,32,0.3);
    }

    .chatbot-input button:disabled {
        opacity: 0.6;
        cursor: not-allowed;
        transform: none;
    }

    /* Scrollbar styling */
    .chatbot-messages::-webkit-scrollbar {
        width: 6px;
    }

    .chatbot-messages::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 3px;
    }

    .chatbot-messages::-webkit-scrollbar-thumb {
        background: #1b5e20;
        border-radius: 3px;
    }

    .chatbot-messages::-webkit-scrollbar-thumb:hover {
        background: #43ea7c;
    }

    /* Responsive */
    @media (max-width: 480px) {
        .chatbot-container {
            width: calc(100vw - 40px);
            right: 20px;
            left: 20px;
        }
    }
</style>

<script>
    let isTyping = false;

    function toggleChatbot() {
        const container = document.getElementById('chatbot-container');
        const toggleBtn = document.querySelector('.chatbot-toggle');
        
        if (container.style.display === 'none' || container.style.display === '') {
            container.style.display = 'flex';
            toggleBtn.innerHTML = '🤖'; // Robot icon when open
            
            // Hiển thị tin nhắn chào mừng thông minh
            if (document.getElementById('chatbot-messages').children.length === 0) {
                const currentPage = window.location.pathname;
                let welcomeMessage = "Xin chào! Tôi là TechSign AI Assistant 🤖<br><br>💼 Tôi có thể giúp bạn:<br>• Tìm việc làm phù hợp<br>• Tư vấn về công ty<br>• Hướng dẫn sử dụng website<br>• Trả lời mọi thắc mắc<br><br>Hãy hỏi tôi bất cứ điều gì nhé!";
                
                // Lấy thông tin người dùng từ session (nếu có)
                const userName = '<%= session.getAttribute("user") != null ? ((User)session.getAttribute("user")).getFullName() : "" %>';
                const userRole = '<%= session.getAttribute("user") != null ? ((User)session.getAttribute("user")).getRoleName() : "" %>';
                
                // Tùy chỉnh tin nhắn theo trang và người dùng
                if (currentPage.includes('companyHome')) {
                    if (userName && userName.trim() !== '') {
                        welcomeMessage = "Xin chào " + userName + "! Tôi là TechSign AI Assistant 🤖<br><br>🏢 <strong>Chào mừng công ty!</strong><br>💼 Tôi có thể giúp bạn:<br>• Đăng tin tuyển dụng hiệu quả<br>• Tìm ứng viên phù hợp<br>• Quản lý hồ sơ ứng tuyển<br>• Tư vấn chiến lược tuyển dụng<br>• Hướng dẫn sử dụng hệ thống<br><br>Hãy hỏi tôi bất cứ điều gì nhé!";
                    } else {
                        welcomeMessage = "Xin chào! Tôi là TechSign AI Assistant 🤖<br><br>🏢 <strong>Chào mừng công ty!</strong><br>💼 Tôi có thể giúp bạn:<br>• Đăng tin tuyển dụng hiệu quả<br>• Tìm ứng viên phù hợp<br>• Quản lý hồ sơ ứng tuyển<br>• Tư vấn chiến lược tuyển dụng<br>• Hướng dẫn sử dụng hệ thống<br><br>Hãy hỏi tôi bất cứ điều gì nhé!";
                    }
                } else if (currentPage.includes('candidateHome')) {
                    if (userName && userName.trim() !== '') {
                        welcomeMessage = "Xin chào " + userName + "! Tôi là TechSign AI Assistant 🤖<br><br>👨‍💻 <strong>Chào mừng ứng viên!</strong><br>💼 Tôi có thể giúp bạn:<br>• Tìm việc làm phù hợp<br>• Tạo CV chuyên nghiệp<br>• Tư vấn phỏng vấn<br>• Hướng dẫn kỹ năng mềm<br>• Thông tin công ty<br><br>Hãy hỏi tôi bất cứ điều gì nhé!";
                    } else {
                        welcomeMessage = "Xin chào! Tôi là TechSign AI Assistant 🤖<br><br>👨‍💻 <strong>Chào mừng ứng viên!</strong><br>💼 Tôi có thể giúp bạn:<br>• Tìm việc làm phù hợp<br>• Tạo CV chuyên nghiệp<br>• Tư vấn phỏng vấn<br>• Hướng dẫn kỹ năng mềm<br>• Thông tin công ty<br><br>Hãy hỏi tôi bất cứ điều gì nhé!";
                    }
                } else if (currentPage.includes('adminHome')) {
                    if (userName && userName.trim() !== '') {
                        welcomeMessage = "Xin chào " + userName + "! Tôi là TechSign AI Assistant 🤖<br><br>⚙️ <strong>Chào mừng Admin!</strong><br>💼 Tôi có thể giúp bạn:<br>• Quản lý hệ thống<br>• Thống kê và báo cáo<br>• Hỗ trợ người dùng<br>• Tư vấn bảo mật<br>• Hướng dẫn quản trị<br><br>Hãy hỏi tôi bất cứ điều gì nhé!";
                    } else {
                        welcomeMessage = "Xin chào! Tôi là TechSign AI Assistant 🤖<br><br>⚙️ <strong>Chào mừng Admin!</strong><br>💼 Tôi có thể giúp bạn:<br>• Quản lý hệ thống<br>• Thống kê và báo cáo<br>• Hỗ trợ người dùng<br>• Tư vấn bảo mật<br>• Hướng dẫn quản trị<br><br>Hãy hỏi tôi bất cứ điều gì nhé!";
                    }
                }
                
                addBotMessage(welcomeMessage);
            }
        } else {
            container.style.display = 'none';
            toggleBtn.innerHTML = '🤖'; // Keep robot icon when closed
        }
    }

    function addUserMessage(message) {
        const messagesDiv = document.getElementById('chatbot-messages');
        const messageDiv = document.createElement('div');
        messageDiv.className = 'message user';
        messageDiv.innerHTML = message;
        messagesDiv.appendChild(messageDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }

    function addBotMessage(message) {
        const messagesDiv = document.getElementById('chatbot-messages');
        const messageDiv = document.createElement('div');
        messageDiv.className = 'message bot';
        messageDiv.innerHTML = message;
        messagesDiv.appendChild(messageDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }

    function showTypingIndicator() {
        const messagesDiv = document.getElementById('chatbot-messages');
        const typingDiv = document.createElement('div');
        typingDiv.className = 'typing-indicator';
        typingDiv.id = 'typing-indicator';
        typingDiv.innerHTML = `
            <div class="typing-dots">
                <div class="typing-dot"></div>
                <div class="typing-dot"></div>
                <div class="typing-dot"></div>
            </div>
        `;
        messagesDiv.appendChild(typingDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }

    function hideTypingIndicator() {
        const typingIndicator = document.getElementById('typing-indicator');
        if (typingIndicator) {
            typingIndicator.remove();
        }
    }

    function sendMessage() {
        if (isTyping) return;

        const input = document.getElementById('chatbot-input-field');
        const sendBtn = document.getElementById('chatbot-send-btn');
        const message = input.value.trim();

        if (message === '') return;

        // Disable input and button
        input.disabled = true;
        sendBtn.disabled = true;
        isTyping = true;

        addUserMessage(message);
        input.value = '';
        showTypingIndicator();

        // Gửi tin nhắn đến server
        fetch('${pageContext.request.contextPath}/techsign-ai-chatbot', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'message=' + encodeURIComponent(message)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            hideTypingIndicator();
            addBotMessage(data.reply);
        })
        .catch(error => {
            hideTypingIndicator();
            addBotMessage('Xin lỗi, có lỗi xảy ra. Vui lòng thử lại sau hoặc liên hệ hỗ trợ.');
            console.error('Error:', error);
        })
        .finally(() => {
            // Re-enable input and button
            input.disabled = false;
            sendBtn.disabled = false;
            isTyping = false;
            input.focus();
        });
    }

    // Enter key để gửi tin nhắn
    document.addEventListener('DOMContentLoaded', function() {
        const input = document.getElementById('chatbot-input-field');
        if (input) {
            input.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    sendMessage();
                }
            });
        }
    });
</script>

<div class="techsign-ai-chatbot">
    <button class="chatbot-toggle" onclick="toggleChatbot()">🤖</button>
    
    <div id="chatbot-container" class="chatbot-container">
        <div class="chatbot-header">
            <span>🤖 TechSign AI Assistant</span>
            <button class="close-btn" onclick="toggleChatbot()">×</button>
        </div>
        
        <div id="chatbot-messages" class="chatbot-messages">
            <!-- Messages will be displayed here -->
        </div>
        
        <div class="chatbot-input">
            <input type="text" id="chatbot-input-field" placeholder="Nhập câu hỏi của bạn..." autocomplete="off">
            <button id="chatbot-send-btn" onclick="sendMessage()">Gửi</button>
        </div>
    </div>
</div> 