<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table width="100%" border=0 cellspacing=0 cellpadding=0>
  <c:choose>
  <c:when test="${boardSttVO.listOpt == 'miniWide'}">
	<jsp:include page="miniWideList.jsp"/>
  </c:when>
  <c:when test="${boardSttVO.listOpt == 'miniNarr'}">
	<jsp:include page="miniNarrList.jsp"/>
  </c:when>
  <c:otherwise> 
	<jsp:include page="list.jsp"/>
  </c:otherwise> 
  </c:choose>
</table>
