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
<body class="bg-light">
<core:import url="navbar.jsp"></core:import>
<!-- check for login -->
<core:if test="${sessionScope.loggedIn}">
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	<sql:query dataSource="${con}" var="borrower">
		select * from borrowers order by borrowing_date desc;
		</sql:query>
	
	<sql:query dataSource="${con}" var="borrowingSum">
		select total_borrowing from borrowers ;
		</sql:query>
	
 	<core:set var="totalBorrowings" value="${0}"/>
		<core:forEach var="article" items="${borrowingSum.rows}">
	    	<core:set var="totalBorrowings" value="${totalBorrowings + article.total_borrowing}"/>
	</core:forEach>
	



<!-- chech for admin -->
<core:if test="${sessionScope.is_admin}">
<div class="container mt-5">
<!-- search for another borrowers -->
<div class="row justify-content-center">
<div class="col col-6">
	<a href="addBorrower.jsp" class="btn btn-sm btn-primary">Add Borrowers</a>
</div>
	<div class="col col-6">
		<form action="searchBorrowersResult.jsp" class="d-flex col-8 ml-5">
	        <input class="form-control me-2 " type="search" placeholder="Search Borrower by name..." aria-label="Search" name="searchBorrowerFor" required>
	        <button class="btn btn-sm  btn-success col-2" type="submit"  title="Click to Search for borrowers"><i class="bi bi-search"></i></button>
      	</form>
	</div>
</div>
<!-- total borrowings Details-->
<core:if test="${borrower.rowCount gt 0}">
<div class="row justify-content-center mt-4">
	  <div class="alert alert-success alert-dismissible fade show text-center col-12" role="alert">
	  		Total Borrowings Rs.&nbsp;<b><fmt:formatNumber type="number" groupingUsed="true" value="${totalBorrowings}" /></b> | Total Borrowings  <b>( ${borrower.rowCount} )</b> 
	  </div>
</div>
<!-- borrowing details -->
<div class="row justify-content-md-center ">
<div class="col col-12 ">
<!-- all borrowers table -->
<table class="table table-bordered border-success table-success table-hover table-striped text-center" border="1">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Name</th>
      <th scope="col">Mobile Number</th>
      <th scope="col">Borrowing (Price)</th>
      <th scope="col">Date</th>
      <th scope="col">Address</th>
      <th scope="col">Update</th>
      <th scope="col">Delete</th>
    </tr>
  </thead>
  <tbody>
  <core:forEach  var="data" items="${borrower.rows}" varStatus="i">
    <tr>
      <td>${i.count}</td>
      <td>${data.customer_name}</td>
      <td>${data.customer_mobile_number}</td>
      <td>${data.total_borrowing}</td>
      <td>${data.borrowing_date}</td>
      <td>${data.address}</td>
      <td><a href="#" class="btn btn-success btn-sm mx-2" >Update</a></td>
	  <td><a href="#" class="btn btn-danger btn-sm mx-2" >delete </a></td>			    
    </tr>
 </core:forEach>
  </tbody>
</table>
</div>
</div>
</core:if>

<core:if test="${borrower.rowCount eq 0}">
	<div class="row justify-content-center mt-5">
	<div class="col col-6 border border-danger rounded text-center mt-5">
	<h2 class="mt-3"> Borrower not available <br>( <i><span style="color:red">${param.searchBorrowerFor}</span></i> ) </h2>
	<a href="adminPanel.jsp" class="btn btn-sm btn-warning mt-1 mb-3">Admin Panel</a> 
	<a href="addBorrower.jsp?borrowerName=${param.searchBorrowerFor}" class="btn btn-sm btn-success mt-1 mb-3">Add New Borrower</a> 
	<a href="allBorrowers.jsp" class="btn btn-sm btn-primary mt-1 mb-3">All Borrowers</a> 
	</div>
	</div>
	
</core:if>
</div>
</core:if>
<!-- container for authorized person -->
<core:if test="${not sessionScope.is_admin}">
<div class="container">
	<div class="row justify-content-center mt-5">
		<div class="col col-6 mt-5 text-center border border-danger rounded px-5 py-5">
			<h3 style="color:red">Oops! It seems that you are not logged In </h3>
			</div>
	</div>
</div>	
<!--  end checking is_Admin false -->
</core:if>
<!-- end checking logged in true -->
</core:if>
<!-- checking for not logged in -->
<core:if test="${sessionScope.loggedIn==null}">
<div class="container">
	<div class="row justify-content-center mt-5">
		<div class="col col-6 mt-5 text-center border border-danger rounded px-5 py-5">
			<h3 style="color:red">Oops! It seems that you are not logged In </h3>
			<small>You have to login first to visit this page </small><br>
			<a href="login.jsp" class="btn btn-sm btn-success w-25 mt-4"><i class="bi bi-box-arrow-in-right"></i> Login</a>
		</div>
	</div>
</div>	
</core:if>
<core:import url="footer.jsp"></core:import>

</body>
</html>