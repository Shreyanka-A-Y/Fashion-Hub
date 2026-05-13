<%@ page import="java.util.*, com.fashionhub.dao.*, com.fashionhub.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String admin = (String) session.getAttribute("admin");
    if(admin == null){ response.sendRedirect("admin-login.jsp"); return; }

    // Simulating Data Fetching - Replace with actual DAO calls
    UserDAO uDao = new UserDAO();
    UsedProductDAO pDao = new UsedProductDAO();
    
    int totalUsers = uDao.getAllUsers().size();
    int pendingApprovals = pDao.getPendingProducts().size();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard | FashionHub Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>

<div class="admin-layout">
    <aside class="sidebar">
        <div class="sidebar-brand">FashionHub<span>Admin</span></div>
        <nav class="nav-links">
            <a href="admin-dashboard.jsp" class="active">Dashboard</a>
            <a href="approve-products.jsp">Approve Products</a>
            <a href="view-users.jsp">Users</a>
            <a href="admin-add-product.jsp">Add Product</a>
            <a href="adminLogout.jsp" style="margin-top: 50px; color: #f87171;">Logout</a>
        </nav>
    </aside>

    <main class="main-wrapper">
        <div class="header-section">
            <h1>Welcome back, Admin</h1>
            <p>Here is what's happening with FashionHub today.</p>
        </div>

        <div class="stat-grid">
            <div class="stat-card">
                <h3>Total Members</h3>
                <div class="value"><%= totalUsers %></div>
            </div>
            <div class="stat-card">
                <h3>Pending Items</h3>
                <div class="value" style="color: var(--indigo-primary);"><%= pendingApprovals %></div>
            </div>
            <div class="stat-card">
                <h3>Store Status</h3>
                <div class="value" style="color: var(--success);">LIVE</div>
            </div>
        </div>

        <div class="header-section" style="margin-top: 50px;">
            <h2>Quick Overview</h2>
        </div>

        <div class="data-card">
            <p style="color: var(--text-muted); text-align: center; padding: 40px 0;">
                Select a category from the sidebar to manage users or approve product listings.
            </p>
        </div>
    </main>
</div>

</body>
</html>