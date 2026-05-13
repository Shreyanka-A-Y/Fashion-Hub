<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Purchase Failed | FashionHub</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css">

<style>

:root{
    --primary:#111111;
    --danger:#e63946;
    --danger-light:#fff5f5;
    --text:#1a1a1a;
    --muted:#777;
    --border:#eeeeee;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Inter',sans-serif;
    background:#fafafa;
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    padding:30px;
    color:var(--text);
}

.fail-container{
    width:100%;
    max-width:600px;
}

.fail-card{
    background:#fff;
    border-radius:24px;
    padding:50px;
    text-align:center;
    box-shadow:
        0 10px 40px rgba(0,0,0,0.06);
    border:1px solid var(--border);
    position:relative;
    overflow:hidden;
}

.fail-card::before{
    content:'';
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:6px;
    background:linear-gradient(
        90deg,
        #ff4d4d,
        #ff6b6b
    );
}

.fail-icon{
    width:100px;
    height:100px;
    margin:0 auto 30px;
    background:var(--danger-light);
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:48px;
}

.fail-title{
    font-family:'Playfair Display',serif;
    font-size:42px;
    margin-bottom:15px;
    color:var(--primary);
}

.fail-subtitle{
    color:var(--muted);
    font-size:16px;
    line-height:1.7;
    margin-bottom:35px;
}

.reason-box{
    background:#fafafa;
    border:1px solid var(--border);
    border-radius:18px;
    padding:25px;
    margin-bottom:35px;
    text-align:left;
}

.reason-title{
    font-size:15px;
    font-weight:700;
    margin-bottom:18px;
    color:var(--primary);
    text-transform:uppercase;
    letter-spacing:1px;
}

.reason-item{
    display:flex;
    align-items:center;
    gap:12px;
    margin-bottom:14px;
    color:#444;
    font-size:15px;
}

.reason-item:last-child{
    margin-bottom:0;
}

.reason-dot{
    width:10px;
    height:10px;
    background:var(--danger);
    border-radius:50%;
    flex-shrink:0;
}

.action-buttons{
    display:flex;
    gap:15px;
    justify-content:center;
    flex-wrap:wrap;
}

.btn{
    padding:14px 28px;
    border-radius:12px;
    text-decoration:none;
    font-weight:600;
    font-size:14px;
    transition:all 0.3s ease;
}

.btn-primary{
    background:var(--primary);
    color:#fff;
}

.btn-primary:hover{
    transform:translateY(-2px);
    box-shadow:0 8px 20px rgba(0,0,0,0.12);
}

.btn-secondary{
    border:1.5px solid var(--border);
    color:var(--primary);
    background:#fff;
}

.btn-secondary:hover{
    background:#f5f5f5;
}

@media(max-width:768px){

    .fail-card{
        padding:35px 25px;
    }

    .fail-title{
        font-size:34px;
    }

    .action-buttons{
        flex-direction:column;
    }

    .btn{
        width:100%;
    }
}

</style>

</head>

<body>

<div class="fail-container">

    <div class="fail-card">

        <div class="fail-icon">
            ❌
        </div>

        <h1 class="fail-title">
            Purchase Failed
        </h1>

        <p class="fail-subtitle">
            We couldn't complete your purchase request at this time.
            Please review the possible reasons below and try again.
        </p>

        <div class="reason-box">

            <div class="reason-title">
                Possible Reasons
            </div>

            <div class="reason-item">
                <div class="reason-dot"></div>
                <span>Insufficient coin balance in your wallet</span>
            </div>

            <div class="reason-item">
                <div class="reason-dot"></div>
                <span>This product has already been purchased</span>
            </div>

            <div class="reason-item">
                <div class="reason-dot"></div>
                <span>The selected product no longer exists</span>
            </div>

        </div>

        <div class="action-buttons">

            <a href="${pageContext.request.contextPath}/jsp/used-market.jsp"
               class="btn btn-primary">

               Back To Marketplace

            </a>

            <a href="javascript:history.back()"
               class="btn btn-secondary">

               Try Again

            </a>

        </div>

    </div>

</div>

</body>

</html>