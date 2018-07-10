<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<script src="js/jquery.min.js"></script>
<title>Login Page</title>
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
        <li><a href="index.html">Home<span class="sr-only"></span></a></li>
        
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="http://localhost:8080/DBProj/login.jsp">Login</a></li>
        <li><a href="http://localhost:8080/DBProj/Signup.jsp">Sign Up</a></li>
      </ul>
    </div>
  </div>
</nav>

    <div class="container">
        <div class="row">
            <div class="col-md-offset-3 col-md-6">
                <form class="form-horizontal" method = "post" action = "http://localhost:8080/DBProj/loginconf.jsp">
                    <span class="heading">Login</span>
                    <div class="form-group">
                        <input type="email" class="form-control" id="inputEmail3" name="inputEmail" placeholder="E-mail">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="form-group help">
                        <input type="password" class="form-control" id="inputPassword3" name="inputPassword" placeholder="Password">
                        <i class="fa fa-lock"></i>
                        <a href="#" class="fa fa-question-circle"></a>
                    </div>
                    <div class="form-group">
                        <div class="main-checkbox">
                            <input type="checkbox" value="None" id="checkbox1" name="check"/>
                            <label for="checkbox1"></label>
                        </div>
                        <span class="text">Remember me</span>
                        <%
						// 判断是否有错误信息，如果有则打印
						// 如果没有此段代码，则显示时会直接打印null
						if(request.getAttribute("err")!=null)
						{
						%>
						<h4><font color="red">
						<%=request.getAttribute("err")%>
						</font></h4>
						<%
						}
						%>
                        <button type="submit" class="btn btn-default">Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
	

</body>

</html>