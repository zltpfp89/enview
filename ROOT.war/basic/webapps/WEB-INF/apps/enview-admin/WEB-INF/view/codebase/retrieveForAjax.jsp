
<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${inform.resultStatus}"/>",
  "Reason": "<util:json value="${inform.failureReason}"/>",
  "TotalSize": "<util:json value="${inform.totalSize}"/>",
  "ResultSize": "<util:json value="${inform.resultSize}"/>",
  "Editable": "<util:json value="${editable}"/>",
  "Data":
  [
<c:forEach items="${results}" var="codebase" varStatus="status">
	{
"systemCode": "<util:json value="${codebase.systemCode}"/>"
,"codeId": "<util:json value="${codebase.codeId}"/>"
,"code": "<util:json value="${codebase.code}"/>"
,"langKnd": "<util:json value="${codebase.langKnd}"/>"
,"codeName": "<util:json value="${codebase.codeName}"/>"
,"codeName2": "<util:json value="${codebase.codeName2}"/>"
,"codeTag1": "<util:json value="${codebase.codeTag1}"/>"
,"codeTag2": "<util:json value="${codebase.codeTag2}"/>"
,"remark": "<util:json value="${codebase.remark}"/>"
,"domainId": "<util:json value="${codebase.domainId}"/>"
,"domainNm": "<util:json value="${codebase.domainNm}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
