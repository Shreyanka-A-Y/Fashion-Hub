<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.fashionhub.dao.UserDAO, com.fashionhub.model.User"%>
<%
    String admin = (String) session.getAttribute("admin");
    if(admin == null){ response.sendRedirect("admin-login.jsp"); return; }
    UserDAO dao = new UserDAO();
    List<User> list = dao.getAllUsers();
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Management | Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>

<div class="admin-layout">
    <aside class="sidebar">
        <div class="sidebar-brand">FashionHub<span>Admin</span></div>
        <nav class="nav-links">
            <a href="admin-dashboard.jsp">Dashboard</a>
            <a href="approve-products.jsp">Approve Products</a>
            <a href="view-users.jsp" class="active">Users</a>
            <a href="admin-add-product.jsp">Add Product</a>
            <a href="adminLogout" style="margin-top: 50px; color: #f87171;">Logout</a>
        </nav>
    </aside>

    <main class="main-wrapper">
        <div class="header-section">
            <h1>User Management</h1>
            <p>Monitor community activity and coin balances.</p>
        </div>

        <div class="data-card">
            <table class="premium-table">
                <thead>
                    <tr>
                        <th>User Name</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Balance</th>
                        <th style="text-align: right;">Management</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(User u : list) { %>
                    <tr>
                        <td><strong style="font-size:15px;"><%= u.getFullName() %></strong></td>
                        <td style="color: var(--text-muted);"><%= u.getEmail() %></td>
                        <td><span class="badge-status">ACTIVE</span></td>
                        <td><span class="coin-value">🪙 <%= u.getCoins() %></span></td>
                        <td style="text-align: right;">
                            <a href="edit-user.jsp?id=<%= u.getUserId() %>" class="btn-action" style="color: var(--indigo-primary);">Edit Profile</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </main>
</div>

</body>
</html>