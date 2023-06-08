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
		
		<sql:update dataSource="${con}" var="updateDealerStatus">
			update dealers set shop_name=?, mobile=?, gstno=?,address=? where id=?;
			<sql:param value="${param.dealerShop}"></sql:param>
			<sql:param value="${param.dealerMobile}"></sql:param>
			<sql:param value="${param.gstnumber}"></sql:param>
			<sql:param value="${param.dealerAddress}"></sql:param>
			<sql:param value="${param.dealerID}"></sql:param>
		</sql:update>
	
	
	<core:if test="${exception eq null}">
		<core:set var="exception" value="noexception" scope="session"></core:set>
		<core:set var="shop_id" value="${param.dealerID}" scope="session"></core:set>
		<core:redirect url="allDealers.jsp"></core:redirect>
	</core:if>
</body>
</html>