
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <batchAction>

		<actionId><c:out value="${batchAction.actionId}"/></actionId>	
		<name><![CDATA[  <c:out value="${batchAction.name}"/>  ]]></name>	
		<actionType><![CDATA[  <c:out value="${batchAction.actionType}"/>  ]]></actionType>	
		<program><![CDATA[  <c:out value="${batchAction.program}"/>  ]]></program>	
		<parameter><![CDATA[  <c:out value="${batchAction.parameter}"/>  ]]></parameter>	
		<useYn><c:out value="${batchAction.useYn}"/></useYn>	
		<updUserId><![CDATA[  <c:out value="${batchAction.updUserId}"/>  ]]></updUserId>	
		<updDatim><c:out value="${batchAction.updDatimByFormat}"/></updDatim>	
	</batchAction>
</js>

