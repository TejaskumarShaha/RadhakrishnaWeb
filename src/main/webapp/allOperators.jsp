<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/adminPanel.css">
<title>All Products</title>
</head>

<body class="bg-light">
<core:if test="${sessionScope.loggedIn}">
<!-- navbar -->
<core:import url="navbar.jsp"></core:import>
<!-- jstl -->
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	<sql:query dataSource="${con}" var="rs">
		select * from operators ;
	</sql:query>	
<div class="container col-10 mt-3">
	<div class="row justify-content-md-center">
		<div class="col col-12 bg-white py-2 px-4 rounded">
			<core:if test="${sessionScope.loggedIn}">
				<core:if test="${sessionScope.is_admin}">
				<core:if test="${rs.rowCount > 0}">
					<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
					   All Operators <strong>( ${rs.rowCount} )</strong>
					  </div>
					<table class="table  table-bordered  table-striped text-center">
					  <thead>
					    <tr>
					    <th scope="col">#</th>
					    <th scope="col">Operator ID</th>
					      <th scope="col">Operator Name</th>
					      <th scope="col">Mobile</th>
					      <th scope="col">Joining Date</th>
					      <th scope="col">Salary</th>
					      <th scope="col">Update</th>
					      <th scope="col">Delete</th>
					    </tr>
					  </thead>
					  <tbody>
					  <core:forEach  var="operator" items="${rs.rows}" varStatus="i">
					    <tr>
					    <td >${i.count}</td>
					    <td >${operator.id}</td>
					      <td >${operator.operater_name}</td>
					      <td>${operator.mobile}</td>
					      <td> <fmt:formatDate type = "date" 
					         value = "${operator.operater_joining_date}" /></td>
					      <td>${operator.salary}</td>
					      
					      <td><a href="#" class="btn btn-success btn-sm mx-2" >Update</a></td>
					      <td><a href="#" class="btn btn-danger btn-sm mx-2" >delete </a></td>
					    </tr>
					 </core:forEach>
					  </tbody>
					</table>
					</core:if>
					<core:if test="${rs.rowCount eq 0}">
						<div class="row justify-content-center mt-5">
						<div class="col col-6 border border-danger rounded text-center mt-5">
						<h2 class="mt-3">There is no Product in the Stock<i><span style="color:red">${param.searchProductFor}</span></i></h2>
						<a href="addProduct.jsp" class="btn btn-sm btn-success mt-1 mb-3">Add Products</a> 
						</div>
						</div>
					</core:if>
					</core:if>
					</core:if>
					<core:if test="${sessionScope.loggedIn==null}">
					<div class="container">
						<div class="row justify-content-center mt-5">
							<div class="col col-6 mt-5 text-center border border-danger rounded px-5 py-5">
								<h3 style="color:red">Oops! It seems that you are not logged In </h3>
								<small>You have to login first to visit this page </small><br>
								<a href="login.jsp" class="btn btn-sm btn-success w-25 mt-4"><i class="bi bi-box-arrow-in-right"></i> Login</a>
							</div>
						</div>
				    </div>
			</core:if>
		</div>
		<core:import url="footer.jsp"></core:import>
	</div>
	
</div>
<script src="./js/adminPanel.js"></script>
</core:if>
<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
</body>
</html>