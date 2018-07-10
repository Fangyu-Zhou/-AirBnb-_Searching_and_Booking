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

	<%!
		String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
		String DBURL = "jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl";
		String DBNAME = "fangyu";
		String DBPASS = "Lovemomo940219";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//String email = session.getAttribute("loginEmail").toString();
		String orderhouseId = null;
		String email = null;
		String username = null;
		String gender = null;
		String ordername = null;
		String orderstartdate = null;
		String orderenddate = null;
		
	%>
	
	<%
		//连接数据库
		email = session.getAttribute("loginEmail").toString();
		request.setAttribute("reviewerEmail",email);
		String sql = "SELECT * from users where email=?";
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,email); //把name放到sql语句的第一个问号里
			rs = pstmt.executeQuery();
			if (rs.next()) {
				username = rs.getString("name");
				gender = rs.getString("gender");
			}
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
										<img src="images/file.png">
									</figure>
								</div>
								<div class="column">
									<div class="row">
										Name
										<ol class="breadcrumb">
  										<li><%out.println(username); %></li>
  										</ol>
									</div>
									<div class="row">
										Gender
										<ol class="breadcrumb">
  										<li><%out.println(gender); %></li>
  										</ol>
									</div>
									<div class="row">
										Email
										<ol class="breadcrumb">
  										<li><%out.println(email); %></li>
  										</ol>
									</div>
									<hr>
									<div class="row">
										<p class="control">
											<a class="button is-primary" href="http://localhost:8080/DBProj/PostHouse.jsp">Add My House</a>
										</p>
									</div>
								</div>
							</div>
							<%
							//连接数据库
								sql = "select * from (booking inner join houses on booking.house_id = houses.house_id) where user_email = ? and order_time = (select max(order_time) from booking where user_email = ?)";
								try {
									Class.forName(DBDRIVER);
									conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
									pstmt = conn.prepareStatement(sql);
									pstmt.setString(1,email); //把name放到sql语句的第一个问号里
									pstmt.setString(2,email);
									rs = pstmt.executeQuery();
									if(rs.next()) {
										ordername = rs.getString("name");
										orderstartdate = rs.getString("start_date");
										orderenddate = rs.getString("end_date");
										orderhouseId = rs.getString("house_id"); 
										
									}
									request.setAttribute("orderhouseId",orderhouseId);
									rs.close();
									pstmt.close();
									conn.close();
								}
								catch (Exception e) {
									out.println(e);
								}
							%>
							
							<div class="card">
  								<header class="card-header">
    								<p class="card-header-title">
     								 Last Stay
    								</p>
    								
  								</header>
  								<div class="card-content">
    								<div class="content">
      								<%out.println(ordername); %>
      								<br>
      								<small class="level-right"><%out.println(orderstartdate); %> - <%out.println(orderenddate); %></small>
    								</div>
  								</div>
  								<footer class="card-footer">
    								<form action = "http://localhost:8080/DBProj/ViewHouse.jsp" method = "post">
                                    <input type = "hidden" name = "ViewHouseId" value = "${orderhouseId}">
                                    <button style = "position:absolute; right:0px;" class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button>
                                    </form>
                                    <br>
                                    
                                <br>    
  								</footer>
  								<footer class="card-footer">
  								
  								<form action = "http://localhost:8080/DBProj/reviewconf.jsp" method = "post">
                                    <input type = "hidden" name = "reviewHouseId" value = "${orderhouseId}">
                                    <input type = "hidden" name = "reviewerEmail" value = "${reviewerEmail}">
                                    <input style = "height: 50px; width :300px;" type = "text" name = "comment" placeholder = "enter ur comment..."><br><br>
                                    <input  type = "text" name = "reviewScore" placeholder = "enter score">
                                    <button style = "position:absolute; bottom: 10px; right:0px;" class="btn btn-default btn-lg btn-success" type="submit" id = "view1">Review</button>
                                    </form>
  								
  								</footer>
								</div>
						</div>
					</div>
				</div>
			</section>
			<%ordername = null;
				orderstartdate = null;
				orderenddate = null;
				orderhouseId = null;
				email = null;%>
			
		</body>
</html>