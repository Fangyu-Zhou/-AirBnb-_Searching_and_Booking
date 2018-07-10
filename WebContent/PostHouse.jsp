<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<title>Post My House</title>
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
						<form method = "post" action = "http://localhost:8080/DBProj/PostHouseConf.jsp">
							<h1 class="title">
							Post My House
							</h1>
							<div class="columns">
								<div class="column">
									<div class="row">
										House Name
										<p class="control">
											<input class="input" name = "postName" type="text" placeholder="Comfortable Cabin">
										</p>
									</div>
									<div class="row">
										Street
										<p class="control">
											<input class="input" name = "postStreet" type="text" placeholder="2800 SW Williston Road">
										</p>
									</div>
									<div class="row">
										Neighborhood
										<p class="control">
											<input class="input" name = "postNeighborhood" type="text" placeholder="Williston">
										</p>
									</div>
									<div class="row">
										City
										<p class="control is-expanded">
    										<span class="select is-fullwidth">
      										<select name="postCity">
        										<option value="Los Angeles">Los Angeles</option>
        										<option value="San Diego">San Diego</option>
      										</select>
    										</span>
  										</p>
									</div>
									<div class="row">
										Property Type
										<p class="control">
											<input class="input" name = "postPtype" type="text" placeholder="Cabin">
										</p>
									</div>
									<div class="row">
										Room Type
										<div class="field has-addons">
  										<p class="control is-expanded">
    										<span class="select is-fullwidth">
      										<select name="postRtype">
        										<option value="Private room">Private Room</option>
        										<option value="Shared room">Shared Room</option>
        										<option value="Entire house/apt">Entire House/APT</option>
      										</select>
    										</span>
  										</p>
										</div>
									</div>
									<div class="row">
										Accommodates
										<div class="field has-addons">
  										<p class="control is-expanded">
    										<span class="select is-fullwidth">
      										<select name="postAccommodates">
        										<option value="1">1</option>
        										<option value="2">2</option>
        										<option value="3">3</option>
        										<option value="4">4</option>
        										<option value="5">5</option>
        										<option value="6">6</option>
        										<option value="7">7</option>
        										<option value="8">8</option>
        										<option value="9">9</option>
        										<option value="10">10</option>
      										</select>
    										</span>
  										</p>
  										</div>
									</div>
									<div class="row">
										Bedrooms
										<div class="field has-addons">
  										<p class="control is-expanded">
    										<span class="select is-fullwidth">
      										<select name="postBedrooms">
        										<option value="1">1</option>
        										<option value="2">2</option>
        										<option value="3">3</option>
        										<option value="4">4</option>
        										<option value="5">5</option>
        										<option value="6">6</option>
        										<option value="7">7</option>
        										<option value="8">8</option>
        										<option value="9">9</option>
        										<option value="10">10</option>
      										</select>
    										</span>
  										</p>
  										</div>
									</div>
									<div class="row">
										Beds
										<div class="field has-addons">
  										<p class="control is-expanded">
    										<span class="select is-fullwidth">
      										<select name="postBeds">
        										<option value="1">1</option>
        										<option value="2">2</option>
        										<option value="3">3</option>
        										<option value="4">4</option>
        										<option value="5">5</option>
        										<option value="6">6</option>
        										<option value="7">7</option>
        										<option value="8">8</option>
        										<option value="9">9</option>
        										<option value="10">10</option>
      										</select>
    										</span>
  										</p>
  										</div>
									</div>
									<div class="row">
										Bed Type
										<p class="control">
											<input class="input" name = "postBtype" type="text" placeholder="Air bed">
										</p>
									</div>
									<div class="row">
										Bathrooms
										<div class="field has-addons">
  										<p class="control is-expanded">
    										<span class="select is-fullwidth">
      										<select name="postBathrooms">
        										<option value="0">0</option>
        										
        										<option value="1">1</option>
        										
        										<option value="2">2</option>
        										
        										<option value="3">3</option>
        										
        										<option value="4">4</option>
        										
      										</select>
    										</span>
  										</p>
  										</div>
									</div>
									<div class="row">
										Price
										<p class="control">
											<input class="input" name = "postPrice" type="text" placeholder="100">
										</p>
									</div>
									<div class="row">
										Cleaning Fee
										<p class="control">
											<input class="input" name = "postClean_fee" type="text" placeholder="50">
										</p>
									</div>
									<hr>
									<div class="row">
										<p class="control">
											<button class="btn btn-default btn-lg btn-success" type="submit" id = "view1">Post</button>
											
										</p>
									</div>
								</div>
							</div>
							</form>
						</div>
					</div>
				</div>
			</section>
		</div>
		</body>
</html>