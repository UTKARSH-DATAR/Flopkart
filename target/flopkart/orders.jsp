<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders</title>
<style>
    body {
        font-family: roboto, Arial, sans-serif;
        background-color: #f5f5f5;
    }
    .orders-container {
        max-width: 1000px;
        margin: auto;
        padding: 20px;
    }
    .order-card {
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        margin-bottom: 20px;
        padding: 15px;
        transition: transform 0.2s ease;
    }
    .order-card:hover {
        transform: translateY(-3px);
    }
    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #eee;
        padding-bottom: 10px;
        margin-bottom: 15px;
    }
    .order-number {
        font-weight: bold;
        font-size: 18px;
        color: #333;
    }

    .order-status {
        font-size: 13px;
        font-weight: bold;
        padding: 6px 12px;
        border-radius: 20px;
        text-transform: uppercase;
        display: inline-block;
    }
    .order-status.Placed {
        background-color: #e7f1ff;
        color: #0056b3;
        border: 1px solid #b3d4ff;
    }
    .order-status.Cancelled {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    .order-status.Delivered {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    .order-status.Shipped {
        background-color: #fff3cd;
        color: #856404;
        border: 1px solid #ffeeba;
    }
    .order-details {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 10px;
        font-size: 14px;
        color: #555;
    }
    .order-actions {
        margin-top: 15px;
        text-align: right;
    }
    .view-btn, .cancel-btn {
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        transition: background 0.2s ease;
        margin-left: 8px; 
    }
    .view-btn {
        background: #111;
        color: #fff;
    }
    .view-btn:hover {
        background: #333;
    }
    .cancel-btn {
        background: #dc3545;
        color: #fff;
    }
    .cancel-btn:hover {
        background: #a71d2a;
    }
</style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="orders-container">
        <h2>My Orders</h2>
        <%
            List<Order> orders = (List<Order>) session.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
                for (Order order : orders) {
        %>
            <div class="order-card">
                <div class="order-header">
                    <div class="order-number">Order #<%= order.getOrderNumber() %></div>
                    <div class="order-status <%= order.getStatus() %>"><%= order.getStatus() %></div>
                </div>
                <div class="order-details">
                    <div><strong>Total:</strong> ₹<%= order.getTotalAmount() %></div>
                    <div><strong>Date:</strong> <%= order.getOrderDate() %></div>
                    <div><strong>Items:</strong> <%= order.getItems().size() %></div>
                </div>
                <div class="order-actions">
                    <% if(order.getStatus().equals("Placed")){ %>
                        <form action="Order" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="status" value="Cancelled">
                            <input type="hidden" name="source" value="orders.jsp">
                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                            <input type="submit" class="cancel-btn" value="Cancel Order">
                        </form>
                    <% } %>
                    <form action="ViewOrder" method="get" style="display:inline;">
                        <input type="hidden" name="orderId" value="<%= order.getId() %>">
                        <input type="submit" class="view-btn" value="View Order">
                    </form>
                </div>
            </div>
        <% 
                }
            } else { 
        %>
            <p>No orders found.</p>
        <% } %>
    </div>
</body>
</html>