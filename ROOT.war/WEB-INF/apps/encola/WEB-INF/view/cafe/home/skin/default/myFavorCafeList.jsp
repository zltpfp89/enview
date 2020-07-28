<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${!mmbrVO.isLogin}">
    <li style="padding-top:3px"><util:message key="eb.error.need.login"/></li><%--로그인 하셔야 합니다.--%>
</c:if>
<c:if test="${mmbrVO.isLogin}">
  <c:if test="${empty favorList}">
    <li style="padding-top:3px"><util:message key="cf.error.not.exist.favor.cafe"/></li><%--등록된 자주가는 카페가 없습니다.--%>
  </c:if>
  <c:if test="${!empty favorList}">
    <c:forEach items="${favorList}" var="favor">
      <li style="padding-top:3px"><a href="<%=evcp%>/cafe/<c:out value="${favor.cmntUrl}"/>"><c:out value="${favor.cmntNm}"/></a></li>
    </c:forEach>
  </c:if>
</c:if>
