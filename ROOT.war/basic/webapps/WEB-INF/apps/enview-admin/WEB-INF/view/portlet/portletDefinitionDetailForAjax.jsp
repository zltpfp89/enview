<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <portletDefinition>

		<id><c:out value="${portletDefinition.id}"/></id>	
		<expirationCache><![CDATA[  <c:out value="${portletDefinition.expirationCache}"/>  ]]></expirationCache>	
		<name><![CDATA[  <c:out value="${portletDefinition.name}"/>  ]]></name>	
		<className><![CDATA[  <c:out value="${portletDefinition.className}" escapeXml="false"/>  ]]></className>	
		<applicationId><c:out value="${portletDefinition.applicationId}"/></applicationId>	
		<categoryId><c:out value="${portletDefinition.categoryId}"/></categoryId>	
		<portletIdentifier><![CDATA[  <c:out value="${portletDefinition.portletIdentifier}" escapeXml="false"/>  ]]></portletIdentifier>	
		<resourceBundle><![CDATA[  <c:out value="${portletDefinition.resourceBundle}" escapeXml="false"/>  ]]></resourceBundle>	
		<preferenceValidator><![CDATA[  <c:out value="${portletDefinition.preferenceValidator}" escapeXml="false"/>  ]]></preferenceValidator>	
		<applicationName><![CDATA[  <c:out value="${portletDefinition.applicationName0}" escapeXml="false"/>  ]]></applicationName>	
		<applicationTitle><![CDATA[  <c:out value="${portletDefinition.applicationTitle}" escapeXml="false"/>  ]]></applicationTitle>	
		<keywords><![CDATA[  <c:out value="${portletDefinition.keywords}" escapeXml="false"/>  ]]></keywords>	
		<title1><![CDATA[  <c:out value="${portletDefinition.title1}" escapeXml="false"/>  ]]></title1>	
		<description2><![CDATA[  <c:out value="${portletDefinition.description2}" escapeXml="false"/>  ]]></description2>	
		<iconName3><![CDATA[  <c:out value="${portletDefinition.iconName3}" escapeXml="false"/>  ]]></iconName3>	
		<serviceable><![CDATA[  <c:out value="${portletDefinition.serviceable}" escapeXml="false"/>  ]]></serviceable>	
	</portletDefinition>
</js>
