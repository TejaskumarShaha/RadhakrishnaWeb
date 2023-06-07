<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>Admin Panel</title>
</head>

<body class="bg-light">
<!-- navbar -->
<core:import url="navbar.jsp"></core:import>

<core:if test="${sessionScope.loggedIn}">
<!-- jstl -->
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	<!-- stock -->
	<sql:query dataSource="${con}" var="stock">
		select * from products;
	</sql:query>
	<!-- billings -->
	<sql:query dataSource="${con}" var="billings">
		select * from billings;
	</sql:query>
	
	<!-- billings for today-->
	<sql:query dataSource="${con}" var="billingsToday">
		select * from billings where product_add_date = current_date();
	</sql:query>
	
	<!-- billings for today-->
	<sql:query dataSource="${con}" var="billingsYesterday">
		select * from billings where product_add_date = date_sub(current_date(),interval 1 day);
	</sql:query>
	<!--  admins table -->
	<sql:query dataSource="${con}" var="admins">
		select * from admins;
	</sql:query>
	<!-- operators table -->
	<sql:query dataSource="${con}" var="operators">
		select * from operators;
	</sql:query>
	<!-- borrowers table -->
	<sql:query dataSource="${con}" var="borrowers">
		select * from borrowers;
	</sql:query>
	<!-- Stock Room-->
	<sql:query dataSource="${con}" var="stockRoom">
		select * from stockRoom;
	</sql:query>

<!-- message -->
<core:if test="${sessionScope.passwordUpdateStatus}">
	<div class="container mt-3">
	<div class="alert alert-info alert-dismissible fade show text-center" role="alert">
		  <strong>Success! </strong> Password Updated Successfully for ID : <b>${sessionScope.passwordUpdateId }</b>.
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>
</div>
</core:if>
<div class="container mt-5">
<div class="row justify-content-center ">
<div class="col col-12  px-4 py-4 rounded border bg-white" >
<!-- wrapper container ends -->

	
<div class="row justify-content-center ">
<core:if test="${sessionScope.is_admin}">
<div class="col-4 mt-2 ">
    <div class="card border border-success bg-light">
      <div class="card-body">
        <h5 class="card-title"><i class="bi bi-cart"></i> Product Stock </h5>
        <p class="card-text">All Products in Stock <b>( ${stock.rowCount} ) </b> </p>
        <a href="allProducts.jsp" class="btn btn-sm btn-info "><i class="bi bi-cart"></i> All Products in  Stock</a>
      <a href="addProductInStock.jsp" class="btn btn-sm btn-warning "><i class="bi bi-cart-plus"></i> Add Product to Stock</a>
      </div>
    </div>
  </div>
  
  <div class="col-4 mt-2">
    <div class="card border border-success bg-light">
      <div class="card-body">
        <h5 class="card-title">Stock Room </h5>
        <p class="card-text">All Stock Room(s) <b> ( ${stockRoom.rowCount} )</b></p>
        <a href="stockRoom.jsp" class="btn btn-sm btn-info"><i class="bi bi-eye"></i> View all Stock Rooms</a>
      	<a href="addStockRoom.jsp" class="btn btn-sm btn-warning"><i class="bi bi-shop"></i> Add Stock Room</a>
      </div>
    </div>
  </div>
  
  
  <div class="col-4 mt-2">
    <div class="card border border-success bg-light">
      <div class="card-body">
        <h5 class="card-title">Dealers</h5>
        <p class="card-text">All Dealers <b>( )</b></p>
        <a href="#" class="btn btn-sm btn-info"><i class="bi bi-eye"></i> View all Dealer</a>
      </div>
    </div>
  </div>
  
  
  <div class="col-4 mt-2">
    <div class="card border border-success bg-light">
      <div class="card-body">
        <h5 class="card-title"><i class="bi bi-journal-text"> </i>Ledger</h5>
        <p class="card-text">All Ledger <b>( )</b></p>
        <a href="#" class="btn btn-sm btn-info"><i class="bi bi-eye"></i> View all Ledger</a>
      </div>
    </div>
  </div>  
   
  <!-- admins -->
  <div class="col-4 mt-2 ">
    <div class="card border border-success bg-light">
      <div class="card-body">
        <h5 class="card-title"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-person-gear" viewBox="0 0 16 16">
  			<path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0ZM8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm.256 7a4.474 4.474 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10c.26 0 .507.009.74.025.226-.341.496-.65.804-.918C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4s1 1 1 1h5.256Zm3.63-4.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382l.045-.148ZM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0Z"/>
			</svg>  Admins</h5>
        <p class="card-text">All Admins <b>( ${admins.rowCount} ) </b> </p>
        <a href="allAdmins.jsp" class="btn btn-sm btn-info "><i class="bi bi-eye"></i> View all Admins</a>
      </div>
    </div>
  </div>
  
  <div class="col-4 mt-2">
    <div class="card border border-success bg-light">
      <div class="card-body">
        <h5 class="card-title"><i class="bi bi-cart-check"></i> billings <b>( ${billings.rowCount} )</b></h5>
        <p class="card-text"> Last Day billings <b>( ${billingsYesterday.rowCount} )</b> | Today billings Today <b>( ${billingsToday.rowCount} )</b> </p>
        <a href="allBillings.jsp" class="btn btn-sm btn-info"><i class="bi bi-eye"></i> View All billings</a>
         <a href="addBilling.jsp" class="btn btn-sm btn-warning"><i class="bi bi-journal-plus"></i> Add Billings</a>
      
      </div>
    </div>
  </div>
  
  <div class="col-4 mt-2">
    <div class="card border border-success bg-light">
      <div class="card-body">
        <h5 class="card-title"><i class="bi bi-receipt"></i> Sales</h5>
        <p class="card-text">Today Sales <b>( ) </b>| Last Day Sale <b>( ) </b></p>
        <a href="#" class="btn btn-sm btn-info"><i class="bi bi-eye"></i> View Total Sales</a>
        <a href="#" class="btn btn-sm btn-warning">Add Sale</a>
        
      </div>
    </div>
  </div>
  
  <div class="col-4 mt-2">
    <div class="card border border-success bg-light">
      <div class="card-body">
        <h5 class="card-title"><i class="bi bi-person"></i> Operators Account</h5>
        <p class="card-text">Total Operators <b> (  ${operators.rowCount} )</b></p>
        <a href="allOperators.jsp" class="btn btn-sm btn-info"><i class="bi bi-eye"></i> View all Operators</a>
        <a href="addOperatorForm.jsp" class="btn btn-sm btn-warning"><i class="bi bi-person-plus"></i> Add new Operator</a>
      </div>
    </div>
  </div> 
  <div class="col-4 mt-2">
    <div class="card border border-success bg-light">
      <div class="card-body">
        <h5 class="card-title"> <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-exclamation" viewBox="0 0 16 16">
  <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0ZM8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm.256 7a4.474 4.474 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10c.26 0 .507.009.74.025.226-.341.496-.65.804-.918C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4s1 1 1 1h5.256Z"/>
  <path d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Zm-3.5-2a.5.5 0 0 0-.5.5v1.5a.5.5 0 0 0 1 0V11a.5.5 0 0 0-.5-.5Zm0 4a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1Z"/>
</svg> Borrowers <b>(${borrowers.rowCount} )</b></h5>
        <!-- search borrowers  -->
         <form action="searchBorrowersResult.jsp" class="d-flex col-8 mb-2" style="margin-top:-5px" >
	        <input class="form-control me-2 col-4" type="search" placeholder="Search Borrower by name..." aria-label="Search" name="searchBorrowerFor" required>
	        <button class="btn btn-sm  btn-success col-2" type="submit"  title="Click to Search for borrowers" ><i class="bi bi-search" ></i> </button>
      	</form>
        <a href="allBorrowers.jsp" class="btn btn-sm btn-info"><i class="bi bi-eye"></i> View all Borrowers</a>
        <a href="addBorrower.jsp" class="btn btn-sm btn-warning"><i class="bi bi-person-add"></i><i class="bi bi-person-plus"></i> Add new Borrowers</a>
      </div>
    </div>
  </div>
  
  
  
  
  
  </core:if>
  <!-- row ends -->
  
 </div>
 <!-- ends checking admin -->
 <core:if test="${not sessionScope.is_admin}">
 <div class="row justify-content-center mt-5">
 	<div class="col col-7 border px-2 py-2 mt-5 rounded text-center border-danger">
 		<h3 class="text-denager">Oops! You are not authorized to see this page</h3> <br>
 	</div>
 </div>
 <!-- ends checking not admin  -->
 </core:if>
 <!-- ends checking logged in -->
 
 <core:if test="${not sessionScope.loggedIn}">
 <div class="row justify-content-center mt-5">
 	<div class="col col-6 border px-2 py-2 mt-5 rounded text-center border-danger">
 		<small>Oops! You are not Logged In</small> <br>
 		<a href="login.jsp" class="btn btn-sm btn-primary mt-2">Login</a>
 	</div> 	
 </div>
 </core:if>
<!-- wrapper container ends -->
</div>
</div>
<core:import url="footer.jsp"></core:import>
</div>
<core:remove var="passwordUpdateStatus"/>
<core:remove var="passwordUpdateId"/> 
</core:if>
<core:if test="${not sessionScope.loggedIn  }">
<div class="container mt-5">
	<div class="row justify-content-center mt-5">
		<div class="col col-6 text-center mt-5 border border-danger  px-3 py-3 rounded">
			<h2 class="text-danger">Oops! you are not logged in </h2>
			<small>You have to login again to view this page</small><br><br>
			<a href="login.jsp" class="btn btn-sm btn-warning">LogIn</a>
		</div>
	</div>
</div>
	
</core:if>
</body>
</html>