
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
<c:forEach items="${results}" var="urlPermission" varStatus="status">
	{
"permissionId": "<util:json value="${urlPermission.permissionId}"/>"
,"principalId": "<util:json value="${urlPermission.principalId}"/>"
,"domainId": "<util:json value="${urlPermission.domainId}"/>"
,"title": "<util:json value="${urlPermission.title}"/>"
,"resUrl": "<util:json value="${urlPermission.resUrl}"/>"
,"resType": "<util:json value="${urlPermission.resType}"/>"
,"actionMask": "<util:json value="${urlPermission.actionMask}"/>"
,"isAllow": "<util:json value="${urlPermission.isAllow}"/>"
,"creationDate": "<util:json value="${urlPermission.creationDate}"/>"
,"modifiedDate": "<util:json value="${urlPermission.modifiedDate}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
