<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.fashionhub.model.*, com.fashionhub.dao.*, java.util.*"%>
<% 
    User user = (User) session.getAttribute("loggedUser"); 
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String view = request.getParameter("view");
    if (view == null) view = "settings"; 

    List<UsedProduct> myUploads = null;
    List<UsedProduct> myPurchases = null;
    if ("listings".equals(view)) {
        UsedProductDAO dao = new UsedProductDAO();
        myUploads = dao.getProductsBySeller(user.getUserId());
        myPurchases = dao.getPurchasedProductsByUser(user.getUserId());
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile | FashionHub</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">

<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Playfair+Display:wght@700&display=swap"
	rel="stylesheet">

<style>
:root {
	--lux-gold: #d4af37;
	--lux-black: #0a0a0a;
}

body {
	background-color: #fcfcfc;
	font-family: 'Inter', sans-serif;
	margin: 0;
	color: #333;
}

.profile-container {
	max-width: 1100px;
	margin: 40px auto;
	display: grid;
	grid-template-columns: 280px 1fr;
	gap: 30px;
	padding: 0 20px;
}

/* --- SIDEBAR --- */
.sidebar {
	background: white;
	padding: 40px 20px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
	height: fit-content;
	border: 1px solid #f0f0f0;
	text-align: center;
}

.profile-avatar {
	width: 70px;
	height: 70px;
	background: var(--lux-black);
	color: #fff;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
	font-weight: 700;
	margin: 0 auto 15px;
}

.side-menu {
	list-style: none;
	padding: 0;
	margin: 30px 0 0 0;
	text-align: left;
}

.side-menu li a {
	display: block;
	padding: 14px 20px;
	color: #666;
	text-decoration: none;
	font-weight: 600;
	font-size: 14px;
	border-radius: 12px;
	transition: 0.3s;
	margin-bottom: 8px;
}

.side-menu li a:hover {
	background: #f8f9fa;
	color: #000;
}

.side-menu li a.active {
	background: var(--lux-black);
	color: #fff;
}

/* --- MAIN CONTENT --- */
.main-content {
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
	border: 1px solid #f0f0f0;
	min-height: 550px;
}

h2 {
	font-family: 'Playfair Display', serif;
	font-size: 26px;
	margin: 0 0 30px 0;
}

/* --- UNIFORM ACTIVITY CARDS --- */
.activity-card {
	display: flex;
	align-items: center;
	gap: 20px;
	padding: 15px;
	border: 1px solid #f8f8f8;
	border-radius: 12px;
	margin-bottom: 12px;
	height: 90px; /* Fixed Height */
	box-sizing: border-box;
}

.activity-card img {
	width: 60px;
	height: 60px;
	min-width: 60px; /* Fixed Width */
	object-fit: cover;
	border-radius: 10px;
	background: #f5f5f5;
}

.card-info {
	flex: 1;
	min-width: 0;
}

.card-info h4 {
	margin: 0 0 5px 0;
	font-size: 15px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.card-price {
	color: var(--lux-gold);
	font-weight: 700;
	font-size: 13px;
}

.status-pill {
	width: 90px; /* Fixed Pill Width */
	text-align: center;
	padding: 6px 0;
	border-radius: 20px;
	font-size: 10px;
	font-weight: 700;
	text-transform: uppercase;
	flex-shrink: 0;
}

.status-pill.live {
	background: #e6fcf5;
	color: #087f5b;
}

.status-pill.sold {
	background: #f1f3f5;
	color: #495057;
}

/* Market Header & Tabs */
.market-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
	border-bottom: 1px solid #eee;
}

.market-tabs {
	display: flex;
	gap: 5px;
}

.tab-btn {
	background: none;
	border: none;
	padding: 10px 15px;
	cursor: pointer;
	font-weight: 600;
	color: #888;
	border-bottom: 2px solid transparent;
}

.tab-btn.active {
	color: #000;
	border-bottom-color: var(--lux-gold);
}

/* Settings Form Grid */
.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.form-group {
	margin-bottom: 20px;
}

.full-width {
	grid-column: 1/-1;
}

label {
	display: block;
	font-size: 11px;
	font-weight: 700;
	text-transform: uppercase;
	margin-bottom: 8px;
	color: #999;
}

input, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #eee;
	border-radius: 8px;
	font-family: inherit;
	box-sizing: border-box;
}

.readonly {
	background: #f9f9f9;
	color: #888;
	cursor: not-allowed;
}

.update-btn {
	background: var(--lux-black);
	color: #fff;
	padding: 14px 30px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-weight: 700;
}
</style>
</head>
<body>

	<jsp:include page="../components/navbar.jsp" />

	<div class="profile-container">
		<aside class="sidebar">
			<div class="profile-avatar"><%= user.getFullName().substring(0,1).toUpperCase() %></div>
			<h3 style="margin: 0;"><%= user.getFullName() %></h3>
			<p
				style="font-size: 11px; color: #aaa; text-transform: uppercase; letter-spacing: 1px;">Active
				Profile</p>

			<ul class="side-menu">
				<li><a href="?view=settings"
					class="<%= view.equals("settings") ? "active" : "" %>">Account
						Settings</a></li>
				<li><a href="?view=listings"
					class="<%= view.equals("listings") ? "active" : "" %>">Market
						Activity</a></li>
				<li
					style="margin-top: 20px; border-top: 1px solid #f0f0f0; padding-top: 10px;">
					<a href="${pageContext.request.contextPath}/logout"
					style="color: #ff5e5e;">Logout</a>
				</li>
			</ul>
		</aside>

		<main class="main-content">

			<% if (view.equals("settings")) { %>
			<h2>Account Settings</h2>
			<form action="${pageContext.request.contextPath}/updateProfile"
				method="POST">
				<div class="form-grid">
					<div class="form-group">
						<label>Full Name</label> <input type="text" name="fullName"
							value="<%= user.getFullName() %>">
					</div>
					<div class="form-group">
						<label>Email Address</label> <input type="email" class="readonly"
							value="<%= user.getEmail() %>" readonly>
					</div>
					<div class="form-group">
						<label>Phone Number</label> <input type="text" name="phone"
							value="<%= (user.getPhone() != null) ? user.getPhone() : "" %>">
					</div>
					<div class="form-group">
						<label>Wallet Balance</label> <input type="text" class="readonly"
							value="🪙 <%= user.getCoins() %> Coins" readonly>
					</div>
					<div class="form-group full-width">
						<label>Shipping Address</label>
						<textarea name="address" rows="3"><%= (user.getAddress() != null) ? user.getAddress() : "" %></textarea>
					</div>
				</div>
				<button type="submit" class="update-btn">Save Changes</button>
			</form>

			<% } else if (view.equals("listings")) { %>
			<div class="market-header">
				<h2>Market Activity</h2>
				<div class="market-tabs">
					<button class="tab-btn active" onclick="toggleTab('selling')">My
						Listings</button>
					<button class="tab-btn" onclick="toggleTab('bought')">Purchased</button>
				</div>
			</div>

			<div id="selling-box">
				<% if(myUploads == null || myUploads.isEmpty()) { %>
				<p style="text-align: center; padding: 50px; color: #ccc;">No
					items listed.</p>
				<% } else { 
                        for(UsedProduct p : myUploads) { %>
				<div class="activity-card">
					<img
						src="${pageContext.request.contextPath}/assets/images/products/<%= p.getImage() %>"
						onerror="this.src='https://placehold.co/100x100?text=Product'">
					<div class="card-info">
						<h4><%= p.getProductName() %></h4>
						<span class="card-price">🪙 <%= p.getCoinPrice() %></span>
					</div>
					<span class="status-pill <%= p.isSold() ? "sold" : "live" %>">
						<%= p.isSold() ? "Sold" : "Live" %>
					</span>
				</div>
				<% } } %>
			</div>

			<div id="bought-box" style="display: none;">
				<% if(myPurchases == null || myPurchases.isEmpty()) { %>
				<p style="text-align: center; padding: 50px; color: #ccc;">No
					purchases found.</p>
				<% } else { 
                        for(UsedProduct p : myPurchases) { %>
				<div class="activity-card">
					<img
						src="${pageContext.request.contextPath}/assets/images/products/<%= p.getImage() %>"
						onerror="this.src='https://placehold.co/100x100?text=Product'">
					<div class="card-info">
						<h4><%= p.getProductName() %></h4>
						<span class="card-price">🪙 <%= p.getCoinPrice() %></span>
					</div>
					<span class="status-pill sold">Purchased</span>
				</div>
				<% } } %>
			</div>
			<% } %>

		</main>
	</div>

	<script>
        function toggleTab(type) {
            document.getElementById('selling-box').style.display = (type === 'selling') ? 'block' : 'none';
            document.getElementById('bought-box').style.display = (type === 'bought') ? 'block' : 'none';
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            event.currentTarget.classList.add('active');
        }
    </script>

</body>
</html>