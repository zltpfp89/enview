<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- apmLeft -->
	<div id="apmLeft" class="tree">
		<!-- treewrap -->
		<div class="treewrap resizable">
			<div class="tree_title">설문 카테고리</div>
			<!-- 트리 영역 border로 구분. 지우고 사용해주세요 -->
			<div id="apmCateTree" style="width: 100%; height:200px; overflow:auto;"></div>
			<!-- tablewrap -->
			<div id="cateTabs" class="tablewrap">
				<ul>
					<li class="m1"><a href="#apmCateDetailTab" class="first" onclick="aPM.onSelectCateTabs(1);"><span class="title"><util:message key="mm.title.category"/>&nbsp;<util:message key="mm.title.detail"/></span></a></li>
					<li class="m2"><a href="#apmCateLangTab" onclick="aPM.onSelectCateTabs(2);"><span class="title"><util:message key="mm.title.category"/>&nbsp;<util:message key="mm.title.nm"/></span></a></li>
				</ul>
				<div id="apmCateDetailTab">
					<!-- apmCateEditForm -->
					<form id="apmCateEditForm" style="display:inline" action="" method="post">
						<input type="hidden" id="cate_act">
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">   
							<caption>게시판</caption>
							<colgroup>
								<col width="50%" />
								<col width="*" />
							</colgroup>
							<tbody>   
								<tr>
									<th class="L"><util:message key="mm.title.id"/> <em>*</em></th>
									<td class="L"><label for="cate_cateId"></label><input type="text" id="cate_cateId" class="txt_70"></td>
								</tr>
								<!-- c:if test="${sessionScope._user_domain_.domainId != '0' && (sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole)}"--><%--멀티포털 기능을 사용하고 관리자/중간관리자이면--%>
									<tr>
										<th class="L"><util:message key="mm.prop.domain.domainId"/> <em>*</em></th>
										<td class="L">
											<div class="sel_70">
												<select id="cate_domainId" class="txt_70">
													<c:forEach items="${domainList}" var="domain">
														<option value="<c:out value="${domain.domainId}"/>"><c:out value="${domain.domainNm}"/>
													</c:forEach>
												</select>
											</div>
										</td>
									</tr>
								<!-- /c:if-->
								<tr>
									<th class="L"><util:message key="mm.title.category"/>&nbsp;<util:message key="mm.title.nm"/> <em>*</em></th>
									<td class="L"><label for="cate_cateNm"></label><input type="text" id="cate_cateNm" class="txt_70"/></td>
								</tr>
							</tbody>
						</table>
						<!-- btnArea-->
						<div class="btnArea"> 
							<div class="rightArea">
								<a id="cate_btnSave" href="javascript:aPM.doSaveCate()" class="btn_B"><span><util:message key="mm.title.save"/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>
					<!-- apmCateEditForm//-->
				</div>	
				<div id="apmCateLangTab" style="display:none;">
					<!-- apmCateLangListForm -->
					<form id="apmCateLangListForm" style="display:inline" name="apmCateLangListForm" action="" method="post">	
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
							<caption>게시판</caption>
							<colgroup>
								<col width="30px" />
								<col width="*" />
								<col width="*" />
							</colgroup>
							<thead>
								<tr>
									<th class="first">
										<input type="checkbox" id="delCheck" onclick="aPM.m_checkBox.chkAll(this)"/>
										<input type="hidden" id="cateLangList_cateId"/>
									</th>
									<th class="L" ch="0">
										<span class="table_title"><util:message key="eb.title.lang"/></span> 
									</th>
									<th class="L" ch="0">
										<span class="table_title"><util:message key="mm.title.category"/><util:message key="mm.title.nm"/></span>
									</th>
								</tr>
							</thead>
							<tbody id="apmCateLangListBody"></tbody>
						</table>
						<!-- btnArea-->
						<div class="btnArea"> 
							<div class="rightArea">
								<a id="cateLang_new" href="javascript:aPM.doCreateCateLang()" class="btn_B"><span><util:message key="mm.title.new"/></span></a>
								<a id="cateLang_remove" href="javascript:aPM.doDeleteCateLang()" class="btn_B"><span><util:message key="mm.title.remove"/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>	
					<!-- apmCateLangListForm// -->
					<div id="apmCateLangEditPage" style="display:none;">
						<!-- apmCateLangEditForm -->
						<form id="apmCateLangEditForm" style="display:inline" name="apmCateLangEditForm" action="" method="post" onsubmit="return false;">
							<input type="hidden" id="cateLang_act"/>
							<input type="hidden" id="cateLang_cateId"/>
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
								<caption>게시판</caption>
								<colgroup>
									<col width="120px" />
									<col width="*" />
								</colgroup>
								<tr>
									<th class="L"><util:message key="eb.title.lang"/> <em>*</em></th>
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
									<th class="L"><util:message key="mm.title.category"/> <em>*</em></th>
									<td class="L"><input type="text" id="cateLang_cateNm" class="txt_70" size="20" maxLength="120" required="true"/></td>
								</tr>
							</table>
							<!-- btnArea-->
							<div class="btnArea"> 
								<div class="rightArea">
									<a href="javascript:aPM.doSaveCateLang()" class="btn_B"><span><util:message key="mm.title.save"/></span></a>
								</div>
							</div>
							<!-- btnArea//-->							
						</form>
						<!-- apmCateLangEditForm// -->
					</div>
				</div>
			</div>
			<!-- tablewrap// -->
		</div>
		<!-- treewrap// -->
	</div>
	<!-- apmLeft// -->
	<!-- apmRight -->
	<div id="apmRight" class="detail">
		<!-- board -->
		<div class="board first">
			<form id="apmSearchForm" name="apmSearchForm">
				<input type='hidden' name='pageNo' value='1'/>
				<input type='hidden' name='pageSize' value='5'/>
				<input type='hidden' name='pageFunction' value='aPM.doPage'/>
				<input type='hidden' name='formName' value='apmSearchForm'/>
				<input type='hidden' name='sortColumn' value='a.board_id'/>
				<input type='hidden' name='sortMethod' value='ASC'/>
			</form>
			<!-- apmListForm -->
			<form id="apmListForm" style="display:inline" name="apmListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="100px" />
						<col width="*" />
						<col width="200px" />
						<col width="50px" />
					</colgroup>
					<thead>
						<tr style="cursor: pointer;">
							<th>
								<input type="checkbox" id="delCheck" onclick="aPM.m_checkBox.chkAll(this)"/>
							</th>
							<th ch="0" onclick="aPM.doSort('a.board_id')">
								<span class="table_title"><util:message key="mm.title.id"/></span>
							</th>
							<th ch="0" onclick="aPM.doSort('board_nm')">
								<span class="table_title"><util:message key="mm.title.poll"/>&nbsp;<util:message key="eb.title.subj"/></span>
							</th>
							<th ch="0" onclick="aPM.doSort('board_skin')">
								<span class="table_title"><util:message key="eb.prop.board.skin"/></span>
							</th>
							<th ch="0" onclick="aPM.doSort('board_active')">
								<span class="table_title"><util:message key="eb.title.activate"/></span>
							</th>
						</tr>
					</thead>
					<tbody id="apmListBody"></tbody>
				</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="APM_PAGE_ITERATOR">
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->		
			</form>
			<!-- apmListForm// -->
		</div>
		<!-- board// -->
		<!-- board -->
		<div class="board">
			<div id="apmPropTabs">
				<ul>
					<li><a href="#apmPollTab" onclick="aPM.doSelectTab(0)">설문관리</a></li>   
					<li><a href="#apmQstnTab" onclick="aPM.doSelectTab(1)">문항관리</a></li>
					<li><a href="#apmEvalTab" onclick="aPM.doSelectTab(2)">평점관리</a></li>
					<li><a href="#apmPartTab" onclick="aPM.doSelectTab(3)">대상자관리</a></li>
					<li><a href="#apmRsltTab" onclick="aPM.doSelectTab(4)">결과조회</a></li>
				</ul>
				<div id="apmPollTab" style="width:100%;" class="adgridpanel"></div>
				<div id="apmQstnTab" style="width:100%;" class="adgridpanel"></div>
				<div id="apmEvalTab" style="width:100%;" class="adgridpanel"></div>
				<div id="apmPartTab" style="width:100%;" class="adgridpanel"></div>
				<div id="apmRsltTab" style="width:100%;" class="adgridpanel"></div>
			</div>
		</div>
		<!-- board// -->
	</div>
	<!-- apmRight// -->
</div>
<!-- sub_contents// -->
<!-- apmBoardChooser -->
<div id="apmBoardChooser" title="<util:message key="eb.title.boardChooser"/>">
	<div id="boardChooserCateTree" class="tree" style="border-right: 0px #ffffff;"></div>
	<div id="boardChooserRight" style="height:400px; display: table-cell;">
		<form id="boardChooserSearchForm" name="boardChooserSearchForm" style="display:inline" method="post">
			<input type='hidden' name='pageNo' value='1'/>
			<input type='hidden' name='pageSize' value='10'/>
			<input type='hidden' name='pageFunction' value='aPM.getBoardChooser().doPage'/>
			<input type='hidden' name='formName' value='boardChooserSearchForm'/>
		</form>	
		<form id="boardChooserListForm" style="display:inline" name="boardChooserListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<thead>
					<tr style="cursor: pointer;">
 						<th>
							<input type="checkbox" id="delCheck" onclick="aPM.m_checkBox.chkAll(this)"/>
	 	 				</th>
	  					<th ch="0">
							<span class="table_title">아이디</span>
	  					</th>
	  					<th ch="0">
							<span class="table_title">게시판 명</span>
	 	 				</th>
	  					<th ch="0">
							<span class="table_title">게시판 타이틀</span>
	  					</th>
	  					<th ch="0">
							<span class="table_title">적용된 스킨</span>
	  					</th>
					</tr>				
				</thead>
		  		<tbody id="boardChooserListBody"></tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="boardChooser_PAGE_ITERATOR">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->			
		</form>
 	</div>
</div>
<!-- apmBoardChooser// -->
<div id="apmCateChooser" title="<util:message key="eb.title.cateChooser"/>">
	<div id="cateChooserCateTree" style="width:200px; height:300px; overflow:auto;"></div>
</div>

<div id="apmMultiLangMngr" title="<util:message key="eb.title.multiLangMngr"/>"></div>
<!-- div id="apmRoleChooser" title="<util:message key="eb.title.roleChooser"/>"></div -->
<!-- div id="apmGroupChooser" title="<util:message key="eb.title.groupChooser"/>"></div -->
<div id="RoleManager_RoleChooser" title="Role Chooser"></div>	<!-- Role Chooser DIV 팝업 -->
<div id="GroupManager_GroupChooser" title="Group Chooser"></div>	<!-- Group Chooser DIV 팝업 -->
<div id="apmUserChooser" title="<util:message key="eb.title.userChooser"/>"></div>
<div id="apmPollJoinUserMngr" title="설문참여자"></div>

<div id="treeCtxtMenuDiv" title='<util:message key="eb.title.cate"/>'>
	<div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
		<a onclick='aPM.onRefresh()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_refresh_tree.gif">&nbsp;<util:message key="eb.title.refresh.tree"/></a>
	</div>
	<hr>
	<div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
		<a onclick='aPM.onCreateCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_ins_cate.gif">&nbsp;<util:message key="eb.title.ins.cate"/></a>
	</div>
	<hr>
	<div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
		<a onclick='aPM.onUpdateCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_upd_cate.gif">&nbsp;<util:message key="eb.title.upd.cate"/></a>
	</div>
	<hr>
	<div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
		<a onclick='aPM.onMoveUpCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_move_up.gif">&nbsp;<util:message key="eb.title.move.up"/></a>
	</div>
	<div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
		<a onclick='aPM.onMoveDownCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_move_down.gif">&nbsp;<util:message key="eb.title.move.down"/></a>
	</div>
	<hr>
	<div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
		<a onclick='aPM.onDeleteCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_del_cate.gif">&nbsp;<util:message key="eb.title.del.cate"/></a>
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
<iframe name="download" src="blank.brd" width="0" height="0"></iframe>

<link type="text/css" rel="stylesheet" href="<%=evcp%>/board/css/admin/admin-common.css">
<link type="text/css" rel="stylesheet" href="<%=evcp%>/board/calendar/css/calendar.css">
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

<script type="text/javascript" src="<%=evcp%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=evcp%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=evcp%>/javascript/jquery/jquery.form.js"></script>
<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript" src="<%=evcp%>/board/calendar/calendar.js"></script>
<script type="text/javascript" src="<%=evcp%>/board/calendar/ko-kr/generatecalendar.js"></script>
<script type="text/javascript" src="<%=evcp%>/board/javascript/admin_poll.js"></script>

<script type="text/javascript">

  function initAdmPollMngr() {

	aPM = new AdmPollMngr();

	aPM.m_isAdm = '<c:out value="${sessionScope._enview_user_info_.hasAdminRole}"/>';
	aPM.m_isMngr = '<c:out value="${sessionScope._enview_user_info_.hasManagerRole}"/>';
	aPM.m_isDomMngr = '<c:out value="${sessionScope._enview_user_info_.hasDomainManagerRole}"/>';
	aPM.m_usrDomId = '<c:out value="${sessionScope._user_domain_.domainId}"/>';
  }
  function finishAdmPollMngr() {}

  // Attach to the onload event
  if (window.attachEvent) {
    window.attachEvent ("onload", initAdmPollMngr);
	window.attachEvent ("onunload", finishAdmPollMngr);
  } else if (window.addEventListener ) {
    window.addEventListener ("load", initAdmPollMngr, false);
	window.addEventListener ("unload", finishAdmPollMngr, false);
  } else {
    window.onload = initAdmPollMngr;
	window.onunload = finishAdmPollMngr;
  }
</script>