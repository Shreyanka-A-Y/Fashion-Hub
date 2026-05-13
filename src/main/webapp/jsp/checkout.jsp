<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.fashionhub.model.Cart" %>
<%@ page import="com.fashionhub.model.User" %>
<%@ page import="com.fashionhub.dao.CartDAO" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Checkout</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/checkout.css?v=2">


</head>

<body>


<jsp:include page="../components/navbar.jsp" />


<%

    User user =
            (User) session.getAttribute("loggedUser");

    if(user == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    CartDAO dao =
            new CartDAO();

    List<Cart> list =
            dao.getCartByUser(user.getUserId());

    double total = 0;

    for(Cart c : list) {

        total +=
                c.getPrice()
                * c.getQuantity();
    }

%>


<div class="checkout-container">


<h1>
    Checkout
</h1>


<form action="${pageContext.request.contextPath}/placeOrder"
      method="post">


    <label>
        Shipping Address
    </label>

    <textarea name="address"
              required
              style="
              width:100%;
              height:120px;
              margin-top:10px;
              padding:10px;
              "></textarea>


    <br><br>


    <label>
        Payment Method
    </label>


    <select name="paymentMode"
            style="
            width:100%;
            padding:12px;
            margin-top:10px;
            ">

        <option>
            Cash On Delivery
        </option>

        <option>
            UPI
        </option>

        <option>
            Card
        </option>

    </select>


    <h2 style="margin-top:30px;">

        Total Amount:
        ₹ <%= String.format("%,.0f", total) %>

    </h2>


    <button class="checkout-btn"
            type="submit">

        Place Order

    </button>

</form>


</div>


</body>
</html>