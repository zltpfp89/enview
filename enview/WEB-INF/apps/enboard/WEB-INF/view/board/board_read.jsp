<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enboard.vo.BoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${boardVO.boardSys == 'CF' }">
	<jsp:include page='<%="./skin/" + request.getAttribute("boardSkin") + "/board_read.jsp"%>'/>
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
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/vault/dhtmlxvault.css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/dhtmlx/vault/dhtmlxvault.js"></script>
<script type="text/javascript">
	<!--
	if (window.attachEvent) {
		window.attachEvent ("onload", ebRead.initRead);
	} else if (window.addEventListener ) {
		window.addEventListener ("load", ebRead.initRead, false);
	} else {
		window.onload = ebRead.initRead;
	}
	//-->
</script>

<table border=0 cellspacing=0 cellpadding=0 align=center width="100%">
  <tr>
    <td align=center>
      <%-- 게시판 상단 --%>
	  <c:if test="${!empty boardVO.topHtml}">
        <jsp:include page='<%=((BoardVO)request.getAttribute("boardVO")).getTopHtml()%>'/>
	  </c:if>
      <%-- 게시판 본체 --%>
      <jsp:include page='<%="./skin/"+request.getAttribute("boardSkin")+"/board_read.jsp"%>'/>
      <%-- 게시판 하단  --%>
      <c:if test="${!empty boardVO.bottomHtml}">
		<jsp:include page='<%=((BoardVO)request.getAttribute("boardVO")).getBottomHtml()%>'/>
	  </c:if>
    </td>
  </tr>
</table>

<form name=setForm method=post>
  <input type=hidden name=boardId        value="<c:out value="${boardSttVO.boardId}"/>"/>
  <input type=hidden name=cmpBrdId       value="<c:out value="${boardSttVO.cmpBrdId}"/>"/>
  <input type=hidden name=srchKey        value="<c:out value="${boardSttVO.srchKey}"/>"/>
  <input type=hidden name=srchType       value="<c:out value="${boardSttVO.srchType}"/>"/>
  <input type=hidden name=srchBgnReg     value="<c:out value="${boardSttVO.srchBgnReg}"/>"/>
  <input type=hidden name=srchEndReg     value="<c:out value="${boardSttVO.srchEndReg}"/>"/>
  <input type=hidden name=srchReplYn     value="<c:out value="${boardSttVO.srchReplYn}"/>"/>
  <input type=hidden name=srchMemoYn     value="<c:out value="${boardSttVO.srchMemoYn}"/>"/>
  <input type=hidden name=page           value="<c:out value="${boardSttVO.page}"/>"/>
  <input type=hidden name=pageSize       value="<c:out value="${boardSttVO.pageSize}"/>"/>
  <input type=hidden name=cateId         value="<c:out value="${boardSttVO.cateId}"/>"/>
  <input type=hidden name=bltnCateId     value="<c:out value="${boardSttVO.bltnCateId}"/>"/>
  <input type=hidden name=rtnBltnNo      value="<c:out value="${boardSttVO.rtnBltnNo}"/>"/>
  <input type=hidden name=bltnNo         value="<c:out value="${boardSttVO.bltnNo}"/>"/>
  <input type=hidden name=cmd            value="<c:out value="${boardSttVO.cmd}"/>"/>
  <input type=hidden name=onlyReplYn     value="<c:out value="${boardSttVO.onlyReplYn}"/>"/>
  <input type=hidden name=onlyMemoYn     value="<c:out value="${boardSttVO.onlyMemoYn}"/>"/>
  <input type=hidden name=wallUserId     value="<c:out value="${boardSttVO.wallUserId}"/>"/>
  <input type=hidden name=badNickDflt    value="<c:out value="${boardVO.badNickDflt}"/>"/>
  <input type=hidden name=badCnttDflt    value="<c:out value="${boardVO.badCnttDflt}"/>"/>
  <input type=hidden name=boardSkinDflt  value="<c:out value="${boardVO.boardSkinDflt}"/>"/> 
  <input type=hidden name=skin  value="<c:out value="${boardSkin}"/>"/> 
  <input type=hidden name=boardWidth     value="<c:out value="${boardVO.boardWidth}"/>"/>
  <input type=hidden name=writableYn     value="<c:out value="${boardVO.writableYn}"/>"/>
  <input type=hidden name=replyableYn    value="<c:out value="${boardVO.replyableYn}"/>"/>
  <input type=hidden name=memoWritableYn value="<c:out value="${boardVO.memoWritableYn}"/>"/>
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

<input type=hidden name=maxMemoFileCnt    value="<c:out value="${boardVO.maxMemoFileCnt}"/>">
<input type=hidden name=fileName>
<input type=hidden name=fileMask>
<input type=hidden name=fileSize>
 
  <input type=hidden name=userPass>
  <input type=hidden name=userNick>
  <input type=hidden name=memoCntt>
  <input type=hidden name=memoSeq value=0>
  <input type=hidden name=memoGn value=0>
  <input type=hidden name=memoGq value=0>
  <input type=hidden name=memoLev value=0>
  <input type=hidden name=pollSeq>
  <input type=hidden name=evalPnt>
  <input type=hidden name=bltnBestLevel>
  <input type=hidden name=rtnURI>
  <input type=hidden name=befCmd>
</form>

<script>ebRead.loadPoll();</script> 
<iframe name=download width=0 height=0></iframe>
<%---------------------------------------------------------------------------------------------------------------------%>  
  </td>
  <td width=0><jsp:include page="./include/board_right.jsp"/></td>
</tr>
</table>
<jsp:include page="./include/board_footer.jsp"/>
</c:if>