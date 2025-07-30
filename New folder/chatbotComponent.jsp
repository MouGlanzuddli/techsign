<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        #chatContainer {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 350px;
            height: 450px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 10px;
            display: none;
            z-index: 9999;
            transition: all 0.3s;
        }

        #chatToggleBtn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            font-size: 30px;
            text-align: center;
            line-height: 60px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        #chatArea {
            height: 350px;
            overflow-y: auto;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            padding: 10px;
            margin-bottom: 10px;
        }

        #userMessage {
            width: 75%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        #sendBtn {
            width: 20%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        
        
        
        
        
        
    </style>

    <script>
        function toggleChat() {
            var chatContainer = document.getElementById("chatContainer");
            // Toggle chat container visibility
            if (chatContainer.style.display === "none" || chatContainer.style.display === "") {
                chatContainer.style.display = "block";
            } else {
                chatContainer.style.display = "none";
            }
        }

       function sendMessage() {
    var userMessage = document.getElementById("userMessage").value;

    if (userMessage.trim() === "") {
        alert("Please enter a message!");
        return;
    }

    var xhr = new XMLHttpRequest();
xhr.open("POST", "chatbot", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var botReply = JSON.parse(xhr.responseText).reply;
            var chatArea = document.getElementById("chatArea");

            // Hiển thị tin nhắn người dùng và phản hồi bot
            chatArea.innerHTML += "<br><strong>You:</strong> " + userMessage;
            chatArea.innerHTML += "<br><strong>Bot:</strong> " + botReply;

            document.getElementById("userMessage").value = ""; // Xóa input
            chatArea.scrollTop = chatArea.scrollHeight; // Cuộn xuống cuối cùng
        }
    };

    xhr.send("message=" + encodeURIComponent(userMessage));  // Gửi dữ liệu người dùng
}

    </script>
</head>

<body>
    <button id="chatToggleBtn" onclick="toggleChat()">💬</button>

    <div id="chatContainer">
        <div id="chatArea"></div>
        <input type="text" id="userMessage" placeholder="Type a message..." />
        <button id="sendBtn" onclick="sendMessage()">Send</button>
    </div>
</body>
</html>
