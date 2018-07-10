<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<title>View Profile</title>
		<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
    	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    	<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
    	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,300,600' rel='stylesheet' type='text/css'>
    	<link rel="stylesheet" href="css/font-awesome.css">
    	<link rel="stylesheet" href="css/bootstrap.css">
    	<link rel="stylesheet" href="css/bulma.css">
    	<link rel="stylesheet" href="css/styles.css">
</head>

<body class="layout" style="zoom: 1;">
<%-- <%System.out.println(request.getParameter("ViewHostID")); %> --%>

	<%!
		String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
		String DBURL = "jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl";
		String DBNAME = "fangyu";
		String DBPASS = "Lovemomo940219";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//String email = session.getAttribute("loginEmail").toString();
		int id;
		String name = null;
		String location = null;
		String image = null;
		String host_since = null;
		int resrate;
		
	%>
	<%
		id = Integer.parseInt(request.getParameter("ViewHostID"));
	
	%>
	
	<%
		//连接数据库
		String sql = "SELECT * from host where host_id = ?";
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,id); //把name放到sql语句的第一个问号里
			rs = pstmt.executeQuery();
			if (rs.next()) {
				name = rs.getString("HOST_NAME");
				location = rs.getString("HOST_LOCATION");
				image = rs.getString("HOST_PICTURE_URL");
				host_since = rs.getString("host_since");
				resrate = 100 * rs.getInt("HOST_RESPONSE_RATE");
			}
			request.setAttribute("pic",image);
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch (Exception e) {
			out.println(e);
		}
	%>
	
		<nav class="navbar navbar-default">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="http://localhost:8080/DBProj/index.jsp">Home<span class="sr-only"></span></a></li>
        
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="http://localhost:8080/DBProj/ProfilePage.jsp">Welcome! <%=session.getAttribute("uname") %></a></li>
      </ul>
    </div>
  </div>
</nav>
		
		<section class="hero is-bold">
			<div class="hero-body">
				<div class="container">
					<div class="columns is-vcentered">
						<div class="column is-6 is-offset-3">
							<h1 class="title">
							View Profile
							</h1>
							<div class="columns">
								<div class="column">
									<figure class="image is-166x166">
										<img src="${pic} ">
									</figure>
								</div>
								<div class="column">
									<div class="row">
										Name
										<ol class="breadcrumb">
  										<li><%out.println(name); %></li>
  										</ol>
									</div>
									<div class="row">
										Address
										<ol class="breadcrumb">
  										<li><%out.println(location); %></li>
  										</ol>
									</div>
									<div class="row">
										Host Since
										<ol class="breadcrumb">
  										<li><%out.println(host_since); %></li>
  										</ol>
									</div>
									<div class="row">
										Respon Rate
										<ol class="breadcrumb">
  										<li><%out.println(resrate); %>%</li>
  										</ol>
									</div>
									<hr>
									<div class="row">
										<p class="control">
											<button class="btn btn-default btn-lg btn-success" id = "view1" onclick="JavaScript:history.go(-1);">Back</button>
										</p>
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</section>
			<%image = null; %>
		</body>
</html>