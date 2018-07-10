<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Sign Up</title>
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
		String email = request.getParameter("signEmail");
		String password = request.getParameter("signPassword");
		String gender = request.getParameter("signGender");
		String uName = request.getParameter("signName");
	%>
	<%
		//连接数据库
		String sql = "SELECT email from users where email=?";
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,email); //把name放到sql语句的第一个问号里
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
				request.setAttribute("duemail","This email is already exist!");
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
		<jsp:forward page="Signup.jsp" />
	<%
	}
	else {
	%>
	<%
		sql = "insert into users value(email, password, name, gender) values (?, ?, ?, ?)";
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,email); //把name放到sql语句的第一个问号里
			pstmt.setString(2,password);
			pstmt.setString(3,uName);
			pstmt.setString(4,gender);
			rs = pstmt.executeQuery();
			 
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch (Exception e) {
			out.println(e);
		}
	%>
	<jsp:forward page="login.jsp" />
	<%
	}
	%>
</body>
</html>