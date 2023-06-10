<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Add Borrower</title>

<script language="javascript" type="text/javascript">
function limitText(limitField, limitNum) {
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    }
}
</script>
</head>
<body class="bg-light">
<!-- container -->
<core:if test="${sessionScope.loggedIn}">
<core:import url="navbar.jsp"></core:import>
<div class="container mt-5">
<core:if test="${param.notException=='notexception'}">
<!-- message -->
<div class="row">
	<div class="col">
		<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
		  <strong>Success! </strong> Borrowings for <b>${param.addBorrowerFor}</b> added successfully.
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</div>
</div>
</core:if>
	<div class="row justify-content-center">
		<div class="col col-6">
			<h2>Add Borrower</h2>
		</div>
	</div>
	<!-- form container -->
	<div class="row justify-content-center ">
		<div class="col-6 border px-4 py-4 rounded bg-white">
			<form action="addBorrowerLogic.jsp" method="post">
				  <div class="mb-3">
				    <label for="customerName" class="form-label"><i class="bi bi-person"></i> Borrower Name</label>
				    <input type="text" class="form-control"  aria-describedby="emailHelp" name="customerName" value="${param.addBorrowerFor}" required>
				    </div>
				    <div class="mb-3">
				    <label for="borrowingPrice" class="form-label"><i class="bi bi-currency-rupee"></i> Rupees</label>
				    <input type="number" class="form-control" id="borrowingPrice" name="borrowingPrice" required>
				  </div>
				  <div class="mb-3">
				    <label for="customerMobileNumber" class="form-label"><i class="bi bi-phone"></i> Mobile Number</label>
				    <input type="text" class="form-control" id="customerMobileNumber" name="customerMobileNumber" maxlength="10" onKeyDown="limitText(this,10);" required>
				  </div>
				  <div class="mb-3">
				    <label for="date" class="form-label"><i class="bi bi-calendar-check"></i> Date</label>
				    <input type="date" class="form-control" id="date" name="borrowingAddDate" required>
				  </div>
				  <div class="mb-3">
				  	  <label  class="form-label"><i class="bi bi-geo-alt"></i> Address</label>
					  <textarea rows="2" class="form-control" id="address" name="address" required></textarea>  	  
				</div>
				<div class="row">
				<div class="col text-center">
				  <button type="submit" class="btn btn-md btn-success w-25 mt-3"><i class="bi bi-person-check-fill"></i> Add Borrower</button>
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