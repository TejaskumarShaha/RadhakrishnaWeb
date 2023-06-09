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
<style>
#hidePassword{
	display:none;
}
</style>
<body>
<core:if test="${sessionScope.loggedIn}">
<core:import url="navbar.jsp"></core:import>

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
	
<div class="container mt-5 justify-content-center">

<core:if test="${sessionScope.loggedIn}">
	
<div class="row justify-content-center  ">
<div class="col col-5  bg-white justify-content-center rounded">
	<form class="mb-5 px-2 py-1 " action="UpdatePassword" method="post" onsubmit ="return verifyPassword()">
  	<div class="mb-3">
	    <label for="user_id" class="form-label"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-vcard" viewBox="0 0 16 16">
  <path d="M5 8a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm4-2.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5ZM9 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4A.5.5 0 0 1 9 8Zm1 2.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5Z"/>
  <path d="M2 2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H2ZM1 4a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H8.96c.026-.163.04-.33.04-.5C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1.006 1.006 0 0 1 1 12V4Z"/>
</svg> ID</label>
	    <input type="text" class="form-control" id="id" name="customer_id" required value="${param.id}" readonly>
    </div>
    <div class="mb-3">
	    <label for="name" class="form-label"><i class="bi bi-person-circle"></i> Name</label>
	    <input type="text" class="form-control" id="name" name="name" required value="${param.name}" readonly>
    </div>
  <div class="mb-3">
    <label for="password" class="form-label"><i class="bi bi-key"></i> New Pasword</label>
    <input type="password"  class="form-control date" id="password" name="new_password" placeholder="New Password" required>
    </div>
  <div class="mb-3 "  id="showPasswordDiv">
    <button type="button"  class="btn btn-sm btn-primary" id="show_password"><i class="bi bi-eye"></i> </button><br></div>
   
   <div class="mb-3  " id="hidePassword">
    
    <button type="button" class="btn btn-sm btn-danger" id="hide_password"><i class="bi bi-eye-slash"></i> </button><br>
   </div>
  <!-- <div class="mb-3">
    <label for="confirm_password" class="form-label"><i class="bi bi-key-fill"></i> Confirm Password</label>
    <input type="text" class="form-control date" id="confirm_password" name="confirm_password" required>
  </div>-->
  <div class="row justify-content-center">
  <div class="col text-center">
  <button type="submit" class="btn btn-success mt-2 mb-0"><i class="bi bi-shield-lock"></i> Change Password</button>
  </div>
  </div>
</form >
</div>
</div>
	
</core:if>
<core:import url="footer.jsp"></core:import>
</div>
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
	</core:if>
	<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
	</body>
</html>