<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
</head>
<body>
	<%
	if(session.getAttribute("uname")!=null) {
	//用户已登录成功
	%>
	<center><h2><font color="red"
	size=12><%=session.getAttribute("uname")%></font>welcome! 
	</h2></center>
	<%
	}
	else {
	//未登录，提示用户登录
	response.setHeader("refresh","2;URL=login.jsp");
	%> 您还未登录，2秒将后自动跳转到登录界面<br>
	如果没有自动跳转，请<a href="login.jsp"><font color="greed">点击</font></a>这里登录！
	<br>
	<%
	}
	%>
</body>
</html>