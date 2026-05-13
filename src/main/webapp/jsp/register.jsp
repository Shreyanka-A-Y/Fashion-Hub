<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Register | FashionHub</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">


</head>

<body>


    <!-- Navbar -->
    <jsp:include page="../components/navbar.jsp" />


    <div class="container"
         style="padding: 50px 0;">

        <div style="
            width: 400px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        ">

            <h2 style="
                text-align:center;
                margin-bottom:20px;
            ">
                Create Account
            </h2>


            <form action="${pageContext.request.contextPath}/register"
                  method="post">


                <input type="text"
                       name="fullName"
                       placeholder="Full Name"
                       required
                       style="width:100%;
                              padding:12px;
                              margin-bottom:15px;">


                <input type="email"
                       name="email"
                       placeholder="Email"
                       required
                       style="width:100%;
                              padding:12px;
                              margin-bottom:15px;">


                <input type="password"
                       name="password"
                       placeholder="Password"
                       required
                       style="width:100%;
                              padding:12px;
                              margin-bottom:15px;">


                <input type="text"
                       name="phone"
                       placeholder="Phone Number"
                       required
                       style="width:100%;
                              padding:12px;
                              margin-bottom:15px;">


                <button type="submit"
                        style="
                        width:100%;
                        padding:12px;
                        background:black;
                        color:white;
                        border:none;
                        cursor:pointer;
                        font-size:16px;
                        ">

                    Register

                </button>

            </form>


            <p style="
                margin-top:15px;
                text-align:center;
            ">

                Already have an account?

                <a href="login.jsp">
                    Login
                </a>

            </p>

        </div>

    </div>


    <!-- Footer -->
    <jsp:include page="../components/footer.jsp" />


</body>
</html>