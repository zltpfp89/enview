<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <client>

		<clientId><c:out value="${client.clientId}"/></clientId>	
		<name><![CDATA[<c:out value="${client.name}"/>]]></name>	
		<evalOrder><c:out value="${client.evalOrder}"/></evalOrder>	
		<userAgentPattern><![CDATA[<c:out value="${client.userAgentPattern}"/>]]></userAgentPattern>	
		<manufacturer><![CDATA[<c:out value="${client.manufacturer}"/>]]></manufacturer>	
		<model><![CDATA[<c:out value="${client.model}"/>]]></model>	
		<version><![CDATA[<c:out value="${client.version}"/>]]></version>	
		<preferredMimetypeId><c:out value="${client.preferredMimetypeId}"/></preferredMimetypeId>	
		<useTheme><c:out value="${client.useTheme}"/></useTheme>	
	</client>
</js>

