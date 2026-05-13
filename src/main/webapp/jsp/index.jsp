<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionHub - Premium Fashion Marketplace</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
</head>
<body>

    <jsp:include page="../components/navbar.jsp" />

    <main class="main-content">
        <section class="hero">
            <div class="hero-overlay"></div>
            <div class="hero-content">
                <h1>Define Your Style</h1>
                <p>Discover premium fashion, shop trending outfits, and trade used styles using reward coins.</p>
                <div class="hero-buttons">
                    <a href="${pageContext.request.contextPath}/jsp/products.jsp" class="btn-primary">Shop Now</a>
                    <a href="${pageContext.request.contextPath}/jsp/used-market.jsp" class="btn-secondary">Used Market</a>
                </div>
            </div>
        </section>

        <section class="features">
            <div class="feature-card">
                <h3>🛍 Premium Fashion</h3>
                <p>Explore curated fashion collections from top brands.</p>
            </div>
            <div class="feature-card">
                <h3>♻️ Trade and Earn</h3>
                <p>Sell used fashion and earn coins for shopping.</p>
            </div>
            <div class="feature-card">
                <h3>💎 Exclusive Deals</h3>
                <p>Unlock special discounts using your reward coins.</p>
            </div>
        </section>
    </main>

    <jsp:include page="../components/footer.jsp" />

</body>
</html>