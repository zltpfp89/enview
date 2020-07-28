<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.saltware.enboard.integrate.DefaultBltnExtnMapper,com.saltware.enboard.integrate.DefaultBltnExtnVO"%>

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
<tr>
<td align=center>
<div class="board">
  
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0">
	<tr><td height="60" colspan="28"><font style="color:blue;font-weight:bold;font-size:18px"><c:out value="${boardVO.boardNm}"/></font>&nbsp;|&nbsp;<c:out value="${boardVO.boardTtl}"/></td></tr>
	<tr><td height="2"  colspan="28" bgcolor="blue"></td></tr>
  </table>
  
  <%--BEGIN::Write Area on the Top--%>
  <c:if test="${boardVO.writableYn == 'Y'}"><%--쓰기권한이 있을 때만--%>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0">
    <colgroup width="100">
    <colgroup width="3">
    <colgroup width="<c:out value="${boardVO.boardWidth - 100 - 3}"/>">
	<form name="editForm" onsubmit="return false">
	<%-- writer --%>
	<tr>
	  <td id="rootBltnViewTitle" colspan="3"></td>
	</tr>
    <tr><td id="rootBltnViewLine" name="rootBltnViewLine" height="7" colspan="3" align="right" background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_dot.gif" style="display:none"></td></tr>
	<tr><td id="rootBltnViewSpace" name="rootBltnViewSpace" height="4" colspan="3" style="display:none"></td></tr>
	<tr>
	  <td id="rootBltnView" colspan="3"></td>
	</tr>
    <tr><td id="rootBltnViewLine" name="rootBltnViewLine" height="7" colspan="3" align="right" background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_dot.gif" style="display:none"></td></tr>
	<tr><td id="rootBltnViewSpace" name="rootBltnViewSpace" height="4" colspan="3" style="display:none"></td></tr>
	<tr>
	  <td id="editFormTitle" colspan="3"></td>
	</tr>
    <tr><td id="rootBltnViewLine" name="rootBltnViewLine" height="7" colspan="3" align="right" background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_dot.gif" style="display:none"></td></tr>
	<tr><td id="rootBltnViewSpace" name="rootBltnViewSpace" height="4" colspan="3" style="display:none"></td></tr>
	<c:if test="${boardVO.ableAnonYn == 'Y'}"><%--익명글기능이 있으면--%>
    <tr>
      <td height="25" align="center" background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">작 성 자</td>
      <td background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
      <td class="table_list_l">
		<input type="text" maxlength="30" name="userNick" value="<c:out value="${secPmsnVO.userNick}"/>" style="width:300px" class="form" readonly/>
	  </td>
    </tr>
    <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>
	</c:if>  
    <c:if test="${boardVO.ableAnonYn == 'N'}"><%--익명글기능이 없으면--%>
	  <input type="hidden" name="userNick" value='<c:out value="${secPmsnVO.userNick}"/>'/>
	</c:if>
    <%-- Subject --%>
	<input type="hidden" name="bltnSubj" value="한줄메모"/>
	<%-- Contents --%>
    <tr>
      <td colspan="3">
        <textarea id="editorCntt" name="editorCntt"></textarea>
        <input type=hidden name=bltnOrgCntt>
      </td>
    </tr>
	<tr>
	  <td colspan="3" align="right">
	    최대 600 Byte
		<input type="hidden" id="editorCnttMaxBytes" name="editorCnttMaxBytes" value="600">
	  </td>
	</tr>
	<%-- Notice --%>
	<c:if test="${boardVO.noticeYn == 'Y' && secPmsnVO.ableNotice == 'true'}">
    <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
    <tr>
      <td height="25" align="center" background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">공지글여부</td>
      <td background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
      <td class="table_list_l">
        <input type=checkbox name=bltnTopTag id=bltnTopTag <c:if test="${bltnVO.bltnTopTag == 'Y'}">checked</c:if> value="Y" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'Y')"/>&nbsp;공지글
	    <span style=visibility:hidden><img src='' height=1 width=30></span>
        <input type=checkbox name=bltnTopTag id=bltnTopTag <c:if test="${bltnVO.bltnTopTag == 'N'}">checked</c:if> value="N" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'N')"/>&nbsp;공지글 아님
	    <span style=visibility:hidden><img src='' height=1 width=30></span>
        <input type=checkbox name=bltnTopTag id=bltnTopTag <c:if test="${bltnVO.bltnTopTag == 'T'}">checked</c:if> value="T" onclick="ebUtil.setCheckedValue(document.editForm.bltnTopTag, 'T')"/>&nbsp;최상위 공지글
      </td>
    </tr>
    </c:if>
	<%-- Secret --%>
	<c:if test="${boardVO.secretYn == 'Y' && secPmsnVO.isLogin == 'true'}">
    <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
    <tr>
      <td height="25" align="center" background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">비밀글여부</td>
      <td background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
      <td class="table_list_l">
        <input type=checkbox name=bltnSecretYn <c:if test="${bltnVO.bltnSecretYn == 'Y'}">checked</c:if>>&nbsp;Y / N
      </td>
    </tr>
    </c:if>
	<%-- Able Anonymous --%>
	<c:if test="${boardVO.ableAnonYn == 'Y' && secPmsnVO.isLogin == 'true'}">
    <tr><td height="1" colspan="3" bgcolor="#dbdee7"></td></tr>          
    <tr>
      <td height="25" align="center" background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">익명글여부</td>
      <td background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/img_t_bar2.gif" ></td>
      <td class="table_list_l">
	    <c:if test="${boardSttVO.cmd == 'MODIFY'}">
	      <c:if test="${empty bltnVO.userId}"><input type="checkbox" name="anonFlag" checked onclick="ebEdit.checkAbleAnon(this)">&nbsp;Y / N</c:if>
		  <c:if test="${!empty bltnVO.userId}"><input type="checkbox" name="anonFlag" onclick="ebEdit.checkAbleAnon(this)">&nbsp;Y / N</c:if>
		</c:if>
		<c:if test="${boardSttVO.cmd != 'MODIFY'}">
		  <input type="checkbox" name="anonFlag" onclick="ebEdit.checkAbleAnon(this)">&nbsp;Y / N
		</c:if>
	    <c:if test="${boardVO.anonYn == 'N'}">
		  &nbsp;&nbsp;&nbsp;&nbsp;비밀번호&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="password" name="userPass" value="<c:out value="${bltnVO.userPass}"/>" maxlength="12" size="14"/>				
        </c:if>
  	  </td>
    </tr>
    </c:if>
	</form><%--editForm--%>
    <tr><td height="7" colspan="3" align="right" background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_dot.gif"></td></tr>
	<tr><td height="4" colspan="3"></td></tr>
    <tr>
      <td colspan="3" align="right">
	    <span onclick="ebList.saveOnList()" style="cursor:pointer"><c:out value="${boardVO.imgSave}" escapeXml="false"/></span>
	    <span onclick="ebList.actionOnList('cancel')" style="cursor:pointer"><c:out value="${boardVO.imgCancel}" escapeXml="false"/></span>
      </td>
    </tr>
    <tr><td height="7" colspan="3" align="right" background="/board/images/board/skin/<c:out value="${boardVO.boardSkin}"/>/bg_dot.gif"></td></tr>
	<tr><td height="4" colspan="3"></td></tr>
  </table>
  </c:if>
  <%--END::Write Area on the Top--%>

  <%--BEGIN::List Area--%>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="30" align="left" style="padding-left:5px;" valign=bottom>
        <c:out value="${boardVO.imgTotal}" escapeXml="false"/>전체 <font color="blue"><b><c:out value="${boardSttVO.totalBltns}"/></b></font>건
      </td>
      <td height="30" align="right" style="padding-right:5px;" valign=bottom>
        현재 <c:out value="${boardSttVO.page}"/> 페이지 / 전체 <c:out value="${boardSttVO.totalPage}"/> 페이지
      </td>
    </tr>
    <tr hieght="5"><td colspan="2"><td></tr>
  </table>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" >
      <%--list title --%>
	  <form name="frmlist">
	  <table width=100% border="0" cellspacing="0" cellpadding="0">
	    <tr><td height="2" bgcolor="blue"></td></tr>
        <%-- Bulletins are not exist.. --%>
        <c:if test="${empty bltnList}">
        <tr><td height="1" bgcolor="#dbdee7" ></td></tr>
        <tr height=22>
          <td align="center">등록된 게시물이 존재하지 않습니다.<input type=hidden name=chk></td>
        </tr>
        <tr><td height="2" bgcolor="#dbdee7" ></td></tr>
        </c:if>

        <%-- List of Bulletin --%>
        <c:forEach items="${bltnList}" var="list">   
        <tr><td height="1" bgcolor="#dbdee7" ></td></tr>
        <tr onMouseOver=this.style.backgroundColor='#E8ECF9' onMouseOut=this.style.backgroundColor=''>
		  <td id="rootBltnCntt<c:out value="${list.bltnNo}"/>">
			<table width=100% border="0" cellspacing="0" cellpadding="0">
              <colgroup width="30">
			  <colgroup width="500">
			  <colgroup width="<c:out value="${boardVO.boardWidth - 30 - 500}"/>">
			  <tr>
		        <td colspan="2" align="left">
                  <c:if test="${list.bltnLev != '1'}">
                    <span style="padding-left:<c:out value="${list.bltnLevLen}"/>px">&nbsp;</span>
                    <c:out value="${boardVO.imgRe}" escapeXml="false"/>
                  </c:if>
				  <span style="padding-right:10px"><b><c:out value="${list.userNick}"/></b></span>
                  <span style="padding-right:10px"><font color=#888888><c:out value="${list.regDatimF}"/></font></span>
				  <c:if test="${boardVO.ttlReplyYn == 'Y' &&  list.bltnReplyCnt != '0'}">
                    <span style="padding-right:10px"><c:out value="${boardVO.imgReCnt}" escapeXml="false"/><font color="#CC4848">(<c:out value="${list.bltnReplyCnt}"/>)</font></span>
                  </c:if>
                  <c:if test="${boardVO.ttlNewYn == 'Y'}">
                    <span style="padding-right:10px"><c:if test="${list.recentBltn == 'Y'}"><c:out value="${boardVO.imgNew}" escapeXml="false"/></c:if></span>
                  </c:if>
				</td>
				<td id="rootBltnCnttButtons<c:out value="${list.bltnNo}"/>" align="right">
				  <c:if test="${boardVO.replyableYn == 'Y' && boardVO.replyYn == 'Y'}">
				    <a style=cursor:pointer onclick="ebList.actionOnList('reply',<c:out value="${list.bltnNo}"/>)">
					  <c:out value="${boardVO.imgReply}" escapeXml="false"/>
				    </a>&nbsp;
				  </c:if>
			      <c:if test="${list.editable == 'true'}"><%--수정권한이 있는 경우--%>
                    <a style=cursor:pointer onclick="ebList.securityOnList('modify',<c:out value="${list.bltnNo}"/>,true)">
				      <c:out value="${boardVO.imgModify}" escapeXml="false"/>
				    </a>&nbsp;
                  </c:if>
			      <c:if test="${list.editable == 'false'}"><%--수정권한이 없는 경우--%>
			        <c:if test="${empty list.userId}"><%--익명글이면--%>
			          <c:if test="${list.editableUserId == '_is_admin_'}"><%--관리자인 경우--%>
                        <a style=cursor:pointer onclick="ebList.securityOnList('modify',<c:out value="${list.bltnNo}"/>,true)">
				          <c:out value="${boardVO.imgModify}" escapeXml="false"/>
				        </a>&nbsp;
                      </c:if>
			          <c:if test="${list.editableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
					    <c:if test="${boardVO.writableYn == 'Y'}">
                          <a style=cursor:pointer onclick="ebList.securityOnList('modify',<c:out value="${list.bltnNo}"/>,false)">
				            <c:out value="${boardVO.imgModify}" escapeXml="false"/>
				          </a>&nbsp;
						</c:if>
                      </c:if>
			        </c:if>
			      </c:if>
                  <c:if test="${list.deletable == 'true'}"><%--삭제권한이 있는 경우--%>
                    <a style=cursor:pointer onclick="ebList.securityOnList('delete',<c:out value="${list.bltnNo}"/>,true)">
				      <c:out value="${boardVO.imgDelete}" escapeXml="false"/>
				    </a>&nbsp;
                  </c:if>
                  <c:if test="${list.deletable == 'false'}"><%--삭제권한이 없는 경우--%>
			        <c:if test="${empty list.userId}"><%--익명글이면--%>
			          <c:if test="${list.deletableUserId == '_is_admin_'}"><%--관리자인 경우--%>
                        <a style=cursor:pointer onclick="ebList.securityOnList('delete',<c:out value="${list.bltnNo}"/>,true)">
				          <c:out value="${boardVO.imgDelete}" escapeXml="false"/>
				        </a>&nbsp;
                      </c:if>
			          <c:if test="${list.deletableUserId != '_is_admin_'}"><%--관리자가 아닌 경우--%>
					    <c:if test="${boardVO.writableYn == 'Y'}">
                          <a style=cursor:pointer onclick="ebList.securityOnList('delete',<c:out value="${list.bltnNo}"/>,false)">
				            <c:out value="${boardVO.imgDelete}" escapeXml="false"/>
				          </a>&nbsp;
						</c:if>
                      </c:if>
				    </c:if>  
			      </c:if>
				</td>
			  </tr>
			  <tr><td colspan="3" height="6"></td></tr>
			  <tr>
			    <td></td>
		        <td colspan="2">
				  <table width=100% border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed">
				    <tr>
					  <td style="word-wrap:break-word;word-break:break-all">
                        <c:if test="${list.bltnLev != '1'}">
                          <span style="padding-left:<c:out value="${list.bltnLevLen}"/>px">&nbsp;</span>
                        </c:if>
			            <c:out value="${list.bltnOrgCntt}" escapeXml="false"/>
				        <input type="hidden" id="bltnCntt<c:out value="${list.bltnNo}"/>" name="bltnCntt<c:out value="${list.bltnNo}"/>" value="<c:out value="${list.bltnOrgCntt}"/>"/>
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>
			</table>
          </td>
        </tr>
        </c:forEach>
        <%-- End of List of Bulletin --%>
        <tr><td height="2" bgcolor="#dbdee7" ></td></tr>
      </table>
      </form>
      <%--리스트끝 --%>
    </td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  <tr>
    <td id="pageIndex" align="center" class="board_num"></td>
  </tr>
  <tr><td height="11" align="right" background="/board/images/board/skin/enboard/bg_dot.gif"></td></tr>
  </table>
  <%--END::List Area--%>
  <%--BEGIN::Search Area--%>
  <table <c:out value="${boardVO.boardWidthDflt}"/> border="0" cellspacing="0" cellpadding="0">
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
              <option style=background-color:#dddddd value=<c:out value="${cList.bltnCateId}"/> <c:out value="${cList.selected}"/>><c:out value="${cList.bltnCateNm}"/></option>
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
  </form>      
  </table>
  <%--END::Search Area--%>
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
	var setSize     = 10;
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

	moduloCP = (currentPage - 1) % setSize / 10 ;
	startPage = Math.ceil((((currentPage - 1) / setSize) - moduloCP)) * setSize + 1;
	moduloSP = ((startPage - 1) + setSize) % setSize / 10;
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
