
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
<c:forEach items="${results}" var="lang" varStatus="status">
	{
"domainId": "<util:json value="${lang.domainId}"/>"
, "domainNm": "<util:json value="${lang.domainNm}"/>"
, "langKnd": "<util:json value="${lang.langKnd}"/>"
,"langCd": "<util:json value="${lang.langCd}"/>"
,"langDesc": "<util:json value="${lang.langDesc}"/>"
,"langUpdDate": "<util:json value="${lang.langUpdDateByFormat}"/>"
,"langUpdId": "<util:json value="${lang.langUpdId}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
