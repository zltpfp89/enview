<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <securityPolicy>

		<policyId><c:out value="${securityPolicy.policyId}"/></policyId>	
		<ipaddress><![CDATA[  <c:out value="${securityPolicy.ipaddress}"/>  ]]></ipaddress>	
		<resUrl><![CDATA[  <c:out value="${securityPolicy.resUrl}"/>  ]]></resUrl>	
		<authMethod><c:out value="${securityPolicy.authMethod}"/></authMethod>	
		<isAllow><c:out value="${securityPolicy.isAllow}"/></isAllow>	
		<isEnabled><c:out value="${securityPolicy.isEnabled}"/></isEnabled>	
		<startDate><c:out value="${securityPolicy.startDateValue}"/></startDate>	
		<endDate><c:out value="${securityPolicy.endDateValue}"/></endDate>	
	</securityPolicy>
</js>
