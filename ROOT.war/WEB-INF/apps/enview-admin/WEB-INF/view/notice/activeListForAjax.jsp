<%@ page contentType="text/xml;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<noticeInfo>
	<status><c:out value="${inform.resultStatus}"/></status>
	<reason><![CDATA[   <c:out value="${inform.failureReason}"/>   ]]></reason>
<c:forEach items="${results}" var="notice" varStatus="status">
	<notice>
		<noticeId><c:out value="${notice.noticeId}"/></noticeId>
		<title><![CDATA[   <c:out value="${notice.title}"/>   ]]></title>
		<emergency><c:out value="${notice.emergency}"/></emergency>
		<template><c:out value="${notice.template}"/></template>
		<layoutX><c:out value="${notice.layoutX}"/></layoutX>
		<layoutY><c:out value="${notice.layoutY}"/></layoutY>
		<layoutWidth><c:out value="${notice.layoutWidth}"/></layoutWidth>
		<layoutHeight><c:out value="${notice.layoutHeight}"/></layoutHeight>
		<content><![CDATA[   <c:out value="${notice.content}" escapeXml="false"/>   ]]></content>
	</notice>
</c:forEach>
</noticeInfo>