<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script language="javascript" type="text/javascript">
function limitText(limitField, limitNum) {
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    }
}
</script>
</head>
<style>
#hidePassword{
	display:none;
}
</style>
<body class="bg-light">
<core:import url="navbar.jsp"></core:import>
<core:if test="${sessionScope.loggedIn != 'true'}">
<!-- message -->
<div class="container mt-5">
	<div class="row justify-content-center ">
		<div class="col col-10 text-center">
			<core:if test="${sessionScope.message!=null}">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
				  ${sessionScope.message}
				  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</core:if>
			
			<core:if test="${sessionScope.RightTimeToLogInToOperator == false}">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
				  Oh dear operator! you can't login right now you can only login between <strong>8Am to 9pm</strong>
				  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</core:if>
			
		</div>
	</div>
</div>
<!-- login container -->
<div class="container rounded bg-white border col-8">
<!-- login heading -->
<div class="row justify-content-center">
<div class="col col-9">
	<div class="mt-2"><h2> Login </h2></div>
</div>
</div>
<!-- login form -->
<div class="row justify-content-center " >

<div class="col col-5">
<form action="Login" method="post" class="mt-3 mb-5">
  <div class="mb-3">
    <label for="id" class="form-label"><i class="fa-solid fa-id-card"></i> Login ID</label>
    <input type="text" class="form-control" id="mobile" aria-describedby="emailHelp" name="id" required title="Enter you mobile number here" value="${sessionScope.idFailedAttempt}" maxlength="10" onKeyDown="limitText(this,10);" >
  </div>
  <div class="mb-3">
    <label for="exampleInputPassword1" class="form-label" ><i class="fa-solid fa-lock"></i> Password</label>
    <input type="password" class="form-control" id="exampleInputPassword1" name="password" required title="Enter you password here">
  </div>
  <div class="mb-3 form-check">
    <input type="checkbox" class="form-check-input" id="is_opeartor" name="is_operator" value="operator" >
    <label class="form-check-label" for="is_opeartor" title="check this to login as operator">Login as Operator</label><br>
   </div>
   
   <div class="mb-3 "  id="showPasswordDiv">
    <button type="button"  class="btn btn-sm btn-primary" title="click to show password" id="show_password"><i class="bi bi-eye"></i> </button><br></div>
   
   <div class="mb-3  " id="hidePassword">
    
    <button type="button" class="btn btn-sm btn-danger" title="click to hide password" id="hide_password"><i class="bi bi-eye-slash"></i> </button><br>
   </div>
   <div class="row justify-content-center">
  <div class="d-grid gap-2 col-6 mx-auto text-center">
  	<button type="submit" class="btn btn-success col-8" title="click here to login"><i class="fa-solid fa-right-to-bracket"></i> Login</button>
</div>
</div>
</form>
</div>
<!-- login form ends -->

<!-- login svg -->
<div class="col col-4 " style="margin-top:-50px">
	<img alt="Login Image" src="images/login-green.png" height="400px" width=400px title="Used from:https://storyset.com/user">
</div>
</div>
<core:import url="footer.jsp"></core:import>

</div>
</core:if>
<core:if test="${sessionScope.loggedIn}">
<div class="row justify-content-center">
		<div class="col col-6">
			<h4>You are already logged in</h4>
		</div>
	</div>
	
	</core:if>
	<core:remove var="message"></core:remove>
	<core:remove var="idFailedAttempt"></core:remove>
	<core:remove var="RightTimeToLogInToOperator"></core:remove>
	<script>
		var showPassword 	= document.getElementById("show_password");
		var hidePassword 	= document.getElementById("hide_password");
		var password	 	= document.getElementById("exampleInputPassword1");
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
</body>
</html>