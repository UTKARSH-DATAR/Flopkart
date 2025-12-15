<%@page import="model.Address"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Address</title>
<style>
    body {
        margin-top: 60px;
        font-family: roboto, Arial, sans-serif;
        background-color: #f9f9f9;
    }
    .container {
        max-width: 600px;
        margin: 0 auto;
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    h1 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
        margin-top: 0;
    }
    label {
        font-weight: bold;
        color: #555;
        display: block;
        margin-bottom: 5px;
    }
    input[type="text"] {
        width: 96%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
        transition: border-color 0.3s ease;
    }
    input[type="text"]:focus {
        border-color: #007bff;
        outline: none;
    }
    .submit-btn {
        width: 100%;
        padding: 12px;
        background: #28a745;
        color: #fff;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        cursor: pointer;
        transition: background 0.3s ease;
    }
    .submit-btn:hover {
        background: #218838;
    }
</style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <% Address address = (Address) request.getAttribute("address"); %>
    
    <div class="container">
        <h1>Edit Address</h1>
        <form action="Address" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="addressId" value="<%= address.getId() %>">

            <label for="line1">Address Line 1</label>
            <input type="text" id="line1" name="line1" value="<%= address.getLine1() %>" required>

            <label for="line2">Address Line 2</label>
            <input type="text" id="line2" name="line2" value="<%= address.getLine2() %>" required>

            <label for="city">City</label>
            <input type="text" id="city" name="city" value="<%= address.getCity() %>" required>

            <label for="state">State</label>
            <input type="text" id="state" name="state" value="<%= address.getState() %>" required>

            <label for="pincode">Pincode</label>
            <input type="text" id="pincode" name="pincode" value="<%= address.getPincode() %>" required>

            <button type="submit" class="submit-btn">save changes</button>
        </form>
    </div>
</body>
</html>