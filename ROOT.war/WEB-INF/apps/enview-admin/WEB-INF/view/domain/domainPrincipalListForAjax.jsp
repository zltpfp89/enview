
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
<c:forEach items="${results}" var="domainPrincipal" varStatus="status">
	{
"domain": "<util:json value="${domainPrincipal.domain}"/>", "principal": "<util:json value="${domainPrincipal.principal}"/>"
,"domainId": "<util:json value="${domainPrincipal.domainId}"/>", "principalId": "<util:json value="${domainPrincipal.principalId}"/>"
,"userName": "<util:json value="${domainPrincipal.userName}"/>", "userNameId": "<util:json value="${domainPrincipal.principal}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
