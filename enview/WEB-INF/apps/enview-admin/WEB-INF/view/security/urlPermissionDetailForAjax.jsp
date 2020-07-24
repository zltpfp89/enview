<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <urlPermission>

		<permissionId><c:out value="${urlPermission.permissionId}"/></permissionId>	
		<principalId><c:out value="${urlPermission.principalId}"/></principalId>
		<domainId><c:out value="${urlPermission.domainId}"/></domainId>	
		<title><![CDATA[  <c:out value="${urlPermission.title}"/>  ]]></title>	
		<resUrl><![CDATA[  <c:out value="${urlPermission.resUrl}"/>  ]]></resUrl>	
		<resType><c:out value="${urlPermission.resType}"/></resType>	
		<actionMask><c:out value="${urlPermission.actionMask}"/></actionMask>	
		<isAllow><c:out value="${urlPermission.isAllow}"/></isAllow>	
		<creationDate><c:out value="${urlPermission.creationDate}"/></creationDate>	
		<modifiedDate><c:out value="${urlPermission.modifiedDate}"/></modifiedDate>	
	</urlPermission>
</js>
