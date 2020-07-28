
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status2><c:out value="${inform.resultStatus}"/></status2>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <batchResult>

		<resultId><c:out value="${batchResult.resultId}"/></resultId>	
		<scheduleId><c:out value="${batchResult.scheduleId}"/></scheduleId>	
		<actionId><c:out value="${batchResult.actionId}"/></actionId>	
		<actionName0><![CDATA[  <c:out value="${batchResult.actionName0}"/>  ]]></actionName0>	
		<parameter><![CDATA[  <c:out value="${batchResult.parameter}"/>  ]]></parameter>	
		<status><![CDATA[  <c:out value="${batchResult.status}"/>  ]]></status>	
		<errorInfo><![CDATA[  <c:out value="${batchResult.errorInfo}"/>  ]]></errorInfo>	
		<executStart><![CDATA[  <c:out value="${batchResult.executStartByFormat}"/>  ]]></executStart>	
		<executEnd><![CDATA[  <c:out value="${batchResult.executEndByFormat}"/>  ]]></executEnd>	
		<updUserId><![CDATA[  <c:out value="${batchResult.updUserId}"/>  ]]></updUserId>	
		<updDatim><c:out value="${batchResult.updDatimByFormat}"/></updDatim>	
	</batchResult>
</js>

