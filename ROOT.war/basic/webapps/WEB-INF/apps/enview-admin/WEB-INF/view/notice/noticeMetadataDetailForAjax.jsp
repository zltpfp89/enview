<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <noticeMetadata>

		<id><c:out value="${noticeMetadata.id}"/></id>	
		<noticeId><c:out value="${noticeMetadata.noticeId}"/></noticeId>	
		<langKnd><![CDATA[  <c:out value="${noticeMetadata.langKnd}"/>  ]]></langKnd>	
		<title><![CDATA[  <c:out value="${noticeMetadata.title}"/>  ]]></title>	
		<content><![CDATA[  <c:out value="${noticeMetadata.content}"/>  ]]></content>	
	</noticeMetadata>
</js>
