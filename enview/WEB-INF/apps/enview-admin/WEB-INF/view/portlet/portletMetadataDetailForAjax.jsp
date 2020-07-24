<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <portletMetadata>

		<metaName><![CDATA[  <c:out value="${portletMetadata.metaName}"/>  ]]></metaName>	
		<localeString><![CDATA[  <c:out value="${portletMetadata.localeString}"/>  ]]></localeString>	
		<metaValue><![CDATA[  <c:out value="${portletMetadata.metaValue}" escapeXml="false"/>  ]]></metaValue>	
	</portletMetadata>
</js>
