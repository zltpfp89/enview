<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <pageStatistics>

		<totalSession><c:out value="${pageStatistics.totalSession}"/></totalSession>	
		<totalHits><c:out value="${pageStatistics.totalHits}"/></totalHits>	
		<totalMaxTime><c:out value="${pageStatistics.totalMaxTime}"/></totalMaxTime>	
		<totalMinTime><c:out value="${pageStatistics.totalMinTime}"/></totalMinTime>	
		<totalAverageTime><c:out value="${pageStatistics.totalAverageTime}"/></totalAverageTime>	
		<title><![CDATA[  <c:out value="${pageStatistics.title}"/>  ]]></title>	
		<path><![CDATA[  <c:out value="${pageStatistics.path}"/>  ]]></path>	
		<hits><c:out value="${pageStatistics.hits}"/></hits>	
		<maxTime><c:out value="${pageStatistics.maxTime}"/></maxTime>	
		<minTime><c:out value="${pageStatistics.minTime}"/></minTime>	
		<averageTime><c:out value="${pageStatistics.averageTime}"/></averageTime>	
	</pageStatistics>
</js>