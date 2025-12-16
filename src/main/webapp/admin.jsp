<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: roboto, Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
        }

        .container {
            background-color: #fff;
            width: 380px;
            max-width: 90%;
            padding: 30px 25px;
            margin: 60px auto;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.15);
            text-align: center;
            box-sizing: border-box;
        }

        h1 {
            color: #111;
            font-size: 26px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        h3 {
            color: #555;
            margin-bottom: 25px;
            font-size: 16px;
            font-weight: 500;
        }

        .btn-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 18px;
        }

        .btn-link {
            text-decoration: none;
            width: 100%;
        }

        .btn, .btn-link button, .btn-link input[type="submit"] {
            padding: 12px 20px;
            font-size: 15px;
            background-color: #222;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            width: 100%;
            font-weight: bold;
            box-sizing: border-box;
        }

        .btn:hover, .btn-link button:hover, .btn-link input[type="submit"]:hover {
            background-color: #444;
            transform: scale(1.03);
        }

        @media (max-width: 480px) {
            .container {
                margin: 40px 15px;
                padding: 20px;
            }
            h1 { font-size: 22px; }
            h3 { font-size: 14px; }
            .btn, .btn-link button, .btn-link input[type="submit"] {
                font-size: 14px;
                padding: 12px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="container">
        <h1>Welcome Admin</h1>
        <h3>Select your operation</h3>

        <div class="btn-container">
            <a href="addproduct.jsp" class="btn-link">
                <button class="btn">Add Product</button>
            </a>
            <form action="ViewProducts" method="get" class="btn-link">
                <input type="submit" value="View Products" class="btn">
            </form>
            <a href="Order" class="btn-link">
                <button class="btn">View Orders</button>
            </a>
            <form action="ViewUsers" method="get" class="btn-link">
                <input type="submit" value="View Users" class="btn">
            </form>
        </div>
    </div>
</body>
</html>