<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <credential>

		<credentialId><c:out value="${credential.credentialId}"/></credentialId>	
		<principalId><c:out value="${credential.principalId}"/></principalId>	
		<columnValue><![CDATA[  <c:out value="${credential.columnValue}"/>  ]]></columnValue>	
		<updateRequired><c:out value="${credential.updateRequired}"/></updateRequired>	
		<authFailures><c:out value="${credential.authFailures}"/></authFailures>	
		<modifiedDate><c:out value="${credential.modifiedDateByFormat}"/></modifiedDate>	
	</credential>
</js>
