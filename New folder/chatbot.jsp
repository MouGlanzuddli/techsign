<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chatbot AI</title>
    <style>
        
        
        
        /* Ảnh sản phẩm trong chatbot */
.chatbot-msg img.product-image {
  max-width: 100%;        /* Ảnh không vượt quá khung tin nhắn */
  height: auto;           /* Tỷ lệ ảnh giữ nguyên */
  border-radius: 12px;    /* Bo góc ảnh */
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  display: block;         /* Cho margin hoạt động */
  margin: 10px 0 5px 0;  /* Cách đều trên dưới */
  object-fit: contain;    /* Ảnh vừa vặn trong khung */
  cursor: pointer;        /* Chuột hover thành pointer nếu cần */
  transition: transform 0.3s ease;
}

.chatbot-msg img.product-image:hover {
  transform: scale(1.05); /* Hiệu ứng zoom nhẹ khi hover */
}



.chatbot-msg.bot-msg img {
  max-width: 100%;
  height: auto;
  border-radius: 12px;
  display: block;
  margin: 8px 0 0 0;
  object-fit: contain;
}
.chatbot-msg.bot-msg {
  max-width: 80%; /* Giới hạn chiều rộng tin nhắn */
  overflow-wrap: break-word;
  position: relative; /* Để ::before mũi tên hoạt động */
}

.chatbot-msg.bot-msg img {
  max-width: 100% !important;  /* Ảnh không vượt quá chiều rộng container */
  height: auto !important;
  display: block;
  border-radius: 12px;
  margin-top: 8px;
  object-fit: contain;
  box-sizing: border-box;
}

        
        
        
        
        /* Chatbot Container Styles */
        .chatbot-container * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        /* Toggle Button */
        .chatbot-toggle {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: linear-gradient(135deg, #FF8C00, #FF7043);
            color: white;
            border: none;
            box-shadow: 0 8px 25px rgba(255, 140, 0, 0.4);
            cursor: pointer;
            font-size: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        .chatbot-toggle:hover {
            transform: scale(1.15) rotate(10deg);
            box-shadow: 0 12px 30px rgba(255, 107, 0, 0.5);
            background: linear-gradient(135deg, #FF7043, #FF8C00);
        }
        
        .chatbot-toggle.new-message {
            animation: pulse 1.5s infinite;
            background: linear-gradient(135deg, #FF5722, #E64A19);
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.15); }
            100% { transform: scale(1); }
        }
        
        /* Chat Window */
        .chatbot-window {
            position: fixed;
            bottom: 120px;
            right: 30px;
            width: 380px;
            height: 550px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(255, 107, 0, 0.25);
            display: none;
            flex-direction: column;
            z-index: 999;
            overflow: hidden;
            transform: translateY(30px);
            opacity: 0;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: 1px solid rgba(255, 140, 0, 0.2);
        }
        
        .chatbot-window.active {
            display: flex !important;
            transform: translateY(0);
            opacity: 1;
        }
        
        /* Chat Header */
        .chatbot-header {
            background: linear-gradient(135deg, #FF8C00, #FF7043);
            color: white;
            padding: 18px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.2);
            position: relative;
            z-index: 1;
        }
        
        .chatbot-title {
            font-weight: 600;
            font-size: 18px;
            letter-spacing: 0.5px;
        }
        
        .chatbot-close {
            background: none;
            border: none;
            color: white;
            font-size: 28px;
            cursor: pointer;
            line-height: 1;
            transition: transform 0.2s;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        
        .chatbot-close:hover {
            transform: rotate(90deg);
            background: rgba(255,255,255,0.2);
        }
        
        /* Messages Area */
        .chatbot-messages {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 15px;
            background: linear-gradient(to bottom, #FFF9F2, #FFF5EB);
            position: relative;
        }
        
        .chatbot-messages::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 15px;
            background: linear-gradient(to bottom, rgba(255,255,255,0.8), transparent);
            z-index: 2;
        }
        
        .chatbot-msg {
            max-width: 80%;
            padding: 12px 18px;
            border-radius: 20px;
            line-height: 1.5;
            word-wrap: break-word;
            position: relative;
            font-size: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            animation: fadeIn 0.3s ease-out;
            transition: transform 0.2s;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .user-msg {
            align-self: flex-end;
            background: linear-gradient(135deg, #FF8C00, #FF7043);
            color: white;
            border-bottom-right-radius: 5px;
            margin-left: 20%;
        }
        
        .bot-msg {
            align-self: flex-start;
            background: white;
            color: #5A4A42;
            border-bottom-left-radius: 5px;
            border: 1px solid #FFE0C2;
            margin-right: 20%;
        }
        
        .bot-msg::before {
            content: "";
            position: absolute;
            left: -8px;
            top: 12px;
            width: 0;
            height: 0;
            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
            border-right: 8px solid white;
        }
        
        .user-msg::after {
            content: "";
            position: absolute;
            right: -8px;
            top: 12px;
            width: 0;
            height: 0;
            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
            border-left: 8px solid #FF8C00;
        }
        
        /* Input Area */
        .chatbot-input-area {
            display: flex;
            padding: 15px;
            border-top: 1px solid #FFE0C2;
            background: white;
            position: relative;
        }
        
        .chatbot-input {
            flex: 1;
            padding: 12px 20px;
            border: 1px solid #FFD5B5;
            border-radius: 25px;
            outline: none;
            transition: all 0.3s;
            font-size: 15px;
            background: #FFF9F2;
            color: #5A4A42;
        }
        
        .chatbot-input:focus {
            border-color: #FF8C00;
            box-shadow: 0 0 0 3px rgba(255, 140, 0, 0.2);
            background: white;
        }
        
        .chatbot-send {
            margin-left: 12px;
            padding: 0;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #FF8C00, #FF7043);
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.3);
        }
        
        .chatbot-send:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(255, 107, 0, 0.4);
            background: linear-gradient(135deg, #FF7043, #FF8C00);
        }
        
        .chatbot-send i {
            font-size: 20px;
        }
        
        /* Typing indicator */
        .typing-indicator {
            display: flex;
            padding: 10px 15px;
            background: white;
            border-radius: 20px;
            align-self: flex-start;
            margin-bottom: 5px;
            border: 1px solid #FFE0C2;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .typing-dot {
            width: 8px;
            height: 8px;
            background: #FF8C00;
            border-radius: 50%;
            margin: 0 3px;
            animation: typingAnimation 1.4s infinite ease-in-out;
        }
        
        .typing-dot:nth-child(1) {
            animation-delay: 0s;
        }
        
        .typing-dot:nth-child(2) {
            animation-delay: 0.2s;
        }
        
        .typing-dot:nth-child(3) {
            animation-delay: 0.4s;
        }
        
        @keyframes typingAnimation {
            0%, 60%, 100% { transform: translateY(0); }
            30% { transform: translateY(-5px); }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <!-- Chatbot Container -->
    <div class="chatbot-container">
        <button class="chatbot-toggle" id="chatbotToggleBtn">
            <i class="fas fa-robot"></i>
        </button>
        
        <div class="chatbot-window" id="chatbotWindow">
            <div class="chatbot-header">
                <span class="chatbot-title">Trợ lý ảo ShoesStore</span>
                <button class="chatbot-close" id="chatbotCloseBtn">×</button>
            </div>
            
            <div class="chatbot-messages" id="chatbotMessages">
                <!-- Messages will appear here -->
            </div>
            
            <div class="chatbot-input-area">
                <input type="text" class="chatbot-input" id="chatbotInput" placeholder="Nhập tin nhắn..." onkeypress="handleKeyPress(event)">
                <button class="chatbot-send" id="chatbotSendBtn">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
    const toggleBtn = document.getElementById('chatbotToggleBtn');
    const closeBtn = document.getElementById('chatbotCloseBtn');
    const chatWindow = document.getElementById('chatbotWindow');
    const chatMessages = document.getElementById('chatbotMessages');
    const chatInput = document.getElementById('chatbotInput');
    const sendBtn = document.getElementById('chatbotSendBtn');

    // Hàm bật/tắt cửa sổ chat khi nhấn toggle button
    function toggleChatbot(event) {
        event.stopPropagation();
        chatWindow.classList.toggle('active');

        if (chatWindow.classList.contains('active')) {
            toggleBtn.classList.remove('new-message');

            if (chatMessages.children.length === 0) {
                setTimeout(() => {
                    addBotMessage('Xin chào! Tôi là trợ lý ảo của ShoesStore. Tôi có thể giúp gì cho bạn hôm nay?');
                }, 500);
            }
        }
    }

    // Thêm tin nhắn bot (có hiệu ứng typing)
    function addBotMessage(text) {
        const typingIndicator = document.createElement('div');
        typingIndicator.className = 'typing-indicator';
        typingIndicator.innerHTML = `
            <div class="typing-dot"></div>
            <div class="typing-dot"></div>
            <div class="typing-dot"></div>
        `;
        chatMessages.appendChild(typingIndicator);
        chatMessages.scrollTop = chatMessages.scrollHeight;

        setTimeout(() => {
            chatMessages.removeChild(typingIndicator);

            const msgElement = document.createElement('div');
            msgElement.className = 'chatbot-msg bot-msg';

            if (/<[a-z][\s\S]*>/i.test(text)) {
                msgElement.innerHTML = text;
            } else {
                msgElement.textContent = text;
            }

            chatMessages.appendChild(msgElement);
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }, 1500);
    }

    // Thêm tin nhắn user
    function addUserMessage(text) {
        const msgElement = document.createElement('div');
        msgElement.className = 'chatbot-msg user-msg';
        msgElement.textContent = text;
        chatMessages.appendChild(msgElement);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    // Gửi tin nhắn đi
    function sendMessage() {
        const message = chatInput.value.trim();
        if (message === '') return;

        addUserMessage(message);
        chatInput.value = '';

        fetch('ChatServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'message=' + encodeURIComponent(message)
        })
        .then(response => response.json())
        .then(data => {
            addBotMessage(data.reply.trim());
        })
        .catch(error => {
            console.error('Lỗi khi gửi tin nhắn:', error);
            addBotMessage('Xin lỗi, có lỗi xảy ra khi kết nối với hệ thống.');
        });
    }

    // Gán sự kiện cho các nút
    toggleBtn.addEventListener('click', toggleChatbot);

    closeBtn.addEventListener('click', () => {
        chatWindow.classList.remove('active');
    });

    sendBtn.addEventListener('click', sendMessage);

    chatInput.addEventListener('keypress', function(event) {
        if (event.key === 'Enter') {
            sendMessage();
        }
    });

    // Tự động mở chatbot sau 3 giây
    
});

        
        // Global function for Enter key
        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                document.getElementById('chatbotSendBtn').click();
            }
        }
    </script>
</body>
</html>