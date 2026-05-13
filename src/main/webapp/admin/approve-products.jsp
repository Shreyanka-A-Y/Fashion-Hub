<%@ page import="java.util.*" %>
<%@ page import="com.fashionhub.dao.UsedProductDAO" %>
<%@ page import="com.fashionhub.model.UsedProduct" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Approve Used Products</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css">

<style>

.container {
    width: 80%;
    margin: 40px auto;
}

.card {
    background: white;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

.btn {
    padding: 8px 15px;
    text-decoration: none;
    border-radius: 5px;
    color: white;
}

.approve {
    background: green;
}

.reject {
    background: red;
}

</style>

</head>

<body>

<div class="container">

<h1>Pending Used Products</h1>

<%
    UsedProductDAO dao = new UsedProductDAO();
    List<UsedProduct> list = dao.getPendingProducts();
%>

<%
    if(list.isEmpty()){
%>
    <p>No pending products</p>
<%
    } else {

        for(UsedProduct p : list){
%>

<div class="card">

    <h3><%= p.getProductName() %></h3>

    <p><%= p.getDescription() %></p>

    <br>

    <a class="btn approve"
       href="${pageContext.request.contextPath}/approveProduct?usedId=<%= p.getUsedId() %>">
        Approve
    </a>

    <a class="btn reject"
       href="${pageContext.request.contextPath}/rejectProduct?usedId=<%= p.getUsedId() %>">
        Reject
    </a>

</div>

<%
        }
    }
%>

</div>

</body>
</html>