<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- abmLeft -->
	<div id="abmLeft" class="tree">
		<!-- treewrap -->
		<div class="treewrap resizable">
			<div class="tree_title"><util:message key="mm.title.board"/>&nbsp;<util:message key="mm.title.category"/></div>
			<!-- 트리 영역 border로 구분. 지우고 사용해주세요 -->
			<div id="abmCateTree" style="width: 100%; height:400px; overflow:auto;"></div>
			<!-- tablewrap -->
			<div id="cateTabs" class="tablewrap">
				<ul>
					<li class="m1"><a href="#abmCateDetailTab" class="first" onclick="aBM.onSelectCateTabs(1);"><span class="title"><util:message key="mm.title.category"/>&nbsp;<util:message key="mm.title.detail"/></span></a></li>
					<li class="m2"><a href="#abmCateLangTab" onclick="aBM.onSelectCateTabs(2);"><span class="title"><util:message key="mm.title.category"/>&nbsp;<util:message key="mm.title.nm"/></span></a></li>
				</ul>
				<div id="abmCateDetailTab">
					<!-- abmCateEditForm -->
					<form id="abmCateEditForm" style="display:inline" action="" method="post">
					<input type="hidden" id="cate_act"/> 					
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">  
							<caption>게시판</caption>
							<colgroup>
								<col width="45%" />
								<col width="*" />
							</colgroup>
							<tbody>   
								<tr>
									<th class="L"><util:message key="mm.title.id"/></th>
									<td class="L"><label for="cate_cateId"></label><input type="text" id="cate_cateId" class="txt_70"></td>
								</tr>
								<c:if test="${sessionScope._user_domain_.domainId != '0' && (sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole)}"><%--멀티포털 기능을 사용하고 관리자/중간관리자이면--%>
									<tr>
										<th class="L"><util:message key="mm.prop.domain.domainId"/></th>
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
								</c:if>
								<tr>
									<th class="L"><util:message key="mm.title.category"/>&nbsp;<util:message key="mm.title.nm"/></th>
									<td class="L"><label for="cate_cateNm"></label><input type="text" id="cate_cateNm" class="txt_70"/></td>
								</tr>
							</tbody>
						</table>
						<!-- btnArea-->
						<div class="btnArea"> 
							<div class="rightArea">
								<a id="cate_btnSave" href="javascript:aBM.doSaveCate()" class="btn_B"><span><util:message key="mm.title.save"/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>
					<!-- abmCateEditForm//-->
				</div>
				<div id="abmCateLangTab" style="display:none;">
					<!-- abmCateLangListForm -->
					<form id="abmCateLangListForm" style="display:inline" name="abmCateLangListForm" action="" method="post">
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
										<input type="checkbox" id="delCheck" onclick="aBM.m_checkBox.chkAll(this)"/>
										<input type="hidden" id="cateLangList_cateId"/>
									</th>
									<th class="C" ch="0">
										<span class="table_title"><util:message key="eb.title.lang"/></span> 
									</th>
									<th class="C" ch="0">
										<span class="table_title"><util:message key="mm.title.category"/><util:message key="mm.title.nm"/></span>
									</th>
								</tr>
							</thead>
							<tbody id="abmCateLangListBody"></tbody>
						</table>
						<!-- btnArea-->
						<div class="btnArea"> 
							<div class="rightArea">
								<a id="cateLang_new" href="javascript:aBM.doCreateCateLang()" class="btn_B"><span><util:message key="mm.title.new"/></span></a>
								<a id="cateLang_remove" href="javascript:aBM.doDeleteCateLang()" class="btn_B"><span><util:message key="mm.title.remove"/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>
					<!-- abmCateLangListForm//-->
					<div id="abmCateLangEditPage" style="display:none;">
						<!-- abmCateLangEditForm -->
						<form id="abmCateLangEditForm" style="display:inline" name="abmCateLangEditForm" action="" method="post" onsubmit="return false;">
							<input type="hidden" id="cateLang_act"/>
							<input type="hidden" id="cateLang_cateId"/>
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
								<caption>게시판</caption>
								<colgroup>
									<col width="45%" />
									<col width="*" />
								</colgroup>
								<tr>
									<th class="L"><util:message key="eb.title.lang"/></th>
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
									<th class="L"><util:message key="mm.title.category"/><util:message key="mm.title.nm"/></th>
									<td class="L"><input type="text" id="cateLang_cateNm" size="20" maxLength="120" required="true" class="txt_70"/></td>
								</tr>
							</table>
							<!-- btnArea-->
							<div class="btnArea"> 
								<div class="rightArea">
									<a href="javascript:aBM.doSaveCateLang()" class="btn_B"><span><util:message key="mm.title.save"/></span></a>
								</div>
							</div>
							<!-- btnArea//-->
						</form>
						<!-- abmCateLangEditForm//-->
					</div>					
				</div>			
			</div>
			<!-- tablewrap// -->
		</div>
		<!-- treewrap//-->
	</div>
	<!-- abmLeft//-->
	<!-- abmRight -->
	<div id="abmRight" class="detail">
		<!-- board -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p style="display: none;"></p>
				<fieldset>
					<form id="abmSearchForm" name="abmSearchForm">
						<input type='hidden' name='pageNo' value='1'/>
						<input type='hidden' name='pageSize' value='10'/>
						<input type='hidden' name='pageFunction' value='aBM.doPage'/>
						<input type='hidden' name='formName' value='abmSearchForm'/>
						<input type='hidden' name='sortColumn' value='a.board_id'/>
						<input type='hidden' name='sortMethod' value='ASC'/>
					</form>
				</fieldset>
			</div>
			<!-- searchArea//-->
			<!-- abmListForm -->
			<form id="abmListForm" style="display:inline" name="abmListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="160px" />
						<col width="*" />
						<col width="*" />
						<col width="*" />
						<col width="60px" />
					</colgroup>
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="delCheck" onclick="aBM.m_checkBox.chkAll(this)"/>
							</th>
							<th ch="0" onclick="aBM.doSort('a.board_id')">
								<span class="table_title"><util:message key="mm.title.id"/></span>
							</th>
							<th ch="0" onclick="aBM.doSort('board_nm')">
								<span class="table_title"><util:message key="mm.title.board"/>&nbsp;<util:message key="mm.title.nm"/></span>
							</th>
							<th ch="0" onclick="aBM.doSort('board_ttl')">
								<span class="table_title"><util:message key="mm.title.board"/>&nbsp;<util:message key="mm.title.title"/></span>
							</th>
							<th ch="0" onclick="aBM.doSort('board_skin')">
								<span class="table_title"><util:message key="eb.prop.board.skin"/></span>
							</th>
							<th ch="0" onclick="aBM.doSort('board_active')">
								<span class="table_title"><util:message key="eb.title.activate"/></span>
							</th>
						</tr>
					</thead>
					<tbody id="abmListBody"></tbody>
				</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="ABM_PAGE_ITERATOR">
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
			</form>
			<!-- abmListForm//-->
		</div>
		<!-- board//-->
		<!-- board -->
		<div class="board">
			<!-- abmPropTabs -->
			<div id="abmPropTabs">
				<ul>
					<li><a href="#abmBaseTab" onclick="aBM.doSelectTab(0)" class="tabtitle"><span><util:message key="eb.title.base.prop"/></span></a></li>   
					<li><a href="#abmActnTab" onclick="aBM.doSelectTab(1)" class="tabtitle"><span><util:message key="eb.title.func.prop"/></span></a></li>
					<li><a href="#abmScrnTab" onclick="aBM.doSelectTab(2)" class="tabtitle"><span><util:message key="eb.title.scrn.prop"/></span></a></li>
					<li><a href="#abmAuthTab" onclick="aBM.doSelectTab(3)" class="tabtitle"><span><util:message key="eb.title.auth.prop"/></span></a></li>
					<li><a href="#abmBojoTab" onclick="aBM.doSelectTab(4)" class="tabtitle"><span><util:message key="eb.title.bojo.prop"/></span></a></li>
					<li><a href="#abmExtnTab" onclick="aBM.doSelectTab(5)" class="tabtitle"><span><util:message key="eb.title.extn.prop"/></span></a></li>
					<li><a href="#abmBltnTab" onclick="aBM.doSelectTab(6)" class="tabtitle"><span><util:message key="eb.title.bltn.prop"/></span></a></li>		
				</ul>
				<!-- abmBaseTab -->
				<div id="abmBaseTab">
					<div id="abmBaseDiv" style="display:none">
						<!-- abmBaseEditForm -->
						<form id="abmBaseEditForm" style="display:inline" name="abmBaseEditForm" action="" method="post" onsubmit="return false;">
							<input type="hidden" id="base_act"/>
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
								<caption>게시판</caption>
								<colgroup>
									<col width="140px" />
									<col width="*" />
									<col width="140px" />
									<col width="*" />
								</colgroup>
								<tr>
									<th class="L"><util:message key="eb.prop.boardId"/> <em>*</em></th>
									<td class="L" colspan="3">
										<input type="text" id="base_boardId" disabled="true" size="20" maxlength="30" class="txt_200"/>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key="eb.prop.boardNm"/> <em>*</em></th>
									<td class="L" colspan="3">
										<input type="text" id="base_boardNm" size="40" maxlength="100" class="txt_400 fl"/>
										<a id="base_boardNmLangBtn" href="javascript:ebUtil.getMLMngr().doShow(aBM,'abmMultiLangMngr','board',document.getElementById('base_boardId').value)" class="btn_B" ><span><util:message key="eb.title.subj"/></span></a>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key="eb.prop.boardTtl"/> <em>*</em></th>
									<td class="L" colspan="3">
										<input type="text" id="base_boardTtl" size="40" maxlength="1000" class="txt_400 fl"/>
										<a id="base_boardTtlLangBtn" href="javascript:ebUtil.getMLMngr().doShow(aBM,'abmMultiLangMngr','board',document.getElementById('base_boardId').value)" class="btn_B"><span><util:message key="eb.title.subj"/></span></a>
									</td>
								</tr>
								<tr id="baseCreateTr" name="baseCreateTr">
									<th class="L" rowspan="2"><util:message key="eb.prop.boardRid"/> <em>*</em></th>
									<td class="L" colspan="3">
										<input type="text" id="base_boardRid" size="20" disabled="true" class="txt_100 fl"/>
										<input type="text" id="base_boardRidNm" size="40" disabled="true" class="txt_200 fl"/>
										<a id="base_boardTtlLangBtn" href="javascript:aBM.getBoardChooser().doShow('base_boardRid','base_boardRidNm')" class="btn_B" ><span><util:message key="eb.title.boardChooser"/></span></a>
									</td>
								</tr>
								<tr id="baseCreateTr" name="baseCreateTr">
									<td class="L" colspan="3">
										<img src="<%=evcp%>/board/images/admin/ic_triangle.gif" width="10" align="absmiddle">
										<util:message key="eb.title.boardRid.input.virtual.board"/>
										<br><img src="<%=evcp%>/board/images/admin/ic_blank.gif" width="10" align="absmiddle">
										<util:message key="eb.title.virtual.board.thru.real"/>
									</td>
								</tr>
								<tr id="baseUpdateTr" name="baseUpdateTr">
									<th class="L"><util:message key="eb.prop.updUserId"/> <em>*</em></th>
									<td class="L"><input type="text" id="base_updUserId" disabled="true" class="txt_100"/></td>
									<th class="L"><util:message key="eb.prop.updDatim"/> <em>*</em></th>
									<td class="L"><input type="text" id="base_updDatim" disabled="true" class="txt_100"/></td>
								</tr>
								<tr>
									<td class="L" colspan="4">
										<div class="btnArea">
											<div class="leftArea">
												<a href="javascript:aBM.doSaveBase('active')" class="btn_W" id="base_activate" ><span><util:message key="eb.title.activate"/></span></a>
												<a href="javascript:aBM.doSaveBase('inactive')" class="btn_W" id="base_inactivate" ><span><util:message key="eb.title.inactivate"/></span></a>
												<a href="javascript:aBM.doBoardPreview()" class="btn_W" id="base_preview" ><span><util:message key="mm.title.preview"/></span></a>
											</div>
											<div class="rightArea">
												<a href="javascript:aBM.doCreateBoard()" class="btn_O" id="base_new" ><span><util:message key="mm.title.new"/></span></a>
												<a href="javascript:aBM.doSaveBase()" class="btn_O" id="base_save" ><span><util:message key="mm.title.save"/></span></a>
												<a href="javascript:aBM.getPasswordGetter().doShow(aBM.getDeleteBoardHandler())" class="btn_O" id="base_remove" ><span><util:message key="mm.title.remove"/></span></a>
											</div>
										</div>
										<%--게시판 삭제 시 비밀번호 미 체크 시--%>
										<!--span class="btn_pack medium" id="base_remove"><a href="javascript:aBM.getDeleteBoardHandler().processWithPassword();"><util:message key="mm.title.remove"/></a></span-->
									</td>
								</tr>
								<tr id="baseUpdateTr" name="baseUpdateTr">
									<td colspan="4" class="L">
										<img src="<%=evcp%>/board/images/admin/ic_triangle.gif" width="10" align="absmiddle">
										<util:message key="eb.title.board.move.between.category"/>
										<br><img src="<%=evcp%>/board/images/admin/ic_blank.gif" width="10" align="absmiddle">
										<util:message key="eb.title.board.copy.delete.in.category"/>
									</td>
								</tr>
								<tr id="baseUpdateTr">
									<td class="L" colspan="4" >
										<div class="btnArea">
											<div class="leftArea">
										<input type="text" id="base_trgtCateId" size="4" disabled="true" class="txt_100 fl"/>
										<input type="text" id="base_trgtCateNm" size="20" disabled="true" class="txt_200 fl"/>
										<input type="hidden" id="base_trgtCateDomainId"/>
										<a href="javascript:aBM.getCateChooser().doShow('base_trgtCateId','base_trgtCateNm','base_trgtCateDomainId')" class="btn_B" id="base_selCate" ><span><util:message key="eb.title.cateChooser"/></span></a>
											</div>
											<div class="rightArea">
												<a href="javascript:aBM.doCateBoardMove('MOVE')" class="btn_W" id="base_move" ><span><util:message key="mm.title.move"/></span></a>
												<a href="javascript:aBM.doCateBoardMove('COPY')" class="btn_W" id="base_copy" ><span><util:message key="mm.title.copy"/></span></a>
												<a href="javascript:aBM.doCateBoardMove('DELETE')" class="btn_W" id="base_delete" ><span><util:message key="mm.title.remove"/></span></a>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</form>
						<!-- abmBaseEditForm//-->
					</div>
					<div id="bltnCateMngArea" class="adgridpanel"></div>
				</div>
				<!-- abmBaseTab//-->
				<div id="abmActnTab" ></div>
				<div id="abmScrnTab" ></div>
				<div id="abmAuthTab" ></div>
				<div id="abmBojoTab" ></div>
				<div id="abmExtnTab" ></div>
				<div id="abmBltnTab" ></div>			
			</div>
			<!-- abmPropTabs//-->
		</div>
		<!-- board//-->
	</div>
	<!-- abmRight//-->
</div>
<!-- sub_contents// -->
<!-- abmBoardChooser -->
<div id="abmBoardChooser" title="<util:message key="eb.title.boardChooser"/>" style="display: table;">
	<div id="boardChooserCateTree" class="tree" style="border-right: 0px #ffffff;"></div>
	<div id="boardChooserRight" style="height:400px; display: table-cell;height:600px">
		<div style="position:absolute;top:0px;width: 740px">
		<form id="boardChooserSearchForm" name="boardChooserSearchForm" style="display:inline" method="post">
			<input type='hidden' name='pageNo' value='1'/>
			<input type='hidden' name='pageSize' value='10'/>
			<input type='hidden' name='pageFunction' value='aBM.getBoardChooser().doPage'/>
			<input type='hidden' name='formName' value='boardChooserSearchForm'/>
		</form>
		<form id="boardChooserListForm" style="display:inline" name="boardChooserListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board" >
				<caption>게시판</caption>
				<colgroup>
					<col width="30px;"/>
					<col width="100px;"/>
					<col width="*"/>
					<col width="*"/>
					<col width="100px"/>
				</colgroup>	
				<thead>
					<tr style="cursor: pointer;">
						<th>
							<input type="checkbox" id="delCheck" onclick="aBM.m_checkBox.chkAll(this)"/>
						</th>
						<th class="C" ch="0">
							<span class="table_title"><util:message key="mm.title.id"/></span>
						</th>
						<th class="C" ch="0">
							<span class="table_title"><util:message key="eb.prop.boardNm"/></span>
						</th>
						<th class="C" ch="0">
							<span class="table_title"><util:message key="eb.prop.boardTtl"/></span>
						</th>
						<th class="C" ch="0">
							<span class="table_title"><util:message key="eb.prop.board.skin"/></span>
						</th>
					</tr>
				</thead>
				<tbody id="boardChooserListBody"></tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol" >
				<!-- paging -->
				<div class="paging" id="boardChooser_PAGE_ITERATOR">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
		</form>
		</div>		 
	</div>
</div>
<!-- abmBoardChooser//-->
<div id="abmCateChooser" title="<util:message key="eb.title.cateChooser"/>">
	<div id="cateChooserCateTree" class="tree" style="border-right: 0px #ffffff;"></div>
</div>
<div id="abmPasswordGetter" title="<util:message key="eb.info.ttl.passwordGetter"/>">
	<form action="" onsubmit="aBM.getPasswordGetter().doReturnPassword();return false;">
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_board"> 
			<tr>
				<th class="L"><util:message key="eb.info.ttl.password"/></th>
				<td class="L" >
					<input type="password" id="passwordGetter_pass" size="14" class="txt_100per">
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="abmMultiLangMngr" title="<util:message key="eb.title.multiLangMngr"/>"></div>
<div id="abmRoleChooser" title="<util:message key="eb.title.roleChooser"/>"></div>
<div id="abmGroupChooser" title="<util:message key="eb.title.groupChooser"/>"></div>
<div id="abmUserChooser" title="<util:message key="eb.title.userChooser"/>"></div>
<div id="treeCtxtMenuDiv" title='<util:message key="eb.title.cate"/>'>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='aBM.onRefresh()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_refresh_tree.gif">&nbsp;<util:message key="eb.title.refresh.tree"/></a>
  </div>
  <hr>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='aBM.onCreateCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_ins_cate.gif">&nbsp;<util:message key="eb.title.ins.cate"/></a>
  </div>
  <hr>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='aBM.onUpdateCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_upd_cate.gif">&nbsp;<util:message key="eb.title.upd.cate"/></a>
  </div>
  <hr>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='aBM.onMoveUpCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_move_up.gif">&nbsp;<util:message key="eb.title.move.up"/></a>
  </div>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='aBM.onMoveDownCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_move_down.gif">&nbsp;<util:message key="eb.title.move.down"/></a>
  </div>
  <hr>
  <div onmouseover='treeCtxtMenu.onMouseOver(this)' onmouseout='treeCtxtMenu.onMouseOut(this)' style="border:none; cursor:hand">
    <a onclick='aBM.onDeleteCate()'><img src="<%=evcp%>/board/images/admin/ctxt_menu_del_cate.gif">&nbsp;<util:message key="eb.title.del.cate"/></a>
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
<iframe id="AdmBoardMngr.FileExportArea" src="" width="100" height="0" style="display:none"></iframe>
<form name="setRead" method="post" target="_read" style="diplay:inline">
	<input type="hidden" name="boardId"/>
	<input type="hidden" name="bltnNo"/>
	<input type="hidden" name="cmd"/>
</form>

<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript">
AdmBoardMngr = function() {
	//var offset = location.href.indexOf (location.host) + location.host.length;
	//this.m_contextPath = location.href.substring (offset, location.href.indexOf('/', offset + 1));
	this.m_isAdm = '<c:out value="${sessionScope._enview_user_info_.hasAdminRole}"/>';
	this.m_isMngr = '<c:out value="${sessionScope._enview_user_info_.hasManagerRole}"/>';
	this.m_isDomMngr = '<c:out value="${sessionScope._enview_user_info_.hasDomainManagerRole}"/>';
	this.m_usrDomId = '<c:out value="${sessionScope._user_domain_.domainId}"/>';
	this.m_contextPath = portalPage.getContextPath();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = new enview.util.PageNavigationUtil();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_boardChooser = new BoardChooser(this);
	this.m_cateChooser = new CateChooser(this);
	this.m_passwordGetter = new PasswordGetter(this);
	//this.m_deleteBoardHandler = new this.doDeleteBoardHandler();
	//this.m_bltnCateMngr = new BltnCateMngr(this);
	//this.m_multiLangMngr = new MultiLangMngr(this);
	//this.m_actnMngr = new ActnMngr(this);
	//this.m_scrnMngr = new ScrnMngr(this);
	//this.m_authMngr = new AuthMngr(this);
	//this.m_bojoMngr = new BojoMngr(this);
	//this.m_extnMngr = new ExtnMngr(this);
	//this.m_bltnMngr = new BltnMngr(this);
	//this.m_roleChooser = new RoleChooser(this);
	//this.m_groupChooser = new GroupChooser(this);
	//this.m_userChooser = new UserChooser(this);
	//this.m_previewPane = document.getElementById("Abm_PreviewPane");
	//enviewMessageBox = new enview.portal.MessageBox(200, 100, 2500); 
	
	this.init();
}
AdmBoardMngr.prototype = {
	m_isAdm : null,
	m_isMngr : null,
	m_isDomMngr : null,
	m_usrDomId : null,
	m_resDomId : null,
	m_ajax : null,
	m_pageNavi : null,
	m_tree : null,
	m_contextPath : null,
	m_checkBox : null,
	m_msgBox : null,
	m_cateTreeCtxtMenu : null,
	m_boardChooser : null,
	m_cateChooser : null,
	m_passwordGetter : null,
	m_deleteBoardHandler : null,
	m_bltnCateMngr : null,
	//m_multiLangMngr : null,
	m_actnMngr : null,
	m_scrnMngr : null,
	m_authMngr : null,
	m_bojoMngr : null,
	m_extnMngr : null,
	m_bltnMngr : null,
	m_roleChooser : null,
	m_groupChooser : null,
	m_userChooser : null,
	m_selectRowIndex : -1,
	m_dhtmlxContextMenu : null,

	init : function (node) {
		this.m_cateTreeCtxtMenu = treeCtxtMenu = new ContextMenu(this.m_contextPath);
		this.m_dhtmlxContextMenu = new dhtmlXMenuObject();
		this.m_dhtmlxContextMenu.renderAsContextMenu();
		this.m_dhtmlxContextMenu.attachEvent("onClick",this.onDhtmlxContextClick);
		this.m_dhtmlxContextMenu.loadFromHTML("dhtmlx_context_data", true);
		this.m_tree = new dhtmlXTreeObject (document.getElementById('abmCateTree'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler (this.onNodeSelect);
		this.m_tree.enableDragAndDrop (true)
		this.m_tree.setDragHandler (this.onNodeDrag);
		this.m_tree.setDropHandler (this.onNodeDrop);
		//this.m_tree.setOnRightClickHandler (this.onContextMenuHandler);
		this.m_tree.enableContextMenu(this.m_dhtmlxContextMenu);
		this.m_tree.attachEvent("onBeforeContextMenu", function (id) {
			aBM.onNodeSelect( id );
			aBM.m_cateTreeCtxtMenu.setItemId( id );
			return true;
		});
		this.m_tree.enableAutoTooltips (true);
		//this.m_tree.setChildCalcMode (true);
		//this.m_tree.enableItemEditor (true);
		//this.m_tree.setOnEditHandler (this.onEditHandler);
		//this.m_tree.enableKeyboardNavigation (true);
		this.m_tree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=catebaseTree"); 
		this.m_tree.load (this.m_contextPath+"/board/adCate.brd?m=catebaseTree&id=1&act=root");
		
		$(function() {
			$("#abmPropTabs").tabs();
			$("#cateTabs").tabs();
		});
	},
	isAble2Save : function () {
		return (aBM.m_isAdm == 'true' || aBM.m_isMngr == 'true' || (aBM.m_isDomMngr == 'true' && aBM.m_resDomId == aBM.m_usrDomId));
	},
	onContextMenuHandler : function (treeitemId, item) {
		aBM.m_resDomId = aBM.m_tree.getUserData (treeitemId,"domainId");
		aBM.doShowContextMenu( treeitemId, item );
	},
	onCreateCate : function () {
		treeCtxtMenu.hide();
		aBM.doCreateCate (treeCtxtMenu.getItemId());
	},
	onRefresh : function () {
		treeCtxtMenu.hide();
		aBM.m_tree.refreshItem (treeCtxtMenu.getItemId());
	},
	onDeleteCate : function() {
		if( confirm (ebUtil.getMessage("ev.info.remove"))) {
			treeCtxtMenu.hide();
			aBM.doDeleteCate(treeCtxtMenu.getItemId());
		}
		return false;
	},
	onUpdateCate : function() {
		treeCtxtMenu.hide();
		aBM.doUpdateCate (treeCtxtMenu.getItemId());
	},
	onMoveUpCate : function() {
		treeCtxtMenu.hide();
		aBM.onNodeDrop (treeCtxtMenu.getItemId(), "U" );
	},
	onMoveDownCate : function() {
		treeCtxtMenu.hide();
		aBM.onNodeDrop (treeCtxtMenu.getItemId(), "D" );
	},
	onNodeDrag : function (dragId, dropId) {
		var dragDomId = aBM.m_tree.getUserData (dragId, "domainId");
		var dropDomId = aBM.m_tree.getUserData (dropId, "domainId");
		if (dragDomId == dropDomId) {
			if (!(aBM.m_isAdm == 'true' || aBM.m_isMngr == 'true') && (dropId == "1" || dragDomId != aBM.m_usrDomId)) return false; <%--도메인관리자는 ROOT 노드에 또는 자기 도메인에 속한 카테고리를 DnD 할 수 없다.--%>
			return true; <%--기본적으로 도메인이 같아야 이동할 수 있다.--%>
		} else {
			if ((aBM.m_isAdm == 'true' || aBM.m_isMngr == 'true') && dropId == "1") return true; <%--관리자/중간관리자는 ROOT 노드에 DnD 할 수 있다.--%>
			return false; <%--도메인이 틀리면 이동할 수 없다.--%>
		}
	},
	onNodeDrop : function (dragId, dropId) {
		aBM.doMoveCate (dragId, dropId);
	},
	onNodeSelect : function (id) {
		$("#cateTabs").tabs('select', 0);

		aBM.m_resDomId = aBM.m_tree.getUserData (id,"domainId");

		var srchForm = document.getElementById("abmSearchForm");
		srchForm.pageNo.value = 1;
		document.getElementById("cate_cateId").disabled = false;
		document.getElementById("cate_cateId").value = id;
		document.getElementById("cate_cateId").disabled = true;
		if (document.getElementById("cate_domainId")) {
			document.getElementById("cate_domainId").disabled = false;
			ebUtil.setSelectedValue (document.getElementById("cate_domainId"), aBM.m_tree.getUserData (id, "domainId"));
			document.getElementById("cate_domainId").disabled = true;
		}
		document.getElementById("cate_cateNm").disabled = false;
		document.getElementById("cate_cateNm").value = aBM.m_tree.getSelectedItemText();
		document.getElementById("cate_cateNm").disabled = true;
		document.getElementById("cate_btnSave").style.display = "none";
		
		aBM.m_tree.selectItem(id,false,true);
		aBM.doRetrieve();
	},
	onSelectCateTabs : function( id ) {
		if (id == 2) {
			document.getElementById("abmCateLangTab").style.display = "";
			document.getElementById("abmCateLangEditPage").style.display = "none";
			aBM.doRetrieveCateLang();
			if (aBM.isAble2Save() == true) {
				document.getElementById("cateLang_new").style.display = "";
				document.getElementById("cateLang_remove").style.display = "";
			} else {
				document.getElementById("cateLang_new").style.display = "none";
				document.getElementById("cateLang_remove").style.display = "none";
			}
		}
	},
	doShowContextMenu : function( id, item ) {
		/* if (id != "1" && aBM.isAble2Save() == false) return;
		var pos = (new enview.util.Utility()).getAbsolutePosition( item );
		aBM.onNodeSelect( id );
		this.m_cateTreeCtxtMenu.setItemId( id );
		this.m_cateTreeCtxtMenu.show( pos.getX()+45, pos.getY()+20 ); */
	},
	onDhtmlxContextClick : function (menuitemId, type) {
		if (menuitemId == "onRefresh") {
			aBM.onRefresh();
		} else if (menuitemId == "onCreate") {
			aBM.onCreateCate();
		} else if (menuitemId == "onMoveUp") {
			aBM.onMoveUpCate();
		} else if (menuitemId == "onMoveDown") {
			aBM.onMoveDownCate();
		} else if (menuitemId == "onModify") {
			aBM.onUpdateCate();
		} else if (menuitemId == "onDelete") {
			aBM.onDeleteCate();
		}
	},
	doPage : function (formName, pageNo) {
		aBM.m_selectRowIndex = 0;
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		aBM.doRetrieve();
	},
	doRetrieve : function () {
		var param = "m=cateBoard";

		var formElem = document.forms["abmSearchForm"];
		for( var i=0; i<formElem.elements.length; i++ ) {
			param += "&" + formElem.elements[i].name + "=";
			var tmp = formElem.elements[i].value;
			if( tmp.lastIndexOf("*") > 0 ) {
				param += "";
			} else {
				param += encodeURIComponent( tmp );
			}
	    }
		param += "&cateId=" + this.m_tree.getSelectedItemId();
		this.m_ajax.send("POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aBM.doRetrieveHandler(data); }});
	},
	
	doSort : function ( sortColumn) {
		var param = "m=cateBoard";
		var formElem = document.forms["abmSearchForm"];
		var prevSortColumn =  formElem.elements["sortColumn"].value;
		if( sortColumn == prevSortColumn) {
			if( formElem.elements["sortMethod"].value=='ASC') {
				formElem.elements["sortMethod"].value='DESC';
			} else {
				formElem.elements["sortMethod"].value='ASC';
			}
		} else {
			formElem.elements["sortColumn"].value=sortColumn;
			formElem.elements["sortMethod"].value='ASC';
		}
		for (var i=0; i<formElem.elements.length; i++) {
			param += "&" + formElem.elements[i].name + "=";
			var tmp = formElem.elements[i].value;
			if (tmp.lastIndexOf("*") > 0) {
				param += "";
			} else {
				param += encodeURIComponent(tmp);
			}
	    }
		param += "&cateId=" + this.m_tree.getSelectedItemId();
		this.m_ajax.send("POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aBM.doRetrieveHandler(data); }});
	},
	
	doRetrieveHandler : function (data) {
		var bodyElem = document.getElementById ('abmListBody');
	    var tagTR = null;
	    var tagTD = null;

		this.m_checkBox.unChkAll (document.getElementById ("abmListForm"));
		for (; bodyElem.hasChildNodes(); )
			bodyElem.removeChild (bodyElem.childNodes[0]);

		// 상단 게시판 목록을 뿌리는 부분
		/*
		for (i=0; i<data.Data.length; i++) {
			tagTR = document.createElement('tr');
			tagTR.id = "boardList"+i;
			tagTR.onmouseover = new Function ("ebUtil.activeLine(this,true)");
			tagTR.onmouseout = new Function ("ebUtil.activeLine(this,false)");
			tagTR.setAttribute ("ch", i);
			tagTR.setAttribute ("style", "cursor:pointer;");
			if (i % 2 == 1) {
				tagTR.setAttribute("class", "adgridline");
				tagTR.setAttribute("className", "adgridline");
			}
			
			tagTD = document.createElement('td');
			tagTD.align = "center";
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.innerHTML = "<input type='checkbox' id='boardList"+i+"_checkRow' class='webcheckbox'/>";
			tagTD.innerHTML += "<input type='hidden' id='boardList"+i+"_boardId' value='" + data.Data[i].boardId + "'/>";
		 	tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.align = "left";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = "<span id='boardList"+i+"_boardId_label'>" + data.Data[i].boardId + "</span>";
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.align = "left";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = "<span id='boardList"+i+"_boardNm_label'>" + data.Data[i].boardNm + "</span>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.align = "left";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = "<span id='boardList"+i+"_boardTtl_label'>" + data.Data[i].boardTtl + "</span>";
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.align = "left";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = "<span style='width:100%;' id='boardList"+i+"_boardSkin_label'>" + data.Data[i].boardSkin + "</span>";
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgridlast");
			tagTD.setAttribute("className", "adgridlast");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.align = "center";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = "<span style='width:100%;' id='boardList"+i+"_boardActive_label'>" + data.Data[i].boardActive + "</span>";
			tagTR.appendChild( tagTD );

			bodyElem.appendChild (tagTR);
		}
		*/
		// 상단 게시판 목록을 뿌리는 부분
		for (i=0; i<data.Data.length; i++) {
			tagTR = document.createElement('tr');
			tagTR.id = "boardList"+i;
			//tagTR.onmouseover = new Function ("ebUtil.activeLine(this,true)");
			//tagTR.onmouseout = new Function ("ebUtil.activeLine(this,false)");
			tagTR.setAttribute ("ch", i);
			tagTR.setAttribute ("style", "cursor:pointer;");
			/* if (i % 2 == 1) {
				tagTR.setAttribute("class", "adgridline");
				tagTR.setAttribute("className", "adgridline");
			} */
			
			tagTD = document.createElement('td');
			//tagTD.align = "center";
			tagTD.setAttribute("class", "C fixed");
			tagTD.setAttribute("className", "C fixed");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.innerHTML = "<input type='checkbox' id='boardList"+i+"_checkRow'/>";
			tagTD.innerHTML += "<input type='hidden' id='boardList"+i+"_boardId' value='" + data.Data[i].boardId + "'/>";
		 	tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.id = "boardList"+i+"_boardId_label";
			tagTD.setAttribute("class", "L");
			tagTD.setAttribute("className", "L");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = data.Data[i].boardId;
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.id = "boardList"+i+"_boardNm_label";
			tagTD.setAttribute("class", "L");
			tagTD.setAttribute("className", "L");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = data.Data[i].boardNm;
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.id = "boardList"+i+"_boardTtl_label";
			tagTD.setAttribute("class", "L");
			tagTD.setAttribute("className", "L");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = data.Data[i].boardTtl;
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.id = "boardList"+i+"_boardSkin_label";
			tagTD.setAttribute("class", "L");
			tagTD.setAttribute("className", "L");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = data.Data[i].boardSkin;
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.id = "boardList"+i+"_boardActive_label";
			tagTD.setAttribute("class", "C");
			tagTD.setAttribute("className", "C");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.onclick = new Function( "aBM.doSelect(this)" );
			tagTD.innerHTML = data.Data[i].boardActive;
			tagTR.appendChild( tagTD );

			bodyElem.appendChild (tagTR);
		}
		/*
		tagTR = document.createElement( 'tr' );
		tagTD = document.createElement( 'td' );
		tagTD.height = "2";
		tagTD.colSpan = "6";
		tagTD.setAttribute("class", "adgridlimit");
		tagTD.setAttribute("className", "adgridlimit");
		tagTR.appendChild( tagTD );
		bodyElem.appendChild (tagTR);
		*/
		
		if (data.Data.length == 0) {
			//alert("not found");
			tagTR = document.createElement('tr');
			tagTD = document.createElement('td');
			tagTD.colSpan = "6";
			tagTD.setAttribute("class", "C");
			tagTD.innerHTML = ebUtil.getMessage("ev.info.notFoundData");
			tagTR.appendChild (tagTD);
			bodyElem.appendChild (tagTR);
		} else {
			/* tagTR = document.createElement ('tr');
			tagTD = document.createElement ('td');
			tagTD.height = "22";
			tagTD.colSpan = "5";
			tagTD.innerHTML = "<span>"+ebUtil.getMessage("ev.info.resultSize", data.TotalSize)+"</span>";   
			tagTR.appendChild (tagTD);
			bodyElem.appendChild (tagTR); */
		}
		//document.getElementById("ABM_PAGE_ITERATOR").innerHTML = data.PortletIterator;
		var formElem = document.forms[ "abmSearchForm" ];
		var pageNo = formElem.elements[ "pageNo" ].value;
		var pageSize = formElem.elements[ "pageSize" ].value;
		var pageFunction = formElem.elements[ "pageFunction" ].value;
		var formName = formElem.elements[ "formName" ].value;
		
		document.getElementById("ABM_PAGE_ITERATOR").innerHTML = this.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, data.TotalSize, formName, pageFunction);
		
		if (data.Data.length > 0) {
			this.m_selectRowIndex = 0;
			aBM.doDefaultSelect();
		} else {
			this.m_selectRowIndex = -1;
		//	var tabId = $("#abmPropTabs").tabs('option', 'selected');
			var tabId = $("#abmPropTabs").tabs('option', 'active');
			aBM.doSelectTab( tabId );
		}
	},
	doDefaultSelect : function () {
		document.getElementById("abmBaseDiv").style.display = "";
		if( document.getElementById('boardList'+this.m_selectRowIndex+'_checkRow') ) {
		    document.getElementById('boardList'+this.m_selectRowIndex+'_checkRow').checked = true;
		}
	//	var tabId = $("#abmPropTabs").tabs('option', 'selected');
		var tabId = $("#abmPropTabs").tabs('option', 'active');
		aBM.doSelectTab( tabId );		
	},
	doSelect : function( obj ) {
		this.m_selectRowIndex = obj.parentNode.getAttribute("ch");
		this.m_checkBox.unChkAll( document.getElementById("abmListForm"));
		document.getElementById('boardList'+this.m_selectRowIndex+'_checkRow').checked = true;

	//	var tabId = $("#abmPropTabs").tabs('option', 'selected');
		var tabId = $("#abmPropTabs").tabs('option', 'active');
		aBM.doSelectTab( tabId );
	},
	doSelectTab : function( tabId ) {
		if( this.m_selectRowIndex < 0 ) {
			switch( tabId ) {
				case 0:	
					if(this.m_tree.getSelectedItemId() == "1") {
						document.getElementById("abmBaseDiv").style.display = "none"; <%--root node에는 아무런 행위를 할 수 없음--%>
					} else {
						if (aBM.isAble2Save()) aBM.doCreateBoard();
						else document.getElementById("abmBaseDiv").style.display = "none"; <%--도메인관리자는 다른 도메인 밑에서는 아무런 행위를 할 수 없음--%>
					}
					break;
				case 1:	aBM.getActnMngr().doClear(); break;
				case 2:	aBM.getScrnMngr().doClear(); break;
				case 3:	aBM.getAuthMngr().doClear(); break;
				case 4:	aBM.getBojoMngr().doClear(); break;
				case 5:	aBM.getExtnMngr().doClear(); break;
				case 6:	aBM.getBltnMngr().doClear(); break;
			}
			return;
		}
		var boardId = document.getElementById("boardList"+this.m_selectRowIndex+"_boardId").value;
		switch( tabId ) {
			case 0:	
				var param = "m=boardBasic";
				param += "&boardId=" + boardId;
				this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, { success: function(data) { aBM.doInitBase( data )}});
				break;
			case 1:	aBM.getActnMngr().doGet( boardId ); break;
			case 2:	aBM.getScrnMngr().doGet( boardId ); break;
			case 3:	aBM.getAuthMngr().doGet( boardId ); break;
			case 4:	aBM.getBojoMngr().doGet( boardId ); break;
			case 5:	aBM.getExtnMngr().doGet( boardId ); break;
			case 6:	aBM.getBltnMngr().doGet( boardId ); break;
		}
	},
	doInitBase : function( data ) {
		document.getElementById("base_act").value        = "upd";
		document.getElementById("base_boardId").value    = data.Data.boardId;
		document.getElementById("base_boardId").disabled = true;
		aBM.m_resDomId = data.Data.domainId;
		document.getElementById("base_boardNm").value    = data.Data.boardNm;
		document.getElementById("base_boardTtl").value   = data.Data.boardTtl;
		document.getElementById("base_updUserId").value  = data.Data.updUserId;
		document.getElementById("base_updDatim").value   = data.Data.updDatim;
		if (aBM.isAble2Save()) {
			document.getElementById("base_boardNmLangBtn").style.display = "";
			document.getElementById("base_boardTtlLangBtn").style.display = "";
		} else {
			document.getElementById("base_boardNmLangBtn").style.display = "none";
			document.getElementById("base_boardTtlLangBtn").style.display = "none";
		}
		var trs = document.getElementsByName("baseCreateTr");
		for( var i=0; i<trs.length; i++ ) {
			trs[i].style.display = "none";
		}
		trs = document.getElementsByName("baseUpdateTr");
		for( var i=0; i<trs.length; i++ ) {
			if (aBM.isAble2Save()) trs[i].style.display = "";
			else trs[i].style.display = "none"
		}

		aBM.getBltnCateMngr().doGet( data.Data.boardId );
		if( data.Data.boardActive == 'Y') {
			document.getElementById("base_activate").style.display  = 'none';
			document.getElementById("base_inactivate").style.display = 'inline-block';
		}  else {
			document.getElementById("base_activate").style.display  = 'inline-block';
			document.getElementById("base_inactivate").style.display = 'none';
		}
		
		document.getElementById("base_preview").style.display = "";
		
		

		if (aBM.isAble2Save()) {
//			document.getElementById("base_activate").style.display = "";
//			document.getElementById("base_inactivate").style.display = "";
			document.getElementById("base_new").style.display = "";
			document.getElementById("base_save").style.display = "";
			document.getElementById("base_remove").style.display = "";
		} else {
			document.getElementById("base_activate").style.display = "none";
			document.getElementById("base_inactivate").style.display = "none";
			document.getElementById("base_new").style.display = "none";
			document.getElementById("base_save").style.display = "none";
			document.getElementById("base_remove").style.display = "none";
		}
		document.getElementById("bltnCateMngArea").style.display = "";
	},
	doCreateCate : function (itemId) {
		document.getElementById("cate_act").value = "ins";
		document.getElementById("cate_cateId").value = '<util:message key="eb.title.dont.need.input"/>';
		if (document.getElementById("cate_domainId")) {
			if (aBM.m_tree.getSelectedItemId() == "1") {
				document.getElementById("cate_domainId").disabled = false;
				ebUtil.setSelectedValue (document.getElementById("cate_domainId"), "0");
			} else {
				document.getElementById("cate_domainId").disabled = false;
				ebUtil.setSelectedValue (document.getElementById("cate_domainId"), aBM.m_tree.getUserData(itemId, "domainId"));
				document.getElementById("cate_domainId").disabled = true;
			}
		}
		document.getElementById("cate_cateNm").value = "";
		document.getElementById("cate_cateNm").disabled = false;
		document.getElementById("cate_btnSave").style.display = "";
		document.getElementById("cate_cateNm").focus();
	},
	doUpdateCate : function ( itemId ) {
		document.getElementById("cate_act").value = "upd";
		if (document.getElementById("cate_domainId")) document.getElementById("cate_domainId").disabled = true;
		document.getElementById("cate_cateNm").disabled = false;
		document.getElementById("cate_btnSave").style.display = "";
		document.getElementById("cate_cateNm").focus();
	},
	doDeleteCate : function ( itemId ) {
		document.getElementById("cate_act").value = "del";
		aBM.doSaveCate();
	},
	doMoveCate : function( dragId, dropId ) {
		var param = "m=setCatebaseMove";

		param += "&dragId=" + dragId;
		param += "&dropId=" + dropId;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aBM.doMoveCateHandler( data ); }});
	},
	doMoveCateHandler : function( data ) {
		aBM.getMsgBox().doShow( ebUtil.getMessage("mm.info.move.success"));
		//aBM.m_cateTreeCtxtMenu.hide();
		this.m_tree.refreshItem( data.refreshId );
		this.m_tree.selectItem ( data.refreshId, true, false );
		this.m_tree.openItem   ( data.refreshId );
		//aBM.onNodeSelect( data.refreshId );
	},
	doSaveCate : function() {
		if (!ebUtil.chkValue (document.getElementById("cate_cateNm"), '<util:message key="eb.title.o.cateNm"/>', 'true' )) return;
		if (document.getElementById("cate_domainId")) {
			if (!ebUtil.chkSelect (document.getElementById("cate_domainId"), 0, '<util:message key="mm.title.o.domainId"/>', 'true')) return;
		}
		var param = "m=setCatebase";
		param += "&act=" + document.getElementById("cate_act").value;
		param += "&cateId=" + aBM.m_tree.getSelectedItemId();
		if (document.getElementById("cate_domainId")) param += "&domainId=" + ebUtil.getSelectedValue (document.getElementById("cate_domainId"));
		param += "&cateNm=" + encodeURIComponent( document.getElementById("cate_cateNm").value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aBM.doSaveCateHandler( data ); }});
	},
	doSaveCateHandler : function( data ) {
		var act = document.getElementById("cate_act").value;
		if( act == "ins" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.remove"));
		}
		//aBM.m_cateTreeCtxtMenu.hide();
		var refreshId = data.refreshId;
		this.m_tree.refreshItem( data.refreshId );
		this.m_tree.selectItem ( data.refreshId, true, false );
		this.m_tree.openItem   ( data.refreshId );
		//aBM.onNodeSelect( data.refreshId );
	},
	doRetrieveCateLang : function () {
		var param = "m=catebaseLangList";
		param += "&cateId=" + document.getElementById("cate_cateId").value;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aBM.doRetrieveCateLangHandler( data ); }});
	},
	doRetrieveCateLangHandler : function( data ) {
		var bodyElem = document.getElementById ('abmCateLangListBody');
	    var tagTR = null;
	    var tagTD = null;

		this.m_checkBox.unChkAll( document.getElementById( "abmCateLangListForm"));
		for (; bodyElem.hasChildNodes(); )
			bodyElem.removeChild (bodyElem.childNodes[0]);
		if( data.Data.length > 0 ) {
			document.getElementById("cateLangList_cateId").value = data.Data[0].cateId;
		}
		for( i=0; i<data.Data.length; i++ ) {
			tagTR = document.createElement( 'tr' );
			tagTR.id = "cateLangList"+i;
		//	tagTR.onmouseover = new Function( "ebUtil.activeLine(this,true)" );
		//	tagTR.onmouseout = new Function( "ebUtil.activeLine(this,false)" );
			tagTR.setAttribute ("ch", i);
			tagTR.setAttribute ("style", "cursor:pointer;");
			if (i % 2 == 1) {
				tagTR.setAttribute("class", "adgridline");
				tagTR.setAttribute("className", "adgridline");
			}
			
			tagTD = document.createElement( 'td' );
			tagTD.align = "center";
			tagTD.setAttribute( "class", "adgrid" );
			tagTD.setAttribute( "className", "adgrid" );
			tagTD.innerHTML = "<input type='checkbox' id='cateLangList_checkRow' name='cateLangList_checkRow' value='"+data.Data[i].langKnd+"' class='webcheckbox'/>";
		 	tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute( "class", "adgrid" );
			tagTD.setAttribute( "className", "adgrid" );
			tagTD.align = "left";
			if (aBM.isAble2Save() == true) tagTD.onclick = new Function( "aBM.doSelectCateLang('"+data.Data[i].langKnd+"','"+data.Data[i].cateNm+"')" );
			tagTD.innerHTML = "<span id='cateLangList"+i+".langKnd.label'>" + data.Data[i].langKnd + "</span>";
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			tagTD.align = "left";
			if (aBM.isAble2Save() == true) tagTD.onclick = new Function( "aBM.doSelectCateLang('"+data.Data[i].langKnd+"','"+data.Data[i].cateNm+"')" );
			tagTD.innerHTML = "<span id='cateLangList"+i+".cateNm.label'>" + data.Data[i].cateNm + "</span>";
			tagTR.appendChild( tagTD );

			bodyElem.appendChild (tagTR);
		}
		tagTR = document.createElement( 'tr' );
		tagTD = document.createElement( 'td' );
		tagTD.height = "2";
		tagTD.colSpan = "3";
		tagTD.setAttribute("class", "adgridlimit");
		tagTD.setAttribute("className", "adgridlimit");
		tagTR.appendChild( tagTD );
		bodyElem.appendChild (tagTR);
	},
	doCreateCateLang : function() {
		document.getElementById("abmCateLangEditPage").style.display = "";
		document.getElementById("cateLang_act").value = "ins"; 
		document.getElementById("cateLang_cateId").value = this.m_tree.getSelectedItemId();
		document.getElementById("cateLang_langKnd").disabled = false;
		document.getElementById("cateLang_langKnd").value = "";
		document.getElementById("cateLang_cateNm").value = "";
		document.getElementById("cateLang_langKnd").focus();
	},
	doSelectCateLang : function( langKnd, cateNm ) {
		document.getElementById("abmCateLangEditPage").style.display = "";
		document.getElementById("cateLang_act").value = "upd"; 
		document.getElementById("cateLang_cateId").value = this.m_tree.getSelectedItemId();
		document.getElementById("cateLang_langKnd").value = langKnd;
		document.getElementById("cateLang_langKnd").disabled = true;
		document.getElementById("cateLang_cateNm").value = cateNm;
		document.getElementById("cateLang_cateNm").focus();
	},
	doDeleteCateLang : function() {
		document.getElementById("cateLang_act").value = "del"; 
		if( !ebUtil.chkCheck( document.getElementsByName("cateLangList_checkRow"), '<util:message key="eb.title.o.lang"/>', true )) return;

		var param = "m=setCatebaseLang";
		param += "&act=" + document.getElementById("cateLang_act").value;
		param += "&cateId=" + document.getElementById("cateLangList_cateId").value;
		param += "&langKnd=" + ebUtil.getCheckedValues( document.getElementsByName("cateLangList_checkRow"));
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aBM.doSaveCateLangHandler( data ); }});
	},
	doSaveCateLang : function() {
		if( "ins" == document.getElementById("cateLang_act")) {
			if( !ebUtil.chkSelect( document.getElementById("cateLang_langKnd"), 1, '<util:message key="eb.title.o.lang"/>', 'true')) return;
		}
		if( !ebUtil.chkValue( document.getElementById("cateLang_cateNm"), '<util:message key="eb.title.o.cateNm"/>', 'true')) return;
		
		var param = "m=setCatebaseLang";
		param += "&act=" + document.getElementById("cateLang_act").value;
		param += "&cateId=" + document.getElementById("cateLang_cateId").value;
		param += "&langKnd=" + ebUtil.getSelectedValue( document.getElementById("cateLang_langKnd"));
		param += "&cateNm=" + encodeURIComponent( document.getElementById("cateLang_cateNm").value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aBM.doSaveCateLangHandler( data ); }});
	},
	doSaveCateLangHandler : function( data ) {
		var act = document.getElementById("cateLang_act").value;
		if( act == "ins" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else if( act == "del" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.remove"));
		}
		document.getElementById("abmCateLangEditPage").style.display = "none";
		aBM.doRetrieveCateLang();
	},
	doCreateBoard : function() {
		document.getElementById("abmBaseDiv").style.display = "";
		this.m_selectRowIndex = -1;
		this.m_checkBox.unChkAll( document.getElementById( "abmListForm"));
		document.getElementById("base_act").value = "ins";
		document.getElementById("base_boardId").value = "";
		document.getElementById("base_boardId").disabled = false;
		aBM.m_resDomId = aBM.m_tree.getUserData(aBM.m_tree.getSelectedItemId(),"domainId");
		document.getElementById("base_boardNm").value = "";
		document.getElementById("base_boardTtl").value = "";
		document.getElementById("base_updUserId").value = "";
		document.getElementById("base_updDatim").value = "";
		document.getElementById("base_boardRid").value = "";
		document.getElementById("base_boardRidNm").value = "";
		document.getElementById("base_boardNmLangBtn").style.display = "none";
		document.getElementById("base_boardTtlLangBtn").style.display = "none";

		var trs = document.getElementsByName("baseCreateTr");
		for( i=0; i<trs.length; i++ ) {
			trs[i].style.display = "";
		}
		trs = document.getElementsByName("baseUpdateTr");
		for( i=0; i<trs.length; i++ ) {
			trs[i].style.display = "none";
		}
		document.getElementById("bltnCateMngArea").style.display = "none";
		document.getElementById("base_activate").style.display = "none";
		document.getElementById("base_inactivate").style.display = "none"
		document.getElementById("base_preview").style.display = "none"
		document.getElementById("base_new").style.display = "none"
		document.getElementById("base_remove").style.display = "none"
		//document.getElementById("base_boardId").focus();
	},
	doSaveBase : function( act ) {
		if( act == null || act.length == 0 ) {
			act = document.getElementById("base_act").value;
		} else {
			document.getElementById("base_act").value = act;
		}
		var param = "";
		
		if( act == "ins" ) {
			if (!ebUtil.chkValue( document.getElementById("base_boardId"), '<util:message key="eb.title.o.boardId"/>', 'true')) return;
			if( !ebUtil.chkTableName( document.getElementById("base_boardId"), '<util:message key="eb.title.p.boardId"/>', 'true')) return;
			if( !ebUtil.chkValue( document.getElementById("base_boardNm"), '<util:message key="eb.title.o.boardNm"/>', 'true')) return;
			if( !ebUtil.chkValue( document.getElementById("base_boardTtl"), '<util:message key="eb.title.o.boardTtl"/>', 'true')) return;
			if( !confirm( ebUtil.getMessage('eb.info.confirm.create.board', aBM.m_tree.getSelectedItemText()))) return;
			param += "m=boardCreate";
			param += "&act=" + act;
			param += "&cateId=" + aBM.m_tree.getSelectedItemId();
			param += "&boardId=" + document.getElementById("base_boardId").value;
			param += "&boardNm=" + encodeURIComponent( document.getElementById("base_boardNm").value);
			param += "&boardTtl=" + encodeURIComponent( document.getElementById("base_boardTtl").value);
			param += "&boardRid=" + document.getElementById("base_boardRid").value;
		} else if( act == "upd" ) {
			if( !ebUtil.chkValue( document.getElementById("base_boardNm"), '<util:message key="eb.title.o.boardNm"/>', 'true')) return;
			if( !ebUtil.chkValue( document.getElementById("base_boardTtl"), '<util:message key="eb.title.o.boardTtl"/>', 'true')) return;
			param += "m=setBoardLang";
			param += "&act=" + act;
			param += "&boardId=" + document.getElementById("base_boardId").value;
			param += "&boardNm=" + encodeURIComponent( document.getElementById("base_boardNm").value);
			param += "&boardTtl=" + encodeURIComponent( document.getElementById("base_boardTtl").value);
		} else if( act == "active" ) {
			if (!ebUtil.chkValue( document.getElementById("base_boardId"), '<util:message key="eb.title.o.boardId"/>', 'true')) return;
			if( !confirm( ebUtil.getMessage('eb.info.confirm.active'))) return;
			param += "m=setBoardBase";
			param += "&act=" + act;
			param += "&boardId=" + document.getElementById("base_boardId").value;
		} else if( act == "inactive" ) {
			if (!ebUtil.chkValue( document.getElementById("base_boardId"), '<util:message key="eb.title.o.boardId"/>', 'true')) return;
			if( !confirm( ebUtil.getMessage('eb.info.confirm.inactive', aBM.m_tree.getSelectedItemText()))) return;
			param += "m=setBoardBase";
			param += "&act=" + act;
			param += "&boardId=" + document.getElementById("base_boardId").value;
		} else
			return;
		
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.doSaveBaseHandler( data ); }});
	},
	doSaveBaseHandler : function( data ) {
		var act = document.getElementById("base_act").value;
		if( act == "ins" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" || act == "active" || act == "inactive" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		}
		aBM.doRetrieve();
	},
	doCateBoardMove : function( act ) {
		document.getElementById("base_act").value = act;
		var objTrgtCateId = document.getElementById("base_trgtCateId");
		var objSelCate    = document.getElementById("base_selCate");
		if( document.getElementById("base_boardId").value.length == 0 ) {
			alert( ebUtil.getMessage('eb.info.board.notSelect'));
			objSelCate.focus();
			return;
		}
		var trgtCateDomainId = document.getElementById("base_trgtCateDomainId").value;
		var selCateDomainId  = aBM.m_tree.getUserData(aBM.m_tree.getSelectedItemId(), "domainId");
		if ("MOVE" == act) {
			if (objTrgtCateId.value.length == 0) {
				alert (ebUtil.getMessage('eb.info.select.move.trgtCate'));
				objSelCate.focus();
				return;
			}
			if (objTrgtCateId.value == aBM.m_tree.getSelectedItemId()) {
				alert (ebUtil.getMessage('eb.info.sameCate'));
				objSelCate.focus();
				return;
			}
			if (selCateDomainId != trgtCateDomainId) {
				alert (ebUtil.getMessage('eb.info.cant.move.board.domain'));
				objSelCate.focus();
				return;
			}
			if(!confirm( ebUtil.getMessage('eb.info.confirm.move'))) return;
			
		} else if( "COPY" == act ) {
			if( objTrgtCateId.value.length == 0 ) {
				alert( ebUtil.getMessage('eb.info.select.copy.trgtCate'));
				objSelCate.focus();
				return;
			}
			if ( objTrgtCateId.value == aBM.m_tree.getSelectedItemId()) {
				alert( ebUtil.getMessage('eb.info.sameCate'));
				objSelCate.focus();
				return;
			}
			if (selCateDomainId != trgtCateDomainId) {
				alert (ebUtil.getMessage('eb.info.cant.copy.board.domain'));
				objSelCate.focus();
				return;
			}
			if(!confirm( ebUtil.getMessage('eb.info.confirm.copy'))) return;
			
		} else if( "DELETE" == act ) {
			if(!confirm( ebUtil.getMessage('eb.info.confirm.del'))) return;
		}
		var param = "m=setCateBoardMove"
		param += "&act=" + act;
		param += "&cateId=" + aBM.m_tree.getSelectedItemId();
		param += "&trgtCateId=" + objTrgtCateId.value;
		param += "&boardId=" + document.getElementById("base_boardId").value;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.doCateBoardMoveHandler( data ); }});
	},
	doCateBoardMoveHandler : function( data ) {
		var act = document.getElementById("base_act").value;
		if( act == "MOVE"  || act == "COPY" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else if( act == "DELETE" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.delete"));
		}
		// 현재 카테고리의 게시판 목록을 갱신해준다.
		aBM.onNodeSelect( aBM.m_tree.getSelectedItemId());
	},
	doDeleteBoardHandler : function() {
		this.processWithPassword = function( pass ) {
			var boardId = document.getElementById("base_boardId").value;
			if( boardId.length == 0 ) {
				alert( ebUtil.getMessage('eb.info.board.notSelect'));
				return;
			}		
			if (!confirm( ebUtil.getMessage('eb.info.assert.del'))) return;
			var param = "m=boardDelete";
			param += "&boardId=" + boardId;
			param += "&columnValue=" + pass;
			aBM.m_ajax.send( "POST", aBM.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.getDeleteBoardHandler().success( data ); }});
		},
		this.success = function( data ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.delete"));
			aBM.onNodeSelect( aBM.m_tree.getSelectedItemId());
		}	
	},
	doBoardPreview : function() {
		window.open( aBM.m_contextPath+"/board/list.brd?boardId="+document.getElementById("base_boardId").value, "_blank");
	},
	getBoardChooser : function() {
		//if (this.m_boardChooser) return this.m_boardChooser;
		//this.m_boardChooser = new BoardChooser(this);
		return this.m_boardChooser;
	},
	getCateChooser : function() {
		//if (this.m_cateChooser) return this.m_cateChooser;
		//this.m_cateChooser = new CateChooser(this);
		return this.m_cateChooser;
	},
	getPasswordGetter : function() {
		//if (this.m_passwordGetter) return this.m_passwordGetter;
		//this.m_passwordGetter = new PasswordGetter(this);
		return this.m_passwordGetter;
	},
	getDeleteBoardHandler : function() {
		if (this.m_deleteBoardHandler) return this.m_deleteBoardHandler;
		this.m_deleteBoardHandler = new this.doDeleteBoardHandler();
		return this.m_deleteBoardHandler;
	},
	getBltnCateMngr : function() {
		if (this.m_bltnCateMngr) return this.m_bltnCateMngr;
		this.m_bltnCateMngr = new BltnCateMngr(this);
		return this.m_bltnCateMngr;
	},
	// getMultiLangMngr : function() {
		// if (this.m_multiLangMngr) return this.m_multiLangMngr;
		// this.m_multiLangMngr = new MultiLangMngr(this);
		// return this.m_multiLangMngr;
	// },
	getActnMngr : function() {
		if (this.m_actnMngr) return this.m_actnMngr;
		this.m_actnMngr = new ActnMngr(this);
		return this.m_actnMngr;
	},
	getScrnMngr : function() {
		if (this.m_scrnMngr == null) this.m_scrnMngr = new ScrnMngr(this);
		return this.m_scrnMngr;
	},
	getAuthMngr : function() {
		if (this.m_authMngr == null) this.m_authMngr = new AuthMngr(this);
		return this.m_authMngr;
	},
	getBojoMngr : function() {
		if (this.m_bojoMngr == null) this.m_bojoMngr = new BojoMngr(this);
		return this.m_bojoMngr;
	},
	getExtnMngr : function() {
		if (this.m_extnMngr == null) this.m_extnMngr = new ExtnMngr(this);
		return this.m_extnMngr;
	},
	getBltnMngr : function() {
		if (this.m_bltnMngr == null) this.m_bltnMngr = new BltnMngr(this);
		return this.m_bltnMngr;
	},
	getRoleChooser : function() {
		if (this.m_roleChooser == null) this.m_roleChooser = new RoleChooser(this);
		return this.m_roleChooser;
	},
	getGroupChooser : function() {
		if (this.m_groupChooser == null) this.m_groupChooser = new GroupChooser(this);
		return this.m_groupChooser;
	},
	getUserChooser : function() {
		if (this.m_userChooser == null) this.m_userChooser = new UserChooser(this);
		return this.m_userChooser;
	},
	getMsgBox : function() {
		if (this.m_msgBox == null) {
			if ( enviewMessageBox == null ) {
				enviewMessageBox = new enview.portal.MessageBox(300, 100, 1000);
			}
			this.m_msgBox = enviewMessageBox;
		}
		return this.m_msgBox
	}
}
BoardChooser = function (parent) {
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmBoardChooser").dialog({
		autoOpen: false,
		resizable: false,
		width: 1000, 
		modal: true,
		buttons: {
			Cancel: function() {
				$(this).dialog("close");
			}
		}
	});
	this.init();
}
BoardChooser.prototype = {
	m_tree : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_sourceElement1 : null,
	m_sourceElement2 : null,
	
	init : function() {
		this.m_tree = new dhtmlXTreeObject (document.getElementById('boardChooserCateTree'), "100%", "100%", 0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler (this.onNodeSelect);
		this.m_tree.enableAutoTooltips (true);
		this.m_tree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=catebaseTree"); 
		this.m_tree.load (this.m_contextPath+"/board/adCate.brd?m=catebaseTree&id=1&act=root");
	},
	doShow : function (source1, source2) {
		this.m_sourceElement1 = document.getElementById (source1);
		this.m_sourceElement2 = document.getElementById (source2);
		
		aBM.getBoardChooser().doRetrieve();
		$('#abmBoardChooser').dialog('open');
	},
	onNodeSelect : function(id) {
		var srchForm = document.getElementById("boardChooserSearchForm");
		srchForm.pageNo.value = 1;
		aBM.getBoardChooser().doRetrieve();
	},
	doRetrieve : function() {
		if (aBM.getBoardChooser().m_tree.getSelectedItemId().length == 0) return; // 초기화시에 호출되어 선택된 node가 없을 때는 서버로 요청하지 않는다.		
		var param = "m=cateBoard";
		var formElem = document.forms["boardChooserSearchForm"];
		for( var i=0; i<formElem.elements.length; i++ ) {
			param += "&" + formElem.elements[i].name + "=";
			var tmp = formElem.elements[i].value;
			if( tmp.lastIndexOf("*") > 0 ) {
				param += "";
			} else {
				param += encodeURIComponent( tmp );
			}
	    }
		param += "&cateId=" + aBM.getBoardChooser().m_tree.getSelectedItemId();
		this.m_ajax.send("POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aBM.getBoardChooser().doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function(data) { 
		var bodyElem = document.getElementById('boardChooserListBody');
	    var tagTR = null;
	    var tagTD = null;

		this.m_checkBox.unChkAll( document.getElementById("boardChooserListForm") );
		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );

		for(i=0; i<data.Data.length; i++) {
			tagTR = document.createElement('tr');
			tagTR.id = "boardChooserBoardList"+i;
		//	tagTR.onmouseover = new Function( "ebUtil.activeLine(this,true)" );
		//	tagTR.onmouseout = new Function( "ebUtil.activeLine(this,false)" );
			tagTR.setAttribute("ch", i);
			tagTR.setAttribute("style", "cursor:pointer;");
			/* if (i % 2 == 1) {
				tagTR.setAttribute("class", "adgridline");
				tagTR.setAttribute("className", "adgridline");
			} */
			
			tagTD = document.createElement('td');
		//	tagTD.align = "center";
			tagTD.setAttribute("class", "C");
			tagTD.setAttribute("className", "C");
			tagTD.innerHTML = "<input type='checkbox' id='boardChooser"+i+"_checkRow'/>";
			tagTD.innerHTML += "<input type='hidden' id='boardChooser"+i+"_boardId' value='"+data.Data[i].boardId+"'/>";
			tagTD.innerHTML += "<input type='hidden' id='boardChooser"+i+"_boardNm' value='"+data.Data[i].boardNm+"'/>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "L");
			tagTD.setAttribute("className", "L");
		//	tagTD.align = "left";
			tagTD.onclick = new Function( "aBM.getBoardChooser().doSelect(this)" );
			tagTD.innerHTML = "<span id='boardChooser"+i+"_boardId.label'>"+data.Data[i].boardId+"</span>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "L");
			tagTD.setAttribute("className", "L");
		//	tagTD.align = "left";
			tagTD.onclick = new Function( "aBM.getBoardChooser().doSelect(this)" );
			tagTD.innerHTML = "<span id='boardChooser"+i+"_boardNm.label'>"+data.Data[i].boardNm+"</span>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "L");
			tagTD.setAttribute("className", "L");
		//	tagTD.align = "left";
			tagTD.onclick = new Function( "aBM.getBoardChooser().doSelect(this)" );
			tagTD.innerHTML = "<span id='boardChooser"+i+"_boardTtl.label'>"+data.Data[i].boardTtl+"</span>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "L");
			tagTD.setAttribute("className", "L");
		//	tagTD.align = "left";
			tagTD.onclick = new Function( "aBM.getBoardChooser().doSelect(this)" );
			tagTD.innerHTML = "<span style='width:100%;' id='boardChooser"+i+"_boardSkin.label'>"+data.Data[i].boardSkin+"</span>";
			tagTR.appendChild( tagTD );

			bodyElem.appendChild( tagTR );
		}
		/*
		tagTR = document.createElement( 'tr' );
		tagTD = document.createElement( 'td' );
		tagTD.height = "2";
		tagTD.colSpan = "5";
		tagTD.setAttribute("class", "adgridlimit");
		tagTD.setAttribute("className", "adgridlimit");
		tagTR.appendChild( tagTD );
		bodyElem.appendChild (tagTR);
		*/
		
		if( data.Data.length == 0 ) {
			tagTR = document.createElement('tr');
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "C");
			tagTD.colSpan = "5";
			tagTD.innerHTML = "<span>"+ebUtil.getMessage("ev.info.notFoundData")+"</span>";
			tagTR.appendChild( tagTD );
			bodyElem.appendChild( tagTR );
		}		
		else {
			/* 
			tagTR = document.createElement('tr');
			tagTD = document.createElement('td');
			tagTD.height = "22";
			tagTD.colSpan = "5";
			tagTD.innerHTML = "<span>"+ebUtil.getMessage("ev.info.resultSize", data.ResultSize)+"</span>";
			tagTR.appendChild( tagTD );
			bodyElem.appendChild( tagTR );
			*/
		}
		var formElem = document.forms[ "boardChooserSearchForm" ];
		var pageNo = formElem.elements[ "pageNo" ].value;
		var pageSize = formElem.elements[ "pageSize" ].value;
		var pageFunction = formElem.elements[ "pageFunction" ].value;
		var formName = formElem.elements[ "formName" ].value;
		document.getElementById("boardChooser_PAGE_ITERATOR").innerHTML = this.m_pageNavi.getPageIteratorHtmlString(pageNo, pageSize, data.TotalSize, formName, pageFunction);
	},
	doPage : function (formName, pageNo) {
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		aBM.getBoardChooser().doRetrieve();
	},
	doSelect : function (obj) {
		var rowSeq = obj.parentNode.getAttribute("ch");
	    this.m_checkBox.unChkAll( document.getElementById("boardChooserListForm") );
	    document.getElementById('boardChooser'+rowSeq+'_checkRow').checked = true;
		
		var boardId = document.getElementById('boardChooser'+rowSeq+'_boardId').value;
		var boardNm = document.getElementById('boardChooser'+rowSeq+'_boardNm').value;
		
		this.m_sourceElement1.value = boardId;
		this.m_sourceElement2.value = boardNm;
		$('#abmBoardChooser').dialog("close");
	}
}
CateChooser = function( parent ) {
	this.m_contextPath = parent.m_contextPath;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmCateChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:300,
		modal: true,
		buttons: {
			Cancel: function() {
				$(this).dialog('close');
			},
			Select: function() {
				aBM.getCateChooser().doCateSelect();
			}
		}
	});
	this.init();
}
CateChooser.prototype = {
	m_contextPath : null,
	m_checkBox : null,
	m_tree : null,
	m_sourceElement1 : null,
	m_sourceElement2 : null,
	m_sourceElement3 : null,
	
	init : function() {
		this.m_tree = new dhtmlXTreeObject (document.getElementById('cateChooserCateTree'), "100%", "100%", 0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.enableAutoTooltips (true);
		this.m_tree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=catebaseTree"); 
		this.m_tree.load (this.m_contextPath+"/board/adCate.brd?m=catebaseTree&id=1&act=root");
	},
	doShow : function (source1, source2, source3) {
		this.m_sourceElement1 = document.getElementById (source1);
		this.m_sourceElement2 = document.getElementById (source2);
		this.m_sourceElement3 = document.getElementById (source3);
		$('#abmCateChooser').dialog('open');
	},
	doCateSelect : function() {
		var id = this.m_tree.getSelectedItemId();
		if( this.m_tree.getLevel( id ) == "1" ) return; // 루트노드 선택불가!
		this.m_sourceElement1.value = aBM.getCateChooser().m_tree.getSelectedItemId();
		this.m_sourceElement2.value = aBM.getCateChooser().m_tree.getSelectedItemText();
		this.m_sourceElement3.value = aBM.getCateChooser().m_tree.getUserData(aBM.getCateChooser().m_tree.getSelectedItemId(), "domainId");
		$('#abmCateChooser').dialog('close');
	}
}
PasswordGetter = function( parent ) {

	$("#abmPasswordGetter").dialog({
		autoOpen: false,
		resizable: false,
		width:300, 
		modal: true,
		buttons: {
			Cancel: function() {
				$(this).dialog('close');
			},
			Confirm: function() {
				aBM.getPasswordGetter().doReturnPassword();
			}
		}
	});
}
PasswordGetter.prototype = {
	m_callbackHandler : null,

	init : function() {
		document.getElementById("passwordGetter_pass").value = "";
		document.getElementById("passwordGetter_pass").focus();
	},
	doShow : function( handler ) {
		this.m_callbackHandler = handler;
		$('#abmPasswordGetter').dialog('open');
		this.init();
	},
	doReturnPassword : function() {
		if (!ebUtil.chkValue( document.getElementById("passwordGetter_pass"), '<util:message key="eb.info.ttl.o.password"/>', 'true')) return;
		this.m_callbackHandler.processWithPassword( document.getElementById("passwordGetter_pass").value );
		$('#abmPasswordGetter').dialog('close');
	}
}
BltnCateMngr = function( parent ) {
	this.m_contextPath = parent.m_contextPath;
	this.m_elmArea = document.getElementById("bltnCateMngArea");
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
	this.m_msgBox = parent.getMsgBox();
}
BltnCateMngr.prototype = {
	m_contextPath : null,
	m_elmArea : null,
	m_checkedRow : null,
	m_ajax : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_msgBox : null,
	
	doGet : function (boardId) {
		if (boardId != null && boardId.length > 0) this.m_curBoardId = boardId;
		var param = "m=uiBltnCateMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(htmlData) { aBM.getBltnCateMngr().doGetHandler( htmlData ); }});		
	},
	doGetHandler : function (htmlData) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		try {
			if (aBM.isAble2Save()) document.getElementById("bltnCateListBtnTable").style.display = "";
			else                   document.getElementById("bltnCateListBtnTable").style.display = "none";
		} catch(e) {
		}
	},
	/* doShowMultiLangMngr : function() {
		if( this.m_checkedRow == null || document.getElementById("bltnCate_checkRow_"+this.m_checkedRow).value == "" ) {
			alert( ebUtil.getMessage("eb.info.select.cate.update"));
			return;
		}
		ebUtil.getMLMngr().doShow(aBM.getBltnCateMngr(), 'abmMultiLangMngr', 'bltnCate', document.getElementById('base_boardId').value, document.getElementById("bltnCate_checkRow_"+this.m_checkedRow).value );
	}, */
	doShowMultiLangMngr : function( idx ) {
		this.m_checkedRow = idx;
		var checkedRow = document.getElementById("bltnCate_checkRow_"+this.m_checkedRow);		
		if( this.m_checkedRow == null || document.getElementById("bltnCate_checkRow_"+this.m_checkedRow).value == "" ) {
			alert( ebUtil.getMessage("eb.info.select.cate.update"));
			return;
		}
		ebUtil.getMLMngr().doShow(aBM.getBltnCateMngr(), 'abmMultiLangMngr', 'bltnCate', document.getElementById('base_boardId').value, document.getElementById("bltnCate_checkRow_"+this.m_checkedRow).value );
	},	
	doDefaultSelect : function () { // ebUtil.MultiLangMngr 에서 호출한다.
		aBM.getBltnCateMngr().doGet();
	},
	getMsgBox : function () { // ebUtil.MultiLangMngr 에서 호출한다.
		return this.m_msgBox;
	},
	doSelect : function( idx ) {
		this.m_checkedRow = idx;
		var checkedRow = document.getElementById("bltnCate_checkRow_"+this.m_checkedRow);

		this.m_checkBox.unChkAll( document.getElementById("bltnCateMngForm"));
		checkedRow.checked = true;
		
		document.getElementById("base_act").value = "upd";
		document.getElementById("base_bltnCateId").value = checkedRow.value;
		document.getElementById("base_bltnCateId").disabled = true;
		document.getElementById("base_bltnCateOrder").value = checkedRow.getAttribute("bltnCateOrder");
		document.getElementById("base_bltnCateNm").value = checkedRow.getAttribute("bltnCateNm");
		document.getElementById("bltnCateEditDiv").style.display = "";
		if (aBM.isAble2Save()) document.getElementById("bltnCateEditBtnTable").style.display = "";
		else                   document.getElementById("bltnCateEditBtnTable").style.display = "none";
		document.getElementById("base_bltnCateOrder").focus();
	},
	doCreate : function() {
		document.getElementById("base_act").value = "ins";
		document.getElementById("base_bltnCateId").value = "";
		document.getElementById("base_bltnCateId").disabled = false;
		document.getElementById("base_bltnCateOrder").value = "";
		document.getElementById("base_bltnCateNm").value = "";
		document.getElementById("bltnCateEditDiv").style.display = "";
		document.getElementById("base_bltnCateId").focus();
	},
	doSave : function() {
		var act = document.getElementById("base_act").value;
		if( act == "ins" ) {
			if (!ebUtil.chkValue(document.getElementById("base_bltnCateId"), '<util:message key="eb.title.o.cateId"/>', "true")) return;
			if (!ebUtil.chkTableName(document.getElementById("base_bltnCateId"), '<util:message key="eb.title.p.cateId"/>', "true")) return;
		}
		if (!ebUtil.chkValue(document.getElementById("base_bltnCateOrder"), '<util:message key="eb.title.o.cateOrder"/>', "true")) return;
		if (!ebUtil.chkNum(document.getElementById("base_bltnCateOrder"), '<util:message key="eb.title.p.cateOrder"/>', "true")) return;
		if (!ebUtil.chkValue(document.getElementById("base_bltnCateNm"), '<util:message key="eb.title.o.cateNm"/>', "true")) return;

		var param = "m=setBltnCate";
		param += "&act=" + act;
		param += "&boardId=" + document.getElementById("base_boardId").value;
		param += "&bltnCateId=" + document.getElementById("base_bltnCateId").value;
		param += "&bltnCateOrder=" + document.getElementById("base_bltnCateOrder").value;
		param += "&bltnCateNm=" + document.getElementById("base_bltnCateNm").value;

		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.getBltnCateMngr().doSaveHandler( data ); }});
	},
	doDelete : function() {
		if( !ebUtil.chkCheck( document.getElementsByName("bltnCate_checkRow"), '<util:message key="mm.title.o.category"/>', true )) return;
		
		if( confirm( ebUtil.getMessage("ev.info.remove"))) {
			document.getElementById("base_act").value = "del";
			
			var param = "m=setBltnCate";
			param += "&act=" + "del";
			param += "&boardId=" + document.getElementById("base_boardId").value;
			param += "&bltnCateId=" + ebUtil.getCheckedValues( document.getElementsByName("bltnCate_checkRow"));
			
			this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.getBltnCateMngr().doSaveHandler( data ); }});
		}
	},
	doSaveHandler : function( data ) {
		var act = document.getElementById("base_act").value;
		if( act == "ins" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else if( act == "del" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.delete"));
		}
		aBM.getBltnCateMngr().doGet(document.getElementById("base_boardId").value);
	}
}
ActnMngr = function( parent ) {
	this.m_elmArea = document.getElementById("abmActnTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
}
ActnMngr.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_curAcco : 0,
	m_ownGrdCheckedRow : 0,
	
	doGet : function( boardId ) {
		if( boardId != null && boardId.length > 0 ) this.m_curBoardId = boardId;
		
		var param = "m=uiBoardActnMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data){aBM.getActnMngr().doGetHandler(data);}});
	},
	doGetHandler : function( htmlData ) {
		this.m_elmArea.innerHTML = htmlData;
		//$( function() {
			$("#actnAccordion").accordion({
				autoHeight: false,
				change: function(event,ui) { aBM.getActnMngr().m_curAcco = $( "#actnAccordion" ).accordion("option","active");}
			});
		//});
	//	$( "#actnAccordion" ).accordion( "activate", this.m_curAcco );
		$( "#actnAccordion" ).accordion( "option", "active", this.m_curAcco );
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	doSave : function( act ) {
		var param = "m=setBoardFunc";
		param += "&act=" + act;
		param += "&boardId=" + this.m_curBoardId;
		if( act == "type" || act == "tmpl") {
			param += "&boardType=" + ebUtil.getCheckedValue(document.getElementsByName("actn_boardType"));
			param += "&mergeType=" + ebUtil.getCheckedValue(document.getElementsByName("actn_mergeType"));
		} else if( act == "func" ) {
			var mergeType = ebUtil.getCheckedValue(document.getElementsByName("actn_mergeType"));
			if( mergeType!='A') {
				param += "&badStdCnt="   + document.getElementById("actn_badStdCnt").value;
				param += "&replyYn="     + ebUtil.getCheckedValue(document.getElementsByName("actn_replyYn"));
				param += "&memoYn="      + ebUtil.getCheckedValue(document.getElementsByName("actn_memoYn"));
				param += "&memoReplyYn=" + ebUtil.getCheckedValue(document.getElementsByName("actn_memoReplyYn"));
			} else {
				if(!ebUtil.isNumCheck( document.getElementById("actn_maxFileCnt"))) return;
				if(!ebUtil.isNumCheck( document.getElementById("actn_maxFileSize"))) return;
				if(!ebUtil.isNumCheck( document.getElementById("actn_maxFileDown"))) return;
				if(!ebUtil.isNumCheck( document.getElementById("actn_badStdCnt"))) return;
				
				param += "&maxFileCnt="  + document.getElementById("actn_maxFileCnt").value;
				param += "&maxFileSize=" + document.getElementById("actn_maxFileSize").value;
				param += "&maxFileDown=" + document.getElementById("actn_maxFileDown").value;
				
				if( document.getElementById("actn_maxMemoFileCnt") !=null) {
					param += "&maxMemoFileCnt="  + document.getElementById("actn_maxMemoFileCnt").value;
					param += "&maxMemoFileSize=" + document.getElementById("actn_maxMemoFileSize").value;
				}
				
				param += "&badStdCnt="   + document.getElementById("actn_badStdCnt").value;
				param += "&replyYn="     + ebUtil.getCheckedValue(document.getElementsByName("actn_replyYn"));
				param += "&memoYn="      + ebUtil.getCheckedValue(document.getElementsByName("actn_memoYn"));
				param += "&memoReplyYn=" + ebUtil.getCheckedValue(document.getElementsByName("actn_memoReplyYn"));
				param += "&secretYn="    + ebUtil.getCheckedValue(document.getElementsByName("actn_secretYn"));
				param += "&ableAnonYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_ableAnonYn"));
				param += "&anonYn="      + ebUtil.getCheckedValue(document.getElementsByName("actn_anonYn"));
				var termYn = ebUtil.getCheckedValue(document.getElementsByName("actn_termYn"));
				param += "&termYn="      + termYn;
				if( termYn == "Y" ) {
					param += "&termFlag=" + ebUtil.getCheckedValue(document.getElementsByName("actn_termFlag"));
				}
				param += "&cateYn="      + ebUtil.getCheckedValue(document.getElementsByName("actn_cateYn"));
				var extUseYn = ebUtil.getCheckedValue(document.getElementsByName("actn_extUseYn"));
				param += "&extUseYn="    + extUseYn;
				if( extUseYn == "Y" ) {
					param += "&extnClassNm=" + document.getElementById("actn_extnClassNm").value;
				}
				param += "&accSetYn="    + ebUtil.getCheckedValue(document.getElementsByName("actn_accSetYn"));
			}
		} else if( act == "buga" ) {
			var mergeType = ebUtil.getCheckedValue(document.getElementsByName("actn_mergeType"));
			if( mergeType!='A') {
				param += "&noticeYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_noticeYn"));
				var grdAuthYn = ebUtil.getCheckedValue(document.getElementsByName("actn_grdAuthYn"));
				param += "&grdAuthYn=" + grdAuthYn;
				if (grdAuthYn == 'Y') param += "&ownGrdYn=" + ebUtil.getCheckedValue(document.getElementsByName("actn_ownGrdYn"));
				else                  param += "&ownGrdYn=" + "N";
				
			} else {
				param += "&delFlagYn=" + ebUtil.getCheckedValue(document.getElementsByName("actn_delFlagYn"));
				var orgOrgDelYn = document.getElementById("reserve_orgDelYn").value;
				var selOrgDelYn = ebUtil.getCheckedValue(document.getElementsByName("actn_orgDelYn"));
				if (orgOrgDelYn == 'M' && orgOrgDelYn != selOrgDelYn) {
					alert (ebUtil.getMessage('eb.error.orgDelYn.change.fromM'));
					if (!confirm (ebUtil.getMessage('eb.error.orgDelYn.real.delete'))) {
						ebUtil.setCheckedValue (document.getElementsByName("actn_orgDelYn"), orgOrgDelYn);
						return;
					}
				}
				param += "&orgDelYn="  + selOrgDelYn;
				param += "&noticeYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_noticeYn"));
				param += "&permitYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_permitYn"));
				param += "&rcmdYn="    + ebUtil.getCheckedValue(document.getElementsByName("actn_rcmdYn"));
				param += "&evalYn="    + ebUtil.getCheckedValue(document.getElementsByName("actn_evalYn"));
				param += "&attnYn="    + ebUtil.getCheckedValue(document.getElementsByName("actn_attnYn"));
				param += "&snntYn="    + ebUtil.getCheckedValue(document.getElementsByName("actn_snntYn"));
				param += "&subBrdYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_subBrdYn"));
				param += "&memoBadYn=" + ebUtil.getCheckedValue(document.getElementsByName("actn_memoBadYn"));
				var grdAuthYn = ebUtil.getCheckedValue(document.getElementsByName("actn_grdAuthYn"));
				param += "&grdAuthYn=" + grdAuthYn;
				if (grdAuthYn == 'Y') param += "&ownGrdYn=" + ebUtil.getCheckedValue(document.getElementsByName("actn_ownGrdYn"));
				else                  param += "&ownGrdYn=" + "N";
				param += "&bltnBadYn=" + ebUtil.getCheckedValue(document.getElementsByName("actn_bltnBadYn"));
			}
		} else if( act == "srch" ) {
			param += "&srchNickYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_srchNickYn"));
			param += "&srchSubjYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_srchSubjYn"));
			param += "&srchCnttYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_srchCnttYn"));
			param += "&srchAtchYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_srchAtchYn"));
			param += "&srchRegYn="   + ebUtil.getCheckedValue(document.getElementsByName("actn_srchRegYn"));
			param += "&srchReplyYn=" + ebUtil.getCheckedValue(document.getElementsByName("actn_srchReplyYn"));
			param += "&srchMemoYn="  + ebUtil.getCheckedValue(document.getElementsByName("actn_srchMemoYn"));
		} else if( act == "owntbl" ) {
			var owntblYn = ebUtil.getCheckedValue(document.getElementsByName("actn_owntblYn"));
			if( owntblYn == 'Y') {
				if( ebUtil.getSelectedValue(document.getElementById("actn_owntblFix")) == "") {
					alert( ebUtil.getMessage('eb.info.boardTbl'));
					return;
				}
			}
			param += "&owntblYn=" + owntblYn;
			param += "&owntblFix="  + ebUtil.getSelectedValue(document.getElementById("actn_owntblFix"));
		}
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.getActnMngr().doSaveHandler( data ); }});
	},
	doSaveHandler : function( data ) {
		aBM.getMsgBox().doShow( ebUtil.getMessage("mm.info.success"));
		aBM.getActnMngr().doGet();		
	},
	doSelectOwntblYn : function( elm ) {
		if( elm.value == 'N' ) { // 일반형일 때
			document.getElementById("actn_owntblFix").options[0].selected = true;
			document.getElementById("actn_owntblFix").style.display = 'none';
		} else { // 독립형일 때
			document.getElementById("actn_owntblFix").style.display = '';
		} 
	},
	doSelectTermYn : function( elm ) {
		if( elm.value == 'N' ) { // 게시기간 설정 없음.
			var trs = document.getElementsByName("termFlagTr");
			for( var i=0; i<trs.length; i++ ) {
				trs[i].style.display = "none";
			}
		} else { // 게시기간 설정.
			var trs = document.getElementsByName("termFlagTr");
			for( var i=0; i<trs.length; i++ ) {
				trs[i].style.display = "";
			}
		} 
	},
	doSelectExtUseYn : function( elm ) {
		if( elm.value == 'N' ) { // 확장필드 기능 사용 안함.
			var trs = document.getElementsByName("extUseTr");
			for( var i=0; i<trs.length; i++ ) {
				trs[i].style.display = "none";
			}
		} else { // 확장필드 기능 사용함.
			var trs = document.getElementsByName("extUseTr");
			for( var i=0; i<trs.length; i++ ) {
				trs[i].style.display = "";
			}
		} 
	},
	/*
	doSelectOwnAsgnYn : function( elm ) {
		if( elm.value == 'N' ) { // 등급별 사용자 공통 배속
			var ownGrdYn = ebUtil.getCheckedValue(document.getElementsByName("actn_ownGrdYn"));
			if( ownGrdYn == 'Y' ) {
				alert( ebUtil.getMessage("pt.eb.js.info.ownGrdY.cant.OwnAsgnN"));
				ebUtil.setCheckedValue( document.getElementsByName("actn_ownAsgnYn"), "Y" );
				return;
			}
		} 
	},
	doSelectOwnGrdYn : function( elm ) {
		if( elm.value == 'Y' ) { // 독자등급코드 사용
			var ownAsgnYn = ebUtil.getCheckedValue(document.getElementsByName("actn_ownAsgnYn"));
			if( ownAsgnYn == 'N' ) {
				alert( ebUtil.getMessage("pt.eb.js.info.ownAsgnN.cant.OwnGrdY"));
				ebUtil.setCheckedValue( document.getElementsByName("actn_ownGrdYn"), "N" );
				return;
			}
		} 
	},
	*/
	doOwnGrdSelect : function( idx ) {
		this.m_ownGrdCheckedRow = idx;
		var checkedRow = document.getElementById("actn_checkRow_"+this.m_ownGrdCheckedRow);

		this.m_checkBox.unChkAll( document.getElementById("ownGrdMngForm"));
		checkedRow.checked = true;
		
		document.getElementById("actn_ownGrd_act").value = "upd";
		document.getElementById("actn_grade").value = checkedRow.value;
		document.getElementById("actn_gradeNm").value = checkedRow.getAttribute("gradeNm");
		document.getElementById("actn_gradeDesc").value = checkedRow.getAttribute("gradeDesc");
		document.getElementById("ownGrdEditDiv").style.display = "";
	},
	doOwnGrdCreate : function() {
		document.getElementById("actn_ownGrd_act").value = "ins";
		document.getElementById("actn_grade").value = "";
		document.getElementById("actn_gradeNm").value = "";
		document.getElementById("actn_gradeDesc").value = "";
		document.getElementById("ownGrdEditDiv").style.display = "";
		document.getElementById("actn_gradeNm").focus();
	},
	doOwnGrdSave : function() {
		var act = document.getElementById("actn_ownGrd_act").value;
		if(!ebUtil.chkValue( document.getElementById("actn_gradeNm"), '<util:message key="eb.title.o.gradeNm"/>', true)) return;

		var param = "m=setBoardOwnGrade";
		param += "&act=" + act;
		param += "&boardId="  + this.m_curBoardId;
		param += "&code="     + document.getElementById("actn_grade").value;
		param += "&codeName=" + document.getElementById("actn_gradeNm").value;
		param += "&remark="   + document.getElementById("actn_gradeDesc").value;
		
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aBM.getActnMngr().doOwnGrdSaveHandler( data ); }});
	},
	doOwnGrdDelete : function() {
		if( !ebUtil.chkCheck( document.getElementsByName("actn_checkRow"), '<util:message key="eb.title.o.gradeCd"/>', true )) return;

		if( confirm( ebUtil.getMessage("ev.info.remove"))) {
			document.getElementById("actn_ownGrd_act").value = "del";
			
			var param = "m=setBoardOwnGrade";
			param += "&act=" + "del";
			param += "&boardId=" + this.m_curBoardId;
			param += "&code="    + ebUtil.getCheckedValues( document.getElementsByName("actn_checkRow"));
			
			this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aBM.getActnMngr().doOwnGrdSaveHandler( data ); }});
		}
	},
	doOwnGrdUp : function( idx ) {
		document.getElementById("actn_ownGrd_act").value = "up";
		var checkedRow = document.getElementById("actn_checkRow_"+idx);

		var param = "m=setBoardOwnGrade";
		param += "&act=" + "up";
		param += "&boardId=" + this.m_curBoardId;
		param += "&code="   + checkedRow.value;
		
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aBM.getActnMngr().doOwnGrdSaveHandler( data ); }});
	},
	doOwnGrdDown : function( idx ) {
		document.getElementById("actn_ownGrd_act").value = "down";
		var checkedRow = document.getElementById("actn_checkRow_"+idx);

		var param = "m=setBoardOwnGrade";
		param += "&act=" + "down";
		param += "&boardId=" + this.m_curBoardId;
		param += "&code="   + checkedRow.value;
		
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aBM.getActnMngr().doOwnGrdSaveHandler( data ); }});
	},
	doOwnGrdSaveHandler : function( data ) {
		var act = document.getElementById("actn_ownGrd_act").value;
		if( act == "ins" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" || act == "up" || act == "down" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else if( act == "del" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.delete"));
		}
		aBM.getActnMngr().doOwnGrdGet();
	},
	doOwnGrdGet : function( boardId ) {
		if( boardId != null && boardId.length > 0 ) this.m_curBoardId = boardId;
		
		var param = "m=uiBoardActnMng";
		param += "&act=" + "ownGrdGet";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data){aBM.getActnMngr().doOwnGrdGetHandler(data);}});
	},
	doOwnGrdGetHandler : function( htmlData ) {
		document.getElementById("ownGrdMngDiv").innerHTML = htmlData;
	},
	checkAnonGrade : function (elm) {
		if (elm.value == "N" && elm.checked) { // '익명/실명인증 기능 미사용' 설정했을 때...
			if (parseInt(document.getElementById("gradeAActionMask").value) >= 32) { // '익명(로그인전)' 등급이 '글쓰기' 이상의 권한을 가지고 있다면
				alert(ebUtil.getMessage('eb.info.use.anon'));
				// 설정 못하게 막는다.
				var curVal = document.getElementById("actn_anonYn_temp").value;
				var siblings = document.getElementsByName(elm.name);
				for (var i=0; i<siblings.length; i++) {
					if(siblings[i].value == curVal) {
						siblings[i].checked = true;
						return; // 최종값으로 원복하고 바로 종료.
					}
				}
			}
		}
		document.getElementById("actn_anonYn_temp").value = elm.value; // 항상 최종 설정된 값을 백업해둔다. '미사용' 클릭 시 원복할 때 사용하기 위해
	}
}
ScrnMngr = function( parent ) {
	this.m_elmArea = document.getElementById("abmScrnTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
}
ScrnMngr.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_curAcco : null,
	
	doGet : function( boardId ) {
		if( boardId != null && boardId.length > 0 ) this.m_curBoardId = boardId;

		var param = "m=uiBoardScrnMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, { success: function(data) { aBM.getScrnMngr().doGetHandler( data ); } });
	},
	doGetHandler : function( htmlData ) {
		this.m_elmArea.innerHTML = htmlData;
		//$( function() {
			$("#scrnAccordion").accordion({
				autoHeight: false,
				change: function(event,ui) { aBM.getScrnMngr().m_curAcco = $( "#scrnAccordion" ).accordion("option","active");}
			});
		//});
	//	$( "#scrnAccordion" ).accordion( "activate", this.m_curAcco );
		$( "#scrnAccordion" ).accordion( "option", "activate", this.m_curAcco );
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	doSave : function( act ) {
		var param = "m=setBoardScrn";
		param += "&act=" + act;
		param += "&boardId=" + this.m_curBoardId;
		if( act == "base" ) {
			param += "&boardSkin="    + ebUtil.getSelectedValue(document.getElementById("scrn_boardSkin"));
			if (!ebUtil.chkNum (document.getElementById("scrn_listSetCnt"), '<util:message key="eb.title.p.listSetCnt"/>', "true")) return;
			param += "&listSetCnt="   + document.getElementById("scrn_listSetCnt").value;
			
			var objNewTerm = document.getElementById("scrn_newTerm");
			if (!ebUtil.chkNum (objNewTerm, '<util:message key="eb.title.p.newTerm"/>', "true")) return;
			if (document.getElementById("scrn_mergeType").value == "C") { // 최신글형 게시판의 경우
				if (!ebUtil.chkValue(objNewTerm, '<util:message key="eb.title.o.newTerm"/>', "true")) return;
				if (objNewTerm.value == "0") {
					alert('<util:message key="eb.info.newTerm.should.be.more.than.0"/>');
					objNewTerm.focus();
					return;
				}
			}
			param += "&newTerm="      + objNewTerm.value;
			
			var objRaiseCnt = document.getElementById("scrn_raiseCnt");
			if (!ebUtil.chkNum (objRaiseCnt, '<util:message key="eb.title.p.raiseCnt"/>', "true")) return;
			if (document.getElementById("scrn_mergeType").value == "D") { // 인기글형 게시판의 경우
				if (!ebUtil.chkValue(objRaiseCnt, '<util:message key="eb.title.o.raiseCnt"/>', "true")) return;
				if (objRaiseCnt.value == "0") {
					alert('<util:message key="eb.info.raiseCnt.should.be.more.than.0"/>');
					objRaiseCnt.focus();
					return;
				}
			}
			param += "&raiseCnt="     + objRaiseCnt.value;
			
			param += "&raiseColor="   + document.getElementById("scrn_raiseColor").value;
			if (!ebUtil.chkNum (document.getElementById("scrn_boardWidth"), '<util:message key="eb.title.p.boardWidth"/>', "true")) return;
			param += "&boardWidth="   + document.getElementById("scrn_boardWidth").value;
			param += "&boardBgColor=" + document.getElementById("scrn_boardBgColor").value;
			param += "&boardBgPic="   + document.getElementById("scrn_boardBgPic").value;
			param += "&topHtml="      + document.getElementById("scrn_topHtml").value;
			param += "&bottomHtml="   + document.getElementById("scrn_bottomHtml").value;
			param += "&miniTrgtWin="  + document.getElementById("scrn_miniWinInput").value;
			param += "&miniTrgtUrl="  + document.getElementById("scrn_miniTrgtUrl").value;
		} else if( act == "ttl" ) {
			param += "&ttlNoYn="    + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlNoYn"));
			param += "&ttlThumbYn=" + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlThumbYn"));
			param += "&ttlCateYn="  + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlCateYn"));
			param += "&ttlIconYn="  + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlIconYn"));
			param += "&ttlNewYn="   + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlNewYn"));
			param += "&ttlReplyYn=" + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlReplyYn"));
			param += "&ttlMemoYn="  + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlMemoYn"));
			param += "&ttlPntYn="   + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlPntYn"));
			param += "&ttlNickYn="  + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlNickYn"));
			param += "&ttlRegYn="   + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlRegYn"));
			param += "&ttlReadYn="  + ebUtil.getCheckedValue(document.getElementsByName("scrn_ttlReadYn"));
		} else if( act == "size" ) {
			var objSubjSize  = document.getElementById("scrn_subjSize");
			var objNickSize  = document.getElementById("scrn_nickSize");
			var objThumbSize = document.getElementById("scrn_thumbSize");
			if (!ebUtil.chkNum(objSubjSize,  '<util:message key="eb.title.p.subjSize"/>', "true")) return;
			if (!ebUtil.chkNum(objNickSize,  '<util:message key="eb.title.p.nickSize"/>', "true")) return;
			if (!ebUtil.chkNum(objThumbSize, '<util:message key="eb.title.p.thumbSize"/>', "true")) return;
			if( objSubjSize.value == "" )  objSubjSize.value = "0";
			if( objNickSize.value == "" )  objNickSize.value = "0";
			if( objThumbSize.value == "" ) objThumbSize.value = "0";
			if(!ebUtil.isNumCheck( objSubjSize )) return;
			if(!ebUtil.isNumCheck( objNickSize )) return;
			if(!ebUtil.isNumCheck( objThumbSize )) return;
			param += "&subjSize="  + objSubjSize.value;
			param += "&nickSize="  + objNickSize.value;
			param += "&thumbSize=" + objThumbSize.value;
		} else if( act == "listread" ) {
			var mergeType = ebUtil.getCheckedValue(document.getElementsByName("actn_mergeType"));
			if( mergeType!='A') {
				param += "&listAtchYn="      + ebUtil.getCheckedValue(document.getElementsByName("scrn_listAtchYn"));
				param += "&listCnttYn="      + ebUtil.getCheckedValue(document.getElementsByName("scrn_listCnttYn"));
				param += "&listOrgYn="       + ebUtil.getCheckedValue(document.getElementsByName("scrn_listOrgYn"));
				param += "&listImageYn="     + ebUtil.getCheckedValue(document.getElementsByName("scrn_listImageYn"));
				param += "&readListYn="      + ebUtil.getCheckedValue(document.getElementsByName("scrn_readListYn"));
				param += "&readReplyYn="     + ebUtil.getCheckedValue(document.getElementsByName("scrn_readReplyYn"));
				param += "&readReplyCnttYn=" + ebUtil.getCheckedValue(document.getElementsByName("scrn_readReplyCnttYn"));
				param += "&readMultiYn="     + ebUtil.getCheckedValue(document.getElementsByName("scrn_readMultiYn"));
			} else {
				param += "&listAtchYn="      + ebUtil.getCheckedValue(document.getElementsByName("scrn_listAtchYn"));
				param += "&listCnttYn="      + ebUtil.getCheckedValue(document.getElementsByName("scrn_listCnttYn"));
				param += "&listOrgYn="       + ebUtil.getCheckedValue(document.getElementsByName("scrn_listOrgYn"));
				param += "&listImageYn="     + ebUtil.getCheckedValue(document.getElementsByName("scrn_listImageYn"));
				param += "&readListYn="      + ebUtil.getCheckedValue(document.getElementsByName("scrn_readListYn"));
				param += "&readReplyYn="     + ebUtil.getCheckedValue(document.getElementsByName("scrn_readReplyYn"));
				param += "&readReplyCnttYn=" + ebUtil.getCheckedValue(document.getElementsByName("scrn_readReplyCnttYn"));
				param += "&readMultiYn="     + ebUtil.getCheckedValue(document.getElementsByName("scrn_readMultiYn"));
			}
		}
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.getScrnMngr().doSaveHandler( data ); }});
	},
	doSaveHandler : function( data ) {
		aBM.getMsgBox().doShow( ebUtil.getMessage("mm.info.success"));
		aBM.getScrnMngr().doGet();		
	},
	doSelectMiniTrgtWin : function() {
		var winSelect = document.getElementById("scrn_miniTrgtWin");
		var winInput  = document.getElementById("scrn_miniWinInput");
		
		for( var i=0; i<winSelect.length; i++ ) {
			if( winSelect.options[i].selected ) {
				if( winSelect.options[i].value != 'xxxxx' ) {
					winInput.value = winSelect.options[i].value;
					winInput.disabled = true;
				} else {
					winInput.value = '';
					winInput.disabled = false;
				}
			}
		}
	}
}
AuthMngr = function( parent ) {
	this.m_elmArea = document.getElementById("abmAuthTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox; 
}
AuthMngr.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_curAcco : null,
	m_selGradeId : null,
	m_act : null,
	m_pageSize : 10,
	m_roleTree : null,
	m_groupTree : null,
	m_activeElm : null,
	m_activeElmBgColor : null,
	
	doGet : function (boardId) {
		if (boardId != null && boardId.length > 0) this.m_curBoardId = boardId;
		this.m_selGradeId = null; // m_selGradeId는 향후 등급별 권한설정인지 아닌지의 동작분기의 기준이 되므로 tab이 새로 선택될 때 항상 초기화 해준다.2012.08.23.KWShin. 
		
		var param = "m=uiBoardAuthMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, { success: function(data) { aBM.getAuthMngr().doGetHandler(data); } });
	},
	doGetHandler : function (htmlData) {
		this.m_elmArea.innerHTML = htmlData;
		$("#authAccordion").accordion({
			autoHeight: false,
			change: function(event,ui) { 
				aBM.getAuthMngr().m_curAcco = $("#authAccordion").accordion("option","active");
				switch (aBM.getAuthMngr().m_curAcco) {
					case 1:
						if (document.getElementById("auth_role_grade")) aBM.getAuthMngr().doSelectGrade("role", ebUtil.getSelectedValue (document.getElementById("auth_role_grade")));
						if (document.getElementById("roleTree") != null) {
							if (document.getElementById("roleCurAuth")) aBM.getAuthMngr().initRoleTree();
						} else {
							if (document.getElementById("roleCurAuth")) aBM.getAuthMngr().initRoleAuthDiv();
						}
						break;
					case 2:
						if (document.getElementById("auth_group_grade")) aBM.getAuthMngr().doSelectGrade("group", ebUtil.getSelectedValue(document.getElementById("auth_group_grade")));
						if (document.getElementById("groupCurAuth")) aBM.getAuthMngr().initGroupTree();
						break;
					case 3:
						if (document.getElementById("auth_user_grade")) aBM.getAuthMngr().doSelectGrade("user", ebUtil.getSelectedValue (document.getElementById("auth_user_grade")));
						if (document.getElementById("userCurAuth")) aBM.getAuthMngr().initUserAuthDiv();
						break;
				}
			}
		});
	//	$("#authAccordion").accordion("activate", this.m_curAcco);
		$("#authAccordion").accordion("option", "active", this.m_curAcco);
	},
	initRoleTree : function() {
			if (document.getElementById("roleTree").innerHTML == "") {
				this.m_roleTree = new dhtmlXTreeObject (document.getElementById('roleTree'),"100%","100%",0);
				this.m_roleTree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
				this.m_roleTree.enableCheckBoxes (1);
				this.m_roleTree.setOnClickHandler (this.nodeSelectOnRoleTree);
				this.m_roleTree.enableAutoTooltips (true);
				this.m_roleTree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=prinTree&boardId="+this.m_curBoardId); 
				this.m_roleTree.load (this.m_contextPath+"/board/adCate.brd?m=prinTree&id=10&act=root&boardId="+this.m_curBoardId);
			}
	},
	initGroupTree : function() {
		if (document.getElementById("groupTree").innerHTML == "") {
			this.m_groupTree = new dhtmlXTreeObject (document.getElementById('groupTree'),"100%","100%",0);
			this.m_groupTree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
			this.m_groupTree.enableCheckBoxes (1);
			this.m_groupTree.setOnClickHandler (this.nodeSelectOnGroupTree);
			this.m_groupTree.enableAutoTooltips (true);
			this.m_groupTree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=prinTree&boardId="+this.m_curBoardId); 
			this.m_groupTree.load (this.m_contextPath+"/board/adCate.brd?m=prinTree&id=100&act=root&boardId="+this.m_curBoardId);
		}
	},
	nodeSelectOnRoleTree : function(id) {
		var param = "m=uiBoardAuthMng";
		param += "&view="    + "curAuth";
		param += "&boardId=" + aBM.getAuthMngr().m_curBoardId;
		param += "&rguIds="   + id;
		aBM.getAuthMngr().m_ajax.send("POST", aBM.getAuthMngr().m_contextPath+"/board/adAuxil.brd", param, true, { success: function(data) {
			document.getElementById("roleCurAuth").innerHTML = data; 
		}});
	},
	nodeSelectOnGroupTree : function(id) {
		var param = "m=uiBoardAuthMng";
		param += "&view="    + "curAuth";
		param += "&boardId=" + aBM.getAuthMngr().m_curBoardId;
		param += "&rguIds="   + id;
		aBM.getAuthMngr().m_ajax.send("POST", aBM.getAuthMngr().m_contextPath+"/board/adAuxil.brd", param, true, { success: function(data) {
			document.getElementById("groupCurAuth").innerHTML = data; 
		}});
	},
	initRoleAuthDiv : function (pageNo) {
		var param = "m=uiBoardRGUList";
		param += "&act="        + "role";
		param += "&view="       + "existList";
		param += "&pageNo="     + ((pageNo != null && pageNo != "") ? pageNo : 1);
		param += "&pageSize="   + this.m_pageSize;
		param += "&boardId="    + this.m_curBoardId;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) {
			document.getElementById("roleAuthDiv").innerHTML = data;
			var pageNo    = document.gradeRoleMngForm.pageNo.value;
			var totalSize = document.gradeRoleMngForm.totalSize.value;
			document.getElementById("auth_role_page_iterator").innerHTML 
			= aBM.getAuthMngr().m_pageNavi.getPageIteratorHtmlString (pageNo, aBM.getAuthMngr().m_pageSize, totalSize, "gradeRoleMngForm", "aBM.getAuthMngr().doRolePage");
			document.getElementById("userCurAuth").innerHTML = "";
		}});
	},
	initUserAuthDiv : function (pageNo) {
		var param = "m=uiBoardRGUList";
		param += "&act="        + "user";
		param += "&view="       + "existList";
		param += "&pageNo="     + ((pageNo != null && pageNo != "") ? pageNo : 1);
		param += "&pageSize="   + this.m_pageSize;
		param += "&boardId="    + this.m_curBoardId;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) {
			document.getElementById("userAuthDiv").innerHTML = data;
			var pageNo    = document.gradeUserMngForm.pageNo.value;
			var totalSize = document.gradeUserMngForm.totalSize.value;
			document.getElementById("auth_user_page_iterator").innerHTML 
			= aBM.getAuthMngr().m_pageNavi.getPageIteratorHtmlString (pageNo, aBM.getAuthMngr().m_pageSize, totalSize, "gradeUserMngForm", "aBM.getAuthMngr().doUserPage");
			document.getElementById("userCurAuth").innerHTML = "";
		}});
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	doSave : function(act, frm) {
		var param = "m=setBoardAuth";
		if (act) param += "&act=" + act;
		param += "&boardId=" + this.m_curBoardId;
		param += "&domainId=" + document.getElementById("cate_domainId").value;
		//var frm = document.getElementById("authGradeForm");
		if (act == "gradeAuth") {
			for (var i=0; i<frm.elements.length; i++) {
				if( frm.elements[i].type == "hidden" && frm.elements[i].id.indexOf("authGrcd") >= 0 ) {
					frm.elements[i].value = "";
					for( var j=0; j<frm.elements.length; j++ )
						if( frm.elements[j].type == "checkbox" && frm.elements[j].name.indexOf(frm.elements[i].id) >= 0 && frm.elements[j].checked == true)
							frm.elements[i].value += frm.elements[j].value + ","; 
					param += "&" + frm.elements[i].id + "=" + frm.elements[i].value.substring(0,frm.elements[i].value.length-1);
				}
			}
		} else if (act == "everyAuth") {
			if (!ebUtil.chkCheck (document.getElementsByName("auth_every_checkRow"), '<util:message key="eb.title.o.user.type.auth"/>', true)) return;
			param += "&rguIds=" + ebUtil.getCheckedValues(document.getElementsByName("auth_every_checkRow"));
			param += "&authGrcdE=";
			for (var i=0; i<frm.elements.length; i++)
				if (frm.elements[i].type == "checkbox" && frm.elements[i].name.indexOf("authGrcdE") >= 0 && frm.elements[i].checked == true)
					param += frm.elements[i].value + ","
			param = param.substring (0,param.length-1); // remove the last comma.
		
		} else if (act == "roleAuth") {
			if( this.m_roleTree != null) {
				if (this.m_roleTree.getAllChecked() == null || this.m_roleTree.getAllChecked() == "") {
					alert('<util:message key="eb.info.select.role.auth"/>');
					return;
				}
				param += "&rguIds=" + this.m_roleTree.getAllChecked();
			} else {
				if (!ebUtil.chkCheck (document.getElementsByName("auth_role_checkRow"), '<util:message key="eb.title.o.role.auth"/>', true)) return;
				param += "&rguIds=" + ebUtil.getCheckedValues(document.getElementsByName("auth_role_checkRow"));
			}
			param += "&authGrcdR=";
			for (var i=0; i<frm.elements.length; i++)
				if (frm.elements[i].type == "checkbox" && frm.elements[i].name.indexOf("authGrcdR") >= 0 && frm.elements[i].checked == true)
					param += frm.elements[i].value + ","
			param = param.substring (0,param.length-1); // remove the last comma.
		} else if (act == "groupAuth") {
		
			if (this.m_groupTree.getAllChecked() == null || this.m_groupTree.getAllChecked() == "") {
				alert('<util:message key="eb.info.select.group.auth"/>');
				return;
			}
			param += "&rguIds=" + this.m_groupTree.getAllChecked();
			param += "&authGrcdG=";
			for (var i=0; i<frm.elements.length; i++)
				if (frm.elements[i].type == "checkbox" && frm.elements[i].name.indexOf("authGrcdG") >= 0 && frm.elements[i].checked == true)
					param += frm.elements[i].value + ","
			param = param.substring (0,param.length-1); // remove the last comma.
		
		} else if (act == "userAuth") {
			
			if (!ebUtil.chkCheck (document.getElementsByName("auth_user_checkRow"), '<util:message key="eb.title.o.user.auth"/>', true)) return;
			param += "&rguIds=" + ebUtil.getCheckedValues(document.getElementsByName("auth_user_checkRow"));
			param += "&authGrcdU=";
			for (var i=0; i<frm.elements.length; i++)
				if (frm.elements[i].type == "checkbox" && frm.elements[i].name.indexOf("authGrcdU") >= 0 && frm.elements[i].checked == true)
					param += frm.elements[i].value + ","
			param = param.substring (0,param.length-1); // remove the last comma.
		}
		
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aBM.getAuthMngr().doSaveHandler( data ); }});
	},
	doSaveHandler : function( data ) {
		aBM.getMsgBox().doShow( ebUtil.getMessage("mm.info.success"));
		aBM.getAuthMngr().doGet();		
	},
	doSelectGrade : function (act, selGradeId, pageNo) {
		if( selGradeId != null && selGradeId != "" ) this.m_selGradeId = selGradeId;
		if( this.m_selGradeId != null ) {
			if( act != null && act != "" ) this.m_act = act;
			var param = "m=uiGradeRGUList";
			param += "&cmd="        + "own";
			param += "&act="        + this.m_act;
			param += "&view="       + "existList";
			param += "&pageNo="     + ((pageNo != null && pageNo != "") ? pageNo : 1);
			param += "&pageSize="   + this.m_pageSize;
			param += "&boardId="    + this.m_curBoardId;
			param += "&selGradeId=" + this.m_selGradeId;
			this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aBM.getAuthMngr().doSelectGradeHandler( data ); }});
		}
	},
	doSelectGradeHandler : function( htmlData ) {
		if( this.m_act == "role"  ) {
			document.getElementById("gradeRoleDiv").innerHTML  = htmlData;
			var pageNo    = document.gradeRoleMngForm.pageNo.value;
			var totalSize = document.gradeRoleMngForm.totalSize.value;
			document.getElementById("auth_role_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString( pageNo, this.m_pageSize, totalSize, "gradeRoleMngForm", "aBM.getAuthMngr().doRolePage");
		}
		if( this.m_act == "group" ) {
			document.getElementById("gradeGroupDiv").innerHTML = htmlData;
			var pageNo    = document.gradeGroupMngForm.pageNo.value;
			var totalSize = document.gradeGroupMngForm.totalSize.value;
			document.getElementById("auth_group_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString( pageNo, this.m_pageSize, totalSize, "gradeGroupMngForm", "aBM.getAuthMngr().doGroupPage");
		}
		if( this.m_act == "user"  ) {
			document.getElementById("gradeUserDiv").innerHTML  = htmlData;
			var pageNo    = document.gradeUserMngForm.pageNo.value;
			var totalSize = document.gradeUserMngForm.totalSize.value;
			document.getElementById("auth_user_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString( pageNo, this.m_pageSize, totalSize, "gradeUserMngForm", "aBM.getAuthMngr().doUserPage");
		}
	},
	doRolePage : function( formName, pageNo ) {
		if (this.m_selGradeId == null || this.m_selGradeId == "") {
			aBM.getAuthMngr().initRoleAuthDiv (pageNo);
		} else {
			aBM.getAuthMngr().doSelectGrade( "role", "", pageNo );
		}
	},
	doGroupPage : function( formName, pageNo ) {
		aBM.getAuthMngr().doSelectGrade( "group", "", pageNo );
	},
	doUserPage : function( formName, pageNo ) {
		if (this.m_selGradeId == null || this.m_selGradeId == "") {
			aBM.getAuthMngr().initUserAuthDiv (pageNo);
		} else {
			aBM.getAuthMngr().doSelectGrade ("user", "", pageNo);
		}
	},
	doChooseRGU : function (act) {
		if (act == "role" ) aBM.getRoleChooser(). doShow (this.m_curBoardId, this.m_selGradeId);
		if (act == "group") aBM.getGroupChooser().doShow (this.m_curBoardId, this.m_selGradeId);
		if (act == "user" ) aBM.getUserChooser(). doShow (this.m_curBoardId, this.m_selGradeId);
	},
	doSelect : function (act, idx, elm) {
		var checkedRow;
//		alert( act + ':' +  idx + ':' + elm);
		if (act == "role" ) checkedRow = document.getElementById ("auth_role_checkRow_" +idx);
		if (act == "group") checkedRow = document.getElementById ("auth_group_checkRow_"+idx);
		if (act == "user" ) checkedRow = document.getElementById ("auth_user_checkRow_" +idx);
		if (this.m_selGradeId == null || this.m_selGradeId == "") {
			if (elm) {
				if (this.m_activeElm) ebUtil.selectLine (this.m_activeElm, this.m_activeElmBgColor, false);
				this.m_activeElm = elm;
				this.m_activeElmBgColor = elm.style.backgroundColor;
				ebUtil.selectLine (elm, '#E8ECF9', true);

				var param = "m=uiBoardAuthMng";
				param += "&view="    + "curAuth";
				param += "&boardId=" + aBM.getAuthMngr().m_curBoardId;
				param += "&rguIds="  + elm.getAttribute("prinId");
				if (act == "user") {
					param += "&act=user";
					aBM.getAuthMngr().m_ajax.send("POST", aBM.getAuthMngr().m_contextPath+"/board/adAuxil.brd", param, true, { success: function(data) {
						document.getElementById("userCurAuth").innerHTML = data; 
					}});
				} else if (act == "role") {
					param += "&act=role";
					aBM.getAuthMngr().m_ajax.send("POST", aBM.getAuthMngr().m_contextPath+"/board/adAuxil.brd", param, true, { success: function(data) {
						document.getElementById("roleCurAuth").innerHTML = data; 
					}});
				} else if (act == "group") {
					param += "&act=group";
					aBM.getAuthMngr().m_ajax.send("POST", aBM.getAuthMngr().m_contextPath+"/board/adAuxil.brd", param, true, { success: function(data) {
						document.getElementById("groupCurAuth").innerHTML = data; 
					}});
				} else if (act == "every") {
					aBM.getAuthMngr().m_ajax.send("POST", aBM.getAuthMngr().m_contextPath+"/board/adAuxil.brd", param, true, { success: function(data) {
						document.getElementById("everyCurAuth").innerHTML = data; 
					}});
				}
			}
		} else {
			if(checkedRow.checked) checkedRow.checked = false;
			else                   checkedRow.checked = true;
		}
	},
	doAddRGU : function (act, rguIds) {
		this.m_act = act;
		var param = "";
		if (this.m_selGradeId == null || this.m_selGradeId == "") {
			param = "m=setBoardRGUList";
			param += "&boardId=" + this.m_curBoardId;
		} else {
			param = "m=setGradeRGUList";
			param += "&selGradeId=" + this.m_selGradeId;
		}
		param += "&cmd="    + "add";
		param += "&act="    + this.m_act;
		param += "&rguIds=" + rguIds;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aBM.getAuthMngr().doSaveRGUHandler( data ); }});
	},
	doRemRGU : function( act ) {
		this.m_act = act;
		var rguIds = "";
		if( this.m_act == "role" ) {
			if( !ebUtil.chkCheck( document.getElementsByName("auth_role_checkRow"), '<util:message key="eb.title.o.role.delete"/>', true )) return;
			rguIds = ebUtil.getCheckedValues(document.getElementsByName("auth_role_checkRow"));
		}
		if( this.m_act == "group" ) {
			if( !ebUtil.chkCheck( document.getElementsByName("auth_group_checkRow"), '<util:message key="eb.title.o.group.delete"/>', true )) return;
			rguIds = ebUtil.getCheckedValues(document.getElementsByName("auth_group_checkRow"));
		}
		if( this.m_act == "user" ) {
			if( !ebUtil.chkCheck( document.getElementsByName("auth_user_checkRow"), '<util:message key="eb.title.o.user.delete"/>', true )) return;
			rguIds = ebUtil.getCheckedValues(document.getElementsByName("auth_user_checkRow"));
		}
		if( confirm( ebUtil.getMessage("ev.info.remove"))) {
			var param = "";
			if (this.m_selGradeId == null || this.m_selGradeId == "") {
				param = "m=setBoardRGUList";
				param += "&boardId=" + this.m_curBoardId;
			} else {
				param = "m=setGradeRGUList";
				param += "&selGradeId=" + this.m_selGradeId;
			}
			param += "&act="    + this.m_act;
			param += "&cmd="    + "rem";
			param += "&rguIds=" + rguIds;
			this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aBM.getAuthMngr().doSaveRGUHandler( data ); }});
		}
	},
	doSaveRGUHandler : function( data ) {
		aBM.getMsgBox().doShow( ebUtil.getMessage("mm.info.success"));
		if (this.m_selGradeId == null || this.m_selGradeId == "") {
			if( this.m_act == "role" ) {
				aBM.getAuthMngr().initRoleAuthDiv();
			}  else if( this.m_act == "user" ) { 
				aBM.getAuthMngr().initUserAuthDiv();
			}
		} else {
			aBM.getAuthMngr().doSelectGrade();
		}
	},
	showDetailAction : function (idx) {
		document.getElementById("authShowButton"+idx).style.display = "none";
		document.getElementById("authHideButton"+idx).style.display = "";
		document.getElementById("authDetail"+idx).style.display = "";
	},
	hideDetailAction : function (idx) {
		document.getElementById("authShowButton"+idx).style.display = "";
		document.getElementById("authHideButton"+idx).style.display = "none";
		document.getElementById("authDetail"+idx).style.display = "none";
	},
	checkAuthRepGrcd : function (elm, frm) {
	
		var repChecked = elm.checked;
		var idxNm = elm.name.substr(11,1); // "authRepGrcd#"

		if (idxNm == "A" && parseInt(elm.value) >= 32 && elm.checked && document.getElementById("auth_anonYn").value == 'N') {
			// '익명(로그인전)' 등급에서 '글쓰기'이상 권한이 체크되었는데, 게시판이 '익명/실명인증 미사용'이면,
			// 권한설정을 못하도록 막는다.
			alert(ebUtil.getMessage('eb.info.anon.notUse'));
			elm.checked = false;
			return;
		}

		for (var i=0; i<frm.elements.length; i++) {
			if (frm.elements[i].type == "checkbox" && frm.elements[i].name.indexOf("authRepGrcd"+idxNm) >= 0) {
				if (elm.name.substr(elm.name.length-1,1) == "4") { // 모든권한이 클릭되었으면...
					if (frm.elements[i].name.substr(frm.elements[i].name.length-1,1) != 4) { // 나머지들을 맞추어 준다.
						if (repChecked) frm.elements[i].checked = true;
						else            frm.elements[i].checked = false;
					}
				} else { // 그 외의 권한이...
					if (!repChecked) { // 혹시나 해제되었으면...
						if (frm.elements[i].name.substr(frm.elements[i].name.length-1,1) == 4) { // '대표권한'을 해제하여 준다
							frm.elements[i].checked = false;
						}
					}
				}
			}
		}
		// 대표권한의 상태에 따라 상세권한을 체크하거나 풀어준다.
		var repAction = parseInt(elm.value);
		for (var i=0; i<frm.elements.length; i++) {
			if (frm.elements[i].type == "checkbox" && frm.elements[i].name.indexOf("authGrcd"+idxNm) >= 0) {
				var action = parseInt(frm.elements[i].value);
				if ((action & repAction) == action) {
					if (repChecked) frm.elements[i].checked = true;
					else            frm.elements[i].checked = false;
				}
			}
		}
	},
	checkAuthGrcd : function (elm, frm) {
		var idxNm = elm.name.substr(8,1); // "authGrcd#"

		if (idxNm == "A" && parseInt(elm.value) >= 32 && elm.checked && document.getElementById("auth_anonYn").value == 'N') {
			// '익명(로그인전)' 등급에서 '글쓰기'이상 권한이 체크되었는데, 게시판이 '익명/실명인증 미사용'이면,
			// 권한설정을 못하도록 막는다.
			alert(ebUtil.getMessage('eb.info.anon.notUse'));
			elm.checked = false;
			return;
		}
		
		var action = 0;
		for (var i=0; i<frm.elements.length; i++) {
			if (frm.elements[i].type == "checkbox" && frm.elements[i].name.indexOf("authGrcd"+idxNm) >= 0) {
				if (frm.elements[i].checked) action += parseInt(frm.elements[i].value);
			}
		}
		// 상세권한의 상태에 따라 대표권한을 체크하거나 풀어준다.
		for (var i=0; i<frm.elements.length; i++) {
			if (frm.elements[i].type == "checkbox" && frm.elements[i].name.indexOf("authRepGrcd"+idxNm) >= 0) {
				var repAction = parseInt(frm.elements[i].value);
				if ((repAction & action) == repAction) {
					frm.elements[i].checked = true;
				} else {
					frm.elements[i].checked = false;
				}
			}
		}
	}	
}
RoleChooser = function( parent ) {
	this.m_elmArea = document.getElementById("abmRoleChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmRoleChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				aBM.getRoleChooser().m_pageNo = 1;
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("roleChooser_checkRow"), '<util:message key="eb.title.o.role.add"/>', true )) return;
				aBM.getRoleChooser().m_pageNo = 1;
				aBM.getAuthMngr().doAddRGU('role',ebUtil.getCheckedValues( document.getElementsByName("roleChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
RoleChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_selGradeId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "";
		if (this.m_selBradeId == null || this.m_selBradeId == "") {
			param = "m=uiBoardRGUList";
		} else {
			param = "m=uiGradeRGUList";
			param += "&cmd="        + "own";
			param += "&selGradeId=" + this.m_selGradeId;
		}
		param += "&act="        + "role";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aBM.getRoleChooser().doGetHandler( htmlData ); }});		
	},
	doShow : function( boardId, selGradeId ) {
		this.m_curBoardId = boardId;
		this.m_selGradeId = selGradeId;
		aBM.getRoleChooser().doGet();
		$('#abmRoleChooser').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.abmRoleChooserForm.totalSize.value;
		document.getElementById("abmRoleChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString( this.m_pageNo, this.m_pageSize, this.m_totalSize, "abmRoleChooserForm", "aBM.getRoleChooser().doPage");
		
		var frm = document.abmRoleChooserForm;
		if( frm.srchShortPath.value     == "") frm.srchShortPath.value     = '<util:message key="eb.info.ttl.l.roleId"/>';
		if (frm.srchPrincipalName.value == "") frm.srchPrincipalName.value = '<util:message key="eb.info.ttl.l.roleNm"/>';

	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		aBM.getRoleChooser().doSearch();
	},
	doSelect : function( idx ) {
		var checkedRow = document.getElementById( "roleChooser_checkRow_"+idx );
		if(checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doSearch : function(pageNo) {
		if (pageNo != null) this.m_pageNo = pageNo;
		var frm = document.abmRoleChooserForm;
		if (frm.srchShortPath.value     == '<util:message key="eb.info.ttl.l.roleId"/>') frm.srchShortPath.value     = "";
		if (frm.srchPrincipalName.value == '<util:message key="eb.info.ttl.l.roleNm"/>') frm.srchPrincipalName.value = "";
		var param = "";
		if (this.m_selBradeId == null || this.m_selBradeId == "") {
			param = "m=uiBoardRGUList";
		} else {
			param = "m=uiGradeRGUList";
			param += "&cmd="        + "own";
			param += "&selGradeId=" + this.m_selGradeId;
		}		param += "&act="        + "role";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchShortPath=" + frm.srchShortPath.value;
		param += "&srchPrincipalName=" + encodeURIComponent(frm.srchPrincipalName.value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aBM.getRoleChooser().doGetHandler( htmlData ); }});		
	}
}
GroupChooser = function( parent ) {
	this.m_elmArea = document.getElementById("abmGroupChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmGroupChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				aBM.getGroupChooser().m_pageNo = 1;
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("groupChooser_checkRow"), '<util:message key="eb.title.o.group.add"/>', true )) return;
				aBM.getGroupChooser().m_pageNo = 1;
				aBM.getAuthMngr().doAddRGU('group',ebUtil.getCheckedValues( document.getElementsByName("groupChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
GroupChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_ajax : null,
	m_pageNavi : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_selGradeId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiGradeRGUList";
		param += "&cmd="        + "own";
		param += "&act="        + "group";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aBM.getGroupChooser().doGetHandler( htmlData ); }});		
	},
	doShow : function( boardId, selGradeId ) {
		this.m_curBoardId = boardId;
		this.m_selGradeId = selGradeId;
		aBM.getGroupChooser().doGet();
		$('#abmGroupChooser').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.abmGroupChooserForm.totalSize.value;
		document.getElementById("abmGroupChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString( this.m_pageNo, this.m_pageSize, this.m_totalSize, "abmGroupChooserForm", "aBM.getGroupChooser().doPage");
		
		var frm = document.abmGroupChooserForm;
		if( frm.srchShortPath.value     == "") frm.srchShortPath.value     = '<util:message key="eb.info.ttl.l.groupId"/>';
		if (frm.srchPrincipalName.value == "") frm.srchPrincipalName.value = '<util:message key="eb.info.ttl.l.groupNm"/>';

	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		aBM.getGroupChooser().doSearch();
	},
	doSelect : function( idx ) {
		var checkedRow = document.getElementById( "groupChooser_checkRow_"+idx );
		if(checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doSearch : function(pageNo) {
		if (pageNo != null) this.m_pageNo = pageNo;
		var frm = document.abmGroupChooserForm;
		if (frm.srchShortPath.value     == '<util:message key="eb.info.ttl.l.groupId"/>') frm.srchShortPath.value     = "";
		if (frm.srchPrincipalName.value == '<util:message key="eb.info.ttl.l.groupNm"/>') frm.srchPrincipalName.value = "";
		var param = "m=uiGradeRGUList";
		param += "&cmd="        + "own";
		param += "&act="        + "group";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchShortPath=" + frm.srchShortPath.value;
		param += "&srchPrincipalName=" + encodeURIComponet(frm.srchPrincipalName.value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aBM.getGroupChooser().doGetHandler( htmlData ); }});		
	}
}
UserChooser = function( parent ) {
	this.m_elmArea = document.getElementById("abmUserChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmUserChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				aBM.getUserChooser().m_pageNo = 1;
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("userChooser_checkRow"), '<util:message key="eb.title.o.user.add"/>', true )) return;
				aBM.getUserChooser().m_pageNo = 1;
				aBM.getAuthMngr().doAddRGU('user',ebUtil.getCheckedValues( document.getElementsByName("userChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
UserChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_selGradeId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "";
		if (this.m_selBradeId == null || this.m_selBradeId == "") {
			param = "m=uiBoardRGUList";
		} else {
			param = "m=uiGradeRGUList";
			param += "&cmd="        + "own";
			param += "&selGradeId=" + this.m_selGradeId;
		}
		param += "&act="        + "user";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aBM.getUserChooser().doGetHandler (htmlData); }});		
	},
	doShow : function (boardId, selGradeId) {
		this.m_curBoardId = boardId;
		this.m_selGradeId = selGradeId;
		aBM.getUserChooser().doGet();
		$('#abmUserChooser').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.abmUserChooserForm.totalSize.value;
		document.getElementById("abmUserChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString( this.m_pageNo, this.m_pageSize, this.m_totalSize, "abmUserChooserForm", "aBM.getUserChooser().doPage");
		
		var frm = document.abmUserChooserForm;
		if( frm.srchUserId.value == "") frm.srchUserId.value = '<util:message key="eb.info.ttl.l.id"/>';
		if (frm.srchNmKor.value  == "") frm.srchNmKor.value  = '<util:message key="eb.info.ttl.l.name"/>';
	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		aBM.getUserChooser().doSearch();
	},
	doSelect : function (idx) {
		var checkedRow = document.getElementById( "userChooser_checkRow_"+idx);
		if (checkedRow.checked) checkedRow.checked = false;
		else                    checkedRow.checked = true;
	},
	doSearch : function(pageNo) {
		if (pageNo != null) this.m_pageNo = pageNo;
		var frm = document.abmUserChooserForm;
		if (frm.srchUserId.value == '<util:message key="eb.info.ttl.l.id"/>')   frm.srchUserId.value = "";
		if (frm.srchNmKor.value  == '<util:message key="eb.info.ttl.l.name"/>') frm.srchNmKor.value  = "";
		var param = "";
		if (this.m_selBradeId == null || this.m_selBradeId == "") {
			param = "m=uiBoardRGUList";
		} else {
			param = "m=uiGradeRGUList";
			param += "&cmd="        + "own";
			param += "&selGradeId=" + this.m_selGradeId;
		}
		param += "&act="        + "user";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchUserId=" + frm.srchUserId.value;
		param += "&srchNmKor="  + encodeURIComponent(frm.srchNmKor.value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aBM.getUserChooser().doGetHandler (htmlData); }});		
	}
}
BojoMngr = function( parent ) {
	this.m_elmArea = document.getElementById("abmBojoTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
}
BojoMngr.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_curAcco : null,
	
	doGet : function (boardId) {
		if (boardId != null && boardId.length > 0) this.m_curBoardId = boardId;

		var param = "m=uiBoardBojoMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adBoard.brd", param, true, { success: function(data) { aBM.getBojoMngr().doGetHandler(data); }});
	},
	doGetHandler : function (htmlData) {
		this.m_elmArea.innerHTML = htmlData;
		//$(function() {
			$("#bojoAccordion").accordion({
				autoHeight: false,
				change: function(event,ui) { aBM.getBojoMngr().m_curAcco = $( "#bojoAccordion" ).accordion("option","active");}
			});
		//});
	//	$("#bojoAccordion").accordion( "activate", this.m_curAcco );
		$("#bojoAccordion").accordion( "option", "active", this.m_curAcco );
		if (this.m_curBoardId == "ENBOARD.BASE") document.getElementById("bojo_restore").disabled = "true";
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	doSave : function( act ) {
		var param = "m=setBoardBojo";
		param += "&act=" + act;
		param += "&boardId=" + this.m_curBoardId;
		if( act == "prop" ) {
			param += "&evalLevel="  + document.getElementById("bojo_evalLevel").value;
			param += "&bestLimit="  + document.getElementById("bojo_bestLimit").value;
			param += "&extMask="    + document.getElementById("bojo_extMask").value;
			param += "&badExtMask=" + document.getElementById("bojo_badExtMask").value;
			param += "&acceptIp="   + document.getElementById("bojo_acceptIp").value;
			param += "&acceptId="   + document.getElementById("bojo_acceptId").value;
			param += "&badIp="      + document.getElementById("bojo_badIp").value;
			param += "&badId="      + document.getElementById("bojo_badId").value;
			param += "&badNick="    + document.getElementById("bojo_badNick").value;
			param += "&badCntt="    + document.getElementById("bojo_badCntt").value;
			param += "&inputTerm="  + document.getElementById("bojo_inputTerm").value;
			param += "&badNickYn="  + ebUtil.getCheckedValue(document.getElementsByName("bojo_badNickYn"));
			param += "&badCnttYn="  + ebUtil.getCheckedValue(document.getElementsByName("bojo_badCnttYn"));
		} else if( act == "cntt" ) {
			param += "&badCnttCommon=" + document.getElementById("bojo_badCnttCommon").value;
		}
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.getBojoMngr().doSaveHandler( data ); }});
	},
	doSaveHandler : function( data ) {
		aBM.getMsgBox().doShow( ebUtil.getMessage("mm.info.success"));
		aBM.getBojoMngr().doGet();		
	},
	doRestore : function() {
		if( confirm('<util:message key="eb.info.really.use.default.value"/>')) {
			var param = "m=setBoardBojo";
			param += "&act=" + "prop";
			param += "&cmd=" + "RESTORE";
			param += "&boardId=" + this.m_curBoardId;
			this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.getBojoMngr().doSaveHandler( data ); }});
		}
	},
	doUpdateDef : function() {
		this.m_curBoardId = "ENBOARD.BASE";
		var param = "m=uiBoardBojoMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, { success: function(data) { aBM.getBojoMngr().doGetHandler( data ); } });
	}
}
ExtnMngr = function (parent) {
	this.m_elmArea = document.getElementById("abmExtnTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
	this.m_msgBox = parent.getMsgBox();
}
ExtnMngr.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_curAcco : null,
	m_msgBox : null,
	
	doGet : function (boardId) {
		if (boardId != null && boardId.length > 0) this.m_curBoardId = boardId;

		var param = "m=uiBoardExtnMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send("POST", this.m_contextPath+"/board/adBoard.brd", param, true, { success: function(data) { aBM.getExtnMngr().doGetHandler(data); }});
	},
	doGetHandler : function (htmlData) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		//$(function() {
			$("#extnAccordion").accordion({
				autoHeight: false,
				change: function(event,ui) { aBM.getExtnMngr().m_curAcco = $("#extnAccordion").accordion("option","active");}
			});
		//});
	//	$("#extnAccordion").accordion("activate", this.m_curAcco);
		$("#extnAccordion").accordion( "option", "active", this.m_curAcco );
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	doSelect : function( idx ) {
		this.m_checkedRow = idx;
		var checkedRow = document.getElementById("extn_checkRow_"+this.m_checkedRow);

		this.m_checkBox.unChkAll( document.getElementById("bltnExtnPropMngForm"));
		checkedRow.checked = true;
		
		document.getElementById("extn_act").value = "upd";
		document.getElementById("extn_fldNm").value = checkedRow.value;
		document.getElementById("extn_fldNm").disabled = true;
		ebUtil.setCheckedValue( document.getElementsByName("extn_useYn"), checkedRow.getAttribute("useYn"));
		ebUtil.setCheckedValue( document.getElementsByName("extn_ttlYn"), checkedRow.getAttribute("ttlYn"));
		ebUtil.setCheckedValue( document.getElementsByName("extn_srchYn"), checkedRow.getAttribute("srchYn"));
		ebUtil.setSelectedValue( document.getElementById("extn_dataType"), checkedRow.getAttribute("dataType"));
		document.getElementById("extn_title").value = checkedRow.getAttribute("title");
		document.getElementById("extn_utilClassNm").value = checkedRow.getAttribute("utilClassNm");
		document.getElementById("bltnExtnPropEditDiv").style.display = "";
	},
	doCreate : function() {
		document.getElementById("extn_act").value = "ins";
		document.getElementById("extn_fldNm").value = "";
		document.getElementById("extn_fldNm").disabled = false;
		ebUtil.setCheckedValue( document.getElementsByName("extn_useYn"), "N");
		ebUtil.setCheckedValue( document.getElementsByName("extn_ttlYn"), "N");
		ebUtil.setCheckedValue( document.getElementsByName("extn_srchYn"), "N");
		ebUtil.setSelectedValue( document.getElementById("extn_dataType"), "S");
		document.getElementById("extn_title").value = "";
		document.getElementById("extn_utilClassNm").value = "";
		document.getElementById("bltnExtnPropEditDiv").style.display = "";
		document.getElementById("extn_fldNm").focus();
	},
	doSave : function() {
		var act = document.getElementById("extn_act").value;
		if( act == "ins" ) {
			if(!ebUtil.chkValue( document.getElementById("extn_fldNm"), '<util:message key="eb.title.o.fldNm"/>', "true")) return;
			if(!ebUtil.chkTableName( document.getElementById("extn_fldNm"), '<util:message key="eb.title.p.fldNm"/>', "true")) return;
			if(!ebUtil.chkValue( document.getElementById("extn_title"), '<util:message key="eb.title.o.title"/>', "true")) return;
		}
		if( document.getElementById("extn_utilClassNm").value != "" ) {
			if(!ebUtil.chkTableName( document.getElementById("extn_utilClassNm"), '<util:message key="eb.title.p.classNm"/>')) return;
		}

		var param = "m=setBltnExtnProp";
		param += "&act=" + act;
		param += "&boardId="     + this.m_curBoardId;
		param += "&fldNm="       + document.getElementById("extn_fldNm").value;
		param += "&useYn="       + ebUtil.getCheckedValue( document.getElementsByName("extn_useYn"));
		param += "&ttlYn="       + ebUtil.getCheckedValue( document.getElementsByName("extn_ttlYn"));
		param += "&srchYn="      + ebUtil.getCheckedValue( document.getElementsByName("extn_srchYn"));
		param += "&dataType="    + ebUtil.getSelectedValue( document.getElementById("extn_dataType"));
		param += "&title="       + document.getElementById("extn_title").value;
		param += "&utilClassNm=" + document.getElementById("extn_utilClassNm").value;

		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.getExtnMngr().doSaveHandler( data ); }});
	},
	doDelete : function() {
		if( !ebUtil.chkCheck( document.getElementsByName("extn_checkRow"), '<util:message key="eb.title.p.extn.info"/>', true )) return;
		
		if( confirm( ebUtil.getMessage("ev.info.remove"))) {
			document.getElementById("extn_act").value = "del";
			
			var param = "m=setBltnExtnProp";
			param += "&act=" + "del";
			param += "&boardId=" + this.m_curBoardId;
			param += "&fldNm="   + ebUtil.getCheckedValues( document.getElementsByName("extn_checkRow"));
			
			this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aBM.getExtnMngr().doSaveHandler( data ); }});
		}
	},
	doSaveHandler : function( data ) {
		var act = document.getElementById("extn_act").value;
		if( act == "ins" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else if( act == "del" ) {
			aBM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.delete"));
		}
		aBM.getExtnMngr().doGet();
	},
	doShowMultiLangMngr : function() {
		if( this.m_checkedRow == null || document.getElementById("extn_checkRow_"+this.m_checkedRow).value == "" ) {
			alert( ebUtil.getMessage("eb.info.bltnExtnProp.update"));
			return;
		}
		ebUtil.getMLMngr().doShow(aBM.getExtnMngr(), 'abmMultiLangMngr', 'bltnExtnProp', this.m_curBoardId, document.getElementById("extn_checkRow_"+this.m_checkedRow).value);
	},
	doDefaultSelect : function () { // ebUtil.MultiLangMngr 에서 호출한다.
		aBM.getExtnMngr().doGet();
	},
	getMsgBox : function () { // ebUtil.MultiLangMngr 에서 호출한다.
		return this.m_msgBox;
	}
}
BltnMngr = function( parent ) {
	this.m_elmArea = document.getElementById("abmBltnTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
}
BltnMngr.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_curAcco : null,
	
	doGet : function (boardId) {
		if (boardId != null && boardId.length > 0) this.m_curBoardId = boardId;

		var param = "m=uiBoardBltnMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send("POST", this.m_contextPath+"/board/adBoard.brd", param, true, { success: function(data) { aBM.getBltnMngr().doGetHandler(data); } });
	},
	doGetHandler : function (htmlData) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		//$(function() {
			$("#bltnAccordion").accordion({
				autoHeight: false,
				change: function(event,ui) { aBM.getBltnMngr().m_curAcco = $("#bltnAccordion").accordion("option","active");}
			});
		//});
	//	$("#bltnAccordion").accordion("activate", this.m_curAcco);
		$("#bltnAccordion").accordion( "option", "active", this.m_curAcco );
		
		if (document.forms["bltnMngForm"]) { // 가상게시판/통합형게시판은 화면에 생성되지 않으므로 이 폼을 체크하여 후속실행을 막는다.
			var formElem  = document.forms["bltnMngForm"];
			var pageNo    = formElem.elements["bltn_page"].value;
			var pageSize  = formElem.elements["bltn_pageSize"].value;
			var totalSize = formElem.elements["bltn_totalBltns"].value;
			var pageFunc  = formElem.elements["bltn_pageFunc"].value;
			var formName  = formElem.elements["bltn_formName"].value;
			var formElem  = document.forms["bltnMngForm"];
			document.getElementById("bltn_PAGE_ITERATOR").innerHTML = this.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, formName, pageFunc);
		}
	},
	doClear : function () {
		this.m_elmArea.innerHTML = "";
	},
	doSearch : function () {
		var param = "m=uiBoardBltnMng";
		param += "&boardId="  + this.m_curBoardId;
		param += "&srchType=" + document.getElementById("bltn_srchType").value;
		param += "&srchKey="  + document.getElementById("bltn_srchKey").value;
		param += "&srchDelFlag="  + document.getElementById("bltn_srchDelFlag").value;
		param += "&pageSize=" + document.getElementById("bltn_pageSize").value;
		param += "&page="     + document.getElementById("bltn_page").value; 
		this.m_ajax.send("POST", this.m_contextPath+"/board/adBoard.brd", param, true, { success: function(data) { aBM.getBltnMngr().doGetHandler(data); }});
	},
	doPage : function (formName, pageNo) {
		var formElem = document.forms[formName];
	    formElem.elements["bltn_page"].value = pageNo;
		aBM.getBltnMngr().doSearch();
	},
	readBltn : function (bltnNo) {
		document.setRead.boardId.value = this.m_curBoardId;
		document.setRead.bltnNo.value  = bltnNo;
		document.setRead.cmd.value     = "READ";
		document.setRead.action        = this.m_contextPath+"/board/read.brd";
		document.setRead.submit();	
	},
	doBltnMng : function (flag) {

		var selectedItems = '';
		var checkedBltns = document.getElementsByName("bltn_checkRow");
		for (var i=0; i<checkedBltns.length; i++) {
			if(checkedBltns[i].checked == true)
				selectedItems += ";" + checkedBltns[i].value;
		}
		if (selectedItems.length == 0) {
			alert(ebUtil.getMessage('eb.info.bltn.notSelected')); // '선택된 게시물이 없습니다'
			return;
		}
		
		if ("MOVE" == flag) {
			if (!ebUtil.chkValue (document.getElementById("bltn_dstBoardId"), ebUtil.getMessage('eb.info.select.trgtBoard'), "false")) return; // '이동/복사할 대상 게시판을 선택하세요'
			if (this.m_curBoardId == document.getElementById("bltn_dstBoardId").value) {
				alert('<util:message key="eb.info.cant.move.in.same.board"/>'); return;
			}
			if (!confirm (ebUtil.getMessage('eb.info.confirm.move'))) return; // '정말 이동하시겠습니까?'
		} else if ("COPY" == flag) {
			if (!ebUtil.chkValue (document.getElementById("bltn_dstBoardId"), ebUtil.getMessage('eb.info.select.trgtBoard'), "false")) return; // '이동/복사할 대상 게시판을 선택하세요'
			if (this.m_curBoardId == document.getElementById("bltn_dstBoardId").value) {
				alert('<util:message key="eb.info.cant.copy.in.same.board"/>'); return;
			}
			if (!confirm (ebUtil.getMessage('eb.info.confirm.copy'))) return; // '정말 복사하시겠습니까?'
		} else if ("DELETE" == flag) {
			if (!confirm (ebUtil.getMessage('eb.info.confirm.del'))) return; // '정말 삭제하시겠습니까?'
		}

		var param = "m=moveBulletin"
		param += "&cmd="           + flag;
		param += "&boardId="       + this.m_curBoardId;
		param += "&dstBoardId="    + document.getElementById("bltn_dstBoardId").value;
		param += "&selectedItems=" + selectedItems.substring(1); // 첫번째 ';' 제거.
		this.m_ajax.send("POST", this.m_contextPath+"/board/adBoard.brd", param, true, { success: function(data) { aBM.getBltnMngr().doBltnMngHandler(data); }});
	},
	doBltnMngHandler : function (data) {
		aBM.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		aBM.getBltnMngr().doGet();
	}
}

var treeCtxtMenu = null;
ContextMenu = function (contextPath) {
	$("#treeCtxtMenuDiv").dialog({
		autoOpen: false,
		width: "140px",
		resizable: false,
		draggable: false,
		modal: true,
		open: function(event, ui) { 
			//$(".ui-dialog-titlebar-close").hide(); 
			//$("#treeCtxtMenuDiv").attr("style", "left:" + left);
			//$("#treeCtxtMenuDiv").attr("style", "top:" + top);
		}
	});
	this.init();
}
ContextMenu.prototype = {
	m_domElement : null,
	m_id : null,
	
	init : function() {
	},
	getItemId : function () {
		return this.m_id;
	},
	setItemId : function (id) {
		this.m_id = id;
	},
	show : function (left, top) {
		//alert(left + "," + top);
		$("#treeCtxtMenuDiv").dialog("option", "position", [left,top]);
		$("#treeCtxtMenuDiv").dialog("open");
	},
	hide : function() {
		$("#treeCtxtMenuDiv").dialog("close");
	},
	onMouseOver : function(obj) {
		obj.setAttribute("class", "contextMenu_itemOver");
		obj.setAttribute("className", "contextMenu_itemOver");
	},
	onMouseOut : function(obj) {
		obj.setAttribute("class", "contextMenu_item");
		obj.setAttribute("className", "contextMenu_item");
	}
}

function initAdmBoardMngr() {
	aBM = new AdmBoardMngr();
}
function finishAdmBoardMngr() {
}
// Attach to the onload event
if (window.attachEvent) {
    window.attachEvent ("onload", initAdmBoardMngr);
	window.attachEvent ("onunload", finishAdmBoardMngr);
} else if (window.addEventListener ) {
    window.addEventListener ("load", initAdmBoardMngr, false);
	window.addEventListener ("unload", finishAdmBoardMngr, false);
} else {
    window.onload = initAdmBoardMngr;
	window.onunload = finishAdmBoardMngr;
}

function onEnterKey(  f ) {
		if(event.keyCode == 13){
			f();
		}
}
</script>

