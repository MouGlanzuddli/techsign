<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Session</title>
</head>
<body>
    <h2>Test Session</h2>
    
    <%
        // Kiểm tra session
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            model.User user = (model.User) session.getAttribute("user");
            out.println("<p>✅ Đã đăng nhập: " + user.getFullName() + " (ID: " + user.getId() + ")</p>");
        } else {
            out.println("<p>❌ Chưa đăng nhập</p>");
            out.println("<p><a href='login.jsp'>Đăng nhập</a></p>");
        }
    %>
    
    <h3>Test SendMessageServlet</h3>
    <form action="SendMessageServlet" method="post">
        <input type="hidden" name="receiver_id" value="2">
        <input type="hidden" name="content" value="Test message">
        <input type="hidden" name="message_type" value="text">
        <button type="submit">Test Send Message</button>
    </form>
    
    <h3>Test ChatHistoryServlet</h3>
    <a href="ChatHistoryServlet?receiver_id=2">Test Load Chat History</a>
</body>
</html> 