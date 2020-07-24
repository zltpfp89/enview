<%@ page contentType="text/json;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{
  "Status": "<c:out value="${homeForm.status}"/>",
  "Reason": "<c:out value="${homeForm.reason}"/>",
  "TotalSize": "<c:out value="${homeForm.totalSize}"/>",
  "ResultSize": "<c:out value="${homeForm.resultSize}"/>",
  "Data":
  [
<c:forEach items="${cmntCateList}" var="cmntCate" varStatus="status">    
	{
		"cateId": "<c:out value="${cmntCate.cateId}"/>",
		"cateNm": "<c:out value="${cmntCate.cateNm}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
