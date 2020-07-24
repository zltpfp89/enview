<%@ page contentType="text/json;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{
  "Status": "<c:out value="${acForm.status}"/>",
  "Reason": "<c:out value="${acForm.reason}"/>",
  "TotalSize": "<c:out value="${acForm.totalSize}"/>",
  "ResultSize": "<c:out value="${acForm.resultSize}"/>",
  "Data":
  [
<c:forEach items="${boardBaseList}" var="board" varStatus="status">    
	{
		"boardId": "<c:out value="${board.boardId}"/>",
		"boardNm": "<c:out value="${board.boardNm}"/>",
		"boardDesc": "<c:out value="${board.boardDesc}"/>",
		"boardSkin": "<c:out value="${board.boardSkin}"/>",
		"boardActive": "<c:out value="${board.boardActive}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
