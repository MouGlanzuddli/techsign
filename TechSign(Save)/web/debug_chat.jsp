<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Debug Chat</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>Debug Chat History</h1>
    
    <%
    // Kiểm tra session
    HttpSession session = request.getSession(false);
    if (session != null) {
        Object user = session.getAttribute("user");
        if (user != null) {
            out.println("<p style='color: green;'>✅ Đã đăng nhập!</p>");
            out.println("<p>User: " + user.toString() + "</p>");
        } else {
            out.println("<p style='color: red;'>❌ Session có nhưng không có user!</p>");
        }
    } else {
        out.println("<p style='color: red;'>❌ Chưa có session!</p>");
    }
    %>
    
    <h2>Test với receiver_id khác nhau:</h2>
    <button onclick="testChatHistory(1)">Test với user ID 1</button>
    <button onclick="testChatHistory(2)">Test với user ID 2</button>
    <button onclick="testChatHistory(3)">Test với user ID 3</button>
    <button onclick="testChatHistory(22)">Test với user ID 22</button>
    
    <div id="result"></div>
    
    <script>
    function testChatHistory(receiverId) {
        console.log('[Debug] Testing ChatHistoryServlet with receiver_id =', receiverId);
        
        fetch('/TechSign/ChatHistoryServlet?receiver_id=' + receiverId)
        .then(response => {
            console.log('[Debug] Response status:', response.status);
            return response.json();
        })
        .then(data => {
            console.log('[Debug] Response data:', data);
            document.getElementById('result').innerHTML = 
                '<h3>Kết quả cho receiver_id = ' + receiverId + '</h3>' +
                '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
        })
        .catch(err => {
            console.error('[Debug] Error:', err);
            document.getElementById('result').innerHTML = 
                '<h3>Lỗi cho receiver_id = ' + receiverId + '</h3>' +
                '<pre>Error: ' + err + '</pre>';
        });
    }
    </script>
</body>
</html> 