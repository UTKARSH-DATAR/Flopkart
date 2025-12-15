<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.List, model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Users</title>
    <style>
        body {
            margin: 0;
            font-family: roboto, Arial, sans-serif;
            background-color: #f9f9f9;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 80px;
        }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
        }

        th {
            background-color: #222;
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e9f3ff;
        }

        td {
            color: #555;
        }

        .no-users {
            text-align: center;
            font-style: italic;
            color: #888;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <h1>All Users</h1>
    <table>
        <tr>
            <th>Name</th>
            <th>Username</th>
            <th>Contact</th>
        </tr>
        <%
            List<User> users = (List<User>) session.getAttribute("users");
            if (users != null && !users.isEmpty()) {
                for (User u : users) {
                	if(u.getUsername().equals("utkarsh_datar")) continue;
        %>
        <tr>
            <td><%= u.getName() %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getContact() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="3" class="no-users">No users found.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>