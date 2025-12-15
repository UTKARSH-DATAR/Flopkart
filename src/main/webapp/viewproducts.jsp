<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List, model.Product"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>
<style>
body {
	font-family: roboto, Arial, sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
	padding-top: 60px;
}

.container {
	width: 90%;
	margin: 20px auto;
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 20px;
}

.product-card {
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	padding: 15px;
	cursor: pointer;
	text-align: center;
	transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.product-card img {
	width: 200px;
	height: 200px;
	object-fit: cover;
	border-radius: 6px;
	margin-bottom: 10px;
	transition: transform 0.3s ease;
}

.product-card:hover img {
    transform: scale(1.05);
}

.product-card h3 {
	margin: 10px 0;
	font-size: 18px;
	color: #333;
}

.product-card p {
	margin: 5px 0;
	color: #666;
}

.btn {
	display: inline-block;
	padding: 8px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background 0.3s;
}

.btn svg {
	width: 20px;
	height: 20px; fill : #fff;
	vertical-align: middle;
	fill: #fff;
}

.btn-edit {
	background-color: #007bff;
	color: #fff;
}

.btn-edit:hover {
	background-color: #0056b3;
}

.btn-delete {
	background-color: #dc3545;
	color: #fff;
}

.btn-delete:hover {
	background-color: #a71d2a;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>

	<div class="container">
		<%
		List<Product> products = (List<Product>) session.getAttribute("products");
		if (products != null) {
			for (Product p : products) {
		%>
		<div class="product-card" onclick="window.location.href='ProductDetails?productId=<%=p.getId()%>'">
			<img src="<%=p.getImgurl()%>" alt="<%=p.getName()%>">
			<h3><%=p.getName()%></h3>
			<p>
				Price: ₹<%=p.getPrice()%></p>
				<p>Quantity: <%= p.getQuantity() %></p>

			<form action="EditProduct" method="post" style="display: inline;">
				<input type="hidden" name="productId" value="<%=p.getId()%>" />
				<button type="submit" class="btn btn-edit" title="Edit">
					<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path
							d="M16.293 2.293a1 1 0 0 1 1.414 0l4 4a1 1 0 0 1 0 1.414l-13 13A1 1 0 0 1 8 21H4a1 1 0 0 1-1-1v-4a1 1 0 0 1 .293-.707l10-10 3-3zM14 7.414l-9 9V19h2.586l9-9L14 7.414zm4 1.172L19.586 7 17 4.414 15.414 6 18 8.586z" />
                    </svg>
				</button>
			</form>

			<form action="DeleteProduct" method="post" style="display: inline;">
				<input type="hidden" name="productId" value="<%=p.getId()%>" />
				<button type="submit" class="btn btn-delete" title="Delete">
					<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path
							d="M7 4a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v2h4a1 1 0 1 1 0 2h-1.069l-.867 12.142A2 2 0 0 1 17.069 22H6.93a2 2 0 0 1-1.995-1.858L4.07 8H3a1 1 0 0 1 0-2h4V4zm2 2h6V4H9v2zM6.074 8l.857 12H17.07l.857-12H6.074zM10 10a1 1 0 0 1 1 1v6a1 1 0 1 1-2 0v-6a1 1 0 0 1 1-1zm4 0a1 1 0 0 1 1 1v6a1 1 0 1 1-2 0v-6a1 1 0 0 1 1-1z" />
                    </svg>
				</button>
			</form>
		</div>
		<%
		}
		}
		%>
	</div>
</body>
</html>