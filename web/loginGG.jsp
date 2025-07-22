<%-- login.jsp --%>
<!DOCTYPE html>
<html>
<head><title>Login</title></head>
<body>
    <h2>Login In</h2>
    <p style="color:red;">
        <% if (request.getParameter("error") != null) { %>
            Enter Access again
        <% } %>
    </p>
    <a href="https://accounts.google.com/o/oauth2/auth?...">Login with Google</a>
</body>
</html>
