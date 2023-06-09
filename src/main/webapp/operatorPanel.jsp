<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Operator Panel</title>
</head>
<body>
<%@include file="navbar.jsp" %>

<core:if test="${sessionScope.loggedIn}">

	<div class="container mt-3">
	<core:if test="${sessionScope.passwordUpdateStatus}">
	<div class="row">
		<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
			  <strong>Success! </strong> Password Updated Successfully for ID : <b>${sessionScope.passwordUpdateId }</b>.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
		</div>
		</core:if>
		<div class="row">
		
		</div>
		<core:import url="footer.jsp"></core:import>
	</div>
	

<core:remove var="passwordUpdateStatus"/>
<core:remove var="passwordUpdateId"/> 
</core:if>
<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
</body>
</html>