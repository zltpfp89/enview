<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <userRole>

		<roleId><c:out value="${userRole.roleId}"/></roleId>	
		<userId><c:out value="${userRole.userId}"/></userId>	
		<shortPath><c:out value="${userRole.shortPath}"/></shortPath>	
		<principalName0><![CDATA[  <c:out value="${userRole.principalName0}"/>  ]]></principalName0>	
		<mileageTag><![CDATA[  <c:out value="${userRole.mileageTag}"/>  ]]></mileageTag>	
		<sortOrder><c:out value="${userRole.sortOrder}"/></sortOrder>	
	</userRole>
</js>
