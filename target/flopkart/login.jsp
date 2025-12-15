<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In</title>
<style type="text/css">
body {
    margin: 0;
    font-family: roboto, Arial, sans-serif;
	background: linear-gradient(135deg, #f5f5f5, #e0e0e0);
	background-attachment: fixed;
}

.userform {
    background: #ffffff;
    width: 425px;
    padding: 30px 35px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    margin: 60px auto;
    text-align: left;
    transition: transform 0.3s ease;
}
.userform:hover {
    transform: translateY(-5px);
}

.userform h1 {
    text-align: center;
    color: #2c3e50;
    margin-bottom: 25px;
    font-size: 26px;
    font-weight: 600;
}

.userform label {
    display: block;
    margin-bottom: 6px;
    font-weight: bold;
    color: #444;
    font-size: 14px;
}

.userform input[type="text"], 
.userform input[type="password"] {
    width: 93%;
    padding: 12px;
    margin-bottom: 18px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}
.userform input[type="text"]:focus, 
.userform input[type="password"]:focus {
    border-color: #2c3e50;
    box-shadow: 0 0 6px rgba(44, 62, 80, 0.3);
    outline: none;
}

.userform input[type="submit"] {
    width: 100%;
    padding: 14px;
    background: #111;
    color: #fff;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    font-size: 16px;
    cursor: pointer;
    transition: background 0.3s ease, transform 0.2s ease;
}
.userform input[type="submit"]:hover {
    background: #333;
    transform: scale(1.02);
}

.error-message {
    color: #d32f2f;
    text-align: center;
    margin-bottom: 15px;
    font-size: 14px;
    font-weight: bold;
    background: #ffebee;
    padding: 8px;
    border-radius: 6px;
}

.userform a {
    display: block;
    text-align: center;
    margin-top: 20px;
    color: #2c3e50;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
}
.userform a:hover {
    text-decoration: underline;
}
</style>
</head>
<body>

    <%@ include file="header.jsp"%>

    <div class="userform">
        <h1>Sign In</h1>

        <%
        String error = (String) request.getAttribute("errorMessage");
        if (error != null) {
        %>
        <div class="error-message"><%=error%></div>
        <%
        }
        %>

        <form action="validate" method="get">
            <label>Username :</label>
            <input type="text" name="username" placeholder="Enter username" required>

            <label>Password :</label>
            <input type="password" name="password" placeholder="Enter strong password" required>

            <input type="submit" value="Login">
        </form>

        <a href="register.jsp">New user? Sign up here</a>
    </div>

</body>
</html>