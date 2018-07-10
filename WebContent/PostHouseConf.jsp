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
	<title>Post SuccessFully</title>
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/post.css">
<title>PostHouse</title>
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
		
		String postName = request.getParameter("postName");
		//System.out.println(postName);
		String postStreet = request.getParameter("postStreet");
		//System.out.println(postStreet);
		String postNeighborhood = request.getParameter("postNeighborhood");
		String postCity = request.getParameter("postCity");
		String postPtype = request.getParameter("postPtype");
		String postRtype = request.getParameter("postRtype");
		int postAccommodates = Integer.parseInt(request.getParameter("postAccommodates"));
		int postBedrooms = Integer.parseInt(request.getParameter("postBedrooms"));
		int postBeds = Integer.parseInt(request.getParameter("postBeds"));
		String postBtype = request.getParameter("postBtype");
		int postBathrooms = Integer.parseInt(request.getParameter("postBathrooms"));
		int postPrice = Integer.parseInt(request.getParameter("postPrice"));
		int postClean_fee = Integer.parseInt(request.getParameter("postClean_fee"));
		
		int loginid = Integer.parseInt(session.getAttribute("loginid").toString());
		
		
	%>
	
	<%
		//连接数据库
		//String sql = "insert into houses (house_id,name, street,NEIGHBORHOOD, city, PROPERTY_TYPE, ROOM_TYPE, ACCOMMODATES, BEDROOMS, BATHROOMS, BEDS, BED_TYPE, PRICE, CLEANING_FEE) values ((select max(house_id) from houses) + 1,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		String sql = "insert into houses (house_id,name, street,NEIGHBORHOOD, city, PROPERTY_TYPE, ROOM_TYPE, ACCOMMODATES, BEDROOMS, BEDS, BED_TYPE, BATHROOMS, PRICE, CLEANING_FEE) values ((select max(house_id) from houses) + 1,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
			pstmt = conn.prepareStatement(sql);
 			pstmt.setString(1,postName); //把name放到sql语句的第一个问号里
 			pstmt.setString(2,postStreet);
 			pstmt.setString(3,postNeighborhood);
 			pstmt.setString(4,postCity);
 			pstmt.setString(5,postPtype);
 			pstmt.setString(6,postRtype);
 			pstmt.setInt(7,postAccommodates);
 			pstmt.setInt(8,postBedrooms);
 			pstmt.setInt(9,postBeds);
 			pstmt.setString(10,postBtype);
 			pstmt.setInt(11,postBathrooms);
 			pstmt.setInt(12,postPrice);
 			pstmt.setInt(13,postClean_fee);
			
			
			
			rs = pstmt.executeQuery();
			
			
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch (Exception e) {
			out.println(e);
		}
	%>
	
	<%	
	sql = "insert into house_hold value values ((select max(house_id) from houses), ?)";
	try {
		Class.forName(DBDRIVER);
		conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,loginid); //把name放到sql语句的第一个问号里
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
				<h2>You Have Successfully Posted Your House</h2>
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