<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">


<jsp:include page="../components/navbar.jsp" />

<h2 style="text-align:center; margin-top:20px;">Add Product</h2>

<form action="${pageContext.request.contextPath}/addProduct"
      method="post"
      enctype="multipart/form-data"
      style="width:400px; margin:30px auto; background:white; padding:20px; border-radius:10px;">

    <input type="number" name="categoryId" placeholder="Category ID" required><br><br>

    <input type="text" name="productName" placeholder="Product Name" required><br><br>

    <input type="text" name="brand" placeholder="Brand"><br><br>

    <textarea name="description" placeholder="Description"></textarea><br><br>

    <input type="number" name="price" placeholder="Price" required><br><br>

    <input type="number" name="stock" placeholder="Stock" required><br><br>

    <!-- 🔥 THIS IS IMAGE UPLOAD -->
    <input type="file" name="image" required><br><br>

    <button type="submit" style="padding:10px 20px; background:black; color:white;">
        Add Product
    </button>

</form>