
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <portletService>
		<serviceId><![CDATA[<c:out value="${portletService.serviceId}"/>]]></serviceId>	
		<serviceName><![CDATA[<c:out value="${portletService.serviceName}"/>]]></serviceName>	
		<serviceType><![CDATA[<c:out value="${portletService.serviceType}"/>]]></serviceType>	
		<dataType><![CDATA[<c:out value="${portletService.dataType}"/>]]></dataType>	
		<colDel><![CDATA[<c:out value="${portletService.colDel}"/>]]></colDel>	
		<rowDel><![CDATA[<c:out value="${portletService.rowDel}"/>]]></rowDel>	
		<titleYn><c:out value="${portletService.titleYn}"/></titleYn>	
		<dataUrl><![CDATA[<c:out value="${portletService.dataUrl}"/>]]></dataUrl>	
		<jndiName><![CDATA[<c:out value="${portletService.jndiName}"/>]]></jndiName>	
		<userParam><![CDATA[<c:out value="${portletService.userParam}"/>]]></userParam>	
		<portletParam><![CDATA[<c:out value="${portletService.portletParam}"/>]]></portletParam>	
		<dbSql><![CDATA[<c:out value="${portletService.dbSql}" escapeXml="false"/>]]></dbSql>	
		<maxCacheTime><![CDATA[<c:out value="${portletService.maxCacheTime}" escapeXml="false"/>]]></maxCacheTime>	
		<maxCacheSize><![CDATA[<c:out value="${portletService.maxCacheSize}" escapeXml="false"/>]]></maxCacheSize>	
	</portletService>
</js>

