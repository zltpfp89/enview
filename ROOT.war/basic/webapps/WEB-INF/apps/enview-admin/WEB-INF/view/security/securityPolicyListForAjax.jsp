
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
<c:forEach items="${results}" var="securityPolicy" varStatus="status">
	{
"policyId": "<util:json value="${securityPolicy.policyId}"/>"
,"ipaddress": "<util:json value="${securityPolicy.ipaddress}"/>"
,"authMethod": "<util:json value="${securityPolicy.authMethod}"/>"
,"isAllow": "<util:json value="${securityPolicy.isAllow}"/>"
,"isEnabled": "<util:json value="${securityPolicy.isEnabled}"/>"
,"startDate": "<util:json value="${securityPolicy.startDateByFormat}"/>"
,"endDate": "<util:json value="${securityPolicy.endDateByFormat}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
