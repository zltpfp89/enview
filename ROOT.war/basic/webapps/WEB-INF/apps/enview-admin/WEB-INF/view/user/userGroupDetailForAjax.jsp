<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <userGroup>
		<groupId><c:out value="${userGroup.groupId}"/></groupId>	
		<userId><c:out value="${userGroup.userId}"/></userId>	
		<shortPath><c:out value="${userGroup.shortPath}"/></shortPath>	
		<principalName0><![CDATA[  <c:out value="${userGroup.principalName0}"/>  ]]></principalName0>	
		<mileageTag><![CDATA[  <c:out value="${userGroup.mileageTag}"/>  ]]></mileageTag>	
		<sortOrder><c:out value="${userGroup.sortOrder}"/></sortOrder>
		<domain><c:out value="${userGroup.domain}"/></domain>
		<empNo><c:out value="${userGroup.empNo}"/></empNo>
		<orgCd><c:out value="${userGroup.orgCd}"/></orgCd>
	</userGroup>
</js>
