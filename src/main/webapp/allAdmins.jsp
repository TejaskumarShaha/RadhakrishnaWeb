<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Admins</title>
</head>
<body class="bg-light">
<core:if test="${sessionScope.loggedIn}">
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	<!--  admins table -->
	<sql:query dataSource="${con}" var="admins">
		select * from admins;
	</sql:query>
	<core:import url="navbar.jsp"></core:import>
<div class="container mt-3">
<core:if test="${sessionScope.is_admin}">
	
<div class="row justify-content-md-center ">
<div class="col col-12 ">
<!-- all borrowers table -->
<table class="table table-bordered border-success table-success table-hover table-striped text-center" border="1">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Admin ID</th>
      <th scope="col">Name</th>
      <th scope="col">Mobile Number</th>
      <th scope="col">Update</th>
      <!-- <th scope="col">Delete</th> -->
    </tr>
  </thead>
  <tbody>
  <core:forEach  var="data" items="${admins.rows}" varStatus="i">
    <tr>
      <td>${i.count}</td>
      <td>${data.id}</td>
      <td>${data.admin_name}</td>
      <td>${data.mobile}</td>
      <td><a href="updatePasswordForm.jsp?id=${data.id}&name=${data.admin_name}" class="btn btn-success btn-sm mx-2" >Update Password</a></td>
	  <!-- <td><a href="#" class="btn btn-danger btn-sm mx-2" >delete </a></td>	 -->		    
    </tr>
 </core:forEach>
  </tbody>
</table>
</div>
</div>	
</core:if>
</div>
</core:if>	
</body>
</html>