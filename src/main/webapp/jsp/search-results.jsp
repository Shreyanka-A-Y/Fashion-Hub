<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.fashionhub.model.Product" %>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">


<jsp:include page="../components/navbar.jsp" />

<%

@SuppressWarnings("unchecked")

List<Product> list =
(List<Product>) request.getAttribute("products");

String keyword =
(String) request.getAttribute("keyword");

%>

<div style="width:90%; margin:40px auto;">

<h1>

	Search Results for "<%= keyword %>"

</h1>

<%

if(list == null || list.isEmpty()){

%>

<p>

	No products found.

</p>

<%

} else {

%>

<div style="
display:grid;
grid-template-columns:repeat(auto-fit, minmax(250px,1fr));
gap:20px;
margin-top:30px;
">

<%

for(Product p : list){

%>

<div style="
background:white;
padding:15px;
border-radius:10px;
box-shadow:0 0 10px rgba(0,0,0,0.1);
">

<img
src="${pageContext.request.contextPath}/assets/images/products/<%= p.getImage() %>"

style="
width:100%;
height:250px;
object-fit:cover;
border-radius:10px;
">

<h3>

	<%= p.getProductName() %>

</h3>

<p>

	<%= p.getBrand() %>

</p>

<h4>
    ₹ <%= String.format("%,d", (int)p.getPrice()) %>
</h4>

<a

href="${pageContext.request.contextPath}/jsp/product-details.jsp?id=<%= p.getProductId() %>"

style="
display:inline-block;
margin-top:10px;
background:black;
color:white;
padding:10px 15px;
text-decoration:none;
border-radius:5px;
">

	View Product

</a>

</div>

<%
}
%>

</div>

<%
}
%>

</div>

<jsp:include page="../components/footer.jsp" />