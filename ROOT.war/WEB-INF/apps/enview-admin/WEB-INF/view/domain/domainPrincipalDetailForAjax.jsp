
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <domainPrincipal>
		<domainId><c:out value="${domainPrincipal.domainId}"/></domainId>	
		<userName><![CDATA[<c:out value="${domainPrincipal.userName}"/>]]></userName>
		<domain><![CDATA[<c:out value="${domainPrincipal.domain}"/>]]></domain>
		<principalId><c:out value="${domainPrincipal.principalId}"/></principalId>
		<principal><c:out value="${domainPrincipal.principal}"/></principal>
		<theme><![CDATA[<c:out value="${domainPrincipal.theme}"/>]]></theme>	
		<defaultPage><![CDATA[<c:out value="${domainPrincipal.defaultPage}"/>]]></defaultPage>
		<subPage><![CDATA[<c:out value="${domainPrincipal.subPage}"/>]]></subPage>	
	</domainPrincipal>
</js>

