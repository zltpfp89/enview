
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
<c:forEach items="${results}" var="client" varStatus="status">
	{
"clientId": "<util:json value="${client.clientId}"/>","name": "<util:json value="${client.name}"/>","evalOrder": "<util:json value="${client.evalOrder}"/>","useTheme": "<util:json value="${client.useTheme}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
