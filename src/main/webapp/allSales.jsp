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
<body>
<core:if test="${sessionScope.loggedIn}">
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
	<sql:query dataSource="${con}" var="allSales">
		SELECT products.product_name ,sales.product_quantity,sales.sales_date 
		FROM sales
		LEFT JOIN products ON sales.product_id = products.id
		LEFT JOIN stockroom ON sales.store_room_id = stockroom.id;
	</sql:query>
	</core:catch>
	
<div class="container mt-2">
	<div class="row">
		<div class="col border px-3 py-3 rounded bg-white">
				<core:if test="${allSales.rowCount gt 0}">
					<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
					   All Sales <strong>( ${allSales.rowCount} )</strong>
					</div>
				
					<table class="table  table-bordered  table-striped text-center">
					  <thead>
					    <tr>
					      <th scope="col">#</th>
					      <th scope="col">Product Name</th>
					      <th scope="col">Product Quantity</th>
					      <th scope="col">Sales Date </th>
					      
					    </tr>
					  </thead>
					  <tbody>
					  <core:forEach  var="data" items="${allSales.rows}" varStatus="i">
					    <tr>
					      <td>${i.count}</td>
					      <td >${data.product_name}</td>
					      <td >${data.product_quantity}</td>
					      <td>${data.sales_date}</td>
					    </tr>
					 </core:forEach>
					  </tbody>
					</table>
					</core:if>
					<core:if test="${allSales.rowCount eq 0}">
						<h3 class="text-danger text-center">Oh dear! there are no sales.</h3>
					</core:if>
		</div>
		
</div>
	
<core:import url="footer.jsp"></core:import>
</div>
</core:if>
</core:if>
<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
</body>
</html>