<%@ page contentType="text/json;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{
  "Status": "<c:out value="${acForm.status}"/>",
  "Reason": "<c:out value="${acForm.reason}"/>",
  "TotalSize": "<c:out value="${acForm.totalSize}"/>",
  "ResultSize": "<c:out value="${acForm.resultSize}"/>",
  "Data":
  [
<c:forEach items="${boardCateList}" var="boardCate" varStatus="status">    
	{
		"cateId": "<c:out value="${boardCate.cateId}"/>",
		"langKnd": "<c:out value="${boardCate.langKnd}"/>",
		"cateNm": "<c:out value="${boardCate.cateNm}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
