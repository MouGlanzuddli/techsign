<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<html>
<head>
    <title>User Management</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; }
        th { background: #eee; }
        .message { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
<h2>User Management</h2>
<% if (request.getAttribute("message") != null) { %>
    <div class="message"><%= request.getAttribute("message") %></div>
<% } %>
<% if (request.getAttribute("error") != null) { %>
    <div class="error"><%= request.getAttribute("error") %></div>
<% } %>
<form method="get" action="users">
    <input type="text" name="search" placeholder="Search users..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" />
    <button type="submit">Search</button>
</form>
<br/>
<table>
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Verified</th>
    </tr>
    <% List<User> users = (List<User>) request.getAttribute("users");
       if (users != null) {
           for (User user : users) { %>
    <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getUsername() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.isVerified() ? "Yes" : "No" %></td>
    </tr>
    <%   }
       }
    %>
</table>
<br/>
<h3>Add New User</h3>
<form method="post" action="users">
    <input type="text" name="username" placeholder="Username" required />
    <input type="email" name="email" placeholder="Email" required />
    <input type="password" name="password" placeholder="Password" required />
    <button type="submit">Add User</button>
</form>
</body>
</html> 