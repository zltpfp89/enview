<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
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
  <c:forEach items="${rcmdList}" var="rcmd">
    <tr>
	  <td>
	    <a href="<%=evcp%>/cafe/<c:out value="${rcmd.cmntUrl}"/>"><c:out value="${rcmd.cmntNm}"/></a>
	  </td>
	  <td>
	    <c:out value="${rcmd.cmntLevelNm}"/>
	  </td>
	  <td>
	    회원수: <c:out value="${rcmd.mmbrTotCF}"/>
	  </td>
	</tr>
  </c:forEach>
</table>
