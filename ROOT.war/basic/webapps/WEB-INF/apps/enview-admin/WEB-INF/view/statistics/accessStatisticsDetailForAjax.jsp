<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason> 
       
    <accessStatistics>
		<currentUser><c:out value="${accessStatistics.currentUser}"/></currentUser>	
		<todayUser><c:out value="${accessStatistics.todayUser}"/></todayUser>	
		<averageUser><c:out value="${accessStatistics.averageUser}"/></averageUser>	
		<accumulateUser><c:out value="${accessStatistics.accumulateUser}"/></accumulateUser>	
		<registUser><c:out value="${accessStatistics.registUser}"/></registUser>	
		<secessionUser><c:out value="${accessStatistics.secessionUser}"/></secessionUser>	
	</accessStatistics>
</js>