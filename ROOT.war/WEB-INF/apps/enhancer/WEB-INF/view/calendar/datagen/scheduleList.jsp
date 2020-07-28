<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${form.status}"/>",
  "Reason": "<util:json value="${form.reason}"/>",
  "Data":
  [
<c:forEach items="${results}" var="schedule" varStatus="status">
	{
		"id": "s_<util:json value="${schedule.scheduleId}"/>",
		"scheduleId": "<util:json value="${schedule.scheduleId}"/>",
		"calendarId": "<util:json value="${schedule.calendarId}"/>",
		"allDay": <util:json value="${schedule.allday}"/>,
		"start": "<util:json value="${schedule.start}"/>",
		"startTime": "<util:json value="${schedule.startTime12}"/>",
		"end": "<util:json value="${schedule.end}"/>",
		"endTime": "<util:json value="${schedule.endTime12}"/>",
		"langKnd": "<util:json value="${schedule.langKnd}"/>",
		"title": "<util:json value="${schedule.name}"/>",
		"permissions": "<util:json value="${schedule.calPermissions}"/>",
		<%-- <c:if test="${form.userId != schedule.ownerId && fn:indexOf(schedule.calPermissions, 'U') <= -1 }"> --%>
		<%-- <c:if test="${fn:indexOf(schedule.calPermissions, 'U') <= -1 || ( schedule.rrule != null && schedule.start != schedule.repeatStart ) }"> --%>
		<c:if test="${fn:indexOf(schedule.calPermissions, 'U') <= -1 || ( schedule.rrule != null ) }">
		"editable": false, 
		</c:if>
		"textColor": "<util:json value="${schedule.fgColor}"/>",
		"borderColor": "<util:json value="${schedule.bgColor}"/>",
		"backgroundColor": "<util:json value="${schedule.bgColor}"/>",
		"isJoint": "<util:json value="${schedule.isJoint}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
