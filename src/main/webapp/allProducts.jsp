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
<body class="bg-light">
<core:import url="navbar.jsp"></core:import>
<!-- check for login -->
<core:if test="${sessionScope.is_admin}">
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
					      <th scope="col">Product ID</th>
					      <th scope="col">Product Name</th>
					      <th scope="col">Product Quantity (kg)</th>
					      
					    </tr>
					  </thead>
					  <tbody>
					  <core:forEach  var="data" items="${products.rows}" varStatus="i">
					    <tr>
					      <td>${i.count}</td>
					      <td >${data.id}</td>
					      <td >${data.product_name}</td>
					      <td>${data.product_quantity}</td>
					    </tr>
					 </core:forEach>
					  </tbody>
					</table>
					</core:if>
					<core:if test="${products.rowCount eq 0}">
						<h3 class="text-danger text-center">Oops there are no products available.</h3>
					</core:if>
		</div>
		
</div>
	
<core:import url="footer.jsp"></core:import>
</div>
</core:if>
</body>
</html>