<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <groupRole>

		<groupId><c:out value="${groupRole.groupId}"/></groupId>	
		<roleId><c:out value="${groupRole.roleId}"/></roleId>	
		<shortPath><c:out value="${groupRole.shortPath}"/></shortPath>	
		<principalName0><![CDATA[  <c:out value="${groupRole.principalName0}"/>  ]]></principalName0>	
	</groupRole>
</js>