<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<div>
  <ul style="list-style-type:none;padding:10px 5px 10px 5px">
	<c:if test="${!mmbrVO.isLogin}">
	  <li style="padding-top:3px"><util:message key="eb.error.need.login"/></li><%--�α��� �ϼž� �մϴ�.--%>
	</c:if>
	<c:if test="${mmbrVO.isLogin}">
	  <c:forEach items="${rcntList}" var="rcnt">
		<li style="padding-top:3px">
		  <span style="padding-right:20px"><a href="<%=evcp%>/cafe/<c:out value="${rcnt.cmntUrl}"/>"><c:out value="${rcnt.cmntNm}"/></a></span>
		  <span><c:out value="${rcnt.accessDatimTPF}"/></span>
		</li>
	  </c:forEach>
	</c:if>
  </ul>
</div>
