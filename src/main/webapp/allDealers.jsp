<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Dealers</title>
</head>
<body>
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	<!--  admins table -->
	<sql:query dataSource="${con}" var="dealers">
		select * from dealers order by shop_name;
	</sql:query>
<core:import url="navbar.jsp"></core:import>
<div class="container">

<!-- message -->
<div class="row">
<div class="col mt-3">
	<core:if test="${sessionScope.exception eq 'noexception'}">
		<div class="row justify-content-center ">
			<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
			  <strong>Success! </strong> Dealer Shop Details Updated for Dealer ID <strong>${sessionScope.shop_id}</strong>  successfully.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
</div>
</div>
<!-- dealers details -->
<div class="row justify-content-center ">
<div class="col col-12 border px-4 rounded " >
<div class="row">
	<div class="col">
		<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
					   All Dealers <strong>( ${dealers.rowCount} )</strong>
		</div>
	</div>
</div>
<!-- all dealers table -->
<table class="table table-bordered border-success table-success table-hover table-striped text-center" border="2">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col"><i class="fa-solid fa-store"></i> Shop Name</th>
      <th scope="col"><i class="fa-solid fa-mobile-screen"></i> Mobile Number</th>
      <th scope="col"><i class="fa-solid fa-file-invoice"></i> GST Number</th>
      <th scope="col"><i class="fa-solid fa-location-dot"></i> Address</th>
      <th scope="col"><i class="fa-solid fa-pencil"></i> Update</th>
      
    </tr>
  </thead>
  <tbody>
  <core:forEach  var="data" items="${dealers.rows}" varStatus="i">
    <tr>
      <td>${i.count}</td>
      <td>${data.shop_name}</td>
      <td>${data.mobile}</td>
      <td>${data.gstno}</td>
      <td>${data.address}</td>
      <td><a href="updateDealer.jsp?dealerID=${data.id}&dealerShopName=${data.shop_name}&dealerMobile=${data.mobile}&dealerGSTno=${data.gstno}&dealerAddress=${data.address}" class="btn btn-sm btn-warning"><i class="fa-solid fa-pencil"></i> Update</a></td>
     </tr>
 </core:forEach>
  </tbody>
</table>
</div>
</div>
<core:if test="${dealers.rowCount eq 0}">
	<div class="row justify-content-center mt-5">
	<div class="col col-6 border border-danger rounded text-center mt-5">
	<h2 class="mt-3"> Dealers are not available <br>( <i><span style="color:red">${param.searchBorrowerFor}</span></i> ) </h2>
	<a href="adminPanel.jsp" class="btn btn-sm btn-warning mt-1 mb-3">Admin Panel</a> 
	<a href="addBorrower.jsp?borrowerName=${param.searchBorrowerFor}" class="btn btn-sm btn-success mt-1 mb-3">Add New Borrower</a> 
	<a href="allBorrowers.jsp" class="btn btn-sm btn-primary mt-1 mb-3">All Borrowers</a> 
	</div>
	</div>
</core:if>
</div>
<core:remove var="exception" ></core:remove>
<core:remove var="shop_id" ></core:remove>

</body>
</html>