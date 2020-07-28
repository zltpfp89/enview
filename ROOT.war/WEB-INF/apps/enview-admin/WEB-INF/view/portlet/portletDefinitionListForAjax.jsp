
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
<c:forEach items="${results}" var="portletDefinition" varStatus="status">
	{
"name": "<util:json value="${portletDefinition.name}"/>"
,"className": "<util:json value="${portletDefinition.className}"/>"
,"applicationName0": "<util:json value="${portletDefinition.applicationName}"/>"
,"applicationTitle": "<util:json value="${portletDefinition.applicationTitle}"/>"
,"title1": "<util:json value="${portletDefinition.title1}"/>"
,"keywords": "<util:json value="${portletDefinition.keywords}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
