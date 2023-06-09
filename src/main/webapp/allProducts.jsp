<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Products</title>
</head>
<body class="bg-light">
<core:if test="${sessionScope.loggedIn}">
<core:if test="${sessionScope.is_admin}">
<core:import url="navbar.jsp"></core:import>
<!-- check for login -->

<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	<core:catch var="e">
	<sql:query dataSource="${con}" var="products">
		SELECT * FROM products
	</sql:query>
	</core:catch>
	
<div class="container mt-2">
<!-- product name update status -->
<core:if test="${sessionScope.product_name_update_status}">
		<div class="row justify-content-center ">
			<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
			  <strong>Success! </strong> Product Name Updated to <strong>${sessionScope.product_name_after_name_update}</strong>  is added successfully.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
	
<core:if test="${sessionScope.productDeleteStatus}">
		<div class="row justify-content-center ">
			<div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
			  <strong>Deleted! </strong> Product <strong>${sessionScope.product_name_from_delete_product }</strong> deleted successfully.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</div>
	</core:if>
	

	<div class="row">
		<div class="col border px-3 py-3 rounded bg-white">
				<core:if test="${products.rowCount gt 0}">
					<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
					   Products in Stock <strong>( ${products.rowCount} )</strong>
					</div>
				
					<table class="table  table-bordered border-success table-success table-hover table-striped text-center" border="1">
					  <thead>
					    <tr>
					      <th scope="col">#</th>
					      <th scope="col">Product Name</th>
					      <th scope="col">Product Quantity (kg)</th>
					      <th scope="col">Update Name</th>
					      <th scope="col">Delete</th>
					      
					    </tr>
					  </thead>
					  <tbody>
					  <core:forEach  var="data" items="${products.rows}" varStatus="i">
					    <tr>
					      <td>${i.count}</td>
					      <td >${data.product_name}</td>
					      <td>${data.product_quantity}</td>
					      <td><a href="updateProductName.jsp?product_id=${data.id}&product_name=${data.product_name}&product_quantity=${data.product_quantity}" class="btn btn-sm btn-success">Update Name</a> </td>
					      <td><a href="deleteProduct?product_id=${data.id}" class="btn btn-sm btn-danger">Delete </a> </td>
					   </tr>
					 </core:forEach>
					  </tbody>
					</table>
					</core:if>
					<core:if test="${products.rowCount eq 0}">
						<h3 class="text-danger text-center">Oh dear! no products available.</h3>
					</core:if>
		</div>
</div>
	
<core:import url="footer.jsp"></core:import>
<core:remove var="product_name_from_delete_product"></core:remove>
<core:remove var="product_name_after_name_update"></core:remove>
<core:remove var="product_name_update_status"></core:remove>
<core:remove var="productDeleteStatus"></core:remove>
</div>
</core:if>
</core:if>
<core:if test="${not sessionScope.loggedIn}">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
</body>
</html>