
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
<c:forEach items="${results}" var="userGroup" varStatus="status">
	{
"groupId": "<util:json value="${userGroup.groupId}"/>"
,"userId": "<util:json value="${userGroup.userId}"/>"
,"shortPath": "<util:json value="${userGroup.shortPath}"/>"
,"principalName0": "<util:json value="${userGroup.principalName0}"/>"
,"mileageTag": "<util:json value="${userGroup.mileageTag}"/>"
,"sortOrder": "<util:json value="${userGroup.sortOrder}"/>"
,"domain": "<util:json value="${userGroup.domainNm}"/> (<util:json value="${userGroup.domain}"/>)"
,"domainId": "<util:json value="${userGroup.domainId}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
