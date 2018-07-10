<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
</head>


<body>
	
	<%!
		String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
		String DBURL = "jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl";
		String DBNAME = "fangyu";
		String DBPASS = "Lovemomo940219";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String name = null;
		String password = null;
	%>
	<%
		boolean flag = false;
		//接收参数
		String name = request.getParameter("inputEmail");
		String password = request.getParameter("inputPassword");
	%>
	<%
		//连接数据库
		String sql = "SELECT * from users where email=? and password=?";
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,name); //把name放到sql语句的第一个问号里
			pstmt.setString(2,password);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				out.println(rs.getString("name"));
				flag = true;
				session.setAttribute("uname",rs.getString("name"));
				session.setAttribute("loginEmail",rs.getString("email"));
				session.setAttribute("loginid",rs.getString("user_id"));
			} 
			else {
				request.setAttribute("err","Invalide Username or password!");
			}
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch (Exception e) {
			out.println(e);
		}
	%>
	<%
	//跳转
	if(flag) {
	//如果用户登录成功，则跳转到欢迎界面
	//否则提示用户登录失败
	%>
		<jsp:forward page="index.jsp" />
	<%
	}
	else {
	%>
		<jsp:forward page="login.jsp"/>
	<%
	}
	%>
</body>

</html>