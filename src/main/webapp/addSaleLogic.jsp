<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<core:import url="navbar.jsp"></core:import>
<!-- jstl -->
	<fmt:parseNumber var="p" type="number" value="${param.sales_price}" />
	<fmt:parseNumber var="q" type="number" value="${param.sales_quantity}" />
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	
	<!-- product name from products -->
	<sql:query dataSource="${con}" var="pname">
		select product_name from products where id =?;
		<sql:param value="${param.productid}"></sql:param>
	</sql:query>
		
	<core:forEach items="${pname.rows}" var="data">
		<core:set var="prodcut_name" value="${data.product_name}" scope="session"></core:set>
	</core:forEach>
	
	<!-- stock room name from stockroom -->
	<sql:query dataSource="${con}" var="srname">
		select stock_room_name from stockroom where id = ?;
		<sql:param value="${param.stockroomid}"></sql:param>
	</sql:query>
	
	<core:forEach items="${srname.rows}" var="data">
		<core:set var="store_room_name" value="${data.stock_room_name}" scope="session"></core:set>
	</core:forEach>
	
	<!-- quantity from stock room -->
	<sql:query dataSource="${con}" var="product_quantity_from_stock">
		select product_quantity_in_stock_room  from stock where product_id =? and stock_room_id =?;
		<sql:param value="${param.productid} "></sql:param>
		<sql:param value="${param.stockroomid}"></sql:param>
	</sql:query>
	<core:forEach items="${product_quantity_from_stock.rows}" var="quantityFromStock">
		<core:set var="quantity_in_stock" value="${quantityFromStock.product_quantity_in_stock_room}"></core:set>	
	</core:forEach>
	
	<!-- product name from stock room -->
	<sql:query dataSource="${con}" var="product_name_from_stock">
		SELECT product_name FROM stock S
		INNER JOIN products P ON S.product_id= P.id
		INNER JOIN stockroom SR ON S.stock_room_id= SR.id
		WHERE product_id = ? and stock_room_id =?;
		<sql:param value="${param.productid} "></sql:param>
		<sql:param value="${param.stockroomid}"></sql:param>
	</sql:query>
	
		
	<core:forEach items="${product_name_from_stock.rows}" var="productNameFromStock">
		<core:set var="product_name_in_stock" value="${productNameFromStock.product_name}" scope="session"></core:set>	
	</core:forEach>
	
	<!-- quantity from products -->
	<sql:query dataSource="${con}" var="product_quantity_from_products">
		select product_quantity from products where id =? ;
	<sql:param value="${param.productid}"></sql:param>
	</sql:query>
	
	<core:forEach items="${product_quantity_from_products.rows}" var="quantityFromProdcuts">
		<core:set var="quantity_in_products" value="${quantityFromProdcuts.product_quantity}"></core:set>	
	</core:forEach>
	<!-- check for product is available or not in stock room -->
	<core:if test="${product_name_from_stock.rowCount gt 0}">
	<core:if test="${quantity_in_stock ge q}">
		<core:if test="${quantity_in_products ge q}">	
		<core:set var="newQuantityForProducts" value="${quantity_in_products - q}"></core:set>
		<core:set var="newQuantityForStcok" value="${quantity_in_stock - q}"></core:set>
			<core:catch var="CatchException">
			<sql:update dataSource="${con}" var="updateStatus">
				insert into sales(sales_date,product_id,store_room_id,product_quantity) values(?,?,?,?);
				<sql:param value="${param.sales_add_date}"></sql:param>
				<sql:param value="${param.productid}"></sql:param>
				<sql:param value="${param.stockroomid}"></sql:param>
				<sql:param value="${q}"></sql:param>
			</sql:update>
			</core:catch>
			
			<!-- updating  quantity in stock -->
			<sql:update dataSource="${con}" var="stockupdated">
				update stock set product_quantity_in_stock_room =? where stock_room_id=? and product_id=?;
				<sql:param value="${newQuantityForStcok}"></sql:param>
				<sql:param value="${param.stockroomid}"></sql:param>
				<sql:param value="${param.productid} "></sql:param>
			</sql:update>
			
			<!-- updating  quantity in products -->
			<sql:update dataSource="${con}" var="products updated">
				update products set product_quantity =? where id=?;
				<sql:param value="${newQuantityForProducts}"></sql:param>
				<sql:param value="${param.productid} "></sql:param>
			</sql:update>
			<!-- setting message for updation successfully -->
			<core:set var="addedToSalesStatus" value="added" scope="session"></core:set>
			<!-- products quantity check finished in products-->
			<core:redirect url="addSales.jsp"></core:redirect>
		</core:if>	
		<core:if test="${quantity_in_products lt q}">
			<core:set var="exception" value="quantityNotInProducts" scope="session"></core:set>
		<core:redirect url="addSales.jsp"></core:redirect>
		</core:if>
		<!-- products quantity check finished in stock-->
	</core:if>
	
	<core:if test="${quantity_in_stock lt q }">
		<core:set var="exception" value="quantityNotInstock" scope="session"></core:set>
		<core:redirect url="addSales.jsp"></core:redirect>
	</core:if>
	</core:if>
	<core:if test="${product_name_from_stock.rowCount eq 0}">
		<core:set var="exception" value="ProductnotAvailableInStock" scope="session"></core:set>
		<core:redirect url="addSales.jsp"></core:redirect>
	</core:if>
</body>
</html>