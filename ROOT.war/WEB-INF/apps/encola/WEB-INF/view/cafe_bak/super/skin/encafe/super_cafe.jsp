<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
<tr>
  <td id="superLeft" style="width:280px; height:1224px; background:#FFFFFF;" valign="top" class="webpanel"> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td height="28px" align="center" class="adpanel">
	      <div onclick="superMngr.onSelectLeft('cate')">&nbsp;<b><util:message key="mm.title.category"/><%--카테고리--%>별 검색</b>&nbsp;</div>
	    </td>
	  </tr>
	  <tr id="leftSub" name="leftSub" opt="cate">
	    <td>
		  <div id="superCateTree" style="overflow:auto;padding:2px;"></div>
		</td>
	  </tr>
	  <tr id="leftSub" name="leftSub" opt="cate"><td valign='top'>
	    <div id="cateTabs">
		  <ul>
			<li><a href="#superCateDetailTab" onclick="superMngr.onSelectCateTabs(1);"><util:message key="mm.title.category"/><%--카테고리--%> 상세</a></li>
			<li><a href="#superCateLangTab" onclick="superMngr.onSelectCateTabs(2);"><util:message key="mm.title.category"/><%--카테고리--%> 명</a></li>
		  </ul>
		  <div id="superCateDetailTab" style="width:100%; height:100%;" class="adformpanel" >
			<form id="superCateEditForm" style="display:inline" action="" method="post" >
			  <input type="hidden" id="cate_act">
			  <table cellpadding=0 cellspacing=0 border=0 width='100%'>
				<tr> 
				  <td colspan="2" class="adformlabel" id="superCateDialog.MessageArea"></td>    
				</tr>
				<tr> 
				  <td width="45%" class="adformlabel"><img src="<%=evcp%>/cola/cafe/images/super/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;아이디</td>
				  <td class="adformfieldlast"><input type="text" id="cate_cateId" width="98%"></td>
				</tr>
				<tr><td height=1 colspan=2></td></tr>
				<tr> 
				  <td width="45%" class="adformlabel"><img src="<%=evcp%>/cola/cafe/images/super/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;<util:message key="mm.title.category"/><%--카테고리--%> 명</td>
				  <td class="adformfieldlast"><input type="text" id="cate_cateNm" maxlength="120" width="98%"></td>
				</tr>
				<tr><td height=2 colspan=2 class='adformlimit'></td></tr>
			  </table>
			  <table style="width:100%;">
				<tr><td height=4 ></td></tr>
				<tr>
				  <td align="right">
					<img id="cate_btnSave" src="<%=evcp%>/cola/cafe/images/super/encafe/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:superMngr.doSaveCate()">
				  </td>
				</tr>
			  </table>
			</form>
		  </div>
		  <div id="superCateLangTab" style="width:100%;" class="adgridpanel" style="display:none;">
			<br style='line-height:5px;'>
			<form id="superCateLangListForm" style="display:inline" name="superCateLangListForm" action="" method="post">
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<thead>
				  <tr><td height="2" colspan="3" class="adgridlimit"></td></tr>
				  <tr style="cursor: pointer;">
					<th class="adgridheader" align="center">
					  <input type="checkbox" id="delCheck" onclick="superMngr.m_checkBox.chkAll(this)"/>
					  <input type="hidden" id="cateLangList_cateId"/>
					</th>
					<th class="adgridheader" ch="0" align="center">
					  <span>언어</span> 
					</th>
					<th class="adgridheaderlast" ch="0" align="center">
					  <span><util:message key="mm.title.category"/><%--카테고리--%>명</span>
					</th>
				  </tr>
				</thead>
				<tbody id="superCateLangListBody"></tbody>
			  </table>
			  <table style="width:100%;">
				<tr><td height=4 ></td></tr>
				<tr>
				  <td align="right">
					<img src="<%=evcp%>/cola/cafe/images/super/encafe/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:superMngr.doCreateCateLang()">
					<img src="<%=evcp%>/cola/cafe/images/super/encafe/btn_delete.gif" hspace="2" style="cursor:hand" onclick="javascript:superMngr.doDeleteCateLang()">
				  </td>
				</tr>
			  </table>
			</form>
			<div id="superCateLangEditPage" style="display:none;">
			  <div class="adformpanel" style="width:100%;"> 
				<form id="superCateLangEditForm" style="display:inline" name="superCateLangEditForm" action="" method="post" onsubmit="return false;">
				  <input type="hidden" id="cateLang_act"/>
				  <input type="hidden" id="cateLang_cateId"/>
				  <table style="width:100%;">
					<tr>
					  <td width="45%" class="adformlabel"><img src="<%=evcp%>/cola/cafe/images/super/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;언어</td>
					  <td class="adformfieldlast">
						<select id="cateLang_langKnd">
						  <c:forEach items="${langList}" var="lang">
						  <option value="<c:out value="${lang.code}"/>"><c:out value="${lang.codeName}"/></option>
						  </c:forEach>
						</select>
					  </td>
					</tr>
					<tr><td height=1 colspan=2></td></tr>
					<tr>
					  <td width="45%" class="adformlabel"><img src="<%=evcp%>/cola/cafe/images/super/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;<util:message key="mm.title.category"/><%--카테고리--%>명</td>
					  <td class="adformfieldlast"><input type="text" id="cateLang_cateNm" size="20" maxLength="120" required="true"/></td>
					</tr>
					<tr><td height=2 colspan=2 class='adformlimit'></td></tr>
				  </table>
				  <table style="width:100%;">
					<tr><td height=4 ></td></tr>
					<tr>
					  <td align="right">
						<img src="<%=evcp%>/cola/cafe/images/super/encafe/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:superMngr.doSaveCateLang()">
					  </td>
					</tr>
				  </table>
				</form>
			  </div>
			</div> <!-- End superCateLangEditPage -->
		  </div> <!-- End superCateLangTab -->
	    </div>
	    </td>
	  </tr>
	  <tr><td height="5"></td></tr>
	  <tr>
	    <td height="28px" align="center" class="adpanel">
	      <div onclick="superMngr.onSelectLeft('srch')">&nbsp;<b>카페 검색</b>&nbsp;</div>
	    </td>
	  </tr>
	  <tr id="leftSub" name="leftSub" opt="srch" style="display:none">
	    <td>
	      <div class="adformpanel">
		    <select id="cafe_srchType" name="cafe_srchType">
			  <option value="NM"   <c:if test="${suForm.srchType == 'NM'  }">selected</c:if>><util:message key="cf.title.cafe.name"/><%--카페이름--%></option>
			  <option value="URL"  <c:if test="${suForm.srchType == 'URL' }">selected</c:if>>카페주소</option>
			  <option value="TAG"  <c:if test="${suForm.srchType == 'TAG' }">selected</c:if>><util:message key="cf.title.cafe.tag"/><%--카페태그-%></option>
			  <option value="CATE" <c:if test="${suForm.srchType == 'CATE'}">selected</c:if>><util:message key="mm.title.category"/><%--카테고리--%></option>
			</select>
			<input type="text" id="cafe_srchKey" name="cafe_srchKey" style="width:136px" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchCafe();}"/>
			<span class="btn_pack medium"><a href="javascript:superMngr.searchCafe()">검색</a></span>
		  </div>
	    </td>
	  </tr>
	  <tr><td height="5"></td></tr>
	  <tr>
	    <td height="28px" align="center" class="adpanel">
	      <div onclick="superMngr.onSelectLeft('func')">&nbsp;<b>기능별 검색</b>&nbsp;</div>
	    </td>
	  </tr>
	  <tr id="leftSub" name="leftSub" opt="func" style="display:none">
	    <td>
	      <ul style="list-style-type:none">
		    <li style="padding-top:5px"><font onclick="superMngr.listCafe('permit')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">개설 신청</font></li>
			<li style="padding-top:5px"><font onclick="superMngr.listCafe('2close')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">폐쇄 신청</font></li>
			<li style="padding-top:5px"><font onclick="superMngr.listCafe('closed')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">폐쇄 완료</font></li>
			<li style="padding-top:5px"><font onclick="superMngr.listCafe('hit')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">방문수 순위</font></li>
			<li style="padding-top:5px"><font onclick="superMngr.listCafe('mile')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">랭킹  순위</font></li>
			<li style="padding-top:5px"><font onclick="superMngr.listCafe('mmbr')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">회원수 순위</font></li>
			<li style="padding-top:5px"><font onclick="superMngr.listCafe('rcmd')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">추천 카페</font></li>
		  </ul>
	    </td>
	  </tr>
	  <tr><td height="5"></td></tr>
	  <tr>
	    <td height="28px" align="center" class="adpanel">
	      <div onclick="superMngr.onSelectLeft('bltn')">&nbsp;<b>게시물 검색</b>&nbsp;</div>
	    </td>
	  </tr>
	  <tr id="leftSub" name="leftSub" opt="bltn" style="display:none">
	    <td class="adformpanel">
		  <table width="100%">
			<tr>
			  <td align="right" width="35%" style="padding-right:5px"><b>카페명:</b></td>
			  <td align="left" width="70%" style="padding-left:5px">
			    <input type="text" id="bltn_srchCmntNm" style="width:190px" value="<c:out value="${suForm.cmntNm}"/>" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchBltn();}"/>
			  </td>
			</tr>
			<tr>
			  <td align="right" width="35%" style="padding-right:5px"><b>게시판명:</b></td>
			  <td align="left" width="70%" style="padding-left:5px">
			    <input type="text" id="bltn_srchBoardNm" style="width:190px" value="<c:out value="${suForm.boardNm}"/>" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchBltn();}"/>
			  </td>
			</tr>
			<tr>
			  <td align="right" width="35%" style="padding-right:5px">
			    <input type="checkbox" id="bltn_srchType" name="bltn_srchType" value="RegD" 
					<c:if test="${!empty srchTypeList}">
					  <c:forEach items="${srchTypeList}" var="srch">
						<c:if test="${srch.type == 'RegD'}">checked</c:if>
					  </c:forEach>
					</c:if>
				>작성일
			  </td>
			  <td align="left" width="70%" style="padding-left:5px">
				<input type="text" id="bltn_srchBgnReg" value="<c:out value="${suForm.srchBgnReg}"/>" style="width:70px" readonly="true">
				<img align="absmiddle" src="<%=evcp%>/cola/cafe/images/super/encafe/calendar.gif" onclick="displayCalendar(new Date(), 'bltn_srchBgnReg', event)">
				부터
				<input type="text" id="bltn_srchEndReg" value="<c:out value="${suForm.srchEndReg}"/>" style="width:70px" readonly="true">
				<img align="absmiddle" src="<%=evcp%>/cola/cafe/images/super/encafe/calendar.gif" onclick="displayCalendar(new Date(), 'bltn_srchEndReg', event)">
				까지
			  </td>
			</tr>
			<tr>
			  <td colspan="2">
				<input type="checkbox" id="bltn_srchType" name="bltn_srchType" value="Subj"
					<c:if test="${!empty srchTypeList}">
					  <c:forEach items="${srchTypeList}" var="srch">
						<c:if test="${srch.type == 'Subj'}">checked</c:if>
					  </c:forEach>
					</c:if>
				>제목
				<input type="checkbox" id="bltn_srchType" name="bltn_srchType" value="Cntt"
					<c:if test="${!empty srchTypeList}">
					  <c:forEach items="${srchTypeList}" var="srch">
						<c:if test="${srch.type == 'Cntt'}">checked</c:if>
					  </c:forEach>
					</c:if>
				>본문
				<input type="checkbox" id="bltn_srchType" name="bltn_srchType" value="Nick"
					<c:if test="${!empty srchTypeList}">
					  <c:forEach items="${srchTypeList}" var="srch">
						<c:if test="${srch.type == 'Nick'}">checked</c:if>
					  </c:forEach>
					</c:if>
				>작성자
				<input type="checkbox" id="bltn_srchType" name="bltn_srchType" value="Atch"
					<c:if test="${!empty srchTypeList}">
					  <c:forEach items="${srchTypeList}" var="srch">
						<c:if test="${srch.type == 'Atch'}">checked</c:if>
					  </c:forEach>
					</c:if>
				>첨부파일
			  </td>
			</tr>
			<tr>
			  <td colspan="2">
			    <input type="text" id="bltn_srchKey" id="bltn_srchKey" value="<c:out value="${suForm.srchKey}"/>" style="width:130px" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchBltn();}"/>
				<span class="btn_pack medium"><a href="javascript:superMngr.searchBltn()">검색</a></span>
				<select id="bltn_pageSize" name="bltn_pageSize">
				  <c:forEach items="${pageSizeList}" var="pageSize">
					<option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
				  </c:forEach>
				</select>
			  </td>
			</tr>
		  </table>
	    </td>
	  </tr>
	  <tr><td height="5"></td></tr>
	  <tr>
	    <td height="28px" align="center" class="adpanel">
	      <div onclick="superMngr.onSelectLeft('memo')">&nbsp;<b>댓글(메모) 검색</b>&nbsp;</div>
	    </td>
	  </tr>
	  <tr id="leftSub" name="leftSub" opt="memo" style="display:none">
	    <td class="adformpanel">
		  <table width="100%">
			<tr>
			  <td align="right" width="35%" style="padding-right:5px"><b>카페명:</b></td>
			  <td align="left" width="70%" style="padding-left:5px">
			    <input type="text" id="memo_srchCmntNm" style="width:190px" value="<c:out value="${suForm.cmntNm}"/>" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchMemo();}"/>
			  </td>
			</tr>
			<tr>
			  <td align="right" width="35%" style="padding-right:5px"><b>게시판명:</b></td>
			  <td align="left" width="70%" style="padding-left:5px">
			    <input type="text" id="memo_srchBoardNm" style="width:190px" value="<c:out value="${suForm.boardNm}"/>" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchMemo();}"/>
			  </td>
			</tr>
			<tr>
			  <td align="right" width="35%" style="padding-right:5px">
			    <input type="checkbox" id="memo_srchType" name="memo_srchType" value="RegD" 
					<c:if test="${!empty srchTypeList}">
					  <c:forEach items="${srchTypeList}" var="srch">
						<c:if test="${srch.type == 'RegD'}">checked</c:if>
					  </c:forEach>
					</c:if>
				>작성일
			  </td>
			  <td align="left" width="70%" style="padding-left:5px">
				<input type="text" id="memo_srchBgnReg" value="<c:out value="${suForm.srchBgnReg}"/>" style="width:70px" readonly="true">
				<img align="absmiddle" src="<%=evcp%>/cola/cafe/images/super/encafe/calendar.gif" onclick="displayCalendar(new Date(), 'memo_srchBgnReg', event)">
				부터
				<input type="text" id="memo_srchEndReg" value="<c:out value="${suForm.srchEndReg}"/>" style="width:70px" readonly="true">
				<img align="absmiddle" src="<%=evcp%>/cola/cafe/images/super/encafe/calendar.gif" onclick="displayCalendar(new Date(), 'memo_srchEndReg', event)">
				까지
			  </td>
			</tr>
			<tr>
			  <td colspan="2">
				<input type="checkbox" id="memo_srchType" name="memo_srchType" value="Cntt"
					<c:if test="${!empty srchTypeList}">
					  <c:forEach items="${srchTypeList}" var="srch">
						<c:if test="${srch.type == 'Cntt'}">checked</c:if>
					  </c:forEach>
					</c:if>
				>본문
				<input type="checkbox" id="memo_srchType" name="memo_srchType" value="Nick"
					<c:if test="${!empty srchTypeList}">
					  <c:forEach items="${srchTypeList}" var="srch">
						<c:if test="${srch.type == 'Nick'}">checked</c:if>
					  </c:forEach>
					</c:if>
				>작성자
			  </td>
			</tr>
			<tr>
			  <td colspan="2">
			    <input type="text" id="memo_srchKey" id="memo_srchKey" value="<c:out value="${suForm.srchKey}"/>" style="width:130px" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchMemo();}"/>
				<span class="btn_pack medium"><a href="javascript:superMngr.searchMemo()">검색</a></span>
				<select id="memo_pageSize" name="memo_pageSize">
				  <c:forEach items="${pageSizeList}" var="pageSize">
					<option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
				  </c:forEach>
				</select>
			  </td>
			</tr>
		  </table>
	    </td>
	  </tr>
	</table>
  </td> <!-- End superLeft -->
  <td id="superRight" valign="top" class="webpanel">
	<div>
	  <form id="superSearchForm" name="superSearchForm">
		<input type='hidden' name='cmd'/>
		<input type='hidden' name='view'/>
		<input type='hidden' name='pageNo' value='1'/>
		<input type='hidden' name='pageSize' value='10'/>
		<input type='hidden' name='pageFunction' value='superMngr.doPage'/>
		<input type='hidden' name='formName' value='superSearchForm'/>
	  </form>
	</div>
	<%--BEGIN::카페 목록 영역--%>
	<div id="superListDiv" name="superListDiv" class="adgridpanel"></div>
	<%--END::카페 목록 영역--%>
	<div>
	  <table style="width:100%;">
		<tr>
		  <td align="center">
			<div id="SUPER_PAGE_ITERATOR"></div>
		  </td>   
		</tr>
	  </table>
	</div>
	<%--BEGIN::카페 상세정보 영역--%>
	<div id="superDetailDiv" name="superDetailDiv" class="adgridpanel"></div>
	<%--END::카페 상세정보 영역--%>
  </td>
</tr>
</table>

<div id="closeReasonGetter" title="카페 강제 폐쇄 사유 선택"></div>

<div id="treeCtxtMenuDiv" title='<util:message key="eb.title.cate"/>'>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='superMngr.onRefresh()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_refresh_tree.gif">&nbsp;<util:message key="eb.title.refresh.tree"/></a>
  </div>
  <hr>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='superMngr.onCreateCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_ins_cate.gif">&nbsp;<util:message key="eb.title.ins.cate"/></a>
  </div>
  <hr>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='superMngr.onUpdateCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_upd_cate.gif">&nbsp;<util:message key="eb.title.upd.cate"/></a>
  </div>
  <hr>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='superMngr.onMoveUpCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_move_up.gif">&nbsp;<util:message key="eb.title.move.up"/></a>
  </div>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='superMngr.onMoveDownCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_move_down.gif">&nbsp;<util:message key="eb.title.move.down"/></a>
  </div>
  <hr>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='superMngr.onDeleteCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_del_cate.gif">&nbsp;<util:message key="eb.title.del.cate"/></a>
  </div>
</div>
<form name="goHomeForm" method="POST" action="" onsubmit="return false;" target="_blank">
  <input type="hidden" id="boardId" name="boardId"/>
  <input type="hidden" id="bltnNo"  name="bltnNo"/>
</form>
<form name="goJigiForm" method="POST" action="" onsubmit="return false;" target="_blank">
  <input type="hidden" id="m" name="m" value="goJigi"/>
  <input type="hidden" id="cmntUrl" name="cmntUrl"/>
</form>

<link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css">
<link type="text/css" rel="stylesheet" href="<%=evcp%>/board/calendar/css/calendar.css">
<!--link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/dhtmlXTree.css"-->
<style type="text/css">
<!--
	.contextMenu_item {
		display: block;
		/*padding: 2px;*/
	}
	.contextMenu_itemOver{
		background-color:#B3ABBD;
		color:white; 
	}
-->
</style>

<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript" src="<%=evcp%>/board/calendar/calendar.js"></script>
<script type="text/javascript" src="<%=evcp%>/board/calendar/ko-kr/generatecalendar.js"></script>
<script type="text/javascript" src="<%=evcp%>/cola/cafe/javascript/super/encafe.js"></script>
<script type="text/javascript">
  function initSuperMngr() {
	superMngr = new SuperMngr();
	superMngr.init();
  }
  function finishSuperMngr() {}
  // Attach to the onload event
  if (window.attachEvent) {
    window.attachEvent ("onload", initSuperMngr);
	window.attachEvent ("onunload", finishSuperMngr);
  } else if (window.addEventListener ) {
    window.addEventListener ("load", initSuperMngr, false);
	window.addEventListener ("unload", finishSuperMngr, false);
  } else {
    window.onload = initSuperMngr;
	window.onunload = finishSuperMngr;
  }
</script>

