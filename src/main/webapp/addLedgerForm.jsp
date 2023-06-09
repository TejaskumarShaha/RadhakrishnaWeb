<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Ledger</title>
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
	<sql:query dataSource="${con}" var="allDealers">
		select * from dealers order by shop_name asc;
	</sql:query>
	
	<sql:query dataSource="${con}" var="allProducts">
		select * from products order by product_name asc;
	</sql:query>
	
	</core:catch>
<core:import url="navbar.jsp"></core:import>
<div class="container ">


<div class="row justify-content-center px-4 py-4 border rounded bg-white mb-2 mt-2">
	<!-- remaining balance result -->
	<core:if test="${sessionScope.remainingBalance ge 0}">
		<sql:query var="shopName" dataSource="${con}">
			select shop_name from dealers where id =?
			<sql:param value="${sessionScope.shopID}"></sql:param>
		</sql:query>
		
		<core:forEach items="${shopName.rows}" var="data">
			<core:set var="shopnameforresult" value="${data.shop_name}"></core:set>
		</core:forEach>
		
		<div class="row justify-content-center mb-2 text-center" >
			<div class="col col-8">Shop Name: <strong> ${shopnameforresult} </strong> | Remaining Balance: <i class="fa-solid fa-indian-rupee-sign"></i> <strong> ${sessionScope.remainingBalance}</strong></div>
		</div>
	</core:if>
	<!-- form-->
	
	<div class="col col-5 ">
		<form action="SearchReaminingBalance" method="post" class="d-flex " >
	        <select class="form-select " style="margin-right:5px" aria-label="Default select example" name="shopIdSearchRemainingBalance" id="productName"  required>
	  			<option value="">Choose Shop Name for searching remianing balance</option>
	  			<core:forEach var="data" items="${allDealers.rows}">
	  				<option value="${data.id}">${data.shop_name}</option>
	  			</core:forEach>
			</select>
			<button class="btn btn-sm  btn-primary col-1" type="submit"  title="Click to Search reamaing balance according to the selected shop name"><i class="bi bi-search"></i> </button>
      </form>
	</div>
	
</div>
<!-- message -->
<core:if test="${sessionScope.messageForInsertLedger}">
<!-- message -->
<div class="row">
	<div class="col">
		<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
		  <strong>Success! </strong> Ledger added for <b>${sessionScope.shop_name}</b>  successfully.
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</div>
</div>
</core:if>
<!-- form conainer -->
<div class="row">
<!-- for buttons -->
	<div class="col col-2">
	<a class="btn btn-sm btn-info" href="addDealers.jsp"><i class="fa-solid fa-store"></i> Add Dealer Shop</a>
	</div>
	<div class="col col-8">
		<h4>Add New Ledger</h4>
	</div>
	<div class="col col-2">
	<a class="btn btn-sm btn-primary" href="allLedgers.jsp"><i class="fa-solid fa-book"></i> All Ledgers</a>
	</div>
</div>
<div class="row  justify-content-center">
<div class="col col-8 px-4 rounded bg-white border py-4">
<form class="mb-5 " action="addLedgerLogic" method="post">
<!-- select product -->
<div class="row justify-content-center">
<div class="col col-6">
<label for="productName" class="form-label"><i class="fa-solid fa-store"></i> Shop Name</label>
  <select class="form-select" aria-label="Default select example" name="shopId" id="id"  required>
  <option value="">Choose Shop Name</option>
  <core:forEach var="da" items="${allDealers.rows}">
  	<option value="${da.id}">${da.shop_name}</option>
  </core:forEach>
</select>
</div>
<div class="col col-6">
<label for="productStockRoom " class="form-label"><i class="bi bi-cart"></i> Choose Product</label>
<select class="form-select" aria-label="Default select example" name="product_id" id="productStockRoom" required>
  <option value="">Choose Product Room</option>
  <core:forEach var="data" items="${allProducts.rows}">
  	<option value="${data.id}">${data.product_name}</option>
  </core:forEach>
</select>
</div>
</div>
<!-- first row ends -->
<div class="row justify-content-center mt-3">
  <div class="mb-3 col-6">
    <label for="quantity" class="form-label"><i class="fa-solid fa-scale-unbalanced-flip"></i> Product Quantity</label>
    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control date" id="quantity" name="product_quantity" placeholder="type product quantity in kg" required>
    
    </div>
  
  <div class="mb-3 col-6">
    <label for="date" class="form-label"><i class="bi bi-calendar-plus"></i> Date</label>
    <input  class="form-control date" id="date" type="date" name="ledger_add_date" required>
  </div>
 </div>
 <!-- second row end -->
  <div class="row justify-content-center mt-3">
  <div class="mb-3 col-6">
    <label for="price" class="form-label"><i class="bi bi-cash-coin"></i> Product Net Price</label>
    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control " id="price" name="product_net_price" placeholder="type product net price here..." required>
  </div>
 
  <div class="mb-3 col-6">
    <label for="tax" class="form-label"><i class="fa-solid fa-hand-holding-dollar"></i> Credit Rupees </label>
    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control " id="tax" name="credit_rupee" placeholder="type product tax here..." required>
  </div>
  </div>
  <!-- third row ends -->
  
      
  <div class="row justify-content-center mt-3">
  <div class="col text-center">
  <button type="submit" class="btn btn-success btn-sm"><i class="fa-solid fa-file-invoice-dollar"></i> Add Ledger</button>
  </div>
  </div>
</form >
</div>
</div>
<core:import url="footer.jsp"></core:import>
</div>
<core:remove var="messageForInsertLedger"></core:remove>
<core:remove var="shop_name"></core:remove>
</core:if>
<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>

</body>
</html>