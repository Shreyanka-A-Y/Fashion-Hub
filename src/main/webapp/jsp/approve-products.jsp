<%@ page import="java.util.*, com.fashionhub.dao.UsedProductDAO, com.fashionhub.model.UsedProduct" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 1. Session Security
    String admin = (String) session.getAttribute("admin");
    if(admin == null){ 
        response.sendRedirect("admin-login.jsp"); 
        return; 
    }

    // 2. Data Fetching with Safety
    UsedProductDAO dao = new UsedProductDAO();
    List<UsedProduct> list = null;
    try {
        list = dao.getPendingProducts();
    } catch(Exception e) {
        e.printStackTrace();
    }
    
    if(list == null) list = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Approvals | FashionHub Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>

<div class="admin-layout">
    <aside class="sidebar">
        <div class="sidebar-brand">FashionHub<span>Admin</span></div>
        <nav class="nav-links">
            <a href="admin-dashboard.jsp">Dashboard</a>
            <a href="approve-products.jsp" class="active">Approve Products</a>
            <a href="view-users.jsp">Users</a>
            <a href="admin-add-product.jsp">Add Product</a>
            <a href="${pageContext.request.contextPath}/adminLogout.jsp" style="margin-top: 50px; color: #f87171;">Logout</a>
        </nav>
    </aside>

    <main class="main-wrapper">
        <header class="header-section">
            <h1>Pending Approvals</h1>
            <p>You have <%= list.size() %> items waiting for verification.</p>
        </header>

        <div class="data-card">
            <table class="premium-table">
                <thead>
                    <tr>
                        <th style="width: 40%;">Product Details</th>
                        <th style="width: 15%;">Price</th>
                        <th style="width: 15%;">Condition</th>
                        <th style="text-align: right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    for(UsedProduct up : list) { 
                        // Safety: Handle potential nulls in data
                        String productName = (up.getProductName() != null) ? up.getProductName() : "Unnamed Product";
                        String description = (up.getDescription() != null) ? up.getDescription() : "No description provided.";
                        if(description.length() > 55) description = description.substring(0, 52) + "...";
                        
                        String condition = (up.getProductCondition() != null) ? up.getProductCondition() : "NOT SET";
                    %>
                    <tr>
                        <td>
                            <div style="font-weight: 700; font-size: 15px; color: #0f172a;"><%= productName %></div>
                            <div style="font-size: 12px; color: #64748b; margin-top: 2px;"><%= description %></div>
                        </td>
                        <td>
                            <span class="coin-value">🪙 <%= up.getCoinPrice() %></span>
                        </td>
                        <td>
                            <span class="badge-condition"><%= condition.toUpperCase() %></span>
                        </td>
                        <td style="text-align: right;">
                            <div style="display: flex; justify-content: flex-end; gap: 10px;">
                                <a href="${pageContext.request.contextPath}/approveUsed?usedId=<%= up.getUsedId() %>" 
                                   class="btn-action btn-approve">Approve</a>
                                <a href="${pageContext.request.contextPath}/rejectUsed?usedId=<%= up.getUsedId() %>" 
                                   class="btn-action btn-reject">Reject</a>
                            </div>
                        </td>
                    </tr>
                    <% } %>

                    <% if(list.isEmpty()) { %>
                    <tr>
                        <td colspan="4" style="text-align: center; padding: 100px 0;">
                            <div style="font-size: 40px; margin-bottom: 15px;">✅</div>
                            <h3 style="color: #0f172a;">All Caught Up!</h3>
                            <p style="color: #64748b;">There are no products currently waiting for approval.</p>
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