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

<core:catch var="exception" >
<sql:update dataSource="${con}" var="insertStockRoomStatus">
	insert into stockroom(stock_room_name) values(?);
	<sql:param value="${param.stockRoomName }"></sql:param> 
</sql:update>
</core:catch>
<core:if test="${insertStockRoomStatus gt 0}">
	<core:set var="exception" value="notexception" scope="session"></core:set>
	<core:set var="stock_room_name" value="${param.stockRoomName}" scope="session"></core:set>
	<core:redirect url="addStockRoom.jsp"></core:redirect>
</core:if>
<core:if test="${insertStockRoomStatus ne 0}">
	<core:set var="exception" value="exception" scope="session"></core:set>
	<core:set var="stock_room_name" value="${param.stockRoomName}" scope="session"></core:set>
	<core:redirect url="addStockRoom.jsp"></core:redirect>
</core:if>



</body>
</html>