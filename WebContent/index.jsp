<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<script src="js/jquery.min.js"></script>

<title>HomePage</title>
</head>
<body>
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
        <li class="active"><a href="login.html">Home<span class="sr-only">(current)</span></a></li>
        
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="http://localhost:8080/DBProj/ProfilePage.jsp">Welcome! <%=session.getAttribute("uname") %></a></li>
      </ul>
    </div>
  </div>
</nav>
		
	<div class="banner">
		<div class="container">
			<div class="banner-top">
				<h1>For Booking</h1>
				<div class="banner-bottom">
					<form method = "post" action = "http://localhost:8080/DBProj/SearchRes.jsp">
					<div class="bnr-one">
						<div class="bnr-left">
							<p>City</p>
						</div>
						<div class="bnr-right">
							<select name = city>
								<option value = "Los Angeles">Los Angeles</option>
								
								<option value = "San Diego">San Diego</option>
							</select>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="bnr-one">
						<div class="bnr-left">
							<p>Check In</p>
						</div>
						<div class="bnr-right">
							<input class="date" id="datepicker" name = "checkInDate" type="text" value="" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}" required=>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="bnr-one">
						<div class="bnr-left">
							<p>Check Out</p>
						</div>
						<div class="bnr-right">
							<input class="date" id="datepicker1" name = "checkOutDate" type="text" value="" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}" required=>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="bnr-one">
						<div class="bnr-left">
							<p>Adults</p>
						</div>
						<div class="bnr-right">
							<select name = "guestNum">
								<option  class="rm">1</option>
								<option  class="rm">2</option>
								<option  class="rm">3</option>
								<option  class="rm">4</option>
								<option  class="rm">5</option>
								<option  class="rm" value = "6">6 or more</option>
							</select>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="bnr-btn">
						
							<input type="submit" value="Search">
						
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--end-banner-->
	<!---start-date-piker---->
		<link rel="stylesheet" href="css/jquery-ui.css" />
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.js"></script>
 		<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script src="js/jquery-ui.js"></script>
			<script>
				$(function() {
				$( "#datepicker,#datepicker1" ).datepicker();
				});
				var imgSrcs = ["images/holiday2.jpg","images/holiday3.jpg","images/holiday4.jpg","images/banner.jpg"];
				$("body").css("background", "url(" + imgSrcs[0] + ")");
				setInterval(function() {
    			$("body").css("background", "url(" + imgSrcs[imgSrcs.push(imgSrcs.shift())-1] + ")");
					}, 5000);
			</script>
</body>
</html>