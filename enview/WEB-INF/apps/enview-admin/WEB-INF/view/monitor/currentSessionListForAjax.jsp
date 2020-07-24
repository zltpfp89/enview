
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
<c:forEach items="${results}" var="currentSession" varStatus="status">
	{
"domainNm": "<util:json value="${currentSession.userInfoMap.domainNm}"/>"
,"userId": "<util:json value="${currentSession.userInfoMap.user_id}"/>"
,"userName": "<util:json value="${currentSession.userInfoMap.nm_kor}"/>"
,"userIp": "<util:json value="${currentSession.userInfoMap.remote_address}"/>"
,"userAgent": "<util:json value="${currentSession.userInfoMap.userAgent}"/>"
,"elapsedTime": "<util:json value="${currentSession.userInfoMap.session_elapsed}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
