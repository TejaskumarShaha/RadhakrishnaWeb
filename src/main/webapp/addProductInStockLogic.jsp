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
	<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
		<core:catch var="exception">
			<sql:update dataSource="${con}" var="i">
				insert into products(product_name,product_quantity) values(?,?);
				<sql:param value="${param.productNameInStock}"></sql:param>
				<sql:param value="${param.productQuantityInStock}"></sql:param>
				
			</sql:update>
		</core:catch>
		
	<core:if test="${exception != null}">
		<core:set var="product_available_in_Stock" value="exception" scope="session"></core:set>
		<core:set var="product_name_in_stock" value="${param.productNameInStock}" scope="session"></core:set>
		<core:redirect url="addProductInStock.jsp" />	
	</core:if>
	<core:if test="${exception == null}">
		<core:set var="product_name_in_stock" value="${param.productNameInStock}" scope="session"></core:set>
		<core:set var="product_available_in_Stock" value="notexception" scope="session"></core:set>
		<core:redirect url="addProductInStock.jsp" />			
	</core:if>
</core:if>
</body>
</html>