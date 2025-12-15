<%@page import="model.User"%>
<%@page import="model.CartItem"%>
<%@page import="java.util.List"%>
<%@page import="model.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>
<style>
    body {
        margin-top: 60px;
        font-family: roboto, Arial, sans-serif;
        background-color: #f5f5f5;
    }
    .order-container {
        max-width: 1000px;
        margin: auto;
        background: #fff;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    h1, h2, h3 {
        margin: 10px 0;
        color: #333;
    }
    .status-badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: bold;
        color: #fff;
    }
    .status-badge.Delivered { background: #28a745; }
    .status-badge.Shipped { background: #ffc107; }
    .status-badge.Placed { background: #e7f1ff; color:#333; }
    .status-badge.Cancelled { background: #dc3545; }
    .order-details {
        margin: 20px 0;
        line-height: 1.6;
        font-size: 15px;
        color: #555;
    }
    .cart-container {
        margin-top: 30px;
    }
    .cart-item {
        display: flex;
        align-items: center;
        background: #fafafa;
        border: 1px solid #eee;
        border-radius: 6px;
        padding: 15px;
        margin-bottom: 15px;
        transition: transform 0.2s ease;
    }
    .cart-item:hover {
        transform: translateY(-3px);
    }
    .cart-item img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 6px;
        margin-right: 20px;
    }
    .item-details {
        flex: 1;
    }
    .item-details h3 {
        margin: 0;
        font-size: 16px;
        color: #333;
    }
    .item-details p {
        margin: 5px 0;
        font-size: 14px;
        color: #666;
    }
    .item-price {
        font-size: 16px;
        font-weight: bold;
        color: #333;
    }
    .grand-total {
        text-align: right;
        font-size: 18px;
        font-weight: bold;
        margin-top: 20px;
        color: #333;
    }

    .success-banner {
        background: #28a745;
        color: #fff;
        padding: 12px;
        text-align: center;
        font-size: 16px;
        font-weight: bold;
        border-radius: 6px;
        margin-bottom: 20px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.15);
        animation: fadeIn 0.8s ease-in-out;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .bottom-actions {
        text-align: center;
        margin-top: 30px;
    }
    .keep-shopping-btn {
        display: inline-block;
        background: #111;
        color: #fff;
        padding: 12px 28px;
        border-radius: 30px;
        font-size: 16px;
        font-weight: bold;
        text-decoration: none;
        border: none;
        cursor: pointer;
        transition: background 0.3s ease, transform 0.2s ease;
    }
    .keep-shopping-btn:hover {
        background: #333;
        transform: translateY(-2px);
    }
</style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <% Order order = (Order) request.getAttribute("order"); %>
    <% User u = (User) request.getAttribute("user"); %>

    <div class="order-container">
        <% if((boolean) request.getAttribute("newOrder")) { %>
            <div class="success-banner">
                🎉 Order placed successfully! Your items will be shipped soon.
            </div>
        <% } %>

        <h1>Order #<%= order.getOrderNumber() %></h1>
        <span class="status-badge <%= order.getStatus()%>">
            <%= order.getStatus() %>
        </span>

        <div class="order-details">
            <p><strong>Customer:</strong> <%= u.getName() %></p>
            <p><strong>Contact:</strong> <%= u.getContact() %></p>
            <p><strong>Order Date:</strong> <%= order.getOrderDate() %></p>
            <p><strong>Delivery Address:</strong><br>
                <%= order.getAddress().getLine1() %><br>
                <%= order.getAddress().getLine2() %><br>
                <%= order.getAddress().getCity() %>, <%= order.getAddress().getState() %><br>
                <%= order.getAddress().getPincode() %>
            </p>
            <p><strong>Payment Method:</strong> Card ending in ****<%= order.getCardNumber().substring(order.getCardNumber().length()-4) %></p>
        </div>

        <div class="cart-container">
            <h3>Ordered Items</h3>
            <%
                List<CartItem> items = order.getItems();
                for (CartItem item : items) {
                    double total = item.getProduct().getPrice() * item.getQuantity();
            %>
            <div class="cart-item" onclick="window.location.href='ProductDetails?productId=<%=item.getProduct().getId()%>'">
                <img src="<%=item.getProduct().getImgurl()%>" alt="<%=item.getProduct().getName()%>">
                <div class="item-details">
                    <h3><%= item.getProduct().getName() %></h3>
                    <p>Price: ₹<%= String.format("%.2f", item.getProduct().getPrice()) %></p>
                    <p>Quantity: <%= item.getQuantity() %></p>
                </div>
                <div class="item-price">
                    ₹<%= String.format("%.2f", total) %>
                </div>
            </div>
            <% } %>
        </div>

        <div class="grand-total">
            Grand Total: ₹<%= order.getTotalAmount() %>
        </div>

        <% if((boolean) request.getAttribute("newOrder")) { %>
            <div class="bottom-actions">
                <form action="<%=request.getContextPath()%>/home" method="get">
                    <button type="submit" class="keep-shopping-btn">🛒 Keep Shopping</button>
                </form>
            </div>
        <% } %>
    </div>
</body>
</html>