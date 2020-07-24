
<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${inform.resultStatus}"/>",
  "Reason": "<util:json value="${inform.failureReason}"/>",
  "TotalSize": "<util:json value="${inform.totalSize}"/>",
  "ResultSize": "<util:json value="${inform.resultSize}"/>",
  "Data":
  [
<c:forEach items="${results}" var="batchSchedule" varStatus="status">
	{
"scheduleId": "<util:json value="${batchSchedule.scheduleId}"/>","actionName0": "<util:json value="${batchSchedule.actionName0}"/>","updUserId": "<util:json value="${batchSchedule.updUserId}"/>","updDatim": "<util:json value="${batchSchedule.updDatimByFormat}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
