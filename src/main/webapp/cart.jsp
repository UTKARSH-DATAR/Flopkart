<%@page import="model.CartItem"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
<style>
body {
    font-family: roboto, Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
}

h1 {
    text-align: center;
    margin-bottom: 25px;
    color: #222;
    font-size: 28px;
    font-weight: 600;
}

.cart-container {
    max-width: 1000px;
    margin: auto;
    padding: 20px;
    box-sizing: border-box;
}

/* Grid layout for cart items */
.cart-item {
    display: grid;
    grid-template-columns: 90px 1fr 100px; /* image | details | price */
    gap: 16px;
    align-items: center;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 18px;
    padding: 14px;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    cursor: pointer;
}

.cart-item:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 14px rgba(0,0,0,0.15);
}

.cart-item img {
    width: 90px;              /* ✅ slightly bigger thumbnail */
    height: 90px;
    object-fit: cover;
    border-radius: 6px;
    border: 1px solid #eee;
}

/* Details column */
.item-details {
    min-width: 0;
}

.item-details h3 {
    margin: 0;
    font-size: 16px;
    color: #222;
    font-weight: 600;
    line-height: 1.3;
}

.item-details p {
    margin: 4px 0;
    color: #666;
    font-size: 13px;
}

/* Quantity controls */
.cart-controls {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-top: 8px;
    flex-wrap: wrap;
}

.btn-round {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    border: none;
    background-color: #111;
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.2s ease, transform 0.2s ease;
}

.btn-round:hover {
    background-color: #333;
    transform: scale(1.05);
}

.quantity {
    font-size: 14px;
    font-weight: bold;
    color: #333;
    min-width: 22px;
    text-align: center;
}

.delete-btn {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
    margin-left: 6px;
    transition: transform 0.2s ease;
}

.delete-btn svg {
    width: 18px;
    height: 18px;
    fill: #888;
    transition: fill 0.2s ease, transform 0.2s ease;
}

.delete-btn:hover svg {
    fill: #e53935;
    transform: scale(1.1);
}

/* Price column */
.item-price {
    text-align: right;
    font-weight: bold;
    color: #111;
    font-size: 15px;
    white-space: nowrap;
}

/* Totals + CTA */
.grand-total {
    text-align: right;
    font-size: 18px;
    font-weight: bold;
    margin-top: 20px;
    color: #222;
}

.order-btn {
    display: block;
    width: 100%;
    padding: 14px;
    margin-top: 25px;
    background-color: #111;
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    text-align: center;
    transition: background-color 0.3s ease, transform 0.2s ease;
    box-sizing: border-box;
}

.order-btn:hover {
    background-color: #333;
    transform: scale(1.02);
}

/* 📱 Mobile adjustments */
@media (max-width: 768px) {
    .cart-item {
        grid-template-columns: 90px 1fr; /* image | details */
    }
    .cart-item img {
        width: 80px;
        height: 80px;
    }
    .item-price {
        grid-column: 1 / -1;   /* ✅ move price below details */
        text-align: left;
        margin-top: 8px;
        font-size: 14px;
    }
}
</style>

</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="cart-container">
        <h1>Your Shopping Cart</h1>
        <%
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            double grandTotal = 0;
            if (cart != null && !cart.isEmpty()) {
                for (CartItem item : cart) {
                    double total = item.getProduct().getPrice() * item.getQuantity();
                    grandTotal += total;
        %>
        <div class="cart-item" onclick="window.location.href='ProductDetails?productId=<%=item.getProduct().getId()%>'">
            <img src="<%=item.getProduct().getImgurl()%>" alt="<%=item.getProduct().getName()%>">
            <div class="item-details">
                <h3><%= item.getProduct().getName() %></h3>
                <p>Price: ₹<%= String.format("%.2f", item.getProduct().getPrice()) %></p>

                <div class="cart-controls">
                    <form action="Cart" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%=item.getProduct().getId()%>">
                        <input type="hidden" name="action" value="decrease">
                        <input type="hidden" name="source" value="cart.jsp">
                        <button type="submit" class="btn-round">-</button>
                    </form>

                    <span class="quantity"><%= item.getQuantity() %></span>

                    <form action="Cart" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%=item.getProduct().getId()%>">
                        <input type="hidden" name="action" value="increase">
                        <input type="hidden" name="source" value="cart.jsp">
                        <button type="submit" class="btn-round">+</button>
                    </form>

                    <form action="Cart" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%=item.getProduct().getId()%>">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="source" value="cart.jsp">
                        <button type="submit" class="delete-btn" title="Remove Item">
                            <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M7 4a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v2h4a1 1 0 1 1 0 2h-1.069l-.867 12.142A2 2 0 0 1 17.069 22H6.93a2 2 0 0 1-1.995-1.858L4.07 8H3a1 1 0 0 1 0-2h4V4zm2 2h6V4H9v2zM6.074 8l.857 12H17.07l.857-12H6.074zM10 10a1 1 0 0 1 1 1v6a1 1 0 1 1-2 0v-6a1 1 0 0 1 1-1zm4 0a1 1 0 0 1 1 1v6a1 1 0 1 1-2 0v-6a1 1 0 0 1 1-1z" />
                            </svg>
                        </button>
                    </form>
                </div>
            </div>
            <div class="item-price">
                ₹<%= String.format("%.2f", total) %>
            </div>
        </div>
        <% 
                }
            } else { 
        %>
        <p style="text-align:center; font-size:16px; color:#666;">Your cart is empty.</p>
        <% } %>

        <div class="grand-total">
            Grand Total: ₹<%= String.format("%.2f", grandTotal) %>
        </div>

        <% if (cart != null && !cart.isEmpty()) { %>
        <form action="selectaddress.jsp" method="post">
            <button type="submit" class="order-btn">Order Now</button>
        </form>
        <% } %>
    </div>
</body>
</html>