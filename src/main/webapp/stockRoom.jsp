<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Stock</title>
</head>
<style>
.border-left{
border-left:5px solid #008080;

}
</style>
<body class="bg-light">
<core:import url="navbar.jsp"></core:import>
<!-- check for login -->
<core:if test="${sessionScope.loggedIn}">
<core:if test="${sessionScope.is_admin}">
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	<sql:query dataSource="${con}" var="stock">
		select * from stockroom ;
	</sql:query>
		
		
<div class="container mt-3 col-10">

<div class="row">
	<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
			  There are <b> ( ${stock.rowCount} )</b> Stock Rooms
			  </div>
</div>
<core:if test="${requestScope.deleteRoomStatus}">
<!-- message -->
<div class="row">
	<div class="col">
		<div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
		  Deleted! Sock Room Deleted.
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</div>
</div>
</core:if>
<div class="row justify-content-center ">
	<div class="col col-6 border  px-4 py-4 rounded justify-content-center" >
			
			<!-- collapse -->	
<core:if test="${stock.rowCount gt 0}">	
<core:forEach var="data" items="${stock.rows}" varStatus="i">
<div class="card border mt-2 "  style="background-color:#DCF8E7;cursor:pointer;" aria-expanded="false" aria-controls="collapseExample" >
	<div class="card-header border-left">
		    <button class="btn btn-sm btn-primary" data-bs-toggle="collapse" data-bs-target="#collapseExample-${i.count}">Expand </button>
		     <span class="text-center" style="margin-left:180px"><b> ${data.stock_room_name} </b></span>
		    <a href="deleteRoom?id=${data.id}" class="btn btn-sm btn-danger" style="position:absolute;right:10px">Delete</a>
 	</div>
    <div class="collapse"  id="collapseExample-${i.count}">
  <div class="card card-body ">
	<sql:query dataSource="${con}" var="stockData">
		SELECT product_name,product_quantity_in_stock_room FROM stock S
		INNER JOIN products P ON S.product_id= P.id
		INNER JOIN stockroom SR ON S.stock_room_id= SR.id
		WHERE SR.id =${data.id};
	</sql:query> 
	<core:if test="${stockData.rowCount>0}">
	<table class="table table-bordered  border-success table-success table-hover table-striped text-center" border="2">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Product Name</th>
      <th scope="col">Product Quantity</th>
       
      <!-- <th scope="col">Delete</th> -->
    </tr>
  </thead>
  <tbody>
  <core:forEach  var="stockData" items="${stockData.rows}" varStatus="i">
    <tr>
      <td>${i.count}</td>
      <td>${stockData.product_name}</td>
      <td>${stockData.product_quantity_in_stock_room}</td>
      
      </tr>
 </core:forEach>
  </tbody>
</table>
	</core:if>
	<core:if test="${stockData.rowCount eq 0}">
		<h3 class="text-center text-danger">Oh dear! Stock Room Is Empty</h3>
	</core:if>   
</div>
</div>
  
</div>
</core:forEach>
		
</core:if>
<core:if test="${stock.rowCount eq 0}">
<div class="col  text-center">
	<h3 class=" text-danger">Oops there is no stock room please add new Stock room</h3><br>
	<a href="addStockRoom.jsp" class="btn btn-sm btn-primary">Add Stock Room</a>
	</div>
</core:if>		
			
		</div>
		
	</div>
	<core:import url="footer.jsp"></core:import>
</div>
</core:if>
</core:if>
<core:if test="${not sessionScope.loggedIn}">
<core:redirect url="login.jsp"></core:redirect>
</core:if>

</body>
</html>