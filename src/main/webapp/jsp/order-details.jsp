<%@ page import="java.util.*" %>
<%@ page import="com.fashionhub.dao.OrderDAO" %>
<%@ page import="com.fashionhub.model.Cart" %>

<%
    int orderId = Integer.parseInt(request.getParameter("orderId"));

    OrderDAO dao = new OrderDAO();
    List<Cart> list = dao.getOrderItems(orderId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">

<style>

.container {
    width: 80%;
    margin: 40px auto;
}

.item {
    display: flex;
    gap: 20px;
    background: white;
    padding: 15px;
    margin-bottom: 15px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

.item img {
    width: 100%;
    max-width: 420px;
    height: 500px;
    object-fit: cover;
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
}

</style>

</head>

<body>

<jsp:include page="../components/navbar.jsp" />


<div class="container">

<%
    for(Cart c : list){
%>

<div class="item">

    <img src="<%= c.getImage() %>">
    
    <div>
        <h3><%= c.getProductName() %></h3>
        <p>Quantity: <%= c.getQuantity() %></p>
        <p>Price: ₹ <%= c.getPrice() %></p>
    </div>

</div>

<%
    }
%>

</div>
<jsp:include page="../components/footer.jsp" />

</body>
</html>