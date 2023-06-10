<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    <%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body class="bg-light">	
<core:if test="${sessionScope>loggedIn}">
	<core:import url="navbar.jsp"></core:import>
	<core:if test="${sessionScope.loggedIn}">
<!-- jstl -->
	<sql:setDataSource 
		user="root" 
		password="root" 
		driver="com.mysql.cj.jdbc.Driver" 
		url="jdbc:mysql://localhost:3306/radhakrishna" 
		var="con"/>
	<sql:query dataSource="${con}" var="rs">
		select * from billings where product_name=?;
		<sql:param value="${param.searchBillingsFor}"></sql:param>
	</sql:query>
		
<div class="container col-10 mt-5">
<div class="row justify-content-md-center ">
<div class="col col-12">
<core:if test="${rs.rowCount gt 0}">
<table class="table  table-bordered  table-striped text-center">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Product Name</th>
      <th scope="col">Product Quantity (kg)</th>
      <th scope="col">Manufacture Date</th>
      <th scope="col">Expiry Date</th>
      <th scope="col">Product Add Date</th>
      <th scope="col">Product Price</th>
      <core:if test="${sessionScope.is_admin}">
      <th scope="col">Update</th>
      <th scope="col">Delete</th>
      </core:if>
      <core:if test="${not sessionScope.is_admin}">
      <th scope="col">Update</th>
      </core:if>
    </tr>
  </thead>
  <tbody>
  <core:forEach  var="product" items="${rs.rows}" varStatus="i">
    <tr>
      <td>${i.count}</td>
      <td>${product.product_name}</td>
      <td>${product.product_quantity}</td>
      <td>${product.manufacturing_date}</td>
      <td>${product.expiry_date}</td>
      <td>${product.product_add_date}</td>
      <td>${product.product_price}</td>
      <core:if test="${sessionScope.is_admin}">
      <td><a href="#" class="btn btn-success btn-sm mx-2" >Update</a></td>
      <td><a href="confirmDeleteProduct.jsp?product_name=${product.product_name}" class="btn btn-danger btn-sm mx-2" id="deletePrdoductBtnInAdminPanel" >delete </a></td>
      </core:if>
      <core:if test="${not sessionScope.is_admin}">
      	<td><a href="#" class="btn btn-success btn-sm mx-2" >Update</a></td>
      </core:if>
    </tr>
 </core:forEach>
 	
  </tbody>
</table>
</core:if>
<core:if test="${rs.rowCount eq 0}">
	<div class="row justify-content-center mt-5">
	<div class="col col-6 border border-danger rounded text-center mt-5">
	<h2 class="mt-3"> Billings for <i><span style="color:red">${param.searchBillingsFor}</span></i> not available.</h2>
	<core:if test="${sessionScope.is_admin}">
		<a href="allBillings.jsp" class="btn btn-sm btn-success mt-1 mb-3"><i class="bi bi-cart-check"></i> All Billings</a> 
	</core:if>
	<a href="addBillings.jsp?addBillingFor=${param.searchBillingsFor}" class="btn btn-sm btn-primary mt-1 mb-3"><i class="bi bi-cart-plus"></i> Add Billings</a> 
	</div>
	</div>
</core:if>
</div>
</div>
</div>
<script src="./js/adminPanel.js"></script>
<core:import url="footer.jsp"></core:import>
</core:if>
</core:if>
<!-- if user not logged in redirect to the login page -->
<core:if test="${not sessionScope.loggedIn }">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
</body>
</html>