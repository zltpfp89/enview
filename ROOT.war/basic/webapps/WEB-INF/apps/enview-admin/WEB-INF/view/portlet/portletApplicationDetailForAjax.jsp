<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <portletApplication>

		<applicationId><c:out value="${portletApplication.applicationId}"/></applicationId>	
		<appName><![CDATA[  <c:out value="${portletApplication.appName}"/>  ]]></appName>	
		<appIdentifier><![CDATA[  <c:out value="${portletApplication.appIdentifier}"/>  ]]></appIdentifier>	
		<version><![CDATA[  <c:out value="${portletApplication.version}"/>  ]]></version>	
		<appType><c:out value="${portletApplication.appType}"/></appType>	
		<checksum><![CDATA[  <c:out value="${portletApplication.checksum}"/>  ]]></checksum>	
		<description><![CDATA[  <c:out value="${portletApplication.description}"/>  ]]></description>	
		<webAppId><c:out value="${portletApplication.webAppId}"/></webAppId>	
	</portletApplication>
</js>
