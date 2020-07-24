
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <domainInfo>
		<domainId><c:out value="${domain.domainId}"/></domainId>
		<domainCode><c:out value="${domain.domainCode}"/></domainCode>	
		<domain><![CDATA[<c:out value="${domain.domain}"/>]]></domain>	
		<pagePath><![CDATA[<c:out value="${domain.pagePath}"/>]]></pagePath>
		<loginPage><![CDATA[<c:out value="${domain.loginPage}"/>]]></loginPage>		
		<useYn><![CDATA[<c:out value="${domain.useYn}"/>]]></useYn>	
		<updUserId><![CDATA[<c:out value="${domain.updUserId}"/>]]></updUserId>	
		<updDatim><c:out value="${domain.updDatimByFormat}"/></updDatim>	
		<domainNm><![CDATA[<c:out value="${domain.domainNm}"/>]]></domainNm>	
	</domainInfo>
</js>

