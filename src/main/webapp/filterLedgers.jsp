<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
		<sql:query dataSource="${con}" var="LedgersFiltered">
			SELECT ledger.product_quantity,products.product_name,ledger_date,product_net_price,credit_rupee,product_gross_price,dealers.shop_name,ledger.remaining_balance,ledger.initial_remaining_price from ledger
			LEFT JOIN dealers ON ledger.shop_id = dealers.id
			LEFT JOIN products ON ledger.product_id = products.id
			where shop_id =? order by ledger_date asc;
			<sql:param value="${param.shopId}"></sql:param>
			
			</sql:query>
	</core:catch>
	<sql:query dataSource="${con}" var="allDealers">
			select * from dealers;
	</sql:query>
	<sql:query dataSource="${con}" var="delearName">
			select shop_name from dealers where id =${param.shopId};
			
	</sql:query>
	<core:forEach var="data" items="${delearName.rows}" >
		<core:set var="delName" value="${data.shop_name}" ></core:set>
	</core:forEach>
	
	<!-- table -->
	
	<div class="container  mt-3 px-3 py-3 rounded ">
	<!-- filter row -->
	<div class="row justify-content-center ">
	<div class="col col-2 ">
			<a class="btn btn-sm btn-primary mt-3" href="allLedgers.jsp">View All Ledgers</a>
		</div>
		<div class="col col-6 px-2 py-2 ">
		
			<form action="filterLedgers.jsp" class="d-flex " >
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
				<core:if test="${ LedgersFiltered.rowCount >0}">
					<div class="alert alert-success alert-dismissible fade show text-center" role="alert">
					   All Ledgers for <strong> ${delName} ( ${LedgersFiltered.rowCount} )</strong>
					  </div>
					<table class="table table-bordered border-success table-success table-hover table-striped text-center" border="1">
					  <thead>
					    <tr>
					      <th scope="col">#</th>
					      <th scope="col">Shop Name</th>
					      <th scope="col">Product Name</th>
					      <th scope="col">date</th>
					      <th scope="col">Product Quantity</th>
					      <th scope="col">Net Price</th>
					      
					      <th scope="col">Gross Price</th>
					      <th scope="col">Credit Rupee</th>
					      <th scope="col">Initial Remaining Balance</th>
					      <th scope="col">Remaining Balance </th>
					      
					     <!-- <th scope="col">Update</th>
					     <th scope="col">Delete</th> -->
					    </tr>
					  </thead>
					  <tbody>
					  <core:forEach  var="ledgers" items="${LedgersFiltered.rows}" varStatus="i">
					    <tr>
					      <td>${i.count}</td>
					      <td >${ledgers.shop_name}</td>
					      <td>${ledgers.product_name}</td>
					      <td> <fmt:formatDate type = "date" 
					         value = "${ledgers.ledger_date}" /></td>
					      <td>${ledgers.product_quantity}</td>
					      <td>${ledgers.product_net_price}</td>
					     
					      <td>${ledgers.product_gross_price}</td>
					       <td>${ledgers.credit_rupee}</td>
					      <td>${ledgers.initial_remaining_price}</td>
					      <td>${ledgers.remaining_balance}</td>
					      
					      <!-- <td><a href="#" class="btn btn-success btn-sm mx-2" >Update</a></td>
					     <td><a href="confirmDeleteProduct.jsp?product_name=${product.id}" class="btn btn-danger btn-sm mx-2" >delete </a></td>-->
					    </tr>
					 </core:forEach>
					  </tbody>
					</table>
					
					</core:if>
					<core:if test="${allLedgers.rowCount eq 0}">
						<div class="row justify-content-center mt-5">
						<div class="col col-6 border border-danger rounded text-center mt-5">
						<h2 class="mt-3">Oh dear! There is no Ledger Please add ledger to view here</h2>
						<a href="addLedgerForm.jsp" class="btn btn-sm btn-success mt-1 mb-3">Add Ledger</a> 
						</div>
						</div>
					</core:if>
				</core:if>
				<core:if test="${LedgersFiltered.rowCount eq 0 }">
					<div class="row justify-content-center mt-5">
						<div class="col text-center mt-3">
							<h4 class="text-danger">Oh dear! NO RECORD FOUND for </h4><h4 > ${delName} </h4>
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