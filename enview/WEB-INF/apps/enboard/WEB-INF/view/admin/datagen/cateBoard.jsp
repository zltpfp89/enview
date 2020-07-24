<%@ page contentType="text/json;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${acForm.status}"/>",
  "Reason": "<util:json value="${acForm.reason}"/>",
  "TotalSize": "<util:json value="${acForm.totalSize}"/>",
  "ResultSize": "<util:json value="${acForm.resultSize}"/>",
  "Data":
  [
<c:forEach items="${boardBaseList}" var="board" varStatus="status">    
	{
		"boardId": "<util:json value="${board.boardId}"/>",
		"boardNm": "<util:json value="${board.boardNm}"/>",
		"boardTtl": "<util:json value="${board.boardTtl}"/>",
		"boardSkin": "<util:json value="${board.boardSkin}"/>",
		"boardActive": "<util:json value="${board.boardActive}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
