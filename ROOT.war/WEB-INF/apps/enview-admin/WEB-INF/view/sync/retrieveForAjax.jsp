
<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	System.out.println("#### result=" + request.getAttribute("results"));
%>
{
  "Status": "<util:json value="${inform.resultStatus}"/>",
  "Reason": "<util:json value="${inform.failureReason}"/>",
  "TotalSize": "<util:json value="${inform.totalSize}"/>",
  "ResultSize": "<util:json value="${inform.resultSize}"/>",
  "Data":
  [
<c:forEach items="${results}" var="sync" varStatus="status">
	{
"connect": "<util:json value="${sync.result}"/>"
,"address": "<util:json value="${sync.systemKey}"/>"
,"sessionCount": "<util:json value="${sync.count}"/>"
,"target": "<util:json value="${sync.target}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
