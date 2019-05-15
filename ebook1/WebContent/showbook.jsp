<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JKL/Showbooks</title>
<link rel = "stylesheet" type = "text/css" href = "start_style.css" />
</head>
<body>

<%@ page import = "java.io.*" %>
<%@ page import = "java.awt.Desktop" %>

<%
String str = request.getParameter("booklist");

File file = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/"+str+".pdf");

Desktop desktop = Desktop.getDesktop();
desktop.open(file);
%>

<a href = "userview.jsp">Open another custom book</a>
<a href = "userhome.html">Home</a>

</body>
</html>