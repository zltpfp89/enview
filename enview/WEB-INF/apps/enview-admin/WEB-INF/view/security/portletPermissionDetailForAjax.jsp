<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <portletPermission>

		<permissionId><c:out value="${portletPermission.permissionId}"/></permissionId>	
		<principalId><c:out value="${portletPermission.principalId}"/></principalId>
		<domainId><c:out value="${portletPermission.domainId}"/></domainId>	
		<title><![CDATA[  <c:out value="${portletPermission.title}"/>  ]]></title>	
		<resUrl><![CDATA[  <c:out value="${portletPermission.resUrl}"/>  ]]></resUrl>	
		<resType><c:out value="${portletPermission.resType}"/></resType>	
		<actionMask><c:out value="${portletPermission.actionMask}"/></actionMask>	
		<isAllow><c:out value="${portletPermission.isAllow}"/></isAllow>	
		<creationDate><c:out value="${portletPermission.creationDate}"/></creationDate>	
		<modifiedDate><c:out value="${portletPermission.modifiedDate}"/></modifiedDate>	
	</portletPermission>
</js>
