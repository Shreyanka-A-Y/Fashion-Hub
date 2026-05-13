<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.fashionhub.dao.ProductDAO"%>
<%@ page import="com.fashionhub.model.Product"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Details | FashionHub</title>

<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@700&display=swap"
	rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-details.css?v=2">


</head>
<body>

	<jsp:include page="../components/navbar.jsp" />

	<%
    // Data Fetching Logic
		String idParam = request.getParameter("id");
		
		if(idParam == null){
		
		    response.sendRedirect(
		        request.getContextPath()
		        + "/jsp/products.jsp");
		
		    return;
		}
		
		int productId = Integer.parseInt(idParam);
		
		ProductDAO dao = new ProductDAO();
		
		Product p = dao.getProductById(productId);
		
		if(p == null){
		
		    response.getWriter().println("Product Not Found");
		
		    return;
		}
	%>

	<main class="container">
		<div class="product-grid">

			<div class="image-container">
				<%
        // --- IMAGE LOGIC FIX ---
        String dbImage = p.getImage();
        String finalImageUrl = "";
        
        if (dbImage == null || dbImage.isEmpty()) {
            finalImageUrl = "https://placehold.co/600x800?text=No+Image+Available";
        } else if (dbImage.startsWith("http")) {
            finalImageUrl = dbImage; // External Link
        } else if (dbImage.startsWith("assets/")) {
            finalImageUrl = request.getContextPath() + "/" + dbImage; // Path from webapp root
        } else {
            // Just a filename - look in your specific products folder
            finalImageUrl = request.getContextPath() + "/assets/images/products/" + dbImage;
        }
    %>
				<img src="<%= finalImageUrl %>" class="product-image"
					alt="<%= p.getProductName() %>"
					onerror="this.onerror=null;this.src='https://placehold.co/600x800?text=Product+Image+Not+Found';">
			</div>


			<div class="product-details">
				<span class="brand-tag"><%= p.getBrand() %></span>
				<h1 class="product-title"><%= p.getProductName() %></h1>
				<span class="price-tag">₹ <%= String.format("%,d", (int)p.getPrice()) %></span>

				<div class="divider"></div>

				<h3 class="description-heading">Overview</h3>
				<p class="description-text">
					<%= p.getDescription() %>
				</p>

				<div class="stock-indicator">
					<span class="stock-dot"></span> <span>In Stock: <strong><%= p.getStock() %>
							units</strong> available
					</span>
				</div>

				<a
					href="${pageContext.request.contextPath}/addToCart?productId=<%= p.getProductId() %>"
					class="add-to-cart-btn"> Add to Bag </a>

				<p
					style="text-align: center; font-size: 12px; color: #999; margin-top: 15px;">
					Free Shipping on orders over ₹499</p>
			</div>

		</div>
	</main>

	<jsp:include page="../components/footer.jsp" />

</body>
</html>