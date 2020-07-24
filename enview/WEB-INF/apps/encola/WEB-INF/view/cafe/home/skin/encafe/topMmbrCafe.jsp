<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<c:forEach items="${cafeList}" var="cafe" varStatus="status">
	<li>
		<a onclick="javascript:cfHome.go2Cafe('<c:out value="${cafe.cmntUrl}"/>');" class="rank<c:out value="${status.count}"/> text-overflow"><c:out value="${cafe.cmntNm}"/></a><span><c:out value="${cafe.mmbrTot}"/></span>
	</li>
</c:forEach>
