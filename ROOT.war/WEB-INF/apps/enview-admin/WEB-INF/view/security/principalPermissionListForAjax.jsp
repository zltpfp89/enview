
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
<c:forEach items="${results}" var="pagePermission" varStatus="status">
	{
"permissionId": "<util:json value="${pagePermission.permissionId}"/>"
,"principalId": "<util:json value="${pagePermission.principalId}"/>"
,"domainId": "<util:json value="${pagePermission.domainId}"/>"
,"title": "<util:json value="${pagePermission.title}"/>"
,"resUrl": "<util:json value="${pagePermission.resUrl}"/>"
,"resType": "<util:json value="${pagePermission.resType}"/>"
,"actionMask": "<util:json value="${pagePermission.actionMask}"/>"
,"isAllow": "<util:json value="${pagePermission.isAllow}"/>"
,"creationDate": "<util:json value="${pagePermission.creationDate}"/>"
,"modifiedDate": "<util:json value="${pagePermission.modifiedDate}"/>"
,"shortPath": "<util:json value="${pagePermission.shortPath}"/>"
,"principalName": "<util:json value="${pagePermission.principalName}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
