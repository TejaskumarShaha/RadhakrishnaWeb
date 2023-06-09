<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Sales</title>
</head>
<body>
<core:if test="${sessionScope.loggedIn}">
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
		<core:catch var="CatchException">
			<sql:query dataSource="${con}" var="products_in_stock">
					select * from products order by product_name asc;	
			</sql:query>
		</core:catch>
		
		<core:catch var="CatchException">
			<sql:query dataSource="${con}" var="stockRoom">
					select * from stockRoom order by stock_room_name asc;	
			</sql:query>
		</core:catch>
		
<core:import url="navbar.jsp"></core:import>
<div class="container mt-5">
	<div class="row">
		<div class="col">
			
				<!-- failed message -->
	<core:if test="${sessionScope.exception == 'quantityNotInstock'}">
	<!-- message -->
	<div class="row justify-content-center ">
			<div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
			  <strong>Oh dear! </strong> Quantity not available in the Stock Room for <b>${sessionScope.product_name_in_stock}</b> so please change prodcut name or stock room.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
	<!-- failed message -->
	<core:if test="${sessionScope.exception == 'quantityNotInProducts'}">
	<!-- message -->
	<div class="row justify-content-center ">
			<div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
			  <strong>Oh dear! </strong> Quantity not available in the Products for <b>${sessionScope.product_name_in_stock}</b>  so please change prodcut name or stock room.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
	
	<core:if test="${sessionScope.addedToSalesStatus == 'added'}">
	<!-- message -->
	<div class="row justify-content-center ">
			<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
			  <strong>Success! </strong> Sales added for product <strong>${prodcut_name }</strong> from stock room <strong>${sessionScope.store_room_name }</strong>.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
	
	<core:if test="${sessionScope.exception == 'ProductnotAvailableInStock'}">
	<!-- message -->
	<div class="row justify-content-center ">
			<div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
			  <strong>Oh dear! </strong> Product not available in selected stock room.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
				
			<!-- heading -->
		<div class="row justify-content-center">
			<div class="col col-5 ">
			<h3>Add Sales </h3>
			</div>
		</div>	
	<!-- form container -->
	<!-- form row -->
		<div class="row justify-content-center ">
			<div class="col col-5 border  px-5  bg-white rounded">
				
				<!--  form -->
				<form class="mb-5" action="addSaleLogic.jsp" method="post">
				<label for="productName" class="form-label mt-3"><i class="bi bi-cart"></i> Product Name</label>
    
				  <select class="form-select" aria-label="Default select example" name="productid" id="productName" required>
				  <option value="">Choose Product Name</option>
				  <core:forEach var="data" items="${products_in_stock.rows}">
				  	<option value="${data.id}">${data.product_name}</option>
				  </core:forEach>
				</select>
				<br>
				
				<label for="productStockRoom " class="form-label"><i class="bi bi-cart"></i> Choose Stock room</label>
				<select class="form-select" aria-label="Default select example" name="stockroomid" id="productStockRoom" required>
				  <option value="">Choose Stock Room</option>
				  <core:forEach var="data" items="${stockRoom.rows}">
				  	<option value="${data.id}">${data.stock_room_name}</option>
				  </core:forEach>
				</select>
				<br>
				  
				  <div class="mb-3">
				    <label for="price" class="form-label"><i class="fa-solid fa-scale-balanced"></i>  Sales Quantity</label>
				    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control " id="price" name="sales_quantity" placeholder="type sales quantity..." required>
				  </div>
					
				  <div class="mb-3">
				    <label for="date" class="form-label"><i class="bi bi-calendar-plus"></i> Sales Date</label>
				    <input  class="form-control date" id="date" type="date" name="sales_add_date" required>
				  </div>
				  
				  <div class="row justify-content-center mt-3 text-center">
					  <div class="col mt-3">
					  	<button type="submit" class="btn btn-success btn-sm"><i class="bi bi-cart-sub"></i> Add Sales</button>
					  </div>
				  </div>
			</form >
			</div>
			
		</div>
		<core:import url="footer.jsp"></core:import>
		</div>
	</div>
</div>

<core:remove var="exception"></core:remove>
<core:remove var="addedToSalesStatus"></core:remove>
<core:remove var="product_name_in_stock"></core:remove>
</core:if>
<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
</body>
</html>