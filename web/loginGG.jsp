<%-- login.jsp --%>
<!DOCTYPE html>
<html>
<head><title>Login</title></head>
<body>
    <h2>??ng nh?p</h2>
    <p style="color:red;">
        <% if (request.getParameter("error") != null) { %>
            ??ng nh?p th?t b?i. Vui lòng th? l?i.
        <% } %>
    </p>
    <a href="https://accounts.google.com/o/oauth2/auth?...">Login with Google</a>
</body>
</html>
