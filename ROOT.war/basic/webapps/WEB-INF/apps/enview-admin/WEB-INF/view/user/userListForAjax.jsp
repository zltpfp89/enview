
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
<c:forEach items="${results}" var="user" varStatus="status">
	{
"principalId": "<util:json value="${user.principalId}"/>"
,"shortPath": "<util:json value="${user.shortPath}"/>"
,"principalName": "<util:json value="${user.principalName}"/>"
,"theme": "<util:json value="${user.theme}"/>"
,"defaultPage": "<util:json value="${user.defaultPage}"/>"
,"columnValue0": "<util:json value="${user.columnValue0}"/>"
,"isEnabled": "<util:json value="${user.isEnabled}"/>"
,"updateRequired0": "<util:json value="${user.updateRequired0}"/>"
,"authFailures0": "<util:json value="${user.authFailures0}"/>"
,"modifiedDate0": "<util:json value="${user.modifiedDate0ByFormat}"/>"
,"authMethod": "<util:json value="${user.authMethod}"/>"
,"principalType": "<util:json value="${user.principalType}"/>"
,"principalInfo01": "<util:json value="${user.principalInfo01}"/>"
,"principalInfo02": "<util:json value="${user.principalInfo02}"/>"
,"principalInfo03": "<util:json value="${user.principalInfo03}"/>"
,"creationDate": "<util:json value="${user.creationDateByFormat}"/>"
,"modifiedDate": "<util:json value="${user.modifiedDateByFormat}"/>"
,"principalDesc": "<util:json value="${user.principalDesc}"/>"
,"domainId": "<util:json value="${user.domainId}"/>"
<c:if test="${user.domainNm == '' }">,"domainNm": "<util:message key='ev.prop.securityPrincipal.noDomain'/>"</c:if>
<c:if test="${user.domainNm != '' }">,"domainNm": "<util:json value="${user.domainNm}"/>"</c:if>
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
