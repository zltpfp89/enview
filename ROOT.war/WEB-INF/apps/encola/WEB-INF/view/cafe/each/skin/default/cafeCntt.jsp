<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${empty eachForm.cmd}">
  <script type="text/javascript">
	<!--
	function cafe_cntt_iframe_autoresize(arg) {
		arg.width  = arg.contentWindow.document.body.scrollWidth;
		arg.height = arg.contentWindow.document.body.scrollHeight;
	}
	//-->
  </script>
  <div id="div_cafe_cntt" name="div_cafe_cntt" class="board_list">
    <c:if test="${!empty menuVO.boardId}">
	  <iframe name="iframe_cafe_board" src="<%=request.getContextPath()%>/board/list.brd?boardId=<c:out value="${menuVO.boardId}"/>" frameborder="0" onload="cafe_cntt_iframe_autoresize(this)"></iframe>
    </c:if>
  </div>
</c:if>
<c:if test="${eachForm.cmd == 'selectMenu'}">
  <c:if test="${!empty menuVO.boardId}">
	<iframe name="iframe_cafe_board" src="<%=request.getContextPath()%>/board/list.brd?boardId=<c:out value="${menuVO.boardId}"/>" frameborder="0" onload="cafe_cntt_iframe_autoresize(this)"></iframe>
  </c:if>
</c:if>
<c:if test="${eachForm.cmd == 'showProfile'}">
  <c:choose>
  <c:when test="${eachForm.view == 'base'}">
    <%@include file="cafeProfileBase.jsp"%>
  </c:when>
  <c:when test="${eachForm.view == 'rule'}">
    <%@include file="cafeProfileRule.jsp"%>
  </c:when>
  <c:when test="${eachForm.view == 'hist'}">
    <%@include file="cafeProfileHist.jsp"%>
  </c:when>
  <c:when test="${eachForm.view == 'rank'}">
    <%@include file="cafeProfileRank.jsp"%>
  </c:when>
  <c:when test="${eachForm.view == 'staff'}">
    <%@include file="cafeProfileStaff.jsp"%>
  </c:when>
  <c:otherwise>
    <%@include file="cafeProfile.jsp"%>
  </c:otherwise>
  </c:choose>
</c:if>
