<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | FashionHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body class="login-body">

<div class="login-card">
    <div style="text-align: center; margin-bottom: 30px;">
        <h2 style="font-size: 24px; font-weight: 800;">FashionHub<span style="color: #6366f1;">Admin</span></h2>
        <p style="color: #64748b; font-size: 14px; margin-top: 5px;">Secure Dashboard Access</p>
    </div>

    <form action="${pageContext.request.contextPath}/adminLogin" method="POST">
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" class="form-control" placeholder="admin_user" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" placeholder="••••••••" required>
        </div>
        <button type="submit" class="btn-submit">Sign In</button>
    </form>
</div>

</body>
</html>