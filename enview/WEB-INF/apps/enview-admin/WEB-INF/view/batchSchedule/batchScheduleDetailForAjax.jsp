
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <batchSchedule>

		<scheduleId><c:out value="${batchSchedule.scheduleId}"/></scheduleId>	
		<actionId><c:out value="${batchSchedule.actionId}"/></actionId>	
		<actionName0><![CDATA[  <c:out value="${batchSchedule.actionName0}"/>  ]]></actionName0>	
		<executeCycle><![CDATA[  <c:out value="${batchSchedule.executeCycle}"/>  ]]></executeCycle>	
		<executeDay><![CDATA[  <c:out value="${batchSchedule.executeDay}"/>  ]]></executeDay>	
		<executeHour><![CDATA[  <c:out value="${batchSchedule.executeHour}"/>  ]]></executeHour>	
		<executeMin><![CDATA[  <c:out value="${batchSchedule.executeMin}"/>  ]]></executeMin>	
		<executeSec><![CDATA[  <c:out value="${batchSchedule.executeSec}"/>  ]]></executeSec>	
		<executeWeeks><![CDATA[  <c:out value="${batchSchedule.executeWeeks}"/>  ]]></executeWeeks>	
		<isLogging><c:out value="${batchSchedule.isLogging}"/></isLogging>>
		<updUserId><![CDATA[  <c:out value="${batchSchedule.updUserId}"/>  ]]></updUserId>	
		<updDatim><c:out value="${batchSchedule.updDatimByFormat}"/></updDatim>	
	</batchSchedule>
</js>

