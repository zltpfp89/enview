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
<c:forEach items="${results}" var="pageComponent" varStatus="status">
	{
"pageComponentId": "<util:json value="${pageComponent.pageComponentId}"/>"
,"pageId": "<util:json value="${pageComponent.pageId}"/>"
,"region": "<util:json value="${pageComponent.region}"/>"
,"portletName": "<util:json value="${pageComponent.portletName}"/>"
,"parameter": "<util:json value="${pageComponent.parameter}"/>"
,"elementOrder": "<util:json value="${pageComponent.elementOrder}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
