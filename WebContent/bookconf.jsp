<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Book Successfully</title>
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/success.css">
<title>bookConf</title>

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
	
		//int confirmHouseId = Integer.parseInt(request.getParameter("comfirmHouseID"));
		int confirmHouseId = Integer.parseInt(request.getParameter("comfirmHouseID"));
		String comfirmEmail = request.getParameter("comfirmEmail");
		String checkIn = request.getParameter("checkInDate"); 
		System.out.println(checkIn);
		String checkOut = request.getParameter("checkOutDate"); 
		System.out.println(checkOut);
		
	%>
	
	<%
	String sql = "insert into booking values(?,?,to_date(?,'MM/DD/YYYY'),to_date(?,'MM/DD/YYYY'), sysdate)";
	try {
		Class.forName(DBDRIVER);
		conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(2,confirmHouseId); //把name放到sql语句的第一个问号里
		pstmt.setString(1,comfirmEmail);
		pstmt.setString(3,checkIn);
		pstmt.setString(4,checkOut);
		
		
		rs = pstmt.executeQuery();
		
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	catch (Exception e) {
		out.println(e);
	}
	%>
	
	<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<div id="content">
				<h2>You Have Successfully Booked This House</h2>
				<h3>Enjoy Your Travel!</h3>
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