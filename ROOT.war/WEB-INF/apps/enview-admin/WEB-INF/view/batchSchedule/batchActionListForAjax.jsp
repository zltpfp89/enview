
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
<c:forEach items="${results}" var="batchAction" varStatus="status">
	{
"actionId": "<util:json value="${batchAction.actionId}"/>","name": "<util:json value="${batchAction.name}"/>","updUserId": "<util:json value="${batchAction.updUserId}"/>","updDatim": "<util:json value="${batchAction.updDatimByFormat}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
