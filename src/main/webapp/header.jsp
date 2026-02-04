<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flopkart</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
body {
  margin: 0;
  font-family: roboto, Arial, sans-serif;
  padding-top: 60px;
}

/* Header */
.header {
  background-color: #111;
  color: white;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 15px;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1000;
  box-shadow: 0 2px 8px rgba(0,0,0,0.3);
  box-sizing: border-box;
  flex-wrap: nowrap;   /* keep everything on one line */
}

.header-left {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-shrink: 1;
}
#logo {
  margin: 0;
  font-size: 1.4rem;
  font-weight: bold;
  color: white;
  letter-spacing: 1px;
  flex-shrink: 1;
}
.header-left i {
  font-size: 0.85rem;
  color: #BBB;
  font-style: normal;
  flex-shrink: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.header-right {
  display: flex;
  align-items: center;
  flex-shrink: 1;
}
.header-right a, .header-right span {
  margin-left: 12px;
  color: white;
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  transition: color 0.2s ease;
  flex-shrink: 1;
}
.header-right a:hover {
  color: #ffcc00;
}

/* Hamburger */
.hamburger {
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  margin-left: 12px;
  flex-shrink: 0; /* keep icon visible */
}
.hamburger svg {
  width: 24px;
  height: 24px;
  stroke: white;
  transition: stroke 0.2s ease;
}
.hamburger:hover svg {
  stroke: #ffcc00;
}

/* Sidebar */
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
  padding: 14px 20px;
  text-decoration: none;
  font-size: 1rem;
  color: #eee;
  display: block;
  transition: background-color 0.2s, padding-left 0.2s;
}
.sidebar a:hover {
  background-color: #333;
  padding-left: 28px;
}
.sidebar .closebtn {
  position: absolute;
  top: 20px;
  right: 25px;
  font-size: 2rem;
  color: #fff;
  cursor: pointer;
}

/* 📱 Mobile adjustments */
@media (max-width: 768px) {
  #logo { font-size: 1.2rem; }
  .header-left i { display: none; } 
  .header-right a, .header-right span { font-size: 0.8rem; margin-left: 8px; }
  .hamburger svg { width: 22px; height: 22px; }
/*   .container {grid-template-columns: repeat(2, 1fr);}  */
}

/* 📱 Very small screens (≤360px) */
@media (max-width: 360px) {
  .header-left i { display: none; }  /* hide tagline */
  #logo { font-size: 1rem; }
  .header-right a, .header-right span { font-size: 0.75rem; margin-left: 6px; }
  .hamburger svg { width: 20px; height: 20px; }
/*   .container {grid-template-columns: repeat(2, 1fr);}  */
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