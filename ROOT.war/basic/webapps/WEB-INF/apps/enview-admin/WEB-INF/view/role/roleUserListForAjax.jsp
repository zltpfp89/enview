
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
<c:forEach items="${results}" var="roleUser" varStatus="status">
	{
"userId": "<util:json value="${roleUser.userId}"/>"
,"roleId": "<util:json value="${roleUser.roleId}"/>"
,"shortPath": "<util:json value="${roleUser.shortPath}"/>"
,"principalName0": "<util:json value="${roleUser.principalName0}"/>"
,"mileageTag": "<util:json value="${roleUser.mileageTag}"/>"
,"principalInfo01": "<util:json value="${groupUser.principalInfo01}"/>"
,"principalInfo02": "<util:json value="${groupUser.principalInfo02}"/>"
,"principalInfo03": "<util:json value="${groupUser.principalInfo03}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
