<%@ page import="java.util.*" %>
<%@ page import="com.fashionhub.model.User" %>
<%@ page import="com.fashionhub.dao.UserDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Wallet</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/navbar.css">

<style>

.wallet-container {
    width: 85%;
    margin: 40px auto;
}

.balance-card {
    background: linear-gradient(135deg, #000, #444);
    color: gold;
    padding: 30px;
    border-radius: 15px;
    margin-bottom: 30px;
}

.balance-card h1 {
    font-size: 40px;
}

.txn-table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 10px;
    overflow: hidden;
}

.txn-table th, .txn-table td {
    padding: 15px;
    text-align: center;
}

.txn-table th {
    background: black;
    color: white;
}

.credit {
    color: green;
    font-weight: bold;
}

.debit {
    color: red;
    font-weight: bold;
}

</style>

</head>

<body>

<jsp:include page="../components/navbar.jsp" />

<%
    User user = (User) session.getAttribute("loggedUser");

    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    UserDAO dao = new UserDAO();

    List<String[]> txns = dao.getWalletTransactions(user.getUserId());
%>

<div class="wallet-container">

    <!-- BALANCE -->
    <div class="balance-card">
        <h2>Your Coin Balance</h2>
        <h1>&#128176; <%= user.getCoins() %></h1>
    </div>

    <!-- TRANSACTIONS -->
    <h2>Transaction History</h2>

    <table class="txn-table">

        <tr>
            <th>Coins</th>
            <th>Type</th>
            <th>Reason</th>
            <th>Date</th>
        </tr>

        <%
            for(String[] t : txns){
        %>

        <tr>
            <td><%= t[0] %></td>

            <td class="<%= t[1].equals("CREDIT") ? "credit" : "debit" %>">
                <%= t[1] %>
            </td>

            <td><%= t[2] %></td>

            <td><%= t[3] %></td>
        </tr>

        <%
            }
        %>

    </table>

</div>

</body>
</html>