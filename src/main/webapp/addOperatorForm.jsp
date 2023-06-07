<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Operator</title>
</head>
<style>
#hidePassword{
	display:none;
}
</style>
<body class="bg-light">
<core:import url="navbar.jsp"></core:import>
<!-- check for logged in -->
<core:if test="${sessionScope.loggedIn}">
<!-- checks for admin -->
<core:if test="${sessionScope.is_admin}">
	<div class="container mt-4">
	<!-- message -->
	<core:if test="${sessionScope.operatorAddStatus != null}">
		<div class="row justify-content-center ">
			<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
			  <strong>Success! </strong> Operator ${sessionScope.operator_name} is added successfully.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
		<!-- heading -->
		<div class="row justify-content-center">
			<div class="col col-5">
			<h3>Add New Operator</h3>
			</div>
		</div>
		<!-- form container -->
		<div class="row justify-content-center">
			<div class="col col-5 border px-4 py-3 rounded bg-white">
			<!--  form -->
			
				<form class="mb-5" action="addOperatorLogic.jsp" method="post">
				  <div class="mb-3">
				    <label for="operator_name" class="form-label"><i class="bi bi-person"></i> Operator Name</label>
				    <input type="text" class="form-control" id="operator_name" name="operatorName" required>
				    </div>				  
				  <div class="mb-3">
				    <label for="operator_joining_date" class="form-label"><i class="bi bi-calendar-plus"></i> Joining Date</label>
				    <input type="date" class="form-control date" id="operator_joining_date" name="joiningDate" required>
				  </div>
				 
				  <div class="mb-3">
				    <label for="product_price" class="form-label"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-currency-rupee" viewBox="0 0 16 16">
  					<path d="M4 3.06h2.726c1.22 0 2.12.575 2.325 1.724H4v1.051h5.051C8.855 7.001 8 7.558 6.788 7.558H4v1.317L8.437 14h2.11L6.095 8.884h.855c2.316-.018 3.465-1.476 3.688-3.049H12V4.784h-1.345c-.08-.778-.357-1.335-.793-1.732H12V2H4v1.06Z"/>
					</svg> Salary</label>
				    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" class="form-control " id="operator_Salary" name="operatorSalary" required>
				  </div>
				  
				  <div class="mb-3">
				    <label for="product_tax" class="form-label"><i class="bi bi-phone"></i> Mobile</label>
				    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" maxlength="10" min="10" class="form-control " id="operator_mobile" name="operatorMobile" required>
				  </div>
				 <div class="mb-3">
			    <label for="password" class="form-label"><i class="bi bi-key"></i> Create Pasword</label>
			    <input type="password"  class="form-control date" id="password" name="operatorPassword" placeholder="Create Password..." required>
			    </div>
			  <div class="mb-3 "  id="showPasswordDiv">
			    <button type="button" title="click to show password" class="btn btn-sm btn-primary" id="show_password"><i class="bi bi-eye"></i> </button><br></div>
			   
			   <div class="mb-3  " id="hidePassword">
			    
			    <button type="button" title="click to hide password" class="btn btn-sm btn-danger" id="hide_password"><i class="bi bi-eye-slash"></i> </button><br>
			   </div>
				 
				  <div class="row justify-content-center">
					  <div class="col col-4">
					  	<button type="submit" class="btn btn-info btn-sm"><i class="bi bi-person-plus"></i> Add Operator</button>
					  </div>
				  </div>
			</form >
			
			</div>
		</div>
		<core:import url="footer.jsp"></core:import>
	</div>
<!-- end checks for admin logged in -->
</core:if>
<!-- user not admin -->
<core:if test="${not sessionScope.is_admin}">
<div class="container  mt-5">
	<div class="row justify-content-center mt-5">
		<div class="col col-6 border border-danger mt-5 text-center px-5 py-5 rounded">
			<strong class="text-danger">Oops you are not authorized to view this page</strong><br><br>
			<a href="operatorPanel.jsp" class="btn btn-sm btn-info">Operator Panel</a>
		</div>
	</div>
</div>
</core:if>
<!-- end checks for logged in -->
</core:if>
 <script>
		var showPassword 	= document.getElementById("show_password");
		var hidePassword 	= document.getElementById("hide_password");
		var password	 	= document.getElementById("password");
		var showPasswordDiv = document.getElementById("showPasswordDiv");
		var hidePasswordDiv = document.getElementById("hidePassword");
		
		showPassword.addEventListener("click",()=>{
			password.type="text";
			showPasswordDiv.style.display="none";
			hidePasswordDiv.style.display="block";
		});
		
		hidePassword.addEventListener("click",()=>{
			password.type="password";
			showPasswordDiv.style.display="block";
			
			hidePasswordDiv.style.display="none";
		});
		
	</script>
	<!-- removing operator add status var from session -->
	<core:remove var="operatorAddStatus"></core:remove>
	<core:remove var="operator_name"></core:remove>
</body>
</html>