<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${empty cmntVO && empty cmntList}">
  <span>해당 <util:message key="mm.title.category"/><%--카테고리--%>에 카페가 존재하지 않습니다.</span>
</c:if>
<c:if test="${!empty cmntVO || !empty cmntList}">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td rowspan=3>
	  <a href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><c:out value="${cmntVO.thumbImgCmntImg}" escapeXml="false"/></a>
    </td>
	<td>
	  <a href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><c:out value="${cmntVO.cmntNm}"/></a>
	</td>
  </tr>
  <tr>
	<td>
	  <a href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><c:out value="${cmntVO.cmntIntro}"/></a>
	</td>
  </tr>
  <tr>
	<td>
	  회원수: <c:out value="${cmntVO.mmbrTotCF}"/>
	</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <c:forEach items="${cmntList}" var="cmnt">
    <tr>
	  <td>
	    <a href="<%=evcp%>/cafe/<c:out value="${cmnt.cmntUrl}"/>"><c:out value="${cmnt.cmntNm}"/></a>
	  </td>
	  <td>
	    <c:out value="${cmnt.cmntLevelNm}"/>
	  </td>
	  <td>
	    회원수: <c:out value="${cmnt.mmbrTotCF}"/>
	  </td>
	</tr>
  </c:forEach>
</table>
</c:if>