<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.fashionhub.dao.ProductDAO, com.fashionhub.model.Product"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Latest Collection | FashionHub</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">
    
    <style>
        :root {
            --lux-black: #1a1a1a;
            --muted-grey: #757575;
            --bg-soft: #fcfcfc;
            --border: #eeeeee;
        }

        body {
            background-color: #fff;
            font-family: 'Inter', sans-serif;
            color: var(--lux-black);
            margin: 0;
        }

        .page-header {
            text-align: center;
            padding: 60px 20px;
        }

        .page-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            margin: 0;
        }

        .products-grid {
            max-width: 1300px;
            margin: 0 auto 100px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 40px;
            padding: 0 20px;
        }

        .product-card {
            text-decoration: none;
            color: inherit;
            display: block;
            transition: transform 0.4s ease;
        }

        /* THE IMAGE FIX CONTAINER */
        .image-box {
            position: relative;
            width: 100%;
            aspect-ratio: 4 / 5; /* Professional fashion ratio */
            background-color: #f5f5f5;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
            border: 1px solid var(--border);
        }

        .image-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            transition: transform 0.6s cubic-bezier(0.165, 0.84, 0.44, 1);
        }

        .product-card:hover img {
            transform: scale(1.06);
        }

        .info-panel {
            text-align: center;
        }

        .brand-name {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: var(--muted-grey);
            margin-bottom: 8px;
        }

        .product-name {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .price-tag {
            font-size: 1.1rem;
            font-weight: 400;
            color: var(--lux-black);
        }

        /* Hover Overlay */
        .view-cta {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.95);
            padding: 15px;
            text-align: center;
            font-weight: 700;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            transform: translateY(100%);
            transition: transform 0.3s ease;
        }

        .product-card:hover .view-cta {
            transform: translateY(0);
        }
    </style>
</head>
<body>

<jsp:include page="../components/navbar.jsp" />

<header class="page-header">
    <h1>The Modern Edit</h1>
    <p style="letter-spacing: 4px; text-transform: uppercase; font-size: 0.7rem; color: #999; margin-top: 10px;">
        Explore Our Latest Arrivals
    </p>
</header>

<main class="products-grid">
<%
    ProductDAO dao = new ProductDAO();
    List<Product> list = dao.getAllProducts();
    
    for(Product p : list) {
        // --- IMAGE LOGIC FIX ---
        String dbImage = p.getImage();
        String finalImageUrl = "";
        
        if (dbImage == null || dbImage.isEmpty()) {
            finalImageUrl = "https://placehold.co/400x500?text=No+Image";
        } else if (dbImage.startsWith("http")) {
            finalImageUrl = dbImage; // It's an external link
        } else if (dbImage.startsWith("assets/")) {
            finalImageUrl = request.getContextPath() + "/" + dbImage; // Path starts with assets
        } else {
            finalImageUrl = request.getContextPath() + "/assets/images/products/" + dbImage; // Just a filename
        }
%>
    <a href="${pageContext.request.contextPath}/jsp/product-details.jsp?id=<%= p.getProductId() %>" class="product-card">
        <div class="image-box">
            <img src="<%= finalImageUrl %>" 
                 alt="<%= p.getProductName() %>"
                 onerror="this.onerror=null;this.src='https://placehold.co/400x500?text=Image+Not+Found';">
            <div class="view-cta">View Details</div>
        </div>
        
        <div class="info-panel">
            <div class="brand-name"><%= p.getBrand() %></div>
            <div class="product-name"><%= p.getProductName() %></div>
            <div class="price-tag">₹<%= String.format("%,d", (int)p.getPrice()) %></div>
        </div>
    </a>
<%
    }
%>
</main>

<jsp:include page="../components/footer.jsp" />

</body>
</html>