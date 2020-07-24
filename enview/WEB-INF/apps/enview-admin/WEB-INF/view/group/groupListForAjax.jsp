
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
<c:forEach items="${results}" var="group" varStatus="status">
	{
"principalId": "<util:json value="${group.principalId}"/>"
,"parentId": "<util:json value="${group.parentId}"/>"
,"shortPath": "<util:json value="${group.shortPath}"/>"
,"principalName": "<util:json value="${group.principalName}"/>"
,"theme": "<util:json value="${group.theme}"/>"
,"defaultPage": "<util:json value="${group.defaultPage}"/>"
,"principalType": "<util:json value="${group.principalType}"/>"
,"principalOrder": "<util:json value="${group.principalOrder}"/>"
,"creationDate": "<util:json value="${group.creationDateByFormat}"/>"
,"modifiedDate": "<util:json value="${group.modifiedDateByFormat}"/>"
,"principalInfo01": "<util:json value="${group.principalInfo01}"/>"
,"principalInfo02": "<util:json value="${group.principalInfo02}"/>"
,"principalInfo03": "<util:json value="${group.principalInfo03}"/>"
,"principalDesc": "<util:json value="${group.principalDesc}"/>"
,"domain": "<util:json value="${group.domain}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
