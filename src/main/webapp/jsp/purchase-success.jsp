<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exchange Successful | FashionHub</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    
    <style>
        body {
            background-color: #fcfcfc;
            font-family: 'Inter', sans-serif;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .success-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 20px;
        }
        .success-card {
            background: white;
            padding: 60px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            max-width: 500px;
            width: 100%;
        }
        .icon-circle {
            width: 80px;
            height: 80px;
            background: #f0fdf4;
            color: #16a34a;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            margin: 0 auto 20px;
        }
        h1 {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            margin-bottom: 10px;
            color: #1a1a1a;
        }
        p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .btn {
            padding: 12px 24px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: 0.3s;
        }
        .btn-primary {
            background: #000;
            color: #fff;
        }
        .btn-secondary {
            background: #f3f4f6;
            color: #374151;
        }
        .btn:hover {
            opacity: 0.8;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <jsp:include page="../components/navbar.jsp" />

    <div class="success-container">
        <div class="success-card">
            <div class="icon-circle">✓</div>
            <h1>Exchange Successful!</h1>
            <p>Your pre-loved item has been secured. The coins have been deducted from your wallet, and your order is being processed.</p>
            
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/jsp/my-orders.jsp" class="btn btn-primary">View My Orders</a>
                <a href="${pageContext.request.contextPath}/jsp/used-market.jsp" class="btn btn-secondary">Back to Market</a>
            </div>
        </div>
    </div>

</body>
</html>