<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <style>
        body {
    		font-family: roboto, Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding-top: 60px;
        }

        .form-container {
            max-width: 600px;
            margin: 30px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-top: 15px;
            color: #444;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        input[type="submit"] {
            display: block;
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            background-color: #111;
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp"%>

    <div class="form-container">
        <form action="UploadAndForward" method="post" enctype="multipart/form-data">
            <h1>Add New Product</h1>

            <input type="hidden" name="action" value="add" />

            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" required />

            <label for="productDescription">Product Description:</label>
            <textarea id="productDescription" name="productDescription" required></textarea>

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" required />

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" required />

            <label for="image">Image:</label>
            <input type="file" id="image" name="productImage" accept="image/*" required />

            <input type="submit" value="Add Product" />
        </form>
    </div>
</body>
</html>