<%-- login.jsp --%>
<!DOCTYPE html>
<html>
<head><title>Login</title></head>
<body>
    <h2>Login</h2>
    <p style="color:red;">
        <% if (request.getParameter("error") != null) { %>
            Login failed. Please try again.
        <% } %>
    </p>
    <a href="https://accounts.google.com/o/oauth2/auth?...">Login with Google</a>
</body>
</html>