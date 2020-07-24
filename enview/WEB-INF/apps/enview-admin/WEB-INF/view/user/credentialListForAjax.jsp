
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
<c:forEach items="${results}" var="credential" varStatus="status">
	{
"credentialId": "<util:json value="${credential.credentialId}"/>"
,"principalId": "<util:json value="${credential.principalId}"/>"
,"columnValue": "<util:json value="${credential.columnValue}"/>"
,"updateRequired": "<util:json value="${credential.updateRequired}"/>"
,"authFailures": "<util:json value="${credential.authFailures}"/>"
,"modifiedDate": "<util:json value="${credential.modifiedDateByFormat}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
