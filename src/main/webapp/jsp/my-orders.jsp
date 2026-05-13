<%@ page import="java.util.*" %>
<%@ page import="com.fashionhub.model.User" %>
<%@ page import="com.fashionhub.dao.OrderDAO" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Order History | FashionHub</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:ital,wght@0,700;1,400&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">

<style>

:root {

    --lux-black:#1a1a1a;

    --lux-gold:#c5a059;

    --soft-grey:#f8f9fa;

    --border-color:#e5e7eb;
}

body {

    background-color:var(--soft-grey);

    font-family:'Inter', sans-serif;

    color:var(--lux-black);

    margin:0;
}

.order-history-wrapper {

    max-width:1000px;

    margin:60px auto;

    padding:0 20px;
}

.header-section {

    margin-bottom:50px;

    text-align:center;
}

.header-section h1 {

    font-family:'Playfair Display', serif;

    font-size:2.5rem;

    margin-bottom:10px;
}

.header-section p {

    color:#666;

    letter-spacing:1px;

    text-transform:uppercase;

    font-size:0.8rem;
}

.order-row {

    background:#fff;

    border:1px solid var(--border-color);

    border-radius:12px;

    margin-bottom:25px;

    overflow:hidden;

    transition:0.3s;
}

.order-row:hover {

    transform:translateY(-4px);

    box-shadow:0 12px 24px rgba(0,0,0,0.05);
}

.order-header {

    padding:20px 30px;

    border-bottom:1px solid var(--border-color);

    display:flex;

    justify-content:space-between;

    align-items:center;

    background:#fafafa;
}

.order-id {

    font-weight:700;

    color:#888;
}

.order-date {

    color:#444;

    font-size:14px;
}

.order-body {

    padding:30px;

    display:grid;

    grid-template-columns:2fr 1fr 1fr 1.5fr;

    align-items:center;

    gap:20px;
}

.amount-section {

    font-size:1.3rem;

    font-weight:700;
}

.payment-method {

    font-size:13px;

    background:#eee;

    padding:5px 14px;

    border-radius:30px;
}

.status-badge {

    font-size:12px;

    font-weight:bold;

    padding:6px 16px;

    border-radius:30px;

    text-transform:uppercase;
}

.status-delivered {

    background:#dcfce7;

    color:#166534;
}

.status-pending {

    background:#fef9c3;

    color:#854d0e;
}

.status-cancelled {

    background:#fee2e2;

    color:#991b1b;
}

.action-buttons {

    display:flex;

    gap:12px;

    justify-content:flex-end;

    align-items:center;
}

.view-btn {

    text-decoration:none;

    color:black;

    font-weight:600;

    font-size:14px;
}

.view-btn:hover {

    color:var(--lux-gold);
}

.cancel-btn {

    background:#dc2626;

    color:white;

    padding:10px 16px;

    border-radius:6px;

    text-decoration:none;

    font-size:13px;

    font-weight:600;
}

.cancel-btn:hover {

    opacity:0.9;
}

.empty-orders {

    background:white;

    padding:100px 20px;

    border-radius:20px;

    text-align:center;
}

.shop-btn {

    display:inline-block;

    margin-top:20px;

    background:black;

    color:white;

    padding:14px 22px;

    border-radius:6px;

    text-decoration:none;
}

@media(max-width:900px){

    .order-body{

        grid-template-columns:1fr;

        text-align:center;
    }

    .action-buttons{

        justify-content:center;
    }
}

</style>

</head>

<body>

<jsp:include page="../components/navbar.jsp" />

<%

    User user =
            (User) session.getAttribute("loggedUser");

    if(user == null){

        response.sendRedirect("login.jsp");

        return;
    }

    OrderDAO dao =
            new OrderDAO();

    List<String[]> list =
            dao.getUserOrders(user.getUserId());

%>

<main class="order-history-wrapper">

    <div class="header-section">

        <p>Account Dashboard</p>

        <h1>My Order History</h1>

    </div>

<%

if(list == null || list.isEmpty()){

%>

    <div class="empty-orders">

        <h2 style="font-family:'Playfair Display';">

            No orders yet

        </h2>

        <p>

            Your wardrobe is waiting for its first luxury piece.

        </p>

        <a href="${pageContext.request.contextPath}/jsp/products.jsp"
           class="shop-btn">

            Start Shopping

        </a>

    </div>

<%

} else {

    for(String[] o : list){

        String status =
                o[3].toLowerCase();

        String statusClass =
                "status-pending";

        if(status.contains("delivered")){

            statusClass =
                    "status-delivered";
        }

        else if(status.contains("cancel")){

            statusClass =
                    "status-cancelled";
        }

%>

    <div class="order-row">

        <div class="order-header">

            <span class="order-id">

                ORDER #<%= o[0] %>

            </span>

            <span class="order-date">

                <%= o[4] %>

            </span>

        </div>


        <div class="order-body">

            <div class="amount-section">

                &#8377; <%= String.format("%,.0f", Double.parseDouble(o[1])) %>

            </div>


            <div>

                <span class="payment-method">

                    <%= o[2] %>

                </span>

            </div>


            <div>

                <span class="status-badge <%= statusClass %>">

                    <%= o[3] %>

                </span>

            </div>


            <div class="action-buttons">

                <a href="${pageContext.request.contextPath}/jsp/order-details.jsp?orderId=<%= o[0] %>"
                   class="view-btn">

                    View Details

                </a>


                <% if(!o[3].equalsIgnoreCase("CANCELLED")) { %>

                    <a href="${pageContext.request.contextPath}/cancelOrder?orderId=<%= o[0] %>"
                       class="cancel-btn"
                       onclick="return confirm('Cancel this order?')">

                        Cancel

                    </a>

                <% } %>

            </div>

        </div>

    </div>

<%

    }

}

%>

</main>

<jsp:include page="../components/footer.jsp" />

</body>
</html>