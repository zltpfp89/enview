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
<c:forEach items="${boardCateList}" var="boardCate" varStatus="status">    
	{
		"cateId": "<util:json value="${boardCate.cateId}"/>",
		"langKnd": "<util:json value="${boardCate.langKnd}"/>",
		"cateNm": "<util:json value="${boardCate.cateNm}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
