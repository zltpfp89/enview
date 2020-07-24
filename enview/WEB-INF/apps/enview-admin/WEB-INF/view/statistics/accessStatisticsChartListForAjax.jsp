<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason> 
       
    <accessStatistics>
    	<domain><c:out value="${ domain }"/></domain>
    	<domainNm><c:out value="${ domainNm }"/></domainNm>
		<todayAccessCount><c:out value="${todayAccessCount}"/></todayAccessCount>	
		<averageAccessCount><c:out value="${averageAccessCount}"/></averageAccessCount>	
		<accumulateAccessCount><c:out value="${accumulateAccessCount}"/></accumulateAccessCount>	
		<isMaster><c:out value="${isMaster}"/></isMaster>	
	</accessStatistics>
</js>