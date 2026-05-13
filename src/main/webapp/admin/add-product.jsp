<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Add Product</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/navbar.css">

</head>

<body>

<jsp:include page="../components/navbar.jsp" />


<div class="container"
     style="padding:50px 0;">

    <div style="
        width:500px;
        margin:auto;
        background:white;
        padding:30px;
        border-radius:10px;
    ">

        <h2 style="
            margin-bottom:20px;
            text-align:center;
        ">
            Add Product
        </h2>


        <form action="${pageContext.request.contextPath}/addProduct"
              method="post">


            <input type="number"
                   name="categoryId"
                   placeholder="Category ID"
                   required
                   style="width:100%;
                          padding:12px;
                          margin-bottom:15px;">


            <input type="text"
                   name="productName"
                   placeholder="Product Name"
                   required
                   style="width:100%;
                          padding:12px;
                          margin-bottom:15px;">


            <input type="text"
                   name="brand"
                   placeholder="Brand"
                   required
                   style="width:100%;
                          padding:12px;
                          margin-bottom:15px;">


            <textarea name="description"
                      placeholder="Description"
                      style="width:100%;
                             padding:12px;
                             margin-bottom:15px;"></textarea>


            <input type="number"
                   step="0.01"
                   name="price"
                   placeholder="Price"
                   required
                   style="width:100%;
                          padding:12px;
                          margin-bottom:15px;">


            <input type="number"
                   name="stock"
                   placeholder="Stock"
                   required
                   style="width:100%;
                          padding:12px;
                          margin-bottom:15px;">


            <input type="text"
                   name="image"
                   placeholder="Image Filename"
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
                    ">

                Add Product

            </button>

        </form>

    </div>

</div>

</body>
</html>
