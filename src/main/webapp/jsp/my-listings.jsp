<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.fashionhub.model.*, com.fashionhub.dao.*" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) { response.sendRedirect("login.jsp"); return; }

    UsedProductDAO dao = new UsedProductDAO();
    // Assuming your DAO has methods to filter by Seller ID and Buyer ID
    List<UsedProduct> myUploads = dao.getProductsBySeller(user.getUserId());
    List<UsedProduct> myPurchases = dao.getPurchasedProductsByUser(user.getUserId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Listings | FashionHub</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">
    <style>
        .listing-container { width: 90%; max-width: 1200px; margin: 40px auto; display: flex; gap: 30px; }
        .main-panel { flex: 1; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        
        /* Tab Styling */
        .tab-header { display: flex; gap: 20px; border-bottom: 2px solid #eee; margin-bottom: 25px; }
        .tab-link { padding: 10px 20px; cursor: pointer; font-weight: 700; color: #888; border-bottom: 2px solid transparent; transition: 0.3s; }
        .tab-link.active { color: #000; border-bottom-color: #d4af37; }

        /* Item Row */
        .item-card { display: flex; align-items: center; padding: 15px; border: 1px solid #f0f0f0; border-radius: 8px; margin-bottom: 15px; gap: 20px; }
        .item-card img { width: 80px; height: 100px; object-fit: cover; border-radius: 4px; }
        .item-info { flex: 1; }
        .status-tag { padding: 4px 10px; font-size: 10px; border-radius: 20px; font-weight: 700; text-transform: uppercase; }
        .status-pending { background: #fff7ed; color: #c2410c; }
        .status-sold { background: #f0fdf4; color: #16a34a; }
    </style>
</head>
<body>
    <jsp:include page="../components/navbar.jsp" />

    <div class="listing-container">
        <div class="main-panel">
            <div class="tab-header">
                <div class="tab-link active" onclick="showTab('selling')">My Listings (Selling)</div>
                <div class="tab-link" onclick="showTab('bought')">Purchased Items</div>
            </div>

            <div id="selling" class="tab-content">
                <% if(myUploads == null || myUploads.isEmpty()) { %>
                    <p>You haven't listed any items yet.</p>
                <% } else { 
                    for(UsedProduct p : myUploads) { %>
                    <div class="item-card">
                        <img src="${pageContext.request.contextPath}/assets/images/used/<%= p.getImage() %>">
                        <div class="item-info">
                            <h4 style="margin:0;"><%= p.getProductName() %></h4>
                            <p style="color:#d4af37; font-weight:700;">🪙 <%= p.getCoinPrice() %></p>
                        </div>
                        <span class="status-tag <%= p.isSold() ? "status-sold" : "status-pending" %>">
                            <%= p.isSold() ? "Sold" : "Live" %>
                        </span>
                    </div>
                <% } } %>
            </div>

            <div id="bought" class="tab-content" style="display:none;">
                 <% if(myPurchases == null || myPurchases.isEmpty()) { %>
                    <p>No purchases yet.</p>
                <% } else { 
                    for(UsedProduct p : myPurchases) { %>
                    <div class="item-card">
                        <img src="${pageContext.request.contextPath}/assets/images/used/<%= p.getImage() %>">
                        <div class="item-info">
                            <h4 style="margin:0;"><%= p.getProductName() %></h4>
                            <p>Purchased for: 🪙 <%= p.getCoinPrice() %></p>
                        </div>
                        <span class="status-tag status-sold">Owned</span>
                    </div>
                <% } } %>
            </div>
        </div>
    </div>

    <script>
        function showTab(id) {
            document.querySelectorAll('.tab-content').forEach(t => t.style.display = 'none');
            document.querySelectorAll('.tab-link').forEach(l => l.classList.remove('active'));
            document.getElementById(id).style.display = 'block';
            event.currentTarget.classList.add('active');
        }
    </script>
</body>
</html>