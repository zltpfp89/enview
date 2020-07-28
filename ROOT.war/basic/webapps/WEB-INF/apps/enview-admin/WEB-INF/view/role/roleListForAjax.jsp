
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
<c:forEach items="${results}" var="role" varStatus="status">
	{
"principalId": "<util:json value="${role.principalId}"/>"
,"parentId": "<util:json value="${role.parentId}"/>"
,"shortPath": "<util:json value="${role.shortPath}"/>"
,"principalName": "<util:json value="${role.principalName}"/>"
,"theme": "<util:json value="${role.theme}"/>"
,"defaultPage": "<util:json value="${role.defaultPage}"/>"
,"principalType": "<util:json value="${role.principalType}"/>"
,"principalOrder": "<util:json value="${role.principalOrder}"/>"
,"creationDate": "<util:json value="${role.creationDateByFormat}"/>"
,"modifiedDate": "<util:json value="${role.modifiedDateByFormat}"/>"
,"principalInfo01": "<util:json value="${role.principalInfo01}"/>"
,"principalInfo02": "<util:json value="${role.principalInfo02}"/>"
,"principalInfo03": "<util:json value="${role.principalInfo03}"/>"
,"principalDesc": "<util:json value="${role.principalDesc}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
