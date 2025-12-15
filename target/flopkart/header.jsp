<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flopkart</title>
<style>
body {
  margin: 0;
  font-family: roboto, Arial, sans-serif;
  padding-top: 60px;
}

.header {
  background-color: #111;
  color: white;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 20px;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1000;
  box-shadow: 0 2px 8px rgba(0,0,0,0.3);
  box-sizing: border-box;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 15px;
}
#logo {
  margin: 0;
  font-size: 26px;
  font-weight: bold;
  color: white;
  letter-spacing: 1px;
}
.header-left i {
  font-size: 14px;
  color: #BBB;
  font-style: normal;
}

.header-right {
  display: flex;
  align-items: center;
}
.header-right a, .header-right span {
  margin-left: 20px;
  color: white;
  text-decoration: none;
  font-weight: 500;
  font-size: 16px;
  transition: color 0.2s ease;
}
.header-right a:hover {
  color: #ffcc00;
}

.hamburger {
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  margin-left: 20px;
}
.hamburger svg {
  width: 28px;
  height: 28px;
  stroke: white;
  transition: stroke 0.2s ease;
}
.hamburger:hover svg {
  stroke: #ffcc00;
}

.sidebar {
  height: 100%;
  width: 0;
  position: fixed;
  top: 0;
  right: 0;
  background-color: #111;
  overflow-x: hidden;
  transition: 0.3s;
  padding-top: 70px;
  z-index: 2000;
  box-shadow: -2px 0 8px rgba(0,0,0,0.4);
}
.sidebar a {
  padding: 14px 28px;
  text-decoration: none;
  font-size: 18px;
  color: #eee;
  display: block;
  transition: background-color 0.2s, padding-left 0.2s;
}
.sidebar a:hover {
  background-color: #333;
  padding-left: 36px;
}
.sidebar .closebtn {
  position: absolute;
  top: 20px;
  right: 25px;
  font-size: 32px;
  color: #fff;
  cursor: pointer;
}
</style>
</head>
<body>
<div class="header">
  <div class="header-left">
    <h1 id="logo">FLOPKART</h1>
    <i>we deliver disappointment faster!</i>
  </div>
  <div class="header-right">
    <%
      String user = (String) session.getAttribute("username");
      if (user != null) {
    %>
      <span>Welcome, <%=session.getAttribute("clientName")%></span>
    <%
      } else {
    %>
      <a href="login.jsp">Sign in</a>
      <a href="home">All products</a>
    <%
      }
    %>
    <span class="hamburger" onclick="openSidebar()">
      <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M4 18H20" stroke="white" stroke-width="2" stroke-linecap="round"/>
        <path d="M4 12H20" stroke="white" stroke-width="2" stroke-linecap="round"/>
        <path d="M4 6H20" stroke="white" stroke-width="2" stroke-linecap="round"/>
      </svg>
    </span>
  </div>
</div>

<div id="mySidebar" class="sidebar">
  <span class="closebtn" onclick="closeSidebar()">&times;</span>
  <%
    if (user != null && "utkarsh_datar".equals(user)) {
  %>
    <a href="admin.jsp">Admin Home</a>
    <a href="Logout">Logout</a>
  <%
    } else {
  %>
    <a href="Cart">Cart</a>
    <a href="orders.jsp">Orders</a>
    <a href="Address">Addresses</a>
    <a href="home">All Products</a>
    <a href="Logout">Logout</a>
  <%
    }
  %>
</div>

<script>
function openSidebar() {
  document.getElementById("mySidebar").style.width = "260px";
}
function closeSidebar() {
  document.getElementById("mySidebar").style.width = "0";
}
</script>
</body>
</html>