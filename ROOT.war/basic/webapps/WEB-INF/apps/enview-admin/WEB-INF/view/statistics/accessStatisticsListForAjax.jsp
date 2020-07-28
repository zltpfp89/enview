
<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${inform.resultStatus}"/>",
  "Reason": "<util:json value="${inform.failureReason}"/>",
  "TotalSize": "<util:json value="${inform.totalSize}"/>",
  "ResultSize": "<util:json value="${inform.resultSize}"/>",
  "domainId": "<util:json value="${domainId}"/>",
  "domain": "<util:json value="${domain}"/>",
  "domainNm": "<util:json value="${domainNm}"/>",
  "todayAccessCount": "<util:json value="${todayAccessCount}"/>",
  "averageAccessCount": "<util:json value="${averageAccessCount}"/>",
  "accumulateAccessCount": "<util:json value="${accumulateAccessCount}"/>",
  "Data":
  [
<c:forEach items="${results}" var="accessStatistics" varStatus="status">
	{
"row": "<util:json value="${accessStatistics.name}"/>"
,"count": "<util:json value="${accessStatistics.value}"/>"
,"size": "<util:json value="${accessStatistics.size}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
