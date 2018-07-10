<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<html>

<head>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/jquery.min.js"></script>
<link href="css/style.css" rel='stylesheet' type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>p.indent{ padding-bottom: 1.2em }</style>
<style>p.indent1{ padding-bottom: 2.2em }</style>
<script type="text/javascript">
function disp_alert()
{
alert("You Have Successfully Booked This House!")
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>View House</title>
</head>

<body>

	<%
		String ViewHouseID = request.getParameter("ViewHouseId");
		request.setAttribute("confirmHouseID", ViewHouseID);
		String userem = session.getAttribute("loginEmail").toString();
		//System.out.println(ViewHouseID);
		
		String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
		String DBURL = "jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl";
		String DBNAME = "fangyu";
		String DBPASS = "Lovemomo940219";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
	%>
	
	<%
		String sql = "select * from Houses h, house_hold hh where h.HOUSE_ID = hh.house_id and h.HOUSE_ID = ?";
	
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,ViewHouseID); //把name放到sql语句的第一个问号里
			rs = pstmt.executeQuery();

			if(rs.next()) {
// 				String Hname = rs.getString("NAME");
// 				String Hpicture = rs.getString("picture");
// 				String Hstreet = rs.getString("street");
// 				String Haccommondates = rs.getString("accommoondates");
// 				String Hcity = rs.getString("city");
// 				String Hneighbor = rs.getString("NEIGHBORHOOD");
// 				String Hptype = rs.getString("PROPERTY_TYPE");
// 				String Hrtype = rs.getString("ROOM_TYPE");
// 				String Hbtype = rs.getString("BED_TYPE");
// 				String Hbeds = rs.getString("beds");
// 				String Hbathroom = rs.getString("BATHROOMS");
// 				String Hbedroom = rs.getString("BEDROOMS");
// 				String Hrating = rs.getString("RATING");
// 				String Hreviews = rs.getString("REVIEWS");
				
				
				int Hprice = rs.getInt("price");
				int Hclean_fee = rs.getInt("CLEANING_FEE");
				request.setAttribute("hID",rs.getInt("host_id"));
			} 
			
			
			
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


	<div class="container">
	<div class="row">
		<div class="col-md-7">
		     <p class="indent1"></p>

			<img src= "<%=rs.getString("picture") %>" width="600" height="400">
			<dl class="dl-horizontal">
        			<dt>Address: </dt>
        			<dd><%=rs.getString("street") %></dd>
     			</dl>

			<div class="col-md-4">

				<dl class="dl-horizontal">
        			<dt>Rating: </dt>
        			<dd><%=rs.getString("rating")%></dd>
        			<dt>Property Type: </dt>
        			<dd><%=rs.getString("PROPERTY_TYPE")%></dd>
        			<dt>Bedrooms: </dt>
        			<dd><%=rs.getString("bedrooms")%></dd>
        			<dt>Beds: </dt>
        			<dd><%=rs.getString("beds")%></dd>
     			</dl>
			</div>
			<div class="col-md-6">
				<dl class="dl-horizontal">
        			<dt>Reviews: </dt>
        			<dd><%=rs.getString("reviews")%></dd>
        			<dt>Room Type: </dt>
        			<dd><%=rs.getString("room_type")%></dd>
        			<dt>Bathrooms: </dt>
        			<dd><%=rs.getString("BATHROOMS")%></dd>
        			<dt>Bed Type: </dt>
        			<dd><%=rs.getString("bed_type")%></dd>
     			</dl>
			</div>
			
		</div>	
		
		<div class="col-md-5">
		<form action = "http://localhost:8080/DBProj/bookconf.jsp" method = "post">
			<div class="page-header">
  			<h1><%=rs.getString("NAME")%></h1>
  			<small>
  				<div style="display: inline-block;">
  					Accommodates: 
  				</div>
  				<div style="display: inline-block;  width: 60px;">
  					<%=rs.getString("ACCOMMODATES")%>
  				</div><br>
  				<div style="display: inline-block;">
  					City:  
  				</div>
  				<div style="display: inline-block;  width: 120px;">
  					<%=rs.getString("city")%>
  				</div><br>
  				<div style="display: inline-block;">
  					Neighborhood:  
  				</div>
  				<div style="display: inline-block;">
  					<%=rs.getString("neighborhood")%>
  				</div>
  			</small>
			</div>

			<div>
				<dl class="dl-horizontal">
      			<dt>Check In: </dt>
      			<dd><input class="date" id="datepicker" name = "checkInDate" type="text" value="" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}" required=></dd>
      			<p class="indent"></p>
      			<dt>Check Out: </dt>
      			<dd><input class="date" id="datepicker1" name = "checkOutDate" type="text" value="" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}" required=></dd>
     			</dl>
			</div>

            <p class="indent"></p>
  
     <dl class="dl-horizontal">
      <dt>Price Per Night: </dt>
      <dd>$ <%=rs.getInt("price")%></dd>
      <p class="indent"></p>
      <dt>Cleaning Fee: </dt>
      <dd>$ <%=rs.getInt("CLEANING_FEE")%></dd>
      <p class="indent"></p>
      <dt>Total Per Night: </dt>
      <dd>$ <%=rs.getInt("CLEANING_FEE") + rs.getInt("price")%> </dd>
     </dl>
     <p class="indent1"></p>
	 <!-- <p><a class="btn btn-primary btn-lg" href="#" role="button">Book Now</a></p> -->
	 
	 <input type = "hidden" name = "comfirmEmail" value = "${loginEmail}">
	 <input type = "hidden" name = "comfirmHouseID" value = "${confirmHouseID}">
	 <button class="btn btn-primary btn-lg btn-block" type="submit" id = "view1">Book Now!</button><br>
	</form>
		 
	 <form action = "http://localhost:8080/DBProj/HostProfile.jsp" method = "post">
	 	<input type = "hidden" name = "ViewHostID" value = "${hID}">
	 	<button class="btn btn-primary btn-lg btn-block" type="submit" id = "view1">View Host Profile</button>
	 </form>
	 	

        </div>

      </div>

       <div class="clearfix"> </div>
       </div>

</div>
<link rel="stylesheet" href="css/jquery-ui.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="js/jquery-ui.js"></script>
      <script>
        $(function() {
        $( "#datepicker,#datepicker1" ).datepicker();
        });
      </script>
		</div>
	</div>
	</div>
	<%	
		rs.close();
		pstmt.close();
		conn.close();
	%>
</body>
</html>