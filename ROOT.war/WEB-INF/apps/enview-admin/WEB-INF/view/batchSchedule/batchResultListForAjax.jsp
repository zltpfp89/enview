
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
<c:forEach items="${results}" var="batchResult" varStatus="status">
	{
"resultId": "<util:json value="${batchResult.resultId}"/>","actionName0": "<util:json value="${batchResult.actionName0}"/>","status": "<util:json value="${batchResult.status}"/>","executStart": "<util:json value="${batchResult.executStartByFormat}"/>","executEnd": "<util:json value="${batchResult.executEndByFormat}"/>","updUserId": "<util:json value="${batchResult.updUserId}"/>","updDatim": "<util:json value="${batchResult.updDatimByFormat}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
