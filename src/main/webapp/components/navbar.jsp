<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fashionhub.model.User"%>
<%
    User loggedUser = (User) session.getAttribute("loggedUser");
%>

<nav class="navbar">
    <div class="nav-container">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/jsp/index.jsp">Fashion<span>Hub</span></a>
        </div>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/jsp/index.jsp">Home</a> 
            <a href="${pageContext.request.contextPath}/jsp/products.jsp">Shop</a>
            <a href="${pageContext.request.contextPath}/jsp/used-market.jsp">Used Market</a> 
            <a href="${pageContext.request.contextPath}/jsp/my-orders.jsp">Orders</a>
            <a href="${pageContext.request.contextPath}/jsp/cart.jsp">Cart</a>
        </div>

        <div class="nav-right">
            <div class="search-box">
                <form action="${pageContext.request.contextPath}/search" method="get">
                    <input type="text" name="keyword" placeholder="Search...">
                    <button type="submit">Search</button>
                </form>
            </div>

            <div class="user-meta">
                <% if(loggedUser != null) { %>
                    <a href="${pageContext.request.contextPath}/jsp/wallet.jsp" class="coin-badge"> 
                        <%= loggedUser.getCoins() %> 🪙
                    </a>
                    <a href="${pageContext.request.contextPath}/jsp/profile.jsp" class="profile-link">Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="login-btn">Login</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<div class="category-bar">
    <div class="category-container">
        <a href="${pageContext.request.contextPath}/category?catId=1">Men</a>
        <a href="${pageContext.request.contextPath}/category?catId=2">Women</a>
        <a href="${pageContext.request.contextPath}/category?catId=3">Kids</a>
        <a href="${pageContext.request.contextPath}/category?catId=4">Shoes</a>
        <a href="${pageContext.request.contextPath}/category?catId=5">Accessories</a>
        <a href="${pageContext.request.contextPath}/jsp/products.jsp" class="active">All Collections</a>
    </div>
</div>