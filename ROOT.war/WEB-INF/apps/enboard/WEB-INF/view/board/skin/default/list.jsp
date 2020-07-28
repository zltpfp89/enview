<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.List,java.util.ArrayList"%>

<%@ page import="com.saltware.enview.Enview"%>
<%@ page import="com.saltware.enboard.integrate.DefaultBltnExtnMapper,com.saltware.enboard.integrate.DefaultBltnExtnVO"%>
<%@ page import="com.saltware.enview.components.dao.ConnectionContext"%>
<%@ page import="com.saltware.enview.components.dao.ConnectionContextForRdbms"%>
<%@ page import="com.saltware.enboard.security.SecurityMngr"%>
<%@ page import="com.saltware.enboard.vo.BoardVO"%>
<%@ page import="com.saltware.enview.components.dao.DAOFactory"%>
<%@ page import="com.saltware.enboard.dao.AdminDAO"%>
<%@ page import="com.saltware.enboard.form.AdminCateForm"%>

<link href="./css/board/skin/enboard/bbs.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
  body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

<%--BEGIN::현재 게시판이 속한 카테고리의 아들카테고리(바로 한레벨 밑의 카테고리)에 속한 게시판들의 목록을 뿌리는 예제--%>
<%
	ConnectionContext connCtxt = null;
	try {
		connCtxt = new ConnectionContextForRdbms (true);

		BoardVO brdVO = (BoardVO)request.getAttribute ("boardVO");
		AdminDAO admDAO = (AdminDAO)DAOFactory.getInst().getDAO (AdminDAO.DAO_NAME_PREFIX);

		String cateId = admDAO.getCateOfBoard (brdVO.getBoardId(), connCtxt);
		List childCateList = admDAO.getChildCatebase (cateId, true, SecurityMngr.getLocale (request), connCtxt);
		List boardList = new ArrayList();
		AdminCateForm acForm = new AdminCateForm();
		for (int i=0; i<childCateList.size(); i++) {
			acForm.setCateId ((String)childCateList.get(i));
			boardList.addAll (admDAO.getCateBoard (acForm, null, true, connCtxt));
		}
		
		System.out.println("boardList=["+boardList+"]");
		
		com.saltware.enboard.cache.CacheMngr ebCacheMngr = (com.saltware.enboard.cache.CacheMngr)Enview.getComponentManager().getComponent ("com.saltware.enboard.cache.CacheMngr");
		List directChildBoardList = new ArrayList();
		for (int i=0; i<boardList.size(); i++) {
			directChildBoardList.add (ebCacheMngr.getBoard ((String)boardList.get(i), SecurityMngr.getLocale (request)));
		}
		
		request.setAttribute ("dcBoardList", directChildBoardList);	
	
	} catch (Exception e) {
		if (connCtxt != null) connCtxt.rollback();
		// Ignore...
	} finally {
		if (connCtxt != null) connCtxt.release();
	}
%>
<c:forEach items="${dcBoardList}" var="dcBoard">
  <c:out value="${dcBoard.boardId}"/>,<c:out value="${dcBoard.boardNm}"/><br>
</c:forEach>
<%--END::현재 게시판이 속한 카테고리의 아들카테고리(바로 한레벨 밑의 카테고리)에 속한 게시판들의 목록을 뿌리는 예제--%>

<tr>
<td align=center <c:out value="${boardVO.boardBgPicDflt}"/>>
<%-- Details of Board --%>
<div class="board">
  <%-- search --%>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0" <c:out value="${boardVO.boardBgColorDflt}"/>>
  <form name="setSrch" OnSubmit="return ebList.srchBulletin()">
    <tr>
	  <td height="30" align="left" valign=bottom>
		<c:if test="${boardVO.srchRegYn == 'Y'}">
		  <input type="checkbox" name="srchType" id="srchType" value="RegD" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchType == 'RegD'}">checked</c:if> />작성일
		  <input type=text id=srchBgnReg value=<c:out value="${boardSttVO.srchBgnReg}"/> class="tb_input" style="width:70" readonly="true">
          <img align=absmiddle src=/board/images/board/skin/enboard/calendar.gif <c:if test="${empty boardSttVO.srchType}">onclick="displayCalendar(new Date(), 'srchBgnReg', event)"</c:if>>
		  &nbsp;~&nbsp;
          <input type=text id=srchEndReg value=<c:out value="${boardSttVO.srchEndReg}"/> class="tb_input" style="width:70" readonly="true">
          <img align=absmiddle src=/board/images/board/skin/enboard/calendar.gif <c:if test="${empty boardSttVO.srchType}">onclick="displayCalendar(new Date(), 'srchEndReg', event)"</c:if>>
		</c:if>
      </td>
	  <c:if test="${boardVO.cateYn == 'Y'}">
      <td width=100 align="center" valign="bottom">
        <select name="cateSel" style=font-size:9pt;width:110 onchange="ebList.cateList(this.value)">
          <option style=background-color:#444444;color:#dddddd value=-1>** Category **</option>
          <c:forEach items="${bltnCateList}" var="cList">
		    <c:if test="${!empty cList.bltnCateNm}">
              <option style=background-color:#dddddd value=<c:out value="${cList.bltnCateId}"/> <c:if test="${cList.bltnCateId == boardSttVO.bltnCateId}">selected</c:if>><c:out value="${cList.bltnCateNm}"/></option>
			</c:if>
		  </c:forEach>
        </select>
      </td>
      </c:if>
	  <td height="30" align="right" valign=bottom>
		<c:if test="${boardVO.srchReplyYn == 'Y'}">
          <input type="checkbox" name="srchType" id="srchType" value="Repl" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchType == 'Repl'}">checked</c:if>/>답글여부
		  <input type="radio" name="srchReplYn" id="srchReplYn" value="Y" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchReplYn == 'Y'}">checked</c:if>/>답글있는글만
		  <input type="radio" name="srchReplYn" id="srchReplYn" value="N" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchReplYn == 'N'}">checked</c:if>/>답글없는글만
		</c:if>
		<c:if test="${boardVO.srchMemoYn == 'Y'}">
          <input type="checkbox" name="srchType" id="srchType" value="Memo" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchType == 'Memo'}">checked</c:if>/>댓글여부
		  <input type="radio" name="srchMemoYn" id="srchMemoYn" value="Y" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchMemoYn == 'Y'}">checked</c:if>/>댓글있는글만
		  <input type="radio" name="srchMemoYn" id="srchMemoYn" value="N" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> <c:if test="${boardSttVO.srchMemoYn == 'N'}">checked</c:if>/>댓글없는글만
		  <br>
		</c:if>
        <c:forEach items="${srchList}" var="list">         
          <input type="checkbox" name="srchType" id="srchType" value="<c:out value="${list.srchType}"/>" <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> 
		         <c:if test="${boardSttVO.srchType == list.srchType}">checked</c:if>
		  /><c:out value="${list.srchText}"/>
        </c:forEach>
        <input name="srchKey" class="tb_input" style="width:120px;height:18px" value='<c:out value="${boardSttVO.srchKey}"/>' <c:if test="${!empty boardSttVO.srchType}">disabled</c:if> />
        <c:if test="${empty boardSttVO.srchType}">
          <span style=cursor:pointer onClick=ebList.srchBulletin()><c:out value="${boardVO.imgSrch}" escapeXml="false"/></span>
		</c:if>
        <c:if test="${!empty boardSttVO.srchType}">
          <span style=cursor:pointer onClick=ebList.disableSrch()><c:out value="${boardVO.imgSrchX}" escapeXml="false"/></span>
        </c:if>
      </td>
    </tr>
    <tr>
      <td height="30" align="left" style="padding-left:5px;" valign=bottom>
        <c:out value="${boardVO.imgTotal}" escapeXml="false"/>전체 <font color="blue"><b><c:out value="${boardSttVO.totalBltns}"/></b></font>건
      </td>
      <c:if test="${boardVO.cateYn == 'Y'}">
      <td></td>
      </c:if>
      <td height="30" align="right" style="padding-right:5px;" valign=bottom>
        현재 <c:out value="${boardSttVO.page}"/> 페이지 / 전체 <c:out value="${boardSttVO.totalPage}"/> 페이지
      </td>
    </tr>
    <tr hieght="5"><td colspan="3"><td></tr>
  </form>      
  </table>
  
  <%-- contents start --%>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0" <c:out value="${boardVO.boardBgColorDflt}"/>>
  <tr>
    <td valign="top" >
      <%--list title --%>
	  <form name="frmlist" onsubmit="return false">
	  <table width=100% border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td height="2" colspan="28" bgcolor="blue"></td>
	    </tr>
	    <tr>
          <c:if test="${boardVO.readMultiYn == 'Y'}">
          <td width=22 align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>!</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
          </c:if>

          <c:if test="${boardVO.ttlNoYn == 'Y'}">
          <td width="40" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>번호</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
          </c:if>
      
          <c:if test="${boardVO.ttlThumbYn == 'Y' || boardVO.listImageYn == 'Y'}">
          <td width="60" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>Thumb</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
          </c:if>         
      
          <c:if test="${boardVO.ttlCateYn == 'Y'}">
          <c:if test="${boardVO.cateYn == 'Y'}">
          <td width="60" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>Categroy</b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
          </c:if>
          </c:if>
          
          <%-- 확장필드 Mapper 설정 --%>
	      <c:if test="${boardVO.extUseYn == 'Y'}">
		    <c:set var="extnMapper" value="${boardVO.bltnExtnMapper}"/>
			<%--jsp:useBean id="extnMapper" type="com.saltware.enboard.integrate.DefaultBltnExtnMapper"/--%>
		  </c:if>
          <%-- 확장필드 사용예1 --%>
	      <c:if test="${boardVO.extUseYn == 'Y'}">
	      <c:if test="${extnMapper.ext_str2Yn == 'Y' && extnMapper.ext_str2TtlYn == 'Y'}">
	      <td width="67" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif"><b><c:out value="${extnMapper.ext_str2Ttl}"/></b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      </c:if>
	      <c:if test="${extnMapper.ext_str3Yn == 'Y' && extnMapper.ext_str3TtlYn == 'Y'}">
	      <td width="67" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif"><b><c:out value="${extnMapper.ext_str3Ttl}"/></b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      </c:if>
	      </c:if>

          <c:if test="${boardVO.ttlIconYn == 'Y'}">
          <td width="20" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b></b></td>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"></td>
          </c:if>
	      
	      <td align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>제목</b></td>
	      
	      <c:if test="${boardVO.listAtchYn == 'Y'}">
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="67" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif"><b>첨부파일</b></td>
	      </c:if>

          <%-- 확장필드 사용예2 --%>
	      <c:if test="${boardVO.extUseYn == 'Y'}">
	      <c:if test="${extnMapper.ext_str1Yn == 'Y' && extnMapper.ext_str1TtlYn == 'Y'}">
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="67" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif"><b><c:out value="${extnMapper.ext_str1Ttl}"/></b></td>
	      </c:if>
	      </c:if>

	      <c:if test="${boardVO.ttlNickYn == 'Y'}">
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="80" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>작성자</b></td>
          </c:if>
	  
	      <c:if test="${boardVO.ttlRegYn == 'Y'}">
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="90" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>작성일</b></td>
          </c:if>
	      
	      <c:if test="${boardVO.ttlReadYn == 'Y'}">
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="50" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>조회수</b></td>
          </c:if>

		  <%
			if (Enview.getConfiguration().getBoolean("board.red.flag.use")) {
		  %>
	      <td width="3" background="/board/images/board/skin/enboard/bg_t_title.gif"><img src="/board/images/board/skin/enboard/img_t_bar.gif" width="3" height="30"></td>
	      <td width="50" align="center" background="/board/images/board/skin/enboard/bg_t_title.gif" class="table_title"><b>읽음여부</b></td>
		  <%
			}
		  %>
	    </tr>

        <%-- Bulletins are not exist.. --%>
        <c:if test="${empty bltnList}">
        <tr><td height="1" colspan="28" bgcolor="#dbdee7" ></td></tr>
        <tr height=22>
          <td align="center" colspan=20>등록된 게시물이 존재하지 않습니다.<input type=hidden name=chk></td>
        </tr>
        <tr><td height="2" colspan="28" bgcolor="#dbdee7" ></td></tr>
        </c:if>

        <%-- List of Bulletin --%>
        <c:forEach items="${bltnList}" var="list">         
        <tr><td height="1" colspan="28" bgcolor="#dbdee7" ></td></tr>
        <tr onMouseOver=this.style.backgroundColor='#E8ECF9' onMouseOut=this.style.backgroundColor=''>
          <c:if test="${boardVO.readMultiYn == 'Y'}">
          <td class="table_list_c">
		    <c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
              <span style=cursor:pointer onclick=ebList.checkBulletin(this) id=box name=box checkeditem=N  value=<c:out value="${list.bltnNo}"/>>
                <c:out value="${boardVO.imgXox}" escapeXml="false"/>
              </span>
			</c:if>
          </td>
          <td width="3" nowrap></td>
          </c:if>
    
          <c:if test="${boardVO.ttlNoYn == 'Y'}">
          <td class="table_list_c">
            <c:if test="${list.selected == 'false'}">
              <c:if test="${list.boardRow == '0'}"><c:out value="${boardVO.imgNotice}" escapeXml="false"/></c:if>
              <c:if test="${list.boardRow != '0'}"><c:out value="${list.boardRow}"/></c:if>
              <%--c:if test="${list.boardRow != '0'}"><c:out value="${list.bltnGn}"/></c:if--%>
            </c:if>
            <c:if test="${list.selected != 'false'}">
              <c:out value="${boardVO.imgSelected}" escapeXml="false"/>
            </c:if>
          </td>
          <td width="3" nowrap></td>
          </c:if>
    
          <c:if test="${boardVO.ttlThumbYn == 'Y' || boardVO.listImageYn == 'Y'}">
          <td class="table_list_c" width="<c:out value="${boardVO.thumbSize}"/> height="<c:out value="${boardVO.thumbSize}"/>">
		    <c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
			  <img src="<c:out value="${list.thumbImgSrc50}"/>" onerror="<c:out value="${list.thumbImgOnError}"/>"
				   align="absmiddle" style="border:1px #dddddd solid" 
				   onload="ebList.imageResize(this,<c:out value="${boardVO.thumbSize}"/>,<c:out value="${boardVO.thumbSize}"/>)"
			  >
			</c:if>
          </td>
          <td width="3" nowrap></td>
          </c:if>

          <c:if test="${boardVO.ttlCateYn == 'Y'}">
          <c:if test="${boardVO.cateYn == 'Y'}">
          <td class="table_list_c">
		    <c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
		      <c:out value="${list.cateNm}" escapeXml="false"/>
			</c:if>
		  </td>
          <td width="3" nowrap></td>
          </c:if>
          </c:if>

		  <%-- 확장필드 데이터 설정 --%>
	      <c:if test="${boardVO.extUseYn == 'Y'}">
		    <c:set var="extnVO" value="${list.bltnExtnVO}"/>
		  </c:if>
		  
          <%-- 확장필드 사용예1 --%>
	      <c:if test="${boardVO.extUseYn == 'Y'}">
	        <c:if test="${extnMapper.ext_str2Yn == 'Y' && extnMapper.ext_str2TtlYn == 'Y'}">
	          <td id="i<c:out value="${list.bltnNo}"/>" name="i<c:out value="${list.bltnNo}"/>" align=center>
				<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
	              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str2}"/></c:if>
				</c:if>
	          </td>
              <td width="3" nowrap></td>
	        </c:if>
	        <c:if test="${extnMapper.ext_str3Yn == 'Y' && extnMapper.ext_str3TtlYn == 'Y'}">
	          <td id="i<c:out value="${list.bltnNo}"/>" name="i<c:out value="${list.bltnNo}"/>" align=center>
				<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
	              <c:if test="${!empty list.bltnExtnVO}"><c:out value="${extnVO.ext_str3}"/></c:if>
				</c:if>
	          </td>
              <td width="3" nowrap></td>
	        </c:if>
	      </c:if>

          <c:if test="${boardVO.ttlIconYn == 'Y'}"><%--문서아이콘을 보여준다.--%>
          <td class="table_list_c">
		    <c:if test="${!empty list.bltnBestLevel && list.bltnBestLevel > 0}"><%--최고답변으로선정되었다--%>
              <c:if test="${list.bltnBestLevel == '9'}"><c:out value="${boardVO.imgBest9}" escapeXml="false"/></c:if>
              <c:if test="${list.bltnBestLevel == '8'}"><c:out value="${boardVO.imgBest8}" escapeXml="false"/></c:if>
              <c:if test="${list.bltnBestLevel == '7'}"><c:out value="${boardVO.imgBest7}" escapeXml="false"/></c:if>
            </c:if>
			<c:if test="${empty list.bltnBestLevel || list.bltnBestLevel == 0}">
              <c:if test="${boardVO.permitYn == 'Y' && list.bltnPermitYn == 'N'}"><%--승인기능을 사용하는데 승인이 되질 않았다.--%>
			    <c:out value="${boardVO.imgProhibit}" escapeXml="false"/>
			  </c:if>
              <c:if test="${boardVO.permitYn == 'N' || list.bltnPermitYn != 'N' }">
                <c:if test="${list.bltnIcon == 'A'}"><c:out value="${boardVO.imgDoc}" escapeXml="false"/></c:if>
                <c:if test="${list.bltnIcon == 'B'}"><c:out value="${boardVO.imgFile}" escapeXml="false"/></c:if>
                <c:if test="${list.bltnIcon == 'C'}"><c:out value="${boardVO.imgPoll}" escapeXml="false"/></c:if>
                <c:if test="${list.bltnIcon == 'D'}"><c:out value="${boardVO.imgSecret}" escapeXml="false"/></c:if>
			  </c:if>
            </c:if>
          </td>
          <td width="3" nowrap></td>
          </c:if>          

          <td class="table_list_l">
            <c:if test="${list.bltnLev != '1'}">
              <span style=visibility:hidden><img height=1 width=<c:out value="${list.bltnLevLen}"/>></span>
              <c:out value="${boardVO.imgRe}" escapeXml="false"/>
            </c:if>
			<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
              <c:if test="${boardVO.ttlPntYn == 'Y'}">
                <c:if test="${list.betPnt > '0'}"><font color=#A51818>$<c:out value="${list.betPnt}"/></font></c:if>
              </c:if>
			  <a style=cursor:pointer OnMouseOver=this.style.textDecoration='underline' OnMouseOut=this.style.textDecoration='none'
			    <c:if test="${list.readable == 'true'}">
			      <%--게시판이 가상게시판일 수도 있으므로, 게시물이 아니라 게시물이 속한 게시판의 boardId 를 이용하여 읽기화면으로 가야 한다.--%>
				  <c:if test="${boardVO.mergeType == 'A'}">
			        onclick="ebList.readBulletin('<c:out value="${boardVO.boardId}"/>','<c:out value="${list.bltnNo}"/>')"
				  </c:if>
				  <c:if test="${boardVO.mergeType != 'A'}">
			        onclick="ebList.readBulletin('<c:out value="${list.eachBoardVO.boardId}"/>','<c:out value="${list.bltnNo}"/>')"
				  </c:if>
			    </c:if>
			    <c:if test="${list.readable == 'false'}">
				  onclick="alert('작성자가 글읽기를 허용하지 않았습니다');"
			    </c:if>
			  >
			    <%--c:out value="${list.bltnOrgSubj}" escapeXml="false"/--%>
			    <c:out value="${list.bltnOrgSubj}"/>
				<%--게시기간설정기능을 사용하는 게시판의 공지글이고 현재 관리자/운영진/게시판관리자이면 게시기간을 출력한다.--%>
				<c:if test="${boardVO.termYn == 'Y' && list.boardRow == '0' && (secPmsnVO.isAdmin || secPmsnVO.isSysop || secPmsnVO.ableDelete)}">
				  <br>게시시작일:<c:out value="${list.bltnBgnYmdF}"/> 게시종료일:<c:out value="${list.bltnEndYmdF}"/>
				</c:if>
              </a>
              <c:if test="${boardVO.ttlReplyYn == 'Y'}">
                <c:if test="${list.bltnReplyCnt != '0'}">
                  <c:out value="${boardVO.imgReCnt}" escapeXml="false"/>
                  <font color="#CC4848">(<c:out value="${list.bltnReplyCnt}"/>)</font>
                </c:if>
              </c:if>
              <c:if test="${boardVO.ttlMemoYn == 'Y'}">
                <c:if test="${list.bltnMemoCnt != '0'}">
                  <c:out value="${boardVO.imgMemo}" escapeXml="false"/>
                  <font color="#CC4848">(<c:out value="${list.bltnMemoCnt}"/>)</font>
                </c:if>
              </c:if>
              <c:if test="${boardVO.ttlNewYn == 'Y'}">
                <c:if test="${list.recentBltn == 'Y'}"><c:out value="${boardVO.imgNew}" escapeXml="false"/></c:if>
              </c:if>
              <c:if test="${boardVO.listCnttYn == 'Y'}">
              <table border=0 cellspacing=0 cellpadding=0 width=100% style="table-layout:fixed">
                <tr>
                  <td width=22></td>
                  <td style="padding-left:5px;word-wrap:break-word;word-break:break-all"><c:out value="${list.bltnCntt}"/></td>
                </tr>
              </table>
              </c:if>
			</c:if>
			<c:if test="${list.delFlag == 'y'}"><%--삭제표시된 답글있는 글--%>
			  삭제된 글입니다.
			</c:if>
          </td>

	      <c:if test="${boardVO.listAtchYn == 'Y'}">
            <td width="3" nowrap></td>
			<c:if test="${list.fileDownable}">
	          <td id=i<c:out value="${list.bltnNo}"/> name=i<c:out value="${list.bltnNo}"/> align=center>
				<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
                  <c:if test="${!empty list.fileList}">
	    	        <c:forEach items="${list.fileList}" var="fList">
			          <c:out value="${fList.downloadImgLink}" escapeXml="false"/>
	                </c:forEach>
                  </c:if>
				</c:if>
	          </td>
			</c:if>
			<c:if test="${!list.fileDownable}">
	          <td id=i<c:out value="${list.bltnNo}"/> name=i<c:out value="${list.bltnNo}"/>
				<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
			      align=center onclick="alert('작성자가 파일다운로드를 허용하지 않았습니다.')">
				</c:if>
			  </td>
			</c:if>
	      </c:if>

          <%-- 확장필드 사용예2 --%>      
	      <c:if test="${boardVO.extUseYn == 'Y' && !empty list.bltnExtnVO}">
	        <c:if test="${extnMapper.ext_str1Yn == 'Y' && extnMapper.ext_str1TtlYn == 'Y'}">
              <td width="3" nowrap></td>
	          <td id=i<c:out value="${list.bltnNo}"/> name=i<c:out value="${list.bltnNo}"/> align=center>
				<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
	              <c:out value="${extnVO.ext_str1}"/>
				</c:if>
	          </td>
	        </c:if>
	      </c:if>

          <c:if test="${boardVO.ttlNickYn == 'Y'}">
          <td width="3" nowrap></td>
          <td class="table_list_c">
			<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
		      <c:out value="${list.userNick}"/>
			</c:if>
		  </td>
          </c:if>
      
          <c:if test="${boardVO.ttlRegYn == 'Y'}">
          <td width="3" nowrap></td>
          <td class="table_list_c">
			<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
		      <c:out value="${list.regDatimSF}"/>
			</c:if>
		  </td>
          </c:if>
      
          <c:if test="${boardVO.ttlReadYn == 'Y'}">
          <td width="3" nowrap></td>
          <td class="table_list_c">
			<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
              <c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"><b><font color=<c:out value="${boardVO.raiseColor}"/>></c:if>
              <c:out value="${list.bltnReadCnt}"/>&nbsp;
              <c:if test="${list.bltnReadCnt >= boardVO.raiseCnt}"></b></font></c:if>
			</c:if>
          </td>
          </c:if>
		  <%--BEGIN::게시물 읽음여부를 표시할 때만--%>
          <td width="3" nowrap></td>
          <td class="table_list_c">
			<c:if test="${list.delFlag == 'N'}"><%--삭제표시되지 않은 정상적인 글일때만--%>
		      <c:if test="${empty list.firstReadDatim}">N</c:if>
		      <c:if test="${!empty list.firstReadDatim}">Y</c:if>
			</c:if>
		  </td>
		  <%--END::게시물 읽음여부를 표시할 때만--%>
        </tr>
        </c:forEach>
        <%-- End of List of Bulletin --%>
        <tr><td height="2" colspan="28" bgcolor="#dbdee7" ></td></tr>
      </table>
      </form>
      <%--리스트끝 --%>
    </td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  <tr>
    <td align="right">
      <table width=100% border="0" cellspacing="0" cellpadding="0">
        <tr>
          <c:if test="${boardVO.readMultiYn == 'Y'}">
          <td width=22 align=center onClick=ebList.readBulletin('<c:out value="${boardVO.boardId}"/>',-1) style=cursor:pointer>
            <c:out value="${boardVO.imgAllsee}" escapeXml="false"/>
          </td>
          </c:if>
          <td id="pageIndex" align="center" class="board_num"></td>
		  <td align="right" valign=middle>
			<c:if test="${boardVO.writableYn == 'Y'}">
			  <c:if test="${boardVO.mergeType == 'A'}">
				<a onClick=ebList.writeBulletin() style=cursor:pointer><c:out value="${boardVO.imgWrite}" escapeXml="false"/></a>
			  </c:if>
			</c:if>
			<c:if test="${boardVO.writableYn == 'N'}">
			  <c:if test="${boardVO.anonYn == 'R' || boardVO.anonYn == 'P'}">
			    <c:if test="${boardVO.mergeType == 'A'}">
				  <a onClick=ebList.writeBulletin() style=cursor:pointer><c:out value="${boardVO.imgWrite}" escapeXml="false"/></a>
			    </c:if>
			  </c:if>
			</c:if>
		  </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  <tr>
    <td align=right>
	  <font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none' onclick=ebList.showExcelForm(true)>
		<b>Excel</b>
	  </font>&nbsp;
	  <font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none' onclick=ebList.showFeedURL('RSS')>
		<img src="./images/board/rss-icon.png"/><b>RSS</b>
	  </font>&nbsp;
	  <font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none' onclick=ebList.showFeedURL('ATOM')>
		<b>ATOM</b>
	  </font>&nbsp;
	  <font style='cursor:pointer' onmouseover=this.style.textDecoration='underline' onmouseout=this.style.textDecoration='none' onclick=ebList.xmlBulletin()>
		<b>XML</b>
	  </font>&nbsp;
	</td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  </table>
</div>
<%--이용만족도 조사.Draft.2010.02.19.KWShin.--%>
<%--div>
  <form name='rcmdForm'>
  <input type='hidden' name='cMen' value=''>
  <input type='hidden' name='cScore' value=''>
  <table style="border-top:1px solid #e6e6e6; border-bottom:1px solid #e6e6e6; font-family:돋움; font-size:12px;" width="600" border="0" cellspacing="0" cellpadding="0" summary="만족도조사">
    <caption style='display:none;height:0px;'>만족도조사</caption>
    <tr style="border-bottom:1px solid #e6e6e6">
	  <th width="90" rowspan="2" bgcolor="#f6f6f6" style="color:#7c7c7c">만족도조사</th>
	  <td height="29" style="color:#666666; padding-left:9px; border-bottom:1px solid #e6e6e6;">유용한 정보가 되셨습니까?</td>
	  <td></td>
    </tr>
    <tr>
	  <td height="29" style="padding-left:6px">
	    <input type="radio" name='pnt' id='pnt'  value='5' checked title="5점"/>
	    <img src="$themePath/images/rcmd/icon_star5.gif" alt="5점" width="45" height="8" align="absmiddle" />&nbsp;&nbsp;
	    <input type="radio"  name='pnt' id='pnt' value='4' title="4점"/>
	    <img src="$themePath/images/rcmd/icon_star4.gif" alt="4점" width="45" height="8" align="absmiddle" />&nbsp;&nbsp;
	    <input type="radio"  name='pnt' id='pnt' value='3' title="3점"/>
	    <img src="$themePath/images/rcmd/icon_star3.gif" alt="3점" align="absmiddle" width="45" height="8" />&nbsp;&nbsp;
	    <input type="radio"  name='pnt' id='pnt' value='2' title="2점"/>
	    <img src="$themePath/images/rcmd/icon_star2.gif" align="absmiddle" alt="2점" width="45" height="8" />&nbsp;&nbsp;
	    <input type="radio"  name='pnt' id='pnt' value='1' title="1점"/>
	    <img src="$themePath/images/rcmd/icon_star1.gif" alt="1점" align="absmiddle" width="46" height="8" />
	  </td>
	  <td align="right">
	    <a href="javascript:saveRcmd(document.rcmdForm);">
		  <img src="$themePath/images/rcmd/ok_btn01.gif" alt="확인" border="0" width="50" height="18" align="absmiddle" />
	    </a>
	  </td>
    </tr>
  </table>
  <input type="hidden" name="sCd" value="enBoard">
  <input type="hidden" name="cId" value="$site.getPage().getId()">
  <input type="hidden" name="oId" value="$rc.getPage().getOwnerInfoList().get(0).get('user_id')">
  </form>
</div--%>
</td>
</tr>

<script language="javascript">
	var currentPage = <c:out value="${boardSttVO.page}"/>;
	var totalPage   = <c:out value="${boardSttVO.totalPage}"/>;
	var setSize     = 10; <%--하단 Page Iterator에서의 Navigation 갯수--%>
	var imgUrl      = "/board/images/board/skin/enboard/";
	var color       = "808080";
	
	var afpImg = "imgFirstActive.gif";
	var pfpImg = "imgFirstPassive.gif";
	var alpImg = "imgLastActive.gif";
	var plpImg = "imgLastPassive.gif";
	var apsImg = "imgPrev10Active.gif";
	var ppsImg = "imgPrev10Passive.gif";
	var ansImg = "imgNext10Active.gif";
	var pnsImg = "imgNext10Passive.gif";
	
	var startPage;    
	var endPage;      
	var cursor;      
	var curList = "";
	var prevSet = "";
	var nextSet = "";
	var firstP  = "";
	var lastP   = "";

	moduloCP = (currentPage - 1) % setSize / setSize ;
	startPage = Math.ceil((((currentPage - 1) / setSize) - moduloCP)) * setSize + 1;
	moduloSP = ((startPage - 1) + setSize) % setSize / setSize;
	endPage   = Math.ceil(((((startPage - 1) + setSize) / setSize) - moduloSP)) * setSize;

	if (totalPage <= endPage) endPage = totalPage;
		
	if (currentPage > setSize) {
		firstP = "<font onclick=ebList.next('1') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		firstP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+afpImg+"' align=absmiddle border=0 alt='맨 앞 페이지로 가기'></font>";
	    cursor = startPage - 1;
	    prevSet = "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		prevSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+apsImg+"' align=absmiddle border=0 alt='열 페이지 앞으로 가기'></font>";
	} else {
		firstP  = "<img src='"+imgUrl+pfpImg+"' align=absmiddle border=0>"; 
		prevSet = "<img src='"+imgUrl+ppsImg+"' align=absmiddle border=0>"; 
	}
		
	cursor = startPage;
	while( cursor <= endPage ) {
		if( cursor == currentPage ) 
	   		curList += "<font color=#"+color+">"+currentPage+"</font>&nbsp;";
		else {
	    	curList += "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			curList += " onmouseout=this.style.textDecoration='none'>"+cursor+"</font>&nbsp;";
		}
		
		cursor++;
	}
		     
	if ( totalPage > endPage) {
		lastP = "<font onclick=ebList.next('"+totalPage+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		lastP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+alpImg+"' align=absmiddle border=0 alt='맨 끝 페이지로 가기'></font>";
		cursor = endPage + 1;  
		nextSet = "<font onclick=ebList.next('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
		nextSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+ansImg+"' align=absmiddle border=0 alt='열 페이지 뒤로 가기'></font>";
	} else {
		lastP  = "<img src='"+imgUrl+plpImg+"' align=absmiddle border=0>"; 
		nextSet = "<img src='"+imgUrl+pnsImg+"' align=absmiddle border=0>"; 
	}
	
	curList = firstP +"&nbsp;"+ prevSet +"&nbsp;&nbsp;"+ curList +"&nbsp;&nbsp;"+ nextSet +"&nbsp;"+ lastP;
	
	document.getElementById("pageIndex").innerHTML = curList;
</script>
