<%-- 
    Document   : user-list-table
    Created on : Jun 17, 2025, 8:33:12 PM
    Author     : Administrator
--%>

<%@page import="com.mycompany.adminscreen.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.adminscreen.model.User" %>
<%@ page import="java.util.List" %>


<script>
    // Remove refreshUserList and related event listeners
    // Only keep attachDeleteListeners and its initialization
    function attachDeleteListeners() {
        document.querySelectorAll('.btn-delete').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (!confirm('Bạn có chắc chắn muốn xóa người dùng này?')) {
                    e.preventDefault();
                }
            });
        });
    }
    document.addEventListener('DOMContentLoaded', function() {
        attachDeleteListeners();
    });
</script>

<%
    List<User> users = (List<User>) request.getAttribute("userList");
    System.out.println("JSP: users attribute size = " + (users == null ? "null" : users.size()));
    if (users == null) users = new java.util.ArrayList<>();
%>

<div id="userTableContainer">
    <div class="table-controls" style="margin-bottom: 1rem;">
        <!-- Refresh button removed -->
    </div>
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Họ và tên</th>
                    <th>Email</th>
                    <th>Điện thoại</th>
                    <th>Email xác thực</th>
                    <th>Điện thoại xác thực</th>
                    <th>Vai trò</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody id="userTableBody">
                <% if (users != null && !users.isEmpty()) {
                    for (User user : users) { %>
                    <tr>
                        <td><%= user.getId() %></td>
                        <td><%= user.getFullName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getPhone() != null ? user.getPhone() : "-" %></td>
                        <td><%= user.isEmailVerified() ? "Đã xác thực" : "Chưa xác thực" %></td>
                        <td><%= user.isPhoneVerified() ? "Đã xác thực" : "Chưa xác thực" %></td>
                        <td><%= user.getRoleName() %></td>
                        <td>
                            <a href="#" class="btn-edit-user btn btn-sm btn-outline-primary me-1" data-user-id="<%= user.getId() %>"><i class="fas fa-edit"></i></a>
                            <a href="users?action=delete&id=<%= user.getId() %>" class="btn btn-sm btn-outline-danger btn-delete"><i class="fas fa-trash"></i></a>
                        </td>
                    </tr>
                <% } } else { %>
                    <tr>
                        <td colspan="8" class="text-center">Không có người dùng nào.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<style>
    .table-controls {
        display: flex;
        gap: 1rem;
        margin-bottom: 1rem;
    }
    
    .btn-refresh {
        padding: 0.5rem 1rem;
        background: #2563eb;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .btn-refresh:hover {
        background: #1d4ed8;
    }
    
    .btn-refresh:disabled {
        background: #93c5fd;
        cursor: not-allowed;
    }
    
    .btn-refresh i {
        font-size: 1rem;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    .fa-spin {
        animation: spin 1s linear infinite;
    }
</style>