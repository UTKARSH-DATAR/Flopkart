<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flopkart</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
body {
    margin: 0;
    font-family: roboto, Arial, sans-serif;
    background: linear-gradient(135deg, #f5f5f5, #e0e0e0);
    background-attachment: fixed;
}

/* Register form */
.userform {
    background: #ffffff;
    width: 400px;
    max-width: 90%;              /* ✅ shrink on mobile */
    padding: 40px 35px;          /* ✅ space inside */
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    margin: 60px auto;
    text-align: left;
    transition: transform 0.3s ease;
    box-sizing: border-box;      /* ✅ inputs respect padding */
}
.userform:hover { transform: translateY(-5px); }

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
    width: 100%;                 /* ✅ full width inside padded box */
    padding: 12px;
    margin-bottom: 18px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
    box-sizing: border-box;      /* ✅ prevents overflow */
}
.userform input[type="text"]:focus,
.userform input[type="password"]:focus {
    border-color: #2c3e50;
    box-shadow: 0 0 6px rgba(44,62,80,0.3);
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
    box-sizing: border-box;
}
.userform input[type="submit"]:hover {
    background: #333;
    transform: scale(1.02);
}

/* 📱 Mobile adjustments */
@media (max-width: 480px) {
    .userform {
        margin: 40px 15px;       /* ✅ side margins on mobile */
        padding: 20px;           /* tighter padding */
    }
    .userform h1 { font-size: 22px; }
    .userform input[type="submit"] { font-size: 15px; padding: 12px; }
}
</style>
</head>
<body>

    <%@ include file="header.jsp"%>

    <div class="userform">
        <h1>Register New User</h1>
        <form action="Register" method="post">
            <label>Name :</label>
            <input type="text" name="name" placeholder="Enter your name" required="required">

            <label>Contact :</label>
            <input type="text" name="contact" placeholder="Enter your contact number" required="required">

            <label>Username :</label>
            <input type="text" name="username" placeholder="Enter username"
                   required="required" maxlength="20">

            <label>Password :</label>
            <input type="password" name="password" placeholder="Enter strong password"
                   required="required" minlength="8" maxlength="15"
                   pattern=".{8,15}"
                   title="Password must be between 8 and 15 characters">

            <input type="submit" value="Register">
        </form>
    </div>

</body>
</html>