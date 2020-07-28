<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
  <ul style="list-style-type:none">
	<li>랭킹상위</li>
	<c:forEach items="${cafeList}" var="cafe" varStatus="status">
	  <li>
	    <c:out value="${status.count}"/>
		<a href="<%=evcp%>/cafe/<c:out value="${cafe.cmntUrl}"/>"><c:out value="${cafe.cmntNm}"/></a>
		<c:out value="${cafe.mileTot}"/>
	  </li>
	</c:forEach>
  </ul>
