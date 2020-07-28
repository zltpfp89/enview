
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
<c:forEach items="${results}" var="domainPortlet" varStatus="status">
	{
"domainId": "<util:json value="${domainPortlet.domainId}"/>","portletNm": "<util:json value="${domainPortlet.portletNm}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
