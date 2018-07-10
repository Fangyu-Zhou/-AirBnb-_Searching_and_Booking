<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.Map"%>
<%@ page import = "java.util.HashMap"%>
<%@ page import = "java.util.List"%>
<%@ page import = "java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>SearchPage</title>
    <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,300,600' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/styles1.css">
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
		
		String checkIn = request.getParameter("checkInDate"); 
		System.out.println(checkIn);
		String checkOut = request.getParameter("checkOutDate"); 
		System.out.println(checkOut);
		String city = request.getParameter("city");
		int guestNum = Integer.parseInt(request.getParameter("guestNum"));
	%>
	<%!
		// Attribute list define
		List<Map<String, String>> list= new ArrayList<>();
		
	%>


	<%

		//连接数据库
		//String sql = "select * from ((select distinct h.house_id as Hid from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY')) minus (select distinct h.house_id from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY') and c.AVAILABLE = 'f')),houses h2 where h2.house_id = Hid and h2.city = ? and h2.ACCOMMODATES >= ?";
		String sql = "select * from ((select distinct h.house_id as Hid from houses h inner join calendar c on c.house_id = h.house_id where to_date(?,'MM/DD/YYYY') >= to_date('04/20/2017','MM/DD/YYYY') and to_date(?,'MM/DD/YYYY') <= to_date('04/24/2017','MM/DD/YYYY')) minus (select distinct h.house_id from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY') and c.AVAILABLE = 'f')),houses h2 where h2.house_id = Hid and h2.ACCOMMODATES >= ? and h2.CITY = ?";
		//System.out.println(guestNum);
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,checkIn); //把name放到sql语句的第一个问号里
			pstmt.setString(2,checkOut);
			pstmt.setString(3,checkIn);
			pstmt.setString(4,checkOut);
 			pstmt.setString(6,city);
 			pstmt.setInt(5,guestNum);
			rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			while(rs.next()) {
				Map<String, String> temp = new HashMap<>();
				
				for (int i = 1; i <= columnsNumber; i ++) {
					temp.put(rsmd.getColumnName(i), rs.getString(i));
					//System.out.println(rsmd.getColumnName(i) + " " + rs.getString(i));
				}
				list.add(temp);
				//out.println(rs.getString("room_type"));
			} 
			request.setAttribute("HouseInfo", list);
			
			
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch (Exception e) {
			out.println(e);
		}
		
		
	%>

<!--      <table> -->
<!--        <tr><th>Name</th><th>property_type</th><th>room_type</th></tr> -->
<%--         <c:forEach items="${HouseInfo}" var="item"> --%>
        	
<%--             <tr><td><c:out value="${item.NAME}" /></td><td><c:out value="${item.PROPERTY_TYPE}" /></td><td><c:out value="${item.ROOM_TYPE}" /></td><td><form action = "ViewHouse.jsp" method = "post"> --%>
<%--             <input type = "hidden" name = "ViewHouseId" value = "${item.HOUSE_ID}"> --%>
<!--             <button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button></form></td></tr> -->
            
            
<%--         </c:forEach> --%>
<!--      </table> -->
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

            <div class="mfp-with-anim mfp-hide mfp-dialog mfp-search-dialog" id="search-dialog">
                <h3>Change your Filters</h3>
                <form method = "post" action = "http://localhost:8080/DBProj/ResearchRes.jsp">
                    
                    <div class="col-md-2">
                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-usd input-icon input-icon-highlight"></i>
                            <label>Price Min</label>
                            <input class="form-control" name="minPrice" type="text" placeholder="50" />
                        </div>
                    </div>

                    <div class="col-md-2">
                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-usd input-icon input-icon-highlight"></i>
                            <label>Price Max</label>
                            <input class="form-control" name="maxPrice" type="text" placeholder="200" />
                        </div>
                    </div>
                   
                    <div class="input-daterange" data-date-format="mm/dd/yyyy">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-calendar input-icon input-icon-highlight"></i>
                                    <label>Check-in</label>
                                    <input class="form-control" name="start" type="text" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-calendar input-icon input-icon-highlight"></i>
                                    <label>Check-out</label>
                                    <input class="form-control" name="end" type="text" />
                                </div>
                            </div>          
                        </div>
                    </div>

                    <div class="col-md-3">
                                <div class="form-group form-group-lg form-group-select-plus">
                                    <label>Bedrooms</label>
<!--                                     <div class="btn-group btn-group-select-num" data-toggle="buttons"> -->
<!--                                         <label class="btn btn-primary active"> -->
<!--                                             <input type="radio" name="bedRooms" value = "1"/>1</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="bedRooms" value = "2"/>2</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="bedRooms" value = "3"/>3</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="bedRooms"/>3+</label> -->
<!--                                     </div> -->
                                    <select class="form-control" name="bedRooms">
                                        <option value = "1">1</option>
                                        <option value = "2">2</option>
                                        <option value = "3">3</option>
                                        <option value = "4">4</option>
                                        <option value = "5">5</option>
                                        <option value = "6">6</option>
                                        <option value = "7">7</option>
                                        <option value = "8">8</option>
                                        <option value = "9">9</option>
                                        <option value = "10">10</option>
                                        
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group form-group-lg form-group-select-plus">
                                    <label>Bathrooms</label>
<!--                                     <div class="btn-group btn-group-select-num" data-toggle="buttons"> -->
<!--                                         <label class="btn btn-primary active"> -->
<!--                                             <input type="radio" name="bathRooms" />0</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="bathRooms" />0.5</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="bathRooms" />1</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="bathRooms" />1.5+</label> -->
<!--                                     </div> -->
                                    <select class="form-control" name="bathRooms">
                                        <option value = "0">0</option>
                                       
                                        <option value = "1">1</option>
                                        
                                        <option value = "2">2</option>
                                       
                                        <option value = "3">3</option>
                                        
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group form-group-lg form-group-select-plus">
                                    <label>Accommodates</label>
<!--                                     <div class="btn-group btn-group-select-num" data-toggle="buttons"> -->
<!--                                         <label class="btn btn-primary active"> -->
<!--                                             <input type="radio" name="guestsNum" />1</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="guestsNum" />2</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="guestsNum" />3</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="guestsNum" />3+</label> -->
<!--                                     </div> -->
                                    <select class="form-control" name="guestsNum">
                                        <option value = "1">1</option>
                                        <option value = "2">2</option>
                                        <option value = "3">3</option>
                                        <option value = "4">4</option>
                                        <option value = "5">5</option>
                                        <option value = "6">6</option>
                                        <option value = "7">7</option>
                                        <option value = "8">8</option>
                                        <option value = "9">9</option>
                                        <option value = "10">10</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group form-group-lg form-group-select-plus">
                                    <label>Beds</label>
<!--                                     <div class="btn-group btn-group-select-num" data-toggle="buttons"> -->
<!--                                         <label class="btn btn-primary active"> -->
<!--                                             <input type="radio" name="bedsNum" />1</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="bedsNum" />2</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="bedsNum" />3</label> -->
<!--                                         <label class="btn btn-primary"> -->
<!--                                             <input type="radio" name="bedsNum" />3+</label> -->
<!--                                     </div> -->
                                    <select class="form-control" name="bedsNum">
                                        <option value = "1">1</option>
                                        <option value = "2">2</option>
                                        <option value = "3">3</option>
                                        <option value = "4">4</option>
                                        <option value = "5">5</option>
                                        <option value = "6">6</option>
                                        <option value = "7">7</option>
                                        <option value = "8">8</option>
                                        <option value = "9">9</option>
                                        <option value = "10">10</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group form-group-lg ">
                                    <label>Room Type</label>
                                    <select  name = "roomType">
                                        <option value = "Private room">Private Room</option>
                                        <option value = "Shared room">Shared Room</option>
                                        <option value = "Entire home/apt">Entire Home/apt</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group form-group-lg ">
                                    <label>City</label>
                                    <select  name = "filterCity">
                                        <option value = "Los Angeles">Los Angeles</option>
										<option value = "San Diego">San Diego</option>
                                    </select>
                                </div>
                            </div>

                    <button class="btn btn-primary btn-lg" type="submit">Search for Homestays</button>
                </form>
            </div>
                
                <div class="container">
                    <div class="col-md-12">
                <h3 class="booking-title">Here are your search results:</h3>
                   <span class="btn btn-primary popup-text" href="#search-dialog" data-effect="mfp-zoom-out"">Filters</span>
                    <span style="float: right;"><a class="btn btn-primary" href="Recommend.jsp">Recommendations</a></span>
                    <br>
                    <br>
                    
                
                    <ul class="booking-list">
                       <c:forEach items="${HouseInfo}" var="item" end = "30">
                        <li>
                            <a class="booking-item" href="#">
                            
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="booking-item-img-wrap">
                                            <img src="${item.PICTURE}" alt="Image Alternative text" title="hotel THE CLIFF BAY spa suite" />
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="booking-item-rating">
                                             Rating: &nbsp;&nbsp;<span class="booking-item-rating-number"><b ><c:out value="${item.RATING}" /></b> of 100</span><small>(<c:out value="${item.REVIEWS}" /> reviews)</small>
                                        </div>
                                        <h5 class="booking-item-title"><c:out value="${item.NAME}" /></h5>
                                        <p class="booking-item-address"><i class="fa fa-map-marker"></i> <c:out value="${item.STREET}" /></p><small class="booking-item-last-booked"><c:out value="${item.NEIGHBORHOOD}" /></small>
                                    </div>
                                    <div class="col-md-4"><span class="booking-item-price-from">from</span><span class="booking-item-price">$<c:out value="${item.PRICE}" /></span><span>/night</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <form action = "http://localhost:8080/DBProj/ViewHouse.jsp" method = "post">
                                    <input type = "hidden" name = "ViewHouseId" value = "${item.HOUSE_ID}">
                                    <button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button>
                                    </form>
                                    </div>
                                </div>
                            
                            </a>
                        </li>
                        </c:forEach>
                    </ul>
                    
                    </div>
                </div>
            </div>
        </div>
                </div>
                            
                
		<%request.getAttribute("HouseInfo");
			list.clear();
		%>
		
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/slimmenu.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/bootstrap-timepicker.js"></script>
        <script src="js/dropit.js"></script>
        <script src="js/ionrangeslider.js"></script>
        <script src="js/icheck.js"></script>
        <script src="js/typeahead.js"></script>
        <script src="js/card-payment.js"></script>
        <script src="js/magnific.js"></script>
        <script src="js/custom.js"></script>
        <script src="js/nicescroll.js"></script>
    </div>
</body>
</html>