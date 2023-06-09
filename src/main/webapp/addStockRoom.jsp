<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<core:if test="${sessionScope.loggedIn }">
<core:import url="navbar.jsp"></core:import>
	<div class="container mt-5">
		<div class="row ">
			<div class="col mt-5">
			
				<!-- success message -->
	<core:if test="${sessionScope.exception == 'notexception'}">
	<!-- message -->
	<div class="row justify-content-center ">
			<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
			  <strong>Success! </strong> Stock Room <strong>${sessionScope.stock_room_name}</strong> is added successfully.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
	<!-- failed message -->
	<core:if test="${sessionScope.exception == 'exception'}">
	<!-- message -->
	<div class="row justify-content-center ">
			<div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
			  <strong>Oh dear! </strong> Stock Room <strong>${sessionScope.stock_room_name}</strong>  is already available.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
				
			<!-- heading -->
		<div class="row justify-content-center">
			<div class="col col-5 ">
			<h3>Add New Stock Room </h3>
			</div>
		</div>	
				<!-- form container -->
	<!-- form row -->
		<div class="row justify-content-center ">
			<div class="col col-5 border border-success px-5  bg-white rounded">
				
				<!--  form -->
				<form class="mb-5" action="addStockRoomLogic.jsp" method="post">
				  <div class="mb-3">
				    <label for="stock_room_name" class="form-label mt-3"><i class="bi bi-shop"></i> Stock Room Name</label>
				    <input type="text" class="form-control" id="stock_room_name" name="stockRoomName" required placeholder="type stock room name here">
				    </div>				  
				  
				  <div class="row justify-content-center mt-3 text-center">
					  <div class="col mt-3">
					  	<button type="submit" class="btn btn-success btn-sm"><i class="bi bi-shop"></i> Add Stock RoomProduct</button>
					  </div>
				  </div>
			</form >
			
			</div>
			
		</div>
		
		
			</div>
		</div>
	</div>
	<core:remove var="stock_room_name"></core:remove>
	<core:remove var="exception"></core:remove>
	</core:if>
	<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
</body>
</html>