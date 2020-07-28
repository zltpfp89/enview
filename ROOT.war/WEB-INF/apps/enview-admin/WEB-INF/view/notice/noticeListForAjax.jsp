
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
<c:forEach items="${results}" var="notice" varStatus="status">
	{
"title": "<util:json value="${notice.title}"/>"
,"noticeId": "<util:json value="${notice.noticeId}"/>"
,"isEmergency": "<util:json value="${notice.isEmergency}"/>"
,"startDate": "<util:json value="${notice.startDateByFormat}"/>"
,"endDate": "<util:json value="${notice.endDateByFormat}"/>"
,"template": "<util:json value="${notice.template}"/>"
,"layoutX": "<util:json value="${notice.layoutX}"/>"
,"layoutY": "<util:json value="${notice.layoutY}"/>"
,"layoutWidth": "<util:json value="${notice.layoutWidth}"/>"
,"layoutHeight": "<util:json value="${notice.layoutHeight}"/>"
,"principalId": "<util:json value="${notice.principalId}"/>"
,"groups": "<util:json value="${notice.groups}"/>"
,"pages": "<util:json value="${notice.pages}"/>"
,"domainId": "<util:json value="${notice.domainId}"/>"
,"domainNm": "<util:json value="${notice.domainNm}"/>"
,"curNoticeYn": "<util:json value="${notice.curNoticeYn}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
