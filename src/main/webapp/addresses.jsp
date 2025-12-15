<%@page import="model.Address"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Saved Addresses</title>
<style>
    body {
        font-family: roboto, Arial, sans-serif;
        background-color: #f9f9f9;
    }
    .address-container {
        max-width: 800px;
        margin: 0 auto;
    }
    .address-card {
        background: #fff;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 15px 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .address-details p {
        margin: 2px 0;
        color: #333;
    }
    .action-buttons {
        display: flex;
        gap: 10px;
        margin-top: 10px;
    }
    .icon-button {
        background: none;
        border: none;
        cursor: pointer;
        padding: 5px;
        transition: transform 0.2s ease;
    }
    .icon-button:hover {
        transform: scale(1.1);
    }
    .icon-button svg {
        width: 20px;
        height: 20px;
        fill: #555;
    }
    .icon-button.edit svg {
        fill: #007bff; /* blue for edit */
    }
    .icon-button.delete svg {
        fill: #dc3545; /* red for delete */
    }
    .add-btn {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background: #111;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: background 0.3s ease;
    }
    .add-btn:hover {
        background: #333;
    }
</style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="address-container">
        <h2>Saved Addresses</h2>
        <%
            List<Address> addresses = (List<Address>) session.getAttribute("addresses");
            if (addresses == null || addresses.isEmpty()) {
        %>
            <p>No Saved Addresses</p>
        <%
            } else {
                for (Address address : addresses) {
        %>
            <div class="address-card">
                <div class="address-details">
                    <p><%= address.getLine1() %></p>
                    <p><%= address.getLine2() %></p>
                    <p><%= address.getCity() %>, <%= address.getState() %></p>
                    <p><%= address.getPincode() %></p>
                </div>
                <div class="action-buttons">
                    <form action="Address" method="post">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="addressId" value="<%= address.getId() %>">
                        <button type="submit" class="icon-button edit" title="Edit">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 
                                         7.04a1.003 1.003 0 0 0 0-1.42l-2.34-2.34a1.003 
                                         1.003 0 0 0-1.42 0l-1.83 1.83 3.75 3.75 
                                         1.84-1.82z"/>
                            </svg>
                        </button>
                    </form>
                    <form action="Address" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="addressId" value="<%= address.getId() %>">
                        <button type="submit" class="icon-button delete" title="Delete">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                <path d="M3 6h18v2H3V6zm2 3h14v12a2 2 0 0 1-2 
                                         2H7a2 2 0 0 1-2-2V9zm5 3v7h2v-7H10zm4 
                                         0v7h2v-7h-2zM9 4V2h6v2h5v2H4V4h5z"/>
                            </svg>
                        </button>
                    </form>
                </div>
            </div>
        <%
                }
            }
        %>
        <button class="add-btn" onclick="location.href='addaddress.jsp?source=addresses.jsp'">
            + Add New Address
        </button>
    </div>
</body>
</html>