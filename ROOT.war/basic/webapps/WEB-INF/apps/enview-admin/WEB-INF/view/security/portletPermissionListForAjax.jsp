
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
<c:forEach items="${results}" var="portletPermission" varStatus="status">
	{
"permissionId": "<util:json value="${portletPermission.permissionId}"/>"
,"principalId": "<util:json value="${portletPermission.principalId}"/>"
,"domainId": "<util:json value="${portletPermission.domainId}"/>"
,"title": "<util:json value="${portletPermission.title}"/>"
,"resUrl": "<util:json value="${portletPermission.resUrl}"/>"
,"resType": "<util:json value="${portletPermission.resType}"/>"
,"actionMask": "<util:json value="${portletPermission.actionMask}"/>"
,"isAllow": "<util:json value="${portletPermission.isAllow}"/>"
,"creationDate": "<util:json value="${portletPermission.creationDate}"/>"
,"modifiedDate": "<util:json value="${portletPermission.modifiedDate}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
