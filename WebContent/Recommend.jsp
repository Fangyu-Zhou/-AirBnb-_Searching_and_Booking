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
<title>Hot House</title>
    <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,300,600' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/styles.css">
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
		
	%>
	<%!
		// Attribute list define
		List<Map<String, String>> list1= new ArrayList<>();
	List<Map<String, String>> list2= new ArrayList<>();
	List<Map<String, String>> list3= new ArrayList<>();
	List<Map<String, String>> list4= new ArrayList<>();
	List<Map<String, String>> list5= new ArrayList<>();
	List<Map<String, String>> list6= new ArrayList<>();
		
	%>


	<%

		//连接数据库
		//String sql = "select * from ((select distinct h.house_id as Hid from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY')) minus (select distinct h.house_id from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY') and c.AVAILABLE = 'f')),houses h2 where h2.house_id = Hid and h2.city = ? and h2.ACCOMMODATES >= ?";
		String sql = "select * from houses where house_id in (select house_id from (select house_id,(price / ACCOMMODATES ) as xjb from houses order by xjb asc) where rownum <= 1)";
		//System.out.println(guestNum);
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			if(rs.next()) {
				Map<String, String> temp = new HashMap<>();
				
				for (int i = 1; i <= columnsNumber; i ++) {
					temp.put(rsmd.getColumnName(i), rs.getString(i));
					//System.out.println(rsmd.getColumnName(i) + " " + rs.getString(i));
				}
				list1.add(temp);
				//out.println(rs.getString("room_type"));
			} 
			request.setAttribute("inFo1", list1);	
			
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

                <div class="container">
                    <div class="col-md-12">
                <h3 class="booking-title">What Is Popular Here: </h3>
               <!--      
                性价比最高
                最豪华的
                Best for Two
                热门neiborhood top1
                最受欢迎host的房子
                最近被预定的房子 -->
                    <ul class="booking-list">
                       
                        <li>
                        <div class="panel panel-info">
                         <div class="panel-heading">Cost-effective Choice</div>
                            <div class="panel-body">
                        <c:forEach items="${inFo1}" var="item">
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
                                    <span><button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button></span>
                                    </form>
                                    </div>
                                </div>
                            
                            </a>
                            </c:forEach>
                        </li>
<%

			//连接数据库
			//String sql = "select * from ((select distinct h.house_id as Hid from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY')) minus (select distinct h.house_id from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY') and c.AVAILABLE = 'f')),houses h2 where h2.house_id = Hid and h2.city = ? and h2.ACCOMMODATES >= ?";
			sql = "select * from houses where house_id in (select house_id from (select house_id,(price / ACCOMMODATES ) as xjb from houses order by xjb desc) where rownum <= 1)";
			//System.out.println(guestNum);
			try {
				Class.forName(DBDRIVER);
				conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
				if(rs.next()) {
					Map<String, String> temp = new HashMap<>();
					
					for (int i = 1; i <= columnsNumber; i ++) {
						temp.put(rsmd.getColumnName(i), rs.getString(i));
						//System.out.println(rsmd.getColumnName(i) + " " + rs.getString(i));
					}
					list2.add(temp);
					//out.println(rs.getString("room_type"));
				} 
				request.setAttribute("inFo2", list2);	
				
				rs.close();
				pstmt.close();
				conn.close();
			
			}
			catch (Exception e) {
				out.println(e);
			}
		
		
	%>
                        <li>
                        <div class="panel panel-info">
                         <div class="panel-heading">Luxurious Choice</div>
                            <div class="panel-body">
                        <c:forEach items="${inFo2}" var="item">
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
                                    <span><button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button></span>
                                    </form>
                                    </div>
                                </div>
                            
                            </a>
                            </c:forEach>
                        </li>
                        
                        <%

			//连接数据库
			//String sql = "select * from ((select distinct h.house_id as Hid from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY')) minus (select distinct h.house_id from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY') and c.AVAILABLE = 'f')),houses h2 where h2.house_id = Hid and h2.city = ? and h2.ACCOMMODATES >= ?";
			sql = "select * from houses where accommodates >= 2 and rating = 100 and reviews in (select max(reviews) from houses where accommodates >= 2 and rating = 100)";
			//System.out.println(guestNum);
			try {
				Class.forName(DBDRIVER);
				conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
				if(rs.next()) {
					Map<String, String> temp = new HashMap<>();
					
					for (int i = 1; i <= columnsNumber; i ++) {
						temp.put(rsmd.getColumnName(i), rs.getString(i));
						//System.out.println(rsmd.getColumnName(i) + " " + rs.getString(i));
					}
					list3.add(temp);
					//out.println(rs.getString("room_type"));
				} 
				request.setAttribute("inFo3", list3);	
				
				rs.close();
				pstmt.close();
				conn.close();
			
			}
			catch (Exception e) {
				out.println(e);
			}
		
		
	%>

                        <li>
                        <div class="panel panel-info">
                         <div class="panel-heading">Best for Two</div>
                            <div class="panel-body">
                        <c:forEach items="${inFo3}" var="item">
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
                                    <span><button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button></span>
                                    </form>
                                    </div>
                                </div>
                            
                            </a>
                            </c:forEach>
                        </li>
 <%

			//连接数据库
			//String sql = "select * from ((select distinct h.house_id as Hid from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY')) minus (select distinct h.house_id from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY') and c.AVAILABLE = 'f')),houses h2 where h2.house_id = Hid and h2.city = ? and h2.ACCOMMODATES >= ?";
			sql = "select * from houses where rating is not null and neighborhood in (select neighborhood from (select neighborhood, count(*) as neiborNum from houses group by neighborhood order by neiborNum desc) where rownum < = 1) order by rating desc, reviews desc";
			//System.out.println(guestNum);
			try {
				Class.forName(DBDRIVER);
				conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
				if(rs.next()) {
					Map<String, String> temp = new HashMap<>();
					
					for (int i = 1; i <= columnsNumber; i ++) {
						temp.put(rsmd.getColumnName(i), rs.getString(i));
						//System.out.println(rsmd.getColumnName(i) + " " + rs.getString(i));
					}
					list4.add(temp);
					//out.println(rs.getString("room_type"));
				} 
				request.setAttribute("inFo4", list4);	
				
				rs.close();
				pstmt.close();
				conn.close();
			
			}
			catch (Exception e) {
				out.println(e);
			}
		
		
	%>
                        <li>
                        <div class="panel panel-info">
                         <div class="panel-heading">Popular @ Downtown</div>
                            <div class="panel-body">
                        <c:forEach items="${inFo4}" var="item">
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
                                    <span><button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button></span>
                                    </form>
                                    </div>
                                </div>
                            
                            </a>
                            </c:forEach>
                        </li>

                        <%

			//连接数据库
			//String sql = "select * from ((select distinct h.house_id as Hid from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY')) minus (select distinct h.house_id from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY') and c.AVAILABLE = 'f')),houses h2 where h2.house_id = Hid and h2.city = ? and h2.ACCOMMODATES >= ?";
			sql = "select * from (select h.house_id, h.name, h.neighborhood, h.picture, h.street, h.accommodates, h.price, h.reviews, h.rating  from (houses h inner join house_hold hh on h.house_id = hh.house_id) inner join host ho on ho.host_id = hh.host_id where ho.is_super_host = 't' and h.rating = 100 order by reviews desc)";
			//System.out.println(guestNum);
			try {
				Class.forName(DBDRIVER);
				conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
				if(rs.next()) {
					Map<String, String> temp = new HashMap<>();
					
					for (int i = 1; i <= columnsNumber; i ++) {
						temp.put(rsmd.getColumnName(i), rs.getString(i));
						//System.out.println(rsmd.getColumnName(i) + " " + rs.getString(i));
					}
					list5.add(temp);
					//out.println(rs.getString("room_type"));
				} 
				request.setAttribute("inFo5", list5);	
				
				rs.close();
				pstmt.close();
				conn.close();
			
			}
			catch (Exception e) {
				out.println(e);
			}
		
		
	%>
                        <li>
                        <div class="panel panel-info">
                         <div class="panel-heading">Cost-effective Choice</div>
                            <div class="panel-body">
                        <c:forEach items="${inFo5}" var="item">
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
                                    <span><button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button></span>
                                    </form>
                                    </div>
                                </div>
                            
                            </a>
                            </c:forEach>
                        </li>

                        <%

			//连接数据库
			//String sql = "select * from ((select distinct h.house_id as Hid from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY')) minus (select distinct h.house_id from houses h inner join calendar c on c.house_id = h.house_id where c.reserve_date >= to_date(?,'MM/DD/YYYY') and c.reserve_date <= to_date(?,'MM/DD/YYYY') and c.AVAILABLE = 'f')),houses h2 where h2.house_id = Hid and h2.city = ? and h2.ACCOMMODATES >= ?";
			sql = "select * from (select * from houses h inner join booking b on h.house_id = b.house_id order by order_time desc) where rownum <= 1";
			//System.out.println(guestNum);
			try {
				Class.forName(DBDRIVER);
				conn = DriverManager.getConnection(DBURL,DBNAME,DBPASS);
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
				if(rs.next()) {
					Map<String, String> temp = new HashMap<>();
					
					for (int i = 1; i <= columnsNumber; i ++) {
						temp.put(rsmd.getColumnName(i), rs.getString(i));
						//System.out.println(rsmd.getColumnName(i) + " " + rs.getString(i));
					}
					list6.add(temp);
					//out.println(rs.getString("room_type"));
				} 
				request.setAttribute("inFo6", list6);	
				
				rs.close();
				pstmt.close();
				conn.close();
			
			}
			catch (Exception e) {
				out.println(e);
			}
		
		
	%>
                        <li>
                        <div class="panel panel-info">
                         <div class="panel-heading">Latest Booked</div>
                            <div class="panel-body">
                        <c:forEach items="${inFo6}" var="item">
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
                                    <span><button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button></span>
                                    </form>
                                    </div>
                                </div>
                            
                            </a>
                            </c:forEach>
                        </li>

                    </ul>
                    
                    </div>
                </div>
            </div>
        </div>
                </div>
                            
                


        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/slimmenu.js"></script>
        <script src="js/nicescroll.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/bootstrap-timepicker.js"></script>
        <script src="js/dropit.js"></script>
        <script src="js/ionrangeslider.js"></script>
        <script src="js/icheck.js"></script>
        <script src="js/typeahead.js"></script>
        <script src="js/card-payment.js"></script>
        <script src="js/magnific.js"></script>
        <script src="js/custom.js"></script>
    </div>
                
<!--                     <ul class="booking-list"> -->
                    
<!--                         <li> -->
<%--                         <c:forEach items="${inFo1}" var="item"> --%>
<!--                             <a class="booking-item" href="#"> -->
                            
<!--                                 <div class="row"> -->
<!--                                     <div class="col-md-4"> -->
<!--                                         <div class="booking-item-img-wrap"> -->
<%--                                             <img src="${item.PICTURE}" alt="Image Alternative text" title="hotel THE CLIFF BAY spa suite" /> --%>
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="col-md-4"> -->
<!--                                         <div class="booking-item-rating"> -->
<%--                                              Rating: &nbsp;&nbsp;<span class="booking-item-rating-number"><b ><c:out value="${item.RATING}" /></b> of 100</span><small>(<c:out value="${item.REVIEWS}" /> reviews)</small> --%>
<!--                                         </div> -->
<%--                                         <h5 class="booking-item-title"><c:out value="${item.NAME}" /></h5> --%>
<%--                                         <p class="booking-item-address"><i class="fa fa-map-marker"></i> <c:out value="${item.STREET}" /></p><small class="booking-item-last-booked"><c:out value="${item.NEIGHBORHOOD}" /></small> --%>
<!--                                     </div> -->
<%--                                     <div class="col-md-4"><span class="booking-item-price-from">from</span><span class="booking-item-price">$<c:out value="${item.PRICE}" /></span><span>/night</span>&nbsp;&nbsp;&nbsp;&nbsp; --%>
<!--                                     <form action = "http://localhost:8080/DBProj/ViewHouse.jsp" method = "post"> -->
<%--                                     <input type = "hidden" name = "ViewHouseId" value = "${item.HOUSE_ID}"> --%>
<!--                                     <button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">view</button> -->
<!--                                     </form> -->
<!--                                     </div> -->
<!--                                 </div> -->
                            
<!--                             </a> -->
<%--                             </c:forEach> --%>
<!--                         </li> -->
                        
<!--                     </ul> -->
                    
<!--                     </div> -->
<!--                 </div> -->

<%
	list1.clear();
list2.clear();
list3.clear();
list4.clear();
list5.clear();
list6.clear();
%>>                            
                
		

</body>
</html>