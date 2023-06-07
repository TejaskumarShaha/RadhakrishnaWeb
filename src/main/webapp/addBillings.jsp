<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" >
<meta charset="ISO-8859-1">
<title>Add Billings</title>
</head>
<body class="bg-light">
${exceptionInJoin }
${sessionScope.addProdcutToTheStockRoom }
<core:import url="navbar.jsp"></core:import>
<core:if test="${sessionScope.loggedIn}">
<!-- jstl data base connectivity -->

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
<div class="container mt-3">
<div class="row justify-content-center">
<!-- messages -->	
	<!-- if product Billing added -->
	<core:if test="${sessionScope.exception eq 'notexception'}">
		<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
			  <strong>Success! </strong> Product Billing for product <b> ( ${sessionScope.product_name_in_products} )</b> is added successfully!.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</core:if>
	<core:if test="${sessionScope.exception eq 'exception'}">
		<div class="alert alert-info alert-dismissible fade show text-center" role="alert">
			  <strong>Success! </strong> Billing added for product <b> ( ${sessionScope.product_name_in_products} )</b> successfully!.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</core:if>
</div>
<!-- buttons for navigate-->
<div class="row">
	<div class="col col-3">
		<a href="addProductInStock.jsp" class="btn btn-sm btn-primary"><i class="bi bi-cart-plus"></i> Add Product</a>
		<a href="#" class="btn btn-sm btn-warning"><i class="bi bi-shop"></i> Add Stock Room</a>
	</div>
	<div class="col col-6">
		<h2>Add Billings <core:if test="${param.addBillingFor}">for ${param.addBillingFor}</core:if></h2>
		
	</div>
</div>
<!-- form container -->
<!-- form -->
<div class="row justify-content-center">
<div class="col col-6 border px-4 py-4 bg-white rounded">
<form class="mb-5 " action="addBillingLogic.jsp" method="post">
<!-- select product -->

<label for="productName" class="form-label mt-3"><i class="bi bi-cart"></i> Product Name</label>
    
  <select class="form-select" aria-label="Default select example" name="id" id="productName"  required>
  <option value="">Choose Product Name</option>
  <core:forEach var="data" items="${products_in_stock.rows}">
  	<option value="${data.id}">${data.product_name}</option>
  </core:forEach>
</select>
<br>
<label for="productStockRoom " class="form-label"><i class="bi bi-cart"></i> Choose Stock room</label>
<select class="form-select" aria-label="Default select example" name="stock_room_id" id="productStockRoom" required>
  <option value="">Choose Stock Room</option>
  <core:forEach var="data" items="${stockRoom.rows}">
  	<option value="${data.id}">${data.stock_room_name}</option>
  </core:forEach>
</select>
<br>
  <div class="mb-3">
    <label for="quantity" class="form-label"><i class="bi bi-scale"></i> Product Quantity</label>
    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control date" id="quantity" name="product_quantity" placeholder="type product quantity in kg" required>
    </div>
  <br>
  <div class="mb-3">
    <label for="date" class="form-label"><i class="bi bi-calendar-plus"></i> Product Billing Date</label>
    <input  class="form-control date" id="date" type="date" name="product_add_date" required>
  </div>
  <br>
  <div class="mb-3">
    <label for="product_manufacturing_date" class="form-label">Manufacturing Date</label>
    <input type="date" class="form-control date" id="product_manufacturing_date" name="manufacturing_date" required>
  </div>
  
  <br>
  <div class="mb-3">
    <label for="product_expiry_date" class="form-label">Expiry Date</label>
    <input type="date" class="form-control date" id="product_expiry_date" name="expiry_date" required>
  </div>
  
  <br>
  <div class="mb-3">
    <label for="price" class="form-label"><i class="bi bi-cash-coin"></i> Product Net Price</label>
    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control " id="price" name="product_price" placeholder="type product net price here..." required>
  </div>
  
  <br>
  <div class="mb-3">
    <label for="tax" class="form-label">Tax</label>
    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control " id="tax" name="product_tax" placeholder="type product tax here..." required>
  </div>
  
  <br>
  <div class="mb-3">
    <label for="discount" class="form-label">Product Discount</label>
    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control " id="discount" name="product_discount" placeholder="type product discount here..." required>
  </div>
      
  <div class="row justify-content-center mt-5">
  <div class="col text-center">
  <button type="submit" class="btn btn-success "><i class="bi bi-check2-all"></i> Add Product</button>
  </div>
  </div>
</form >
</div>
</div>
</div>
</div>
<core:import url="footer.jsp"></core:import>
</div>
</core:if>
<core:if test="${not sessionScope.loggedIn}">
<div class="container">
	<div class="row justify-content-center mt-5">
		<div class="col col-6 mt-5 text-center border border-danger rounded px-5 py-5">
			<h3 style="color:red">Oops! It seems that you are not logged In </h3>
			<small>You have to login first to visit this page </small><br>
			<a href="login.jsp" class="btn btn-md btn-primary w-25 mt-4">Login</a>
			</div>
		</div>
		
	</div>
</core:if>
	<core:remove var="product_name_in_products"></core:remove>
	<core:remove var="exception"></core:remove>
	<core:remove var="notexception"></core:remove>
</body>
</html>