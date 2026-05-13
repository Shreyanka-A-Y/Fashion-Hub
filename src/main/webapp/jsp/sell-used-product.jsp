<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Sell Used Product</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=2">

<style>

.form-container {

    width: 50%;

    margin: 10px auto;

    background: white;

    padding: 30px;

    border-radius: 10px;

    box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
}


.form-group {

    margin-bottom: 20px;
}


.form-group input,
.form-group textarea,
.form-group select {

    width: 100%;

    padding: 12px;
}

.submit-btn {

    background: black;

    color: white;

    padding: 14px 20px;

    border: none;

    cursor: pointer;
}

</style>

</head>

<body>


<jsp:include page="../components/navbar.jsp" />


<div class="form-container">


<h1>
    Sell Used Product
</h1>


<form action="${pageContext.request.contextPath}/sellUsedProduct"
      method="post"
      enctype="multipart/form-data">


<div class="form-group">

    <input type="text"
           name="productName"
           placeholder="Product Name"
           required>

</div>

<div class="form-group">

    <select name="categoryId" required>
    <option value="">Select Category</option>
    <option value="1">Men</option>
    <option value="2">Women</option>
    <option value="3">Kids</option>
    <option value="4">Shoes</option>
    <option value="5">Accessories</option>
	</select>

</div>


<div class="form-group">

    <textarea name="description"
              placeholder="Description"
              required></textarea>

</div>


<div class="form-group">

    <select name="condition">

        <option>
            Excellent
        </option>

        <option>
            Good
        </option>

        <option>
            Fair
        </option>

    </select>

</div>


<div class="form-group">

    <input type="number"
           name="coinPrice"
           placeholder="Coin Price"
           required>

</div>


<div class="form-group">

    <input type="file" name="image" required>

</div>


<button class="submit-btn"
        type="submit">

    Upload Product

</button>


</form>

	<jsp:include page="../components/footer.jsp" />
</div>


</body>
</html>