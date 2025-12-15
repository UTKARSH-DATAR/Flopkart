<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Product"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product</title>
<style>
body {
	font-family: roboto, Arial, sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding-top: 60px;
}

.form-container {
	max-width: 600px;
	margin: 30px auto;
	background: #fff;
	padding: 25px;
	border-radius: 8px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

label {
	display: block;
	font-weight: bold;
	margin-top: 15px;
	color: #444;
}

input[type="text"], input[type="number"], textarea, input[type="file"] {
	width: 100%;
	padding: 8px;
	margin-top: 6px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

textarea {
	resize: vertical;
	min-height: 80px;
}

img {
	display: block;
	margin: 10px 0;
	max-width: 200px;
	border-radius: 6px;
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.2);
}

.btn-submit {
	display: block;
	width: 100%;
	padding: 10px;
	margin-top: 20px;
	background-color: #007bff;
	border: none;
	border-radius: 4px;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	transition: background 0.3s ease;
}

.btn-submit:hover {
	background-color: #0056b3;
}

.btn-cancel {
	display: block;
	width: 100%;
	padding: 10px;
	margin-top: 20px;
	background-color: red;
	border: none;
	border-radius: 4px;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	transition: background 0.3s ease;
}

.btn-cancel:hover {
	background-color: darkred;
}

a {
	text-decoration: none;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>

	<div class="form-container">
		<form action="UploadAndForward" method="post"
			enctype="multipart/form-data">
			<h1>Edit Product</h1>

			<%
			Product product = (Product) request.getAttribute("product");
			%>

			<input type="hidden" name="action" value="edit" /> 
			<input type="hidden" name="productId" value="<%=product.getId()%>" />
				
			<label for="productName">Product Name:</label> 
			<input type="text" id="productName" name="productName" value="<%=product.getName()%>" required /> 
				
			<label for="productDescription">Product Description:</label>
			<textarea id="productDescription" name="productDescription" required><%=product.getDescription()%></textarea>

			<label for="price">Price:</label> 
			<input type="number" id="price" name="price" value="<%=product.getPrice()%>" required />

			<label for="quantity">Quantity:</label> 
			<input type="number" id="quantity" name="quantity" value="<%=product.getQuantity()%>" required /> 
				
			<label for="image">Image:</label> 
			<img src="<%=product.getImgurl()%>" alt="<%=product.getName()%>"> 
				
			<input type="file" id="productImage" name="productImage" accept="image/*" /> 
			<input type="hidden" name="existingImage" value="<%=product.getImgurl()%>" />
				
			<input type="submit" class="btn-submit" value="Update Product" />
		</form>
		
		<a href="viewproducts.jsp">
			<button class=btn-cancel>Cancel</button>
		</a>
	</div>
</body>
</html>