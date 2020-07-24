<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <groupUser>

		<groupId><c:out value="${groupUser.groupId}"/></groupId>	
		<userId><c:out value="${groupUser.userId}"/></userId>	
		<shortPath><c:out value="${groupUser.shortPath}"/></shortPath>	
		<principalName0><![CDATA[  <c:out value="${groupUser.principalName0}"/>  ]]></principalName0>	
		<mileageTag><![CDATA[  <c:out value="${groupUser.mileageTag}"/>  ]]></mileageTag>	
		<sortOrder><c:out value="${groupUser.sortOrder}"/></sortOrder>	
	</groupUser>
</js>