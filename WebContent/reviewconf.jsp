<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Review Completed</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/post.css">
</head>

<body>
	<%
	
		String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
		String DBURL = "jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl";
		String DBNAME = "fangyu";
		String DBPASS = "Lovemomo940219";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
	
		int reviewHouseId = Integer.parseInt(request.getParameter("reviewHouseId"));
		//out.println(reviewHouseId);
		String reviewerEmail = request.getParameter("reviewerEmail");
		//out.println(reviewerEmail);
		String comment = request.getParameter("comment");
		//out.println(comment);
		int reviewScore = Integer.parseInt(request.getParameter("reviewScore"));
		//out.println(reviewScore);
		
	%>
	
	<%
	try {
		
		String sql = "insert into reviews values(?,sysdate,?,(select name from users where email = ?),?,?)";
		
		Class.forName(DBDRIVER);
		conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,reviewHouseId); //把name放到sql语句的第一个问号里
		pstmt.setString(2,reviewerEmail);
		pstmt.setString(3,reviewerEmail);
		pstmt.setString(4,comment);
		pstmt.setInt(5,reviewScore);
		rs = pstmt.executeQuery();
	}
	catch (Exception e) {
		out.println(e);
	}
	%>
	<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<div id="content">
				<h2>Than you for your review!</h2>
				<hr>
				<button class="btn btn-default btn-lg" onclick="JavaScript:history.go(-1);"><i class="fa fa-check" aria-hidden="true"></i> Confirm</button>
			</div>
		</div>
	</div>
</div>
<script   src="https://code.jquery.com/jquery-3.1.1.js"   integrity="sha256-16cdPddA6VdVInumRGo6IbivbERE8p7CQR3HzTBuELA="   crossorigin="anonymous"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>