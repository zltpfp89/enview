
<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${inform.resultStatus}"/>",
  "Reason": "<util:json value="${inform.failureReason}"/>",
  "TotalSize": "<util:json value="${inform.totalSize}"/>",
  "ResultSize": "<util:json value="${inform.resultSize}"/>",
  "FilesSizeMessage": "<util:json value="${inform.filesSizeMessage}"/>",
  "Data":
  [
<c:forEach items="${results}" var="file" varStatus="status">
	{
"filePath": "<util:json value="${file.filePath}"/>"
,"fileName": "<util:json value="${file.fileName}"/>"
,"fileSize": "<util:json value="${file.fileSize}"/>"
,"modifiedDate": "<util:json value="${file.fileModified}"/>"
,"editable": "<util:json value="${file.editable}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
