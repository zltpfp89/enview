<%@ page contentType="text/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${homeForm.status}"/>",
  "Reason": "<util:json value="${homeForm.reason}"/>",
  "TotalSize": "<util:json value="${homeForm.totalSize}"/>",
  "ResultSize": "<util:json value="${homeForm.resultSize}"/>",
  "Data":
  [
<c:forEach items="${cmntCateList}" var="cmntCate" varStatus="status">    
	{
		"cateId": "<util:json value="${cmntCate.cateId}"/>",
		"cateNm": "<util:json value="${cmntCate.cateNm}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
