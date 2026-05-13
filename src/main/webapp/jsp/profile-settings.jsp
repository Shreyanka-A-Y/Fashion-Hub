<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fashionhub.model.User" %>
<% 
    User loggedUser = (User) session.getAttribute("loggedUser"); 
    if (loggedUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile Settings | FashionHub</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    
    <style>
        body {
            background-color: #fcfcfc;
            font-family: 'Inter', sans-serif;
            margin: 0;
        }
        .settings-container {
            width: 90%;
            max-width: 1000px;
            margin: 50px auto;
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 40px;
        }
        /* Sidebar Styles */
        .settings-sidebar {
            background: white;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid #eee;
            height: fit-content;
        }
        .user-avatar {
            width: 80px;
            height: 80px;
            background: #1a1a1a;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 15px;
        }
        .sidebar-menu a {
            display: block;
            padding: 12px 0;
            color: #666;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            border-bottom: 1px solid #f9f9f9;
        }
        .sidebar-menu a.active { color: #000; }

        /* Form Styles */
        .settings-content {
            background: white;
            padding: 40px;
            border-radius: 12px;
            border: 1px solid #eee;
        }
        h1 { font-family: 'Playfair Display', serif; margin-bottom: 30px; }
        
        .form-group { margin-bottom: 20px; }
        label { display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; text-transform: uppercase; }
        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }
        .readonly-field { background: #f9f9f9; color: #888; }
        
        .save-btn {
            background: #000;
            color: #fff;
            padding: 14px 30px;
            border: none;
            border-radius: 4px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
        }
        .coin-box {
            background: #fffcf0;
            border: 1px solid #f9ebad;
            padding: 15px;
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

    <jsp:include page="../components/navbar.jsp" />

    <div class="settings-container">
        <div class="settings-sidebar">
            <div class="user-avatar">
                <%= loggedUser.getFullName().substring(0, 1).toUpperCase() %>
            </div>
            <h3 style="margin: 0 0 5px 0;"><%= loggedUser.getFullName() %></h3>
            <p style="color: #888; font-size: 12px; margin-bottom: 30px;">Member since 2026</p>
            
            <div class="sidebar-menu">
                <a href="#" class="active">Account Details</a>
                <a href="${pageContext.request.contextPath}/jsp/my-orders.jsp">My Orders</a>
                <a href="${pageContext.request.contextPath}/jsp/wallet.jsp">Wallet & Coins</a>
                <a href="${pageContext.request.contextPath}/logout" style="color: #ff5e5e;">Logout</a>
            </div>
        </div>

        <div class="settings-content">
            <h1>Account Settings</h1>
            
            <div class="coin-box">
                <div>
                    <span style="display: block; font-size: 12px; font-weight: 700; color: #856404;">CURRENT BALANCE</span>
                    <span style="font-size: 24px; font-weight: 700; color: #d4af37;">🪙 <%= loggedUser.getCoins() %> Coins</span>
                </div>
                <a href="${pageContext.request.contextPath}/jsp/wallet.jsp" style="color: #000; font-size: 13px; font-weight: 700;">Top Up</a>
            </div>

            <form action="${pageContext.request.contextPath}/updateProfile" method="POST">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" value="<%= loggedUser.getFullName() %>" required>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" class="readonly-field" value="<%= loggedUser.getEmail() %>" readonly>
                    <small style="color: #999;">Email cannot be changed.</small>
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" name="phone" value="<%= loggedUser.getPhone() != null ? loggedUser.getPhone() : "" %>" placeholder="Enter your contact number">
                </div>

                <div class="form-group">
                    <label>Shipping Address</label>
                    <input type="text" name="address" value="<%= loggedUser.getAddress() != null ? loggedUser.getAddress() : "" %>" placeholder="Street, City, Zip Code">
                </div>

                <button type="submit" class="save-btn">Update Profile</button>
            </form>
        </div>
    </div>

</body>
</html>