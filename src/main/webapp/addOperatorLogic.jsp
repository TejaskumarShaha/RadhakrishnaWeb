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
<core:set var="operator_name" value="${param.operatorName}" scope="session"></core:set>
<core:set var="date" value="${param.joiningDate}"></core:set>
<core:set var="salary" value="${param.operatorSalary}"></core:set>
<core:set var="mobile" value="${param.operatorMobile}"></core:set>
<core:set var="password" value="${param.operatorPassword}"></core:set>
<sql:setDataSource 
	user="root" 
	password="root" 
	driver="com.mysql.cj.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/radhakrishna" 
	var="con"/>
	<core:catch var="exception">
	<sql:update dataSource="${con}" var="updateStatus">
		insert into operators(operater_name,operater_joining_date,mobile,salary,password) values(?,?,?,?,?);
		<sql:param value="${operator_name}"></sql:param>
		<sql:param value="${date}"></sql:param>
		<sql:param value="${mobile}"></sql:param>
		<sql:param value="${salary}"></sql:param>
		<sql:param value="${password}"></sql:param>
	</sql:update>
	</core:catch>
	${exception }
	<core:if test="${exception==null}">
		<core:set var="operatorAddStatus" value="Operator Added" scope="session"></core:set>
		<core:redirect url="addOperatorForm.jsp"></core:redirect>
	</core:if>
</body>
</html>