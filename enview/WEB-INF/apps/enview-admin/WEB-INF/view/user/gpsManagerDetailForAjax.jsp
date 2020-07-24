<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <gpsmanager>
		<userId><![CDATA[<c:out value="${gpsmanager.userId}"/>]]></userId>	
		<latiTude><![CDATA[<c:out value="${gpsmanager.latiTude}"/> ]]></latiTude>	
		<longiTude><![CDATA[<c:out value="${gpsmanager.longiTude}"/>  ]]></longiTude>	
		<addRess><![CDATA[<c:out value="${gpsmanager.addRess}"/>  ]]></addRess>	
	</gpsmanager>
</js>