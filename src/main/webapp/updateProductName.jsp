<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- font awesome cdn -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<title>Add Product In stock</title>
</head>
<body class="bg-light">

<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
<core:import url="navbar.jsp"></core:import>
<core:if test="${sessionScope.loggedIn}">
	<div class="container mt-5">
	<!-- success message -->
	<core:if test="${sessionScope.productNameUpdated == 'updated'}">
	<!-- message -->
	<div class="row justify-content-center ">
			<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
			  <strong>Success! </strong> Product ${sessionScope.product_name_in_stock} is added successfully.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
	<!-- failed message -->
	<core:if test="${sessionScope.product_available_in_Stock == 'exception'}">
	<!-- message -->
	<div class="row justify-content-center ">
			<div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
			  <strong>Oops! </strong> Product ${sessionScope.product_name_in_stock} is already available in stock.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
	
		<!-- heading -->
		<div class="row justify-content-center">
			<div class="col col-5 mt-5">
			<h3>Update Product </h3>
			</div>
		</div>
		<!-- form container -->
	<!-- form row -->
		<div class="row justify-content-center ">
			<div class="col col-5 border border-success px-5  bg-white rounded">
				
				<!--  form -->
				<form class="mb-5" action="updateProductName" method="post">
				  <div class="mb-3">
				    <label for="product_name_in_stock" class="form-label mt-3"><i class="bi bi-cart"></i> Product ID</label>
				    <input type="text" class="form-control" id="product_name_in_stock" name="productIDForUpdateProductName" readonly value="${param.product_id }">
				    </div>
				    
				    <div class="mb-3">
				    <label for="product_name_in_stock" class="form-label mt-3"><i class="bi bi-cart"></i> Product Name</label>
				    <input type="text" class="form-control" id="product_name_in_stock" name="ProductNameForUpdateProductName" required value="${param.product_name }">
				    </div>				  
				  
				  <div class="mb-3">
				    <label for="product_quantity_in_stock" class="form-label"><i class="fa-solid fa-scale-balanced"></i> Product Quantity (kg/L)</label>
				    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control " id="product_quantity_in_stock" value="${param.product_quantity}" maxlength="65" name="productQuantityInStock" readonly >
				  </div>
				  
				  <div class="row justify-content-center mt-3">
					  <div class="col col-4 mt-3">
					  	<button type="submit" class="btn btn-success btn-sm"><i class="bi bi-cart-plus"></i> Update Product</button>
					  </div>
				  </div>
			</form >
			
			</div>
			
		</div>
		
			<core:import url="footer.jsp"></core:import>
		
	</div>
	
</core:if>
<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
</body>
</html>