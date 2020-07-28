<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${form.status}"/>",
  "Reason": "<util:json value="${form.reason}"/>",
  "Data":
  [
<c:forEach items="${results}" var="calendar" varStatus="status">
	{
		"calendarId": "<util:json value="${calendar.calendarId}"/>",
		"isDefault": "<util:json value="${calendar.isDefault}"/>",
		"fgColor": "<util:json value="${calendar.fgColor}"/>",
		"bgColor": "<util:json value="${calendar.bgColor}"/>",
		"ownerId": "<util:json value="${calendar.ownerId}"/>",
		"langKnd": "<util:json value="${calendar.langKnd}"/>",
		"name": "<util:json value="${calendar.name}"/>",
		"comments": "<util:json value="${calendar.comments}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}