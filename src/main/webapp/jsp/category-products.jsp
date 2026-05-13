<%@ page import="java.util.*"%>
<%@ page import="com.fashionhub.model.Product"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Category Products | FashionHub</title>

<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:ital,wght@0,700;1,400&display=swap" rel="stylesheet">

<link rel="stylesheet"href="${pageContext.request.contextPath}/assets/css/style.css?v=2">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/category-product.css?v=2">


</head>

<body>

<jsp:include page="../components/navbar.jsp" />

<div class="shop-wrapper">

<%

    List<Product> list =
            (List<Product>) request.getAttribute("products");

    if(list == null || list.isEmpty()) {

%>

    <div class="empty-state">

        <h1>No Products Found</h1>

        <p>
            Please check back later for new arrivals.
        </p>

        <a href="${pageContext.request.contextPath}/jsp/index.jsp"
           style="
           color: var(--lux-gold);
           text-decoration:none;
           font-weight:bold;
           ">

            Back To Home

        </a>

    </div>

<%

    } else {

%>

    <header class="editorial-header">

        <div>

            <span class="collection-count">

                FashionHub Collection

            </span>

            <h1>

                Selected Pieces

            </h1>

        </div>

        <div class="collection-count">

            <%= list.size() %> Products

        </div>

    </header>

    <div class="editorial-grid">

<%

    for(Product p : list) {

%>

        <a href="${pageContext.request.contextPath}/jsp/product-details.jsp?id=<%= p.getProductId() %>"
           class="lux-card">

            <div class="image-wrap">

                <img src="<%= p.getImage() %>"
                     alt="<%= p.getProductName() %>">

                <div class="view-indicator">

                    →

                </div>

            </div>

            <div class="card-content">

                <span class="brand-label">

                    <%= p.getBrand() %>

                </span>

                <h3 class="item-title">

                    <%= p.getProductName() %>

                </h3>

                <span class="item-price">

                    &#8377;
                    <%= String.format("%,d", (int)p.getPrice()) %>

                </span>

            </div>

        </a>

<%

    }

%>

    </div>

<%

    }

%>

</div>

<jsp:include page="../components/footer.jsp" />

</body>
</html>