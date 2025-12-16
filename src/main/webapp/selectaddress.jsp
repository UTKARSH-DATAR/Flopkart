<%@page import="model.Address"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Address</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
body {
    font-family: roboto, Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
}
.address-container {
    max-width: 900px;
    margin: auto;
    padding: 20px;
}
h2 {
    margin-bottom: 25px;
    font-size: 26px;
    color: #222;
    font-weight: 600;
    text-align: center;
}
.address-card {
    background: #fff;
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 20px;
}
.address-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 14px rgba(0,0,0,0.15);
}
.address-details p {
    margin: 4px 0;
    font-size: 15px;
    color: #444;
}
.action-buttons {
    flex-shrink: 0;
    display: flex;
    align-items: flex-start;
}
.action-buttons button {
    background-color: #111;
    border: none;
    padding: 12px 20px;
    border-radius: 6px;
    color: #fff;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
    font-size: 14px;
}
.action-buttons button:hover {
    background-color: #333;
    transform: scale(1.05);
}
.add-btn {
    display: block;
    margin: 35px auto 0;
    background-color: #111;
    border: none;
    padding: 14px 24px;
    border-radius: 8px;
    color: #fff;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
    font-size: 16px;
}
.add-btn:hover {
    background-color: #333;
    transform: scale(1.02);
}
.no-address {
    text-align: center;
    font-size: 18px;
    color: #777;
    margin-top: 50px;
}
@media (max-width: 768px) {
    .address-card {
        flex-direction: column;
        align-items: stretch;
    }
    .action-buttons {
        margin-top: 15px;
        width: 100%;
    }
    .action-buttons button {
        width: 100%;
        text-align: center;
    }
}
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="address-container">
<%
    List<Address> addresses = (List<Address>) session.getAttribute("addresses");
    if (addresses == null || addresses.isEmpty()) {
%>
    <p class="no-address">No Saved Addresses</p>
<%
    } else {
%>
    <h2>Select an Address</h2>
    <% for (Address address : addresses) { %>
        <div class="address-card">
            <div class="address-details">
                <p><%= address.getLine1() %></p>
                <p><%= address.getLine2() %></p>
                <p><%= address.getCity() %>, <%= address.getState() %></p>
                <p><%= address.getPincode() %></p>
            </div>
            <div class="action-buttons">
                <form action="Address" method="post">
                    <input type="hidden" name="action" value="select">
                    <input type="hidden" name="addressId" value="<%= address.getId() %>">
                    <button type="submit" title="select">Deliver to this address</button>
                </form>
            </div>
        </div>
    <% } %>
<%
    }
%>
    <button class="add-btn" onclick="location.href='addaddress.jsp?source=selectaddress.jsp'">
        + Add New Address
    </button>
</div>
</body>
</html>