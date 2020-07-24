<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BoardVO" %>
<%@ page import="com.saltware.enboard.vo.BoardSttVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardVO.boardSys == 'CF' }">
	<jsp:include page='<%="./skin/" + request.getAttribute("boardSkin") + "/board_list.jsp"%>'/>
</c:if>
<c:if test="${boardVO.boardSys != 'CF' }">
<jsp:include page="./include/board_header.jsp"/>
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="100%">
<tr>
  <td width=0><jsp:include page="./include/board_left.jsp"/></td>
  <td valign=top>
<%---------------------------------------------------------------------------------------------------------------------%>  
<title><c:out value="${boardVO.boardTtl}"/></title>
 
<script type="text/javascript" src="${pageContext.request.contextPath}/board/javascript/enboard_list.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/board/javascript/enboard_read.js"></script>
<script type="text/javascript">
	<!--
	window.onload = ebList.initList;
	//-->
</script>

<table border=0 cellspacing=0 cellpadding=0 align=center width=100%>
  <tr>
    <td> 
      <%-- 게시판 상단 --%>
	  <c:if test="${!empty boardSttVO.listOpt && !empty boardVO.topHtml}">  
        <jsp:include page='<%=((BoardVO)request.getAttribute("boardVO")).getTopHtml()%>'/>
	  </c:if>
      <%-- 게시판 본체 --%>
      <jsp:include page='<%="./skin/"+request.getAttribute("boardSkin")+"/board_list.jsp"%>'/>
      <%-- 게시판 하단  --%>
	  <c:if test="${!empty boardSttVO.listOpt && !empty boardVO.bottomHtml}">  
        <jsp:include page='<%=((BoardVO)request.getAttribute("boardVO")).getBottomHtml()%>'/>
	  </c:if>
	</td>
  </tr>
</table>  
 
<%-- 게시판 데이타 전송 Form --%>
<form name=setForm method=post>
<input type=hidden name="boardId"       value="<c:out value="${boardSttVO.boardId}"/>"/>
<input type=hidden name="cmpBrdId"      value="<c:out value="${boardSttVO.cmpBrdId}"/>"/>
<input type=hidden name="srchKey"       value="<c:out value="${boardSttVO.srchKey}"/>"/>
<input type=hidden name="srchType"      value="<c:out value="${boardSttVO.srchType}"/>"/>
<input type=hidden name="srchBgnReg"    value="<c:out value="${boardSttVO.srchBgnReg}"/>"/>
<input type=hidden name="srchEndReg"    value="<c:out value="${boardSttVO.srchEndReg}"/>"/>
<input type=hidden name="srchReplYn"    value="<c:out value="${boardSttVO.srchReplYn}"/>"/>
<input type=hidden name="srchMemoYn"    value="<c:out value="${boardSttVO.srchMemoYn}"/>"/>
<input type=hidden name="page"          value="<c:out value="${boardSttVO.page}"/>"/>
<input type=hidden name="pageSize"      value="<c:out value="${boardSttVO.pageSize}"/>"/>
<input type=hidden name="cateId"        value="<c:out value="${boardSttVO.cateId}"/>"/>
<input type=hidden name="bltnCateId"    value="<c:out value="${boardSttVO.bltnCateId}"/>"/>
<input type=hidden name="listOpt"       value="<c:out value="${boardSttVO.listOpt}"/>"/>
<input type=hidden name="onlyReplYn"    value="<c:out value="${boardSttVO.onlyReplYn}"/>"/>
<input type=hidden name="onlyMemoYn"    value="<c:out value="${boardSttVO.onlyMemoYn}"/>"/>
<input type=hidden name="wallUserId"    value="<c:out value="${boardSttVO.wallUserId}"/>"/>
<input type=hidden name="systemCurrentTimeMillis" value="1<c:out value="${boardSttVO.systemCurrentTimeMillis}"/>"/>
<input type=hidden name="boardSkinDflt" value="<c:out value="${boardVO.boardSkinDflt}"/>"/>
<input type=hidden name="skin" value="<c:out value="${boardSkin}"/>"/>
<input type=hidden name="miniTrgtWin"   value="<c:out value="${boardVO.miniTrgtWin}"/>"/>
<input type=hidden name="miniTrgtUrl"   value="<c:out value="${boardVO.miniTrgtUrl}"/>"/>
<input type=hidden name="srchKey1"       value="<c:out value="${boardSttVO.srchKey1}"/>"/>
<input type=hidden name="srchKey2"       value="<c:out value="${boardSttVO.srchKey2}"/>"/>
<input type=hidden name="srchKey3"       value="<c:out value="${boardSttVO.srchKey3}"/>"/>
<input type=hidden name="srchKey4"       value="<c:out value="${boardSttVO.srchKey4}"/>"/>
<input type=hidden name="srchType1"      value="<c:out value="${boardSttVO.srchType1}"/>"/>
<input type=hidden name="srchType2"      value="<c:out value="${boardSttVO.srchType2}"/>"/>
<input type=hidden name="srchType3"      value="<c:out value="${boardSttVO.srchType3}"/>"/>
<input type=hidden name="srchType4"      value="<c:out value="${boardSttVO.srchType4}"/>"/>
<input type=hidden name="sortColumn"      value="<c:out value="${boardSttVO.sortColumn}"/>"/>
<input type=hidden name="sortMethod"      value="<c:out value="${boardSttVO.sortMethod}"/>"/>
<input type=hidden name=bltnNo>
<%--다음 rtnBltnNo 는 목록화면에서 직접 읽기화면의 기능(e.g. 'eval-up')을 호출했을 때 필요로 된다.2012.07.05.KWShin.--%>
<input type=hidden name=rtnBltnNo>
<input type=hidden name=cmd>
<input type=hidden name=rtnURI>
<input type=hidden name=userPass>
</form>
<iframe name=download width=0 height=0 style="width:0px; height:0px; border:none;"></iframe>
<%---------------------------------------------------------------------------------------------------------------------%>  
  </td>
  <td width=0><jsp:include page="./include/board_right.jsp"/></td>
</tr>
</table>
<jsp:include page="./include/board_footer.jsp"/>
</c:if>