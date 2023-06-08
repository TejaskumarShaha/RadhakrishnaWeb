<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Dealer</title>
</head>
<body>
<body class="bg-light">
<core:import url="navbar.jsp"></core:import>
<!-- check for logged in -->
<core:if test="${sessionScope.loggedIn}">
<!-- checks for admin -->
<core:if test="${sessionScope.is_admin}">
	<div class="container mt-4">	
		<!-- heading -->
		<div class="row justify-content-center">
			<div class="col col-5">
			<h3>Update Dealer</h3>
			</div>
		</div>
		<!-- form container -->
		<div class="row justify-content-center">
			<div class="col col-5 border px-4 py-3 rounded bg-white">
			<!--  form -->
				<form class="mb-5" action="updateDealerLogic.jsp" method="post">
				  <div class="mb-3">
				     <input type="hidden" class="form-control" id="dealer_name" name="dealerID" required placeholder="type dealer name here..." value="${param.dealerID}">
				    </div>		
				    
				    <div class="mb-3">
				    <label for="dealer_name" class="form-label"><i class="bi bi-shop"></i> Dealer Shop Name</label>
				    <input type="text" class="form-control" id="dealer_name" name="dealerShop" required placeholder="type dealer name here..." value="${param.dealerShopName}">
				    </div>		  
				  
				  <div class="mb-3">
				    <label for="dealer_mobile" class="form-label"><i class="bi bi-phone"></i> Mobile</label>
				    <input type="text" oninput="this.value= this.value.replace(/[^\d.]/g, '')" maxlength="10" min="10" class="form-control " value="${param.dealerMobile}" id="dealer_mobile" name="dealerMobile" placeholder="type dealer mobile here..." required>
				  </div>
				 
				 <div class="mb-3">
				    <label for="gst_number" class="form-label"><i class="fa-solid fa-receipt"></i> GST Number</label>
				    <input type="text" class="form-control" id="gst_number" name="gstnumber" value="${param.dealerGSTno}" required placeholder="type gst number here...">
				    </div>
					
					<div class="mb-3">
				    <label for="dealer_address" class="form-label"><i class="fa-solid fa-location-dot"></i> Address</label>
				    <textarea  class="form-control" id="dealer_address" name="dealerAddress"  required placeholder="type address here...">${param.dealerAddress}</textarea>
				    </div>
				    				    
				  <div class="row justify-content-center">
					  <div class="col col-4">
					  	<button type="submit" class="btn btn-success btn-sm"><i class="fa-solid fa-pencil"></i> Update Dealer</button>
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
			<strong class="text-danger">Oh dear! you are not authorized to view this page</strong><br><br>
			<a href="operatorPanel.jsp" class="btn btn-sm btn-info">Operator Panel</a>
		</div>
	</div>
</div>
</core:if>
<!-- end checks for logged in -->
</core:if>
 
	<!-- removing operator add status var from session -->
	
</body>
</html>