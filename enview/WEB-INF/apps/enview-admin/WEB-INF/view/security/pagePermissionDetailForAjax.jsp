<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <pagePermission>

		<permissionId><c:out value="${pagePermission.permissionId}"/></permissionId>	
		<principalId><c:out value="${pagePermission.principalId}"/></principalId>	
		<title><![CDATA[  <c:out value="${pagePermission.title}"/>  ]]></title>	
		<resUrl><![CDATA[  <c:out value="${pagePermission.resUrl}"/>  ]]></resUrl>	
		<resType><c:out value="${pagePermission.resType}"/></resType>	
		<actionMask><c:out value="${pagePermission.actionMask}"/></actionMask>	
		<isAllow><c:out value="${pagePermission.isAllow}"/></isAllow>	
		<creationDate><c:out value="${pagePermission.creationDateByFormat}"/></creationDate>	
		<modifiedDate><c:out value="${pagePermission.modifiedDateByFormat}"/></modifiedDate>	
	</pagePermission>
</js>