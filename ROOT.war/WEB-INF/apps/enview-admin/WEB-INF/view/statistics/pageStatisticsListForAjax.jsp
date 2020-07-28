
<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${inform.resultStatus}"/>",
  "Reason": "<util:json value="${inform.failureReason}"/>",
  "TotalSize": "<util:json value="${inform.totalSize}"/>",
  "ResultSize": "<util:json value="${inform.resultSize}"/>",
  "totalSession": "<util:json value="${accumulationMap.totalSession}"/>",
  "totalHits": "<util:json value="${accumulationMap.TOTALHITS}"/>",
  "totalMaxTime": "<util:json value="${accumulationMap.TOTALMAXTIME}"/>",
  "totalMinTime": "<util:json value="${accumulationMap.TOTALMINTIME}"/>",
  "totalAverageTime": "<util:json value="${accumulationMap.TOTALAVERAGETIME}"/>",
  "Data":
  [
<c:forEach items="${results}" var="pageStatistics" varStatus="status">
	{
"domainNm": "<util:json value="${pageStatistics.domainNm}"/>"
,"title": "<util:json value="${pageStatistics.title}"/>"
,"path": "<util:json value="${pageStatistics.path}"/>"
,"hits": "<util:json value="${pageStatistics.hits}"/>"
,"maxTime": "<util:json value="${pageStatistics.maxTime}"/>"
,"minTime": "<util:json value="${pageStatistics.minTime}"/>"
,"averageTime": "<util:json value="${pageStatistics.averageTime}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
