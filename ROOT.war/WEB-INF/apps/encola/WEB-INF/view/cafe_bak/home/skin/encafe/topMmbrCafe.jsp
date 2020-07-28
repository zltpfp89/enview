<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<c:forEach items="${cafeList}" var="cafe" varStatus="status">
	<li>
		<span class="rank"><c:out value="${status.count}"/></span>
		<span class="rank_cafeLink txt_over_el" onclick="javascript:cfHome.go2Cafe('<c:out value="${cafe.cmntUrl}"/>');"><c:out value="${cafe.cmntNm}"/></span>
		<span class="point" style="float: right;"><c:out value="${cafe.mmbrTot}"/></span>
	</li>
</c:forEach>
