<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Filter Credits</title>
</head>
<body>
<core:if test="${sessionScope.loggedIn}">
<core:import url="navbar.jsp"></core:import>
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	
	<core:catch var="Exception">
		<sql:query dataSource="${con}" var="creditsFilter">
			SELECT * from CreditRemainingBalance
			LEFT JOIN dealers ON CreditRemainingBalance.shop_id = dealers.id
			where shop_id =? order by credit_date asc;
			<sql:param value="${param.shopId}"></sql:param>
			
			</sql:query>
	</core:catch>
	<sql:query dataSource="${con}" var="allDealers">
			select * from dealers;
	</sql:query>
	
	<!-- table -->
	
	<div class="container  mt-3 px-3 py-3 rounded ">
	<!-- filter row -->
	<div class="row justify-content-center ">
	<div class="col col-2 ">
			<a class="btn btn-sm btn-primary mt-3" href="allCredits.jsp">All Credits</a>
		</div>
		<div class="col col-6 px-2 py-2 ">
		
			<form action="filterCredits.jsp" class="d-flex " >
			<div class="col col-11 px-2 ">
	        	<select class="form-select" aria-label="Default select example" name="shopId" id="id"  >
			 		 <option value="">Choose Dealer Shop </option>
			  		<core:forEach var="da" items="${allDealers.rows}">
			  		 <option value="${da.id}">${da.shop_name}</option>
			       </core:forEach>
		    	</select>
	
		  </div>
		
		<div class="col col-1 text-center">
		    <button class="btn btn-md  btn-success col-12" type="submit"  title="Click to Search"><i class="bi bi-search"></i> </button>
		</div>
		</form>
		</div>
		
	<!-- filter row ends -->
	<div class="row justify-content-md-center">
		<div class="col col-12">
			
				<core:if test="${sessionScope.is_admin}">
				<core:if test="${creditsFilter.rowCount >0}">
					<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
					   All Credits for <strong> ${delName} ( ${creditsFilter.rowCount} )</strong>
					  </div>
					<table class="table  table-bordered  table-striped text-center">
					  <thead>
					    <tr>
					      <th scope="col">#</th>
					      <th scope="col">Shop Name</th>
					      <th scope="col">Credit Amount</th>
					      <th scope="col">date</th>
					      <th scope="col">Credit By</th>
					      
					      
					     <!-- <th scope="col">Update</th>
					     <th scope="col">Delete</th> -->
					    </tr>
					  </thead>
					  <tbody>
					  <core:forEach  var="data" items="${creditsFilter.rows}" varStatus="i">
					    <tr>
					      <td>${i.count}</td>
					      <td >${data.shop_name}</td>
					      <td>${data.credit_amount}</td>
					      <td> <fmt:formatDate type = "date" 
					         value = "${data.credit_date}" /></td>
					      <td>${data.creditor_name}</td>
					      
					      
					      <!-- <td><a href="#" class="btn btn-success btn-sm mx-2" >Update</a></td>
					     <td><a href="confirmDeleteProduct.jsp?product_name=${product.id}" class="btn btn-danger btn-sm mx-2" >delete </a></td>-->
					    </tr>
					 </core:forEach>
					  </tbody>
					</table>
					
					</core:if>
					
				</core:if>
				<core:if test="${creditsFilter.rowCount eq 0 }">
					<div class="row justify-content-center mt-5">
						<div class="col text-center mt-3">
							<h4 class="text-danger">Oh dear! NO RECORD FOUND for </h4>
						</div>
					</div>
				</core:if>
					
		</div>
		
	</div>
	
</div>

	</div>
	<core:import url="footer.jsp"></core:import>
</core:if>
<core:if test="${not sessionScope.loggedIn}">
	<core:redirect url="login.jsp"></core:redirect>
</core:if>
		
		
</body>
</html>