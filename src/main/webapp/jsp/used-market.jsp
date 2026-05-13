<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.fashionhub.dao.UsedProductDAO, com.fashionhub.model.UsedProduct"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Used Market | FashionHub</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">

    <style>
        :root {
            --accent: #d4af37; /* Gold theme for Used/Premium market */
            --text-main: #1a1a1a;
            --text-muted: #888;
            --bg-body: #fcfcfc;
        }

        body {
            background-color: var(--bg-body);
            font-family: 'Inter', sans-serif;
            color: var(--text-main);
            margin: 0;
        }

        .market-container {
            width: 92%;
            max-width: 1400px;
            margin: 40px auto;
            min-height: 70vh;
        }

        /* Header Section */
        .market-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 40px;
            border-bottom: 1px solid #eee;
            padding-bottom: 25px;
        }

        .market-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            margin: 0;
        }

        .sell-button {
            background: #000;
            color: #fff;
            padding: 14px 28px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .sell-button:hover {
            background: #333;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        /* Product Grid */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 40px;
        }

        /* Card Styling */
        .product-card {
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease;
        }

        .img-wrapper {
            width: 100%;
            aspect-ratio: 3/4;
            background-color: #f0f0f0;
            border-radius: 12px;
            overflow: hidden;
            position: relative;
            margin-bottom: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .product-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.8s ease;
        }

        .product-card:hover img {
            transform: scale(1.08);
        }

        /* Condition Badge */
        .condition-tag {
            position: absolute;
            top: 15px;
            left: 15px;
            background: rgba(255, 255, 255, 0.95);
            padding: 5px 12px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-radius: 4px;
            color: #000;
            z-index: 2;
        }

        .info-group {
            padding: 10px 5px;
        }

        .p-name {
            font-size: 18px;
            font-weight: 600;
            margin: 0 0 8px 0;
            color: var(--text-main);
        }

        .p-price {
            font-size: 20px;
            font-weight: 700;
            color: var(--accent);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .exchange-btn {
            margin-top: 15px;
            border: 1.5px solid #000;
            color: #000;
            text-align: center;
            padding: 12px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.2s ease;
            border-radius: 6px;
        }

        .product-card:hover .exchange-btn {
            background: #000;
            color: #fff;
        }

        .empty-msg {
            grid-column: 1/-1;
            text-align: center;
            padding: 120px 0;
            color: var(--text-muted);
        }

        @media (max-width: 768px) {
            .market-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }
        }
    </style>
</head>

<body>

    <jsp:include page="../components/navbar.jsp" />

    <main class="market-container">
        <header class="market-header">
            <div>
                <h1>Pre-loved Collection</h1>
                <p style="color: var(--text-muted); margin: 8px 0 0 0; font-size: 15px;">
                    Sustainable style, curated by the community.
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/jsp/sell-used-product.jsp" class="sell-button"> 
                + List an Item 
            </a>
        </header>

        <%
            UsedProductDAO dao = new UsedProductDAO();
            List<UsedProduct> list = dao.getApprovedProducts();
        %>

        <div class="products-grid">
            <%
                if(list == null || list.isEmpty()){
            %>
                <div class="empty-msg">
                    <p style="font-size: 18px;">The market is currently quiet.</p>
                    <p>Be the first to list an item and start earning coins!</p>
                </div>
            <%
                } else {
                    for(UsedProduct p : list){
                        String imageName = p.getImage();
                        
                        System.out.println("DEBUG: Server looking for image at: " + application.getRealPath("/assets/images/products/" + imageName));
                        
                        String finalPath = "";

                        if(imageName == null || imageName.trim().isEmpty()){
                            finalPath = "https://placehold.co/400x533?text=No+Image";
                        } else if(imageName.startsWith("http")){
                            finalPath = imageName;
                        } else {
                        	finalPath = request.getContextPath() + "/assets/images/products/" + imageName;
                        }
            %>
                <a href="${pageContext.request.contextPath}/buyUsedProduct?usedId=<%= p.getUsedId() %>" class="product-card">
                    <div class="img-wrapper">
                        <div class="condition-tag"><%= p.getProductCondition() %></div>
                        <img src="<%= finalPath %>" 
                             alt="<%= p.getProductName() %>"
                             loading="lazy"
                             onerror="this.onerror=null;this.src='https://placehold.co/400x533?text=Image+Not+Found';">
                    </div>

                    <div class="info-group">
                        <h3 class="p-name"><%= p.getProductName() %></h3>
                        <div class="p-price">
                            <span style="font-size: 16px;">🪙</span>
                            <%= String.format("%,d", p.getCoinPrice()) %>
                        </div>
                        <div class="exchange-btn">View Offering</div>
                    </div>
                </a>
            <%
                    } // End For Loop
                } // End If/Else
            %>
        </div>
    </main>

    <jsp:include page="../components/footer.jsp" />

</body>
</html>