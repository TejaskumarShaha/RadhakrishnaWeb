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
	<fmt:parseNumber var="p" type="number" value="${param.product_price}" />
	<fmt:parseNumber var="q" type="number" value="${param.product_quantity}" />
	<fmt:parseNumber var="d" type="number" value="${param.product_discount}" />
	<fmt:parseNumber var="t" type="number" value="${param.product_tax}" /> 
	<core:set var="price" value="${(((p*q)-d)*(100+t))/100}" ></core:set>
		
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	
	<core:catch var="CatchException">
	<sql:update dataSource="${con}" var="updateStatus">
		insert into billings(id,product_quantity,product_add_date,product_price,manufacturing_date,expiry_date,store_name) values(?,?,?,?,?,?,?);
		<sql:param value="${param.id}"></sql:param>
		<sql:param value="${q}"></sql:param>
		<sql:param value="${param.product_add_date}"></sql:param>
		<sql:param value="${price}"></sql:param>
		<sql:param value="${param.manufacturing_date}"></sql:param>
		<sql:param value="${param.expiry_date}"></sql:param>
		<sql:param value="${param.store_name}"></sql:param>
	</sql:update>
	</core:catch>
	
	<sql:query dataSource="${con}" var="productNameFromStock">
		SELECT product_name FROM stock S
		INNER JOIN products P ON S.product_id= P.id
		INNER JOIN stockroom SR ON S.stock_room_id= SR.id
		WHERE stock_room_id =${param.stock_room_id} and product_id = ${param.id};
	</sql:query>
	
	<core:catch var="e">
	<sql:query dataSource="${con}" var="quantity">
		select product_quantity_in_stock_room  from stock where product_id =${param.id} and stock_room_id =${param.stock_room_id};
	</sql:query>
	</core:catch>
	<!-- extracting quantity of product -->
	<core:forEach var="da" items="${quantity.rows}">
		<core:set var="product_quantity_in_stock" value="${da.product_quantity_in_stock_room}"></core:set>
	</core:forEach> 
	<core:set var="newQuantity" value="${product_quantity_in_stock + q}"></core:set>
	<core:out value="${quan.rowCount}"></core:out>
	<core:out value="${quan.rowCount}"></core:out>
	
	<core:if test="${productNameFromStock.rowCount gt 0}">
	<sql:update dataSource="${con}" var="addedInExistingProduct">
		update stock set product_quantity_in_stock_room = ? where stock_room_id=? and product_id =?;
		<sql:param value="${newQuantity}"></sql:param>
		<sql:param value="${param.stock_room_id}"></sql:param>
		<sql:param value="${param.id}"></sql:param>
	</sql:update>
	</core:if>
	
	<core:if test="${productNameFromStock.rowCount eq 0}">
	<sql:update dataSource="${con}" var="addedInExistingProduct">
		insert into stock(product_id,stock_room_id,product_quantity_in_stock_room) values(?,?,?);
		<sql:param value="${param.id}"></sql:param>
		<sql:param value="${param.stock_room_id}"></sql:param>
		<sql:param value="${q}"></sql:param>
	</sql:update>
	</core:if>
	<!-- extracting product name from products -->
	
	<sql:query dataSource="${con}" var="product_name_in_products_from_query">
		select product_name from products where id=?;
		<sql:param value="${param.id}"></sql:param>
	</sql:query>
	
	<core:forEach var="product_name_in_products_from_loop" items="${product_name_in_products_from_query.rows }">
		<core:set var="product_name_in_products" value="${product_name_in_products_from_loop.product_name }" scope="session"></core:set>
	</core:forEach>
	
	<!-- extracting product quantity from products -->
	<sql:query dataSource="${con}" var="addProductQuantityInProducts">
		select product_quantity from products where product_name=?;
		<sql:param value="${product_name_in_products}"></sql:param>
	</sql:query>
	
	<core:forEach var="pq" items="${addProductQuantityInProducts.rows}">
		<core:set var="product_quantity_in_products" value="${pq.product_quantity}"></core:set>
	</core:forEach>
	
	<core:set var="quantity_for_products" value="${product_quantity_in_products + q }"></core:set>
	
	<sql:update dataSource="${con}" var="updateProductQuantityInProductsStatus">
		update products set product_quantity =${quantity_for_products} where product_name ='${product_name_in_products}';
	</sql:update>
	
	<core:if test="${CatchException ne null}">
		<core:set var="exception" value="exception" scope="session"></core:set>
		<core:set var="price" value="${param.product_name}" scope="session"></core:set>
		<core:redirect url="addBillings.jsp"></core:redirect>
	</core:if>
	
	<core:if test="${CatchException eq null}">		
		<core:set var="exception" value="notexception" scope="session"></core:set>
		<core:set var="isProductInStock" value="${addProdcutToTheStockRoom.rowCount}" scope="session"></core:set>
		<core:redirect url="addBillings.jsp"></core:redirect>
	</core:if>
</body>
</html>