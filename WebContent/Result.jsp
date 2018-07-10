<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	名字
	<%
	//String[] windows = new String[]{"Windows XP", "Windows 7", "Windows 8", "Windows mobile"};
	List<Map<String, String>> list = new ArrayList<>();
	Map<String, String> map = new HashMap<>();
	map.put("id", "1");
	map.put("name", "2");
	map.put("type", "3");
	map.put("accommondates", "4");
	list.add(map);
	list.add(map);
	
	request.setAttribute("windows", list);

	%>
	<c:forEach var="window" items="${map}"> 
            <c:out value="${window.id}" />
            <c:out value="${window.name}" />
            <c:out value="${window.type}" />
            <c:out value="${window.accommondates}" /> <br>
    </c:forEach>
</body>
</html>