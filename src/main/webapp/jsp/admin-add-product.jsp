<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String admin = (String) session.getAttribute("admin");
    if(admin == null){ response.sendRedirect("admin-login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Product | FashionHub Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>

<div class="admin-layout">
    <aside class="sidebar">
        <div class="sidebar-brand">FashionHub<span>Admin</span></div>
        <nav class="nav-links">
            <a href="admin-dashboard.jsp">Dashboard</a>
            <a href="approve-products.jsp">Approve Products</a>
            <a href="view-users.jsp">Users</a>
            <a href="admin-add-product.jsp" class="active">Add Product</a>
            <a href="adminLogout.jsp" style="margin-top: 50px; color: #f87171;">Logout</a>
        </nav>
    </aside>

    <main class="main-wrapper">
        <div class="header-section">
            <h1>Create New Listing</h1>
            <p>Add a brand new item to the official FashionHub store catalog.</p>
        </div>

        <div class="data-card">
            <form action="${pageContext.request.contextPath}/addProduct" method="POST" enctype="multipart/form-data">
                
                <div class="form-group">
                    <label>Product Name</label>
                    <input type="text" name="productName" class="form-control" placeholder="e.g. Premium Cotton Hoodie" required>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label>Brand</label>
                        <input type="text" name="brand" class="form-control" placeholder="e.g. FashionHub Original">
                    </div>
                    <div class="form-group">
                        <label>Category</label>
                        <select name="categoryId" class="form-control" required>
                            <option value="" disabled selected>Select Category</option>
                            <option value="1">Men</option>
                            <option value="2">Women</option>
                            <option value="3">Kids</option>
                            <option value="4">Accessories</option>
                            <option value="5">Other</option>
                        </select>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label>Price (Coins)</label>
                        <input type="number" name="price" class="form-control" placeholder="0" required>
                    </div>
                    <div class="form-group">
                        <label>Stock Quantity</label>
                        <input type="number" name="stock" class="form-control" placeholder="10" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Product Description</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Describe the material, fit, and key features..."></textarea>
                </div>

                <div class="form-group">
                    <label>Product Image</label>
                    <input type="file" name="image" class="form-control" style="padding: 8px;" required>
                </div>

                <button type="submit" class="btn-submit">Publish Product</button>
            </form>
        </div>
    </main>
</div>

</body>
</html>