<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% String msg = (String) request.getAttribute("msg"); %>
	<% String target = (String) request.getAttribute("target"); %>
	<script>
   		alert("<%= msg %>");
    	window.location.href = "<%= target %>";
	</script>
</body>
</html>