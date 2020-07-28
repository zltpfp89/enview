
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
<c:forEach items="${results}" var="domain" varStatus="status">
	{
"domainId": "<util:json value="${domain.domainId}"/>","domainCode": "<util:json value="${domain.domainCode}"/>",
"domain": "<util:json value="${domain.domain}"/>","pagePath": "<util:json value="${domain.pagePath}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
