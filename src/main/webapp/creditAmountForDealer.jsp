<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Credit Amount</title>
</head>
<body>
<core:if test="${sessionScope.loggedIn}">
<core:import url="navbar.jsp"></core:import>
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	
	<core:catch var="CatchException">
	<sql:query dataSource="${con}" var="allDealers">
		select * from dealers;
	</sql:query>
	</core:catch>

<div class="container mt-5">

<core:if test="${requestScope.creditAddStatus == 'success'}">
<!-- message -->
<div class="row">
	<div class="col">
		<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
		  <strong>Success! </strong> Credit Added For <b>${requestScope.shop_name_for_Dealer}</b> added successfully | Remaining Balance <strong>${requestScope.remaining_balance_ater_update} </strong>.
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</div>
</div>
</core:if>
<!-- failed message -->
<core:if test="${requestScope.creditAddStatus == 'failed'}">
<!-- message -->
<div class="row">
	<div class="col">
		<div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
		  <strong>Oh dear! </strong> Remaining Balance is less Than the Credit Amount for <b>${requestScope.shop_name_for_Dealer}</b> | Remaining Balance <strong>${requestScope.remaining_balance_ater_update} </strong>.
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</div>
</div>
</core:if>
	<div class="row justify-content-center">
		<div class="col col-8">
			<h2>Add Credit</h2>
		</div>
	</div>
	<!-- form container -->
	<div class="row justify-content-center ">
		<div class="col-8 border px-4 py-4 rounded bg-white">
			<form action="addCreditAmount" method="post">
			<div class="row">
				  <div class="col col-6">
						<label for="productStockRoom " class="form-label"><i class="bi bi-cart"></i> Shop Name</label>
						<select class="form-select" aria-label="Default select example" name="shop_name_in_credit_amount" id="productStockRoom" required>
						  <option value="">Choose Shop</option>
						  <core:forEach var="data" items="${allDealers.rows}">
						  	<option value="${data.id}">${data.shop_name}</option>
						  </core:forEach>
						</select>
					</div>
					<div class="col col-6">
					    <div class="mb-3">
					    <label for="borrowingPrice" class="form-label"><i class="fa-solid fa-coins"></i> Credit Amount</label>
					    <input type="text" class="form-control" id="borrowingPrice" oninput="this.value= this.value.replace(/[^\d.]/g, '')" placeholder="0.00"  name="creditAmount" required>
					  </div>
				  </div>
				 </div>
				 <!-- row 2 -->
				  <div class="row mt-3">
				  <div class="col col-6">
					  <div class="mb-3">
					    <label for="crediter_name" class="form-label"><i class="fa-regular fa-user"></i> Creditor Name</label>
					    <input type="text" class="form-control" id="crediter_name" name="CreditorName" required>
					  </div>
					 </div>
					 <div class="col col-6"> 
				  <div class="mb-3">
				    <label for="date" class="form-label"><i class="bi bi-calendar-check"></i> Date</label>
				    <input type="date" class="form-control" id="date" name="creditAddDate"  required>
				  </div>
				  </div>
				  </div>
				 
				<div class="row">
				<div class="col text-center">
				  <button type="submit" class="btn btn-sm btn-primary  mt-3"><i class="fa-solid fa-wallet" ></i> Add Credit</button>
				  </div>
				  </div>
			</form>
		</div>
		
	</div>
	
	<core:import url="footer.jsp"></core:import>
<!--  container end -->

</div>
</core:if>
<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
</body>
</html>