<%@page import="model.Product, model.CartItem, java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flopkart - Product Details</title>
<style>
    body {
        font-family: roboto, Arial, sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding-top: 80px;
    }
    .product-container {
        display: flex;
        flex-wrap: wrap;
        max-width: 1200px;
        margin: auto;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        padding: 30px;
        gap: 40px;
    }
    .product-image {
        flex: 1;
        text-align: center;
    }
    .product-image img {
        max-width: 100%;
        max-height: 450px;
        border-radius: 5px;
        object-fit: contain;
        transition: transform 0.3s ease;
    }
    .product-image img:hover {
        transform: scale(1.05);
    }
    .product-details {
        flex: 1.2;
        display: flex;
        flex-direction: column;
    }
    .product-details h2 {
        margin: 0;
        font-size: 32px;
        color: #222;
        font-weight: 600;
    }
    .price-section {
        margin: 20px 0;
    }
    .price {
        font-size: 28px;
        font-weight: bold;
        color: #e53935;
    }
    .old-price {
        font-size: 18px;
        color: #888;
        text-decoration: line-through;
        margin-left: 12px;
    }
    .offer-badge {
        display: inline-block;
        background-color: #ffcc00;
        color: #333;
        font-size: 14px;
        font-weight: bold;
        padding: 4px 10px;
        border-radius: 6px;
        margin-left: 12px;
    }
    .description {
        font-size: 16px;
        color: #444;
        line-height: 1.6;
        margin: 25px 0;
    }
    .stock-alert {
        color: #d32f2f;
        font-size: 14px;
        font-weight: bold;
        margin-top: 10px;
        background-color: #ffebee;
        padding: 8px 12px;
        border-radius: 6px;
        display: inline-block;
    }
    .btn-cart {
        display: inline-block;
        padding: 14px 24px;
        background-color: #111;
        color: #fff;
        font-weight: bold;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        text-decoration: none;
        transition: background-color 0.3s ease, transform 0.2s ease;
        font-size: 16px;
        margin-top: 20px;
    }
    .btn-cart:hover {
        background-color: #333;
        transform: scale(1.02);
    }
    .cart-controls {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-top: 20px;
    }
    .btn-round {
        width: 42px;
        height: 42px;
        border-radius: 50%;
        border: none;
        background-color: #111;
        color: #fff;
        font-size: 22px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.2s ease, transform 0.2s ease;
    }
    .btn-round:hover {
        background-color: #333;
        transform: scale(1.1);
    }
    .quantity {
        font-size: 20px;
        font-weight: bold;
        color: #333;
        min-width: 30px;
        text-align: center;
    }
</style>
</head>
<body style="margin-top: 20px;">
    <%@ include file="header.jsp" %>
    <%
        Product product = (Product) request.getAttribute("product");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        CartItem matchedItem = null;
        if (cart != null) {
            for (CartItem item : cart) {
                if (item.getProduct().getId() == product.getId()) {
                    matchedItem = item;
                    break;
                }
            }
        }
        String username = (String) session.getAttribute("username");
    %>
    <div class="product-container">
        <div class="product-image">
            <img src="<%=product.getImgurl()%>" alt="<%=product.getName()%>">
        </div>
        <div class="product-details">
            <h2><%=product.getName()%></h2>
            <div class="price-section">
                <span class="price">₹<%=product.getPrice()%></span>
                <span class="old-price">₹<%= String.format("%.2f", product.getPrice() * 1.2) %></span>
                <span class="offer-badge">20% OFF</span>
            </div>
            <div class="description">
                <%=product.getDescription()%>
            </div>
            <% if(product.getQuantity() <= 5) { %>
                <div class="stock-alert">
                	<% if(product.getQuantity()==0){ %>
                    	Out of stock!
                    <% } else { %>
                    	Only <%=product.getQuantity()%> left in stock!
                    <% } %>
                </div>
            <% } %>
            <%
                if (username == null) {
                    if (matchedItem == null) {
            %>
                        <form action="Cart" method="post">
                            <input type="hidden" name="productId" value="<%=product.getId()%>">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="source" value="ProductDetails?productId=<%=product.getId()%>">
                            <button type="submit" class="btn-cart">Add to Cart</button>
                        </form>
            <%
                    } else {
            %>
                        <div class="cart-controls">
                            <form action="Cart" method="post" style="display:inline;">
                                <input type="hidden" name="productId" value="<%=product.getId()%>">
                                <input type="hidden" name="action" value="decrease">
                                <input type="hidden" name="source" value="ProductDetails?productId=<%=product.getId()%>">
                                <button type="submit" class="btn-round">-</button>
                            </form>
                            <span class="quantity"><%=matchedItem.getQuantity()%></span>
                            <form action="Cart" method="post" style="display:inline;">
                                <input type="hidden" name="productId" value="<%=product.getId()%>">
                                <input type="hidden" name="action" value="increase">
                                <input type="hidden" name="source" value="ProductDetails?productId=<%=product.getId()%>">
                                <button type="submit" class="btn-round">+</button>
                            </form>
                        </div>
            <%
                    }
                } else if (!"utkarsh_datar".equals(username)) {
                    if (matchedItem == null) {
            %>
                        <form action="Cart" method="post">
                            <input type="hidden" name="productId" value="<%=product.getId()%>">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="source" value="ProductDetails?productId=<%=product.getId()%>">
                            <button type="submit" class="btn-cart">Add to Cart</button>
                        </form>
            <%
                    } else {
            %>
                        <div class="cart-controls">
                            <form action="Cart" method="post" style="display:inline;">
                                <input type="hidden" name="productId" value="<%=product.getId()%>">
                                <input type="hidden" name="action" value="decrease">
                                <input type="hidden" name="source" value="ProductDetails?productId=<%=product.getId()%>">
                                <button type="submit" class="btn-round">-</button>
                            </form>
                            <span class="quantity"><%=matchedItem.getQuantity()%></span>
                            <form action="Cart" method="post" style="display:inline;">
                                <input type="hidden" name="productId" value="<%=product.getId()%>">
                                <input type="hidden" name="action" value="increase">
                                <input type="hidden" name="source" value="ProductDetails?productId=<%=product.getId()%>">
                                <button type="submit" class="btn-round">+</button>
                            </form>
                        </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</body>
</html>