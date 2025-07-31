<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Check Session</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>Session Check</h1>
    
    <%
    // Kiểm tra session
    HttpSession session = request.getSession(false);
    if (session != null) {
        Object user = session.getAttribute("user");
        if (user != null) {
            out.println("<p style='color: green;'>✅ Đã đăng nhập!</p>");
            out.println("<p>User: " + user.toString() + "</p>");
            out.println("<p>Session ID: " + session.getId() + "</p>");
        } else {
            out.println("<p style='color: red;'>❌ Session có nhưng không có user!</p>");
        }
    } else {
        out.println("<p style='color: red;'>❌ Chưa có session!</p>");
    }
    %>
    
    <h2>Test ChatHistoryServlet</h2>
    <button onclick="testChatHistory()">Test Chat History</button>
    <div id="chatResult"></div>
    
    <h2>Test SendMessageServlet</h2>
    <button onclick="testSendMessage()">Test Send Message</button>
    <div id="sendResult"></div>
    
    <script>
    function testChatHistory() {
        fetch('/TechSign/ChatHistoryServlet?receiver_id=2')
        .then(response => response.json())
        .then(data => {
            document.getElementById('chatResult').innerHTML = '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
        })
        .catch(err => {
            document.getElementById('chatResult').innerHTML = '<pre>Error: ' + err + '</pre>';
        });
    }
    
    function testSendMessage() {
        const formData = new URLSearchParams();
        formData.append('receiver_id', '2');
        formData.append('content', 'Test message from JSP');
        formData.append('message_type', 'text');
        
        fetch('/TechSign/SendMessageServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            document.getElementById('sendResult').innerHTML = '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
        })
        .catch(err => {
            document.getElementById('sendResult').innerHTML = '<pre>Error: ' + err + '</pre>';
        });
    }
    </script>
</body>
</html> 