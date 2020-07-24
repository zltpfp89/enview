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
<c:forEach items="${results}" var="userStatistics" varStatus="status">
	{
"accessBrowser": "<util:json value="${userStatistics.accessBrowser}"/>"
,"domainNm": "<util:json value="${userStatistics.domainNm}"/>"
,"userIp": "<util:json value="${userStatistics.userIp}"/>"
,"orgName": "<util:json value="${userStatistics.orgName}"/>"
,"userId": "<util:json value="${userStatistics.userId}"/>"
,"userName": "<util:json value="${userStatistics.userName}"/>"
,"status": "<util:json value="${userStatistics.statusStr}"/>"
,"timeStamp": "<util:json value="${userStatistics.timeStampByFormat}"/>"
,"principalId": "<util:json value="${userStatistics.principalId}"/>"
,"orgCd": "<util:json value="${userStatistics.orgCd}"/>"
,"elapsedTime": "<util:json value="${userStatistics.elapsedTime}"/>"
,"extraInfo01": "<util:json value="${userStatistics.extraInfo01}"/>"
,"extraInfo02": "<util:json value="${userStatistics.extraInfo02}"/>"
,"extraInfo03": "<util:json value="${userStatistics.extraInfo03}"/>"
,"extraInfo04": "<util:json value="${userStatistics.extraInfo04}"/>"
,"extraInfo05": "<util:json value="${userStatistics.extraInfo05}"/>"
,"roleName": "<util:json value="${userStatistics.roleName}"/>"
	} <c:if test="${!status.last}">, </c:if>
</c:forEach>
  ]
}