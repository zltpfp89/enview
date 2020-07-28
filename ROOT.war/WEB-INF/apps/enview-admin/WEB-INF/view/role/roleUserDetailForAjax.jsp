<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <roleUser>

		<roleId><c:out value="${roleUser.roleId}"/></roleId>	
		<userId><c:out value="${roleUser.userId}"/></userId>	
		<principalName0><![CDATA[  <c:out value="${roleUser.principalName0}"/>  ]]></principalName0>	
		<mileageTag><![CDATA[  <c:out value="${roleUser.mileageTag}"/>  ]]></mileageTag>	
		<shortPath><c:out value="${roleUser.shortPath}"/></shortPath>	
	</roleUser>
</js>

