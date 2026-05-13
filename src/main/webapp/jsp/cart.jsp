<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.fashionhub.model.*, com.fashionhub.dao.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Bag | FashionHub</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css?v=2">

   
</head>

<body>

<jsp:include page="../components/navbar.jsp" />

<%
    User user = (User) session.getAttribute("loggedUser");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    CartDAO dao = new CartDAO();
    List<Cart> list = dao.getCartByUser(user.getUserId());
    double subtotal = 0;
%>

<main class="cart-wrapper">

    <% if(list == null || list.isEmpty()) { %>
        <div class="empty-state">
            <h2 style="font-family: 'Playfair Display'; font-size: 40px;">Your bag is empty</h2>
            <p style="color: #666; margin-bottom: 30px;">Let's find something special for you.</p>
            <a href="products.jsp" class="checkout-btn" style="display:inline-block; padding: 15px 40px;">Shop New Arrivals</a>
        </div>
    <% } else { %>
        
        <div class="cart-items-list">
            <% for(Cart c : list) { 
                subtotal += c.getPrice() * c.getQuantity();
            %>
            <div class="cart-card">
                <div class="img-box">
                    <img src="<%= c.getImage().startsWith("http") ? c.getImage() : request.getContextPath() + "/assets/images/products/" + c.getImage() %>" alt="product">
                </div>
                
                <div class="item-details">
                    <h3 class="item-name"><%= c.getProductName() %></h3>
                    <p class="item-price">₹ <%= String.format("%,d", (int)c.getPrice()) %></p>
                    
                    <div style="display: flex; align-items: center;">
                        <div class="qty-control">
                            <a href="${pageContext.request.contextPath}/updateCart?cartId=<%= c.getCartId() %>&action=decrease" class="qty-btn">-</a>
                            <span class="qty-val"><%= c.getQuantity() %></span>
                            <a href="${pageContext.request.contextPath}/updateCart?cartId=<%= c.getCartId() %>&action=increase" class="qty-btn">+</a>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/removeCartItem?cartId=<%= c.getCartId() %>" class="remove-link">Remove</a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <aside class="order-summary">
            <h2 style="margin-top: 0; font-size: 20px;">Summary</h2>
            <div class="summary-row">
                <span>Subtotal</span>
                <span>₹ <%= String.format("%,.2f", subtotal) %></span>
            </div>
            <div class="summary-row">
                <span>Shipping</span>
                <span style="color: #27ae60;">FREE</span>
            </div>
            <div class="summary-row summary-total">
                <span>Total</span>
                <span>₹ <%= String.format("%,.2f", subtotal) %></span>
            </div>
            
            <a href="checkout.jsp" class="checkout-btn">PROCEED TO CHECKOUT</a>
            
            <div style="margin-top: 20px; display: flex; gap: 10px; justify-content: center;">
                <img src="https://cdn-icons-png.flaticon.com/128/349/349221.png" width="30" alt="visa">
                <img src="https://cdn-icons-png.flaticon.com/128/349/349228.png" width="30" alt="mastercard">
                <img src="https://cdn-icons-png.flaticon.com/128/196/196565.png" width="30" alt="paypal">
            </div>
        </aside>

    <% } %>
</main>

<jsp:include page="../components/footer.jsp" />

</body>
</html>