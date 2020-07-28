<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- tree -->
	<div id="superLeft" class="tree">
		<!-- treewrap -->
		<div class="treewrap resizable">
			<div class="tree_title" onclick="superMngr.onSelectLeft('cate')">카테고리별 검색</div>
			<!-- 트리 영역 border로 구분. 지우고 사용해주세요 -->
			<div id="superCateTree" style="width: 100%; height:200px; overflow:auto;"></div>
			<!-- 카페,기능별,기능별,댓글(메모) 검색 -->
			<div style="background:#fff;">
				<!-- searchArea-->
				<div class="tsearchArea">
					<div class="tree_title" style="cursor:pointer;" onclick="superMngr.onSelectLeft('srch')">카페 검색</div>
					<div id="leftSub" name="leftSub" opt="srch" style="display:none; height:100px;">
						<div class="sel_70">
							<select id="cafe_srchType" name="cafe_srchType" class="txt_70">
								<option value="NM"   <c:if test="${suForm.srchType == 'NM'  }">selected</c:if>>카페이름</option>
								<option value="URL"  <c:if test="${suForm.srchType == 'URL' }">selected</c:if>>카페주소</option>
								<option value="TAG"  <c:if test="${suForm.srchType == 'TAG' }">selected</c:if>>카페태그</option>
								<option value="CATE" <c:if test="${suForm.srchType == 'CATE'}">selected</c:if>>카테고리</option>
							</select>
						</div>
						<input type="text" id="cafe_srchKey" name="cafe_srchKey" class="txt_70" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchCafe();}"/>
						<a href="javascript:superMngr.searchCafe()" class="btn_search"><span>검색</span></a>					
					</div>
					<div class="tree_title" style="cursor:pointer;" onclick="superMngr.onSelectLeft('func')">기능별 검색</div>
					<div id="leftSub" name="leftSub" opt="func" style="display:none">
						<ul style="list-style-type:none">
							<li style="padding-top:5px; padding-left:20px; cursor:pointer;"><font onclick="superMngr.listCafe('permit')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">개설 신청</font></li>
							<li style="padding-top:5px; padding-left:20px; cursor:pointer;"><font onclick="superMngr.listCafe('2close')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">폐쇄 신청</font></li>
							<li style="padding-top:5px; padding-left:20px; cursor:pointer;"><font onclick="superMngr.listCafe('closed')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">폐쇄 완료</font></li>
							<li style="padding-top:5px; padding-left:20px; cursor:pointer;"><font onclick="superMngr.listCafe('hit')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">방문수 순위</font></li>
							<li style="padding-top:5px; padding-left:20px; cursor:pointer;"><font onclick="superMngr.listCafe('mile')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">랭킹  순위</font></li>
							<li style="padding-top:5px; padding-left:20px; cursor:pointer;"><font onclick="superMngr.listCafe('mmbr')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">회원수 순위</font></li>
							<li style="padding-top:5px; padding-left:20px; cursor:pointer;"><font onclick="superMngr.listCafe('rcmd')" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">추천 카페</font></li>
						</ul>				
					</div>
					<div class="tree_title" style="cursor:pointer;" onclick="superMngr.onSelectLeft('bltn')">게시물 검색</div>
					<div id="leftSub" name="leftSub" opt="bltn" style="display:none">
						<table cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					 		<caption>게시판</caption>
							<colgroup>
								<col width="40%" />
								<col width="*" />
							</colgroup>					 
							<tr>
								<th class="R">카페명 : </th>
								<td class="L">
									<input type="text" id="bltn_srchCmntNm" class="txt_100" value="<c:out value="${suForm.cmntNm}"/>" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchBltn();}"/>
								</td>
							</tr>
							<tr>
								<th class="R">게시판명 : </th>
								<td class="L">
									<input type="text" id="bltn_srchBoardNm" class="txt_100" value="<c:out value="${suForm.boardNm}"/>" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchBltn();}"/>
								</td>
							</tr>
							<tr>
								<th class="R">
								    <input type="checkbox" id="bltn_srchType" name="bltn_srchType" value="RegD" 
										<c:if test="${!empty srchTypeList}">
											<c:forEach items="${srchTypeList}" var="srch">
												<c:if test="${srch.type == 'RegD'}">checked</c:if>
											</c:forEach>
										</c:if>
									>작성일
							  	</th>
								<td class="L">
									<input type="text" id="bltn_srchBgnReg" value="<c:out value="${suForm.srchBgnReg}"/>" class="txt_70" readonly="true">
									<span class="sel_txt"><img align="absmiddle" src="<%=evcp%>/cola/cafe/images/super/encafe/calendar.gif" onclick="displayCalendar(new Date(), 'bltn_srchBgnReg', event)"></span>
									<span class="sel_txt">부터</span>
									<input type="text" id="bltn_srchEndReg" value="<c:out value="${suForm.srchEndReg}"/>" class="txt_70" readonly="true">
									<span class="sel_txt"><img align="absmiddle" src="<%=evcp%>/cola/cafe/images/super/encafe/calendar.gif" onclick="displayCalendar(new Date(), 'bltn_srchEndReg', event)"></span>
									<span class="sel_txt">까지</span>
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
									<input type="text" id="bltn_srchKey" id="bltn_srchKey" value="<c:out value="${suForm.srchKey}"/>" class="txt_70" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchBltn();}"/>
									<a href="javascript:superMngr.searchBltn()" class="btn_search"><span>검색</span></a>
									<div class="sel_70">
										<select id="bltn_pageSize" name="bltn_pageSize" class="txt_70">
											<c:forEach items="${pageSizeList}" var="pageSize">
												<option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
											</c:forEach>
										</select>								
									</div>
								</td>
							</tr>					
						</table>
					</div>
					<div class="tree_title" style="cursor:pointer;" onclick="superMngr.onSelectLeft('memo')">댓글(메모) 검색</div>
					<div id="leftSub" name="leftSub" opt="memo" style="display:none">
						<table cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					 		<caption>게시판</caption>
							<colgroup>
								<col width="40%" />
								<col width="*" />
							</colgroup>						 
							<tr>
								<th class="R">카페명 : </th>
								<td class="L">
									<input type="text" id="memo_srchCmntNm" class="txt_100" value="<c:out value="${suForm.cmntNm}"/>" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchMemo();}"/>
								</td>
							</tr>
							<tr>
								<th class="R">게시판명 : </th>
								<td class="L">
									<input type="text" id="memo_srchBoardNm" class="txt_100" value="<c:out value="${suForm.boardNm}"/>" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchMemo();}"/>
								</td>
							</tr>
							<tr>
								<th class="R">
									<input type="checkbox" id="memo_srchType" name="memo_srchType" value="RegD" 
										<c:if test="${!empty srchTypeList}">
											<c:forEach items="${srchTypeList}" var="srch">
												<c:if test="${srch.type == 'RegD'}">checked</c:if>
											</c:forEach>
										</c:if>
									>작성일
								</th>
							 	<td class="L">
									<input type="text" id="memo_srchBgnReg" value="<c:out value="${suForm.srchBgnReg}"/>" class="txt_70" readonly="true">
									<span class="sel_txt"><img align="absmiddle" src="<%=evcp%>/cola/cafe/images/super/encafe/calendar.gif" onclick="displayCalendar(new Date(), 'memo_srchBgnReg', event)"></span>
									<span class="sel_txt">부터</span>
									<input type="text" id="memo_srchEndReg" value="<c:out value="${suForm.srchEndReg}"/>" class="txt_70" readonly="true">
									<span class="sel_txt"><img align="absmiddle" src="<%=evcp%>/cola/cafe/images/super/encafe/calendar.gif" onclick="displayCalendar(new Date(), 'memo_srchEndReg', event)"></span>
									<span class="sel_txt">까지</span>
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
								 	<input type="text" id="memo_srchKey" id="memo_srchKey" value="<c:out value="${suForm.srchKey}"/>" class="txt_70" maxlength="30" onKeyPress="if(event.keyCode==13){superMngr.searchMemo();}"/>
									<a href="javascript:superMngr.searchMemo()" class="btn_search"><span>검색</span></a>
									<div class="sel_70">
										<select id="memo_pageSize" name="memo_pageSize" class="txt_70">
											<c:forEach items="${pageSizeList}" var="pageSize">
												<option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
											</c:forEach>
										</select>
									</div>	
								</td>
							</tr>	
						</table>
					</div>										
				</div>
			</div>
			<!-- 카페,기능별,기능별,댓글(메모) 검색 -->				
			<!-- tablewrap -->
			<div id="cateTabs" opt="cate" class="tablewrap">
				<ul>
					<li class="m1"><a href="#superCateDetailTab" class="first" onclick="superMngr.onSelectCateTabs(1);"><span class="title">카테고리 상세</span></a></li>
					<li class="m2"><a href="#superCateLangTab" onclick="superMngr.onSelectCateTabs(2);"><span class="title">카테고리 명</span></a></li>		
				</ul>
				<div id="superCateDetailTab">
					<!-- superCateEditForm -->
					<form id="superCateEditForm" style="display:inline" action="" method="post" >
						<input type="hidden" id="cate_act">
						<table cellpadding="0" cellspacing="0" summary="게시판" class="table_board">  
							<caption>게시판</caption>
							<colgroup>
								<col width="50%" />
								<col width="*" />
							</colgroup>
							<tbody> 
								<tr> 
									<td colspan="2" class="C" id="superCateDialog.MessageArea"></td>    
								</tr>					  
								<tr>
									<th class="L">아이디</th>
						  			<td class="L"><input type="text" id="cate_cateId" class="txt_70"></td>
								</tr>
								<tr> 
									<th class="L">카테고리 명</th>
								  	<td class="L"><input type="text" id="cate_cateNm" maxlength="120" class="txt_70"></td>
								</tr>						
							</tbody>
						</table>
						<!-- btnArea-->
						<div class="btnArea"> 
							<div class="rightArea">
								<a id="cate_btnSave" href="javascript:superMngr.doSaveCate()" class="btn_B"><span><util:message key="mm.title.save"/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>
					<!-- superCateEditForm//-->
				</div>
				<div id="superCateLangTab" style="display:none;">
					<!-- superCateLangListForm -->
					<form id="superCateLangListForm" style="display:inline" name="superCateLangListForm" action="" method="post">
						<table cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
							<caption>게시판</caption>
							<colgroup>
								<col width="30px" />
								<col width="*" />
								<col width="*" />
							</colgroup>
							<thead>
								<tr>
									<th class="C">
										<input type="checkbox" id="delCheck" onclick="superMngr.m_checkBox.chkAll(this)"/>
									  	<input type="hidden" id="cateLangList_cateId"/>
									</th>
									<th class="C" ch="0">
									  	<span class="table_title">언어</span> 
									</th>
									<th class="C" ch="0">
									  	<span class="table_title">카테고리명</span>
									</th>
								<tr>						
							</thead>
							<tbody id="superCateLangListBody"></tbody>
						</table>
						<!-- btnArea-->
						<div class="btnArea"> 
							<div class="rightArea">
								<a id="cateLang_new" href="javascript:superMngr.doCreateCateLang()" class="btn_B"><span><util:message key="mm.title.new"/></span></a>
								<a id="cateLang_remove" href="javascript:superMngr.doDeleteCateLang()" class="btn_B"><span><util:message key="mm.title.remove"/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>
					<!-- superCateLangListForm//-->
					<div id="superCateLangEditPage" style="display:none;">
						<!-- superCateLangEditForm -->
						<form id="superCateLangEditForm" style="display:inline" name="superCateLangEditForm" action="" method="post" onsubmit="return false;">
							<input type="hidden" id="cateLang_act"/>
							<input type="hidden" id="cateLang_cateId"/>
							<table cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
								<caption>게시판</caption>
								<colgroup>
									<col width="50%" />
									<col width="*" />
								</colgroup>
								<tr>
									<th class="L">언어</th>
									<td class="L">
										<div class="sel_70">
											<select id="cateLang_langKnd" class="txt_70">
												<c:forEach items="${langList}" var="lang">
													<option value="<c:out value="${lang.code}"/>"><c:out value="${lang.codeName}"/></option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
								  <th class="L">카테고리명</th>
								  <td class="L"><input type="text" id="cateLang_cateNm" size="20" maxLength="120" required="true" class="txt_70"/></td>
								</tr>
							</table>
							<!-- btnArea-->
							<div class="btnArea"> 
								<div class="rightArea">
									<a href="javascript:superMngr.doSaveCateLang()" class="btn_B"><span><util:message key="mm.title.save"/></span></a>
								</div>
							</div>
							<!-- btnArea//-->
						</form>
						<!-- superCateLangEditForm//-->
					</div>					
				</div>			
			</div>
			<!-- tablewrap// -->
		</div>
		<!-- treewrap//-->	
	</div>
	<!-- tree// -->	
	<!-- detail -->
	<div id="superRight" class="detail">
		<!-- board -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<fieldset>
					<form id="superSearchForm" name="superSearchForm">
						<input type='hidden' name='cmd'/>
						<input type='hidden' name='view'/>
						<input type='hidden' name='pageNo' value='1'/>
						<input type='hidden' name='pageSize' value='10'/>
						<input type='hidden' name='pageFunction' value='superMngr.doPage'/>
						<input type='hidden' name='formName' value='superSearchForm'/>
					</form>			
				</fieldset>
			</div>
			<!-- searchArea// -->
			<%--BEGIN::카페 목록 영역--%>
			<div id="superListDiv" name="superListDiv"></div>
			<%--END::카페 목록 영역--%>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="SUPER_PAGE_ITERATOR">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<%--BEGIN::카페 상세정보 영역--%>
			<div id="superDetailDiv" name="superDetailDiv"></div>
			<%--END::카페 상세정보 영역--%>			
		</div>
		<!-- board// -->
	</div>
	<!-- detail// -->	
</div>
<!-- sub_contents -->

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
<div id="dhtmlx_context_data">
	<div id="onRefresh" text="<util:message key="eb.title.refresh.tree" />" img="<%=evcp%>/board/images/admin/ctxt_menu_refresh_tree.gif"></div>
	<div id="onCreate" text="<util:message key="eb.title.ins.cate" />" img="<%=evcp%>/board/images/admin/ctxt_menu_ins_cate.gif"></div>
	<div id="onModify" text="<util:message key="eb.title.upd.cate" />" img="<%=evcp%>/board/images/admin/ctxt_menu_upd_cate.gif"></div>
	<div id="onMoveUp" text="<util:message key="eb.title.move.up" />" img="<%=evcp%>/board/images/admin/ctxt_menu_move_up.gif"></div>
	<div id="onMoveDown" text="<util:message key="eb.title.move.down" />" img="<%=evcp%>/board/images/admin/ctxt_menu_move_down.gif"></div>
	<div id="onDelete" text="<util:message key="eb.title.del.cate" />" img="<%=evcp%>/board/images/admin/ctxt_menu_del_cate.gif"></div>
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