<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<script src="js/jquery.min.js"></script>
<title>Sign Up</title>
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
                <form class="form-horizontal" method = "post" action = "http://localhost:8080/DBProj/signUpconf.jsp">
                    <span class="heading">Sign Up</span>
                    <div class="form-group">
                        <input type="email" class="form-control" name="signEmail" placeholder="Email Address">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="signName" placeholder="Your Name">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="signGender" placeholder="Gender">
                        <i class="fa fa-user"></i>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" name="signPassword" placeholder="Password">
                        <i class="fa fa-lock"></i>
                        <a href="#" class="fa fa-question-circle"></a>
                    </div>
                    <%
						// 判断是否有错误信息，如果有则打印
						// 如果没有此段代码，则显示时会直接打印null
						if(request.getAttribute("duemail")!=null)
						{
						%>
						<h4><font color="red">
						<%=request.getAttribute("duemail")%>
						</font></h4>
						<%
						}
						%>
                    <div class="form-group">
                        <button type="submit" class="btn1">Sign up</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>