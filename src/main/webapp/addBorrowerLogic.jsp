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
		<core:catch var="CatchException">
		<sql:update dataSource="${con}" var="updateBorrowerStatus">
			insert into borrowers(customer_name,customer_mobile_number,total_borrowing,borrowing_date,address) values(?,?,?,?,?);
			<sql:param value="${param.customerName}"></sql:param>
			<sql:param value="${param.customerMobileNumber}"></sql:param>
			<sql:param value="${param.borrowingPrice}"></sql:param>
			<sql:param value="${param.borrowingAddDate}"></sql:param>
			<sql:param value="${param.address}"></sql:param>		
		</sql:update>
	</core:catch>
	${CatchException.message}
	<core:if test="${CatchException==null}">
		<jsp:forward page="addBorrower.jsp">
				<jsp:param name="notException" value="notexception"></jsp:param>
				<jsp:param name="addBorrowerFor" value="${param.customerName}"></jsp:param>	
		</jsp:forward>
	</core:if>
</body>
</html>