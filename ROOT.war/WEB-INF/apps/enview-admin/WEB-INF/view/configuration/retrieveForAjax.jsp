
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
<c:forEach items="${results}" var="configuration" varStatus="status">
	{
"configCd": "<util:json value="${configuration.configCd}"/>","updUserId": "<util:json value="${configuration.updUserId}"/>","updDatim": "<util:json value="${configuration.updDatimByFormat}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
