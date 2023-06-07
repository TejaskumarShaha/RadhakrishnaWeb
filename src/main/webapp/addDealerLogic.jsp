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
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
		<core:catch var="exception">
		<sql:update dataSource="${con}" var="addDealerStatus">
			insert into dealers(shop_name,mobile,gstno) values(?,?,?);
			<sql:param value="${param.dealerShop}"></sql:param>
			<sql:param value="${param.dealerMobile}"></sql:param>
			<sql:param value="${param.gstnumber}"></sql:param>
		</sql:update>
	</core:catch>
	<core:if test="${exception eq null}">
		<core:set var="exception" value="noexception" scope="session"></core:set>
		<core:set var="shop_name" value="${param.dealerShop}" scope="session"></core:set>
		<core:redirect url="addDealers.jsp"></core:redirect>
	</core:if>
	
	<core:if test="${exception ne null}">
		<core:set var="exception" value="exception" scope="session"></core:set>
		<core:set var="shop_name" value="${param.dealerShop}" scope="session"></core:set>
		<core:redirect url="addDealers.jsp"></core:redirect>
	</core:if>
	
</body>
</html>