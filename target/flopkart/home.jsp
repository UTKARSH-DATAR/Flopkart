<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.List, model.Product, model.CartItem"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flopkart</title>

<style type="text/css">
body {
    font-family: roboto, Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
}

.container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
    padding: 20px;
    max-width: 1200px;
    margin: auto;
}

.product-card {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    padding: 15px;
    text-align: center;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    cursor: pointer;
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    overflow: hidden;
}

.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.product-card img {
    position: relative;
    z-index: 1;
    width: 100%;
    aspect-ratio: 1 / 1;
    object-fit: cover;
    margin-bottom: 10px;
    border-radius: 6px;
    transition: transform 0.3s ease;
}

.product-card:hover img {
    transform: scale(1.05);
}

.product-card h3 {
    margin: 10px 0 5px;
    font-size: 16px;
    font-weight: 600;
    color: #222;
    line-height: 1.4;
    display: -webkit-box;
    -webkit-line-clamp: 2; 
    -webkit-box-orient: vertical;
    overflow: hidden;
    min-height: 44px;
}

.product-card p {
    margin: 5px 0;
    color: #555;
    font-size: 13px;
    display: -webkit-box;
    -webkit-line-clamp: 2; 
    -webkit-box-orient: vertical;
    overflow: hidden;
    min-height: 36px;
}

.price-section {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    margin: 10px 0;
}

.price {
    font-size: 20px;
    font-weight: bold;
    color: #d32f2f;
}

.old-price {
    font-size: 14px;
    color: #888;
    text-decoration: line-through;
}

.offer-badge {
    display: inline-block;
    background-color: #ffcc00;
    color: #333;
    font-size: 12px;
    font-weight: bold;
    padding: 2px 6px;
    border-radius: 4px;
}

.stock-badge {
    position: absolute;
    top: 10px;
    right: 10px;
    background: #d32f2f;
    color: #fff;
    font-size: 12px;
    font-weight: bold;
    padding: 4px 6px;
    border-radius: 4px;
    z-index: 2;
}

.btn-cart {
    display: inline-block;
    margin-top: 10px;
    padding: 10px 15px;
    background-color: #111;
    color: #fff;
    font-weight: bold;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-decoration: none;
    transition: background-color 0.2s ease, transform 0.2s ease;
    width: 100%;
}

.btn-cart:hover {
    background-color: #333;
    transform: scale(1.02);
}

.cart-controls {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    margin-top: 10px;
}

.btn-round {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    border: none;
    background-color: #111;
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.2s ease, transform 0.2s ease;
}

.btn-round:hover {
    background-color: #333;
    transform: scale(1.05);
}

.quantity {
    font-size: 16px;
    font-weight: bold;
    color: #333;
    min-width: 20px;
    text-align: center;
}
</style>
</head>
<body>
    <%@ include file="header.jsp"%>

    <%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    %>

    <div class="container">
        <%
        if (products != null && !products.isEmpty()) {
            for (Product product : products) {
                CartItem matchedItem = null;
                if (cart != null) {
                    for (CartItem item : cart) {
                        if (item.getProduct().getId() == product.getId()) {
                            matchedItem = item;
                            break;
                        }
                    }
                }
        %>
        <div class="product-card" onclick="window.location.href='ProductDetails?productId=<%=product.getId()%>'">
            <% if(product.getQuantity() <= 5) { %>
                <div class="stock-badge">
                    <%= product.getQuantity()==0 ? "Out of stock" : "Only " + product.getQuantity() + " left!" %>
                </div>
            <% } %>
            <img src="<%=product.getImgurl()%>" alt="<%=product.getName()%>">
            <h3><%=product.getName()%></h3>

            <p>
                <%= product.getDescription().length() > 50 
                    ? product.getDescription().substring(0, 50) + "..." 
                    : product.getDescription() %>
            </p>

            <div class="price-section">
                <span class="price">₹<%=product.getPrice()%></span>
                <span class="old-price">₹<%= String.format("%.2f", product.getPrice() * 1.2) %></span>
                <span class="offer-badge">20% OFF</span>
            </div>

            <% if (matchedItem == null) { %>
                <form action="Cart" method="post">
                    <input type="hidden" name="productId" value="<%=product.getId()%>">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="source" value="home">
                    <button type="submit" class="btn-cart">Add to Cart</button>
                </form>
            <% } else { %>
                <div class="cart-controls">
                    <form action="Cart" method="post" style="display: inline;">
                        <input type="hidden" name="productId" value="<%=matchedItem.getProduct().getId()%>">
                        <input type="hidden" name="action" value="decrease">
                        <input type="hidden" name="source" value="home">
                        <button type="submit" class="btn-round">-</button>
                    </form>

                    <span class="quantity"><%=matchedItem.getQuantity()%></span>

                    <form action="Cart" method="post" style="display: inline;">
                        <input type="hidden" name="productId" value="<%=matchedItem.getProduct().getId()%>">
                        <input type="hidden" name="action" value="increase">
                        <input type="hidden" name="source" value="home">
                        <button type="submit" class="btn-round">+</button>
                    </form>
                </div>
            <% } %>
        </div>
        <% 
            }
        } else { 
        %>
        <p style="text-align: center; font-size: 18px; color: #666;">No products available.</p>
        <% } %>
    </div>
</body>
</html>