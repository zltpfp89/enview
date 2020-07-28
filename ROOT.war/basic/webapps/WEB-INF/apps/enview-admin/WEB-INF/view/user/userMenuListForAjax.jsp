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
<c:forEach items="${results}" var="userMenu" varStatus="status">
	{
"id": "<util:json value="${userMenu.id}"/>"
,"name": "<util:json value="${userMenu.name}"/>"
,"path": "<util:json value="${userMenu.path}"/>"
,"url": "<util:json value="${userMenu.url}"/>"
,"title": "<util:json value="${userMenu.title}"/>"
,"shortTitle": "<util:json value="${userMenu.shortTitle}"/>"
,"target": "<util:json value="${userMenu.target}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
