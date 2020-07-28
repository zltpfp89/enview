<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <notice>
		<noticeId><c:out value="${notice.noticeId}"/></noticeId>	
		<isEmergency><c:out value="${notice.isEmergency}"/></isEmergency>	
		<title><![CDATA[  <c:out value="${notice.title}"/>  ]]></title>	
		<startDate><c:out value="${notice.startDateValue}"/></startDate>	
		<endDate><c:out value="${notice.endDateValue}"/></endDate>	
		<template><![CDATA[  <c:out value="${notice.template}"/>  ]]></template>	
		<layoutX><![CDATA[  <c:out value="${notice.layoutX}"/>  ]]></layoutX>	
		<layoutY><![CDATA[  <c:out value="${notice.layoutY}"/>  ]]></layoutY>	
		<layoutWidth><![CDATA[  <c:out value="${notice.layoutWidth}"/>  ]]></layoutWidth>	
		<layoutHeight><![CDATA[  <c:out value="${notice.layoutHeight}"/>  ]]></layoutHeight>	
		<principalId><![CDATA[  <c:out value="${notice.principalId}"/>  ]]></principalId>	
		<groups><![CDATA[  <c:out value="${notice.groups}"/>  ]]></groups>	
		<pages><![CDATA[  <c:out value="${notice.pages}"/>  ]]></pages>	
		<domainId><c:out value="${notice.domainId}"/></domainId>
		<domainNm><![CDATA[  <c:out value="${notice.domainNm}"/>  ]]></domainNm>	
		<systemCode><![CDATA[<c:out value="${notice.systemCode}"/>]]></systemCode>	
	<c:forEach items="${notice.groupInfoList}" var="group" varStatus="status">
		<groupData principalId="<c:out value="${group.PRINCIPAL_ID}"/>" shortPath="<c:out value="${group.SHORT_PATH}"/>"><![CDATA[  <c:out value="${group.PRINCIPAL_NAME}"/>  ]]></groupData>
	</c:forEach>
	<c:forEach items="${notice.pageInfoList}" var="page" varStatus="status">
		<pageData pageId="<c:out value="${page.PAGE_ID}"/>" path="<c:out value="${page.PATH}"/>"><![CDATA[  <c:out value="${page.SHORT_TITLE}"/>  ]]></pageData>
	</c:forEach>
	</notice>
</js>