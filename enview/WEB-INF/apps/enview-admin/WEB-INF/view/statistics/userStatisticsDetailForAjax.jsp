<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <userStatistics>

		<accessBrowser><![CDATA[  <c:out value="${userStatistics.accessBrowser}"/>  ]]></accessBrowser>	
		<userIp><![CDATA[  <c:out value="${userStatistics.userIp}"/>  ]]></userIp>	
		<orgName><![CDATA[  <c:out value="${userStatistics.orgName}"/>  ]]></orgName>	
		<userId><![CDATA[  <c:out value="${userStatistics.userId}"/>  ]]></userId>	
		<userName><![CDATA[  <c:out value="${userStatistics.userName}"/>  ]]></userName>	
		<status><c:out value="${userStatistics.status}"/></status>	
		<timeStamp><c:out value="${userStatistics.timeStampByFormat}"/></timeStamp>	
		<principalId><c:out value="${userStatistics.principalId}"/></principalId>	
		<orgCd><![CDATA[  <c:out value="${userStatistics.orgCd}"/>  ]]></orgCd>	
		<elapsedTime><c:out value="${userStatistics.elapsedTime}"/></elapsedTime>	
		<extraInfo01><![CDATA[  <c:out value="${userStatistics.extraInfo01}"/>  ]]></extraInfo01>	
		<extraInfo02><![CDATA[  <c:out value="${userStatistics.extraInfo02}"/>  ]]></extraInfo02>	
		<extraInfo03><![CDATA[  <c:out value="${userStatistics.extraInfo03}"/>  ]]></extraInfo03>	
		<extraInfo04><![CDATA[  <c:out value="${userStatistics.extraInfo04}"/>  ]]></extraInfo04>	
		<extraInfo05><![CDATA[  <c:out value="${userStatistics.extraInfo05}"/>  ]]></extraInfo05>	
	</userStatistics>
</js>

