
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <domainLang>
		<domainId><c:out value="${domainLang.domainId}"/></domainId>
		<domain><![CDATA[<c:out value="${domainLang.domain}"/>]]></domain>	
		<langKnd><![CDATA[<c:out value="${domainLang.langKnd}"/>]]></langKnd>	
		<domainNm><![CDATA[<c:out value="${domainLang.domainNm}"/>]]></domainNm>	
		<domainDesc><![CDATA[<c:out value="${domainLang.domainDesc}"/>]]></domainDesc>	
	</domainLang>
</js>

