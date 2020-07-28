
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
<c:forEach items="${results}" var="userpass" varStatus="status">
	{
"userId": "<util:json value="${userpass.userId}"/>"
,"nmKor": "<util:json value="${userpass.nmKor}"/>"
,"nmNic": "<util:json value="${userpass.nmNic}"/>"
,"regNo": "<util:json value="${userpass.regNo}"/>"
,"birthYmd": "<util:json value="${userpass.birthYmd}"/>"
,"emailAddr": "<util:json value="${userpass.emailAddr}"/>"
,"offcTel": "<util:json value="${userpass.offcTel}"/>"
,"mileTot": "<util:json value="${userpass.mileTot}"/>"
,"homeTel": "<util:json value="${userpass.homeTel}"/>"
,"mobileTel": "<util:json value="${userpass.mobileTel}"/>"
,"homeZip": "<util:json value="${userpass.homeZip}"/>"
,"homeAddr1": "<util:json value="${userpass.homeAddr1}"/>"
,"homeAddr2": "<util:json value="${userpass.homeAddr2}"/>"
,"langKnd": "<util:json value="${userpass.langKnd}"/>"
,"userInfo05": "<util:json value="${userpass.userInfo05}"/>"
,"userInfo06": "<util:json value="${userpass.userInfo06}"/>"
,"regDatim": "<util:json value="${userpass.regDatimByFormat}"/>"
,"updDatim": "<util:json value="${userpass.updDatimByFormat}"/>"

	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
