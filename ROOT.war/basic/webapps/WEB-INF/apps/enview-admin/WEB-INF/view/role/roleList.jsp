
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleUserManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pagePermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletPermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/urlPermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorPermissionApp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorApp.js"></script>
<script type="text/javascript">
	function initRoleManager() {
		if( aRoleManager == null ) {
			aRoleManager = new RoleManager("<c:out value="${evSecurityCode}"/>");
			aRoleManager.init();
			aRoleManager.doDefaultSelect();
		}
	}
	function finishRoleManager() {
		
	}
	// Attach to the onload event
	if (window.attachEvent)
	{
	    window.attachEvent ( "onload", initRoleManager );
		window.attachEvent ( "onunload", finishRoleManager );
	}
	else if (window.addEventListener )
	{
	    window.addEventListener ( "load", initRoleManager, false );
		window.addEventListener ( "unload", finishRoleManager, false );
	}
	else
	{
	    window.onload = initRoleManager;
		window.onunload = finishRoleManager;
	}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<div id="cateTabs" class="tree">
		<!-- treewrap -->
		<div class="treewrap resizable">
			<div class="tree_title"><util:message key='ev.title.role.roleTree'/></div>
			<!-- 트리 영역 border로 구분. 지우고 사용해주세요 -->
			<div id="RoleManager_TreeTabPage" class="category" style="overflow:auto; padding:2px;"></div>
		</div>
		<!-- treewrap// -->
	</div>
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="RoleManager_ListMessage"></p>
				<fieldset>
					<form id="RoleManager_SearchForm" name="RoleManager_SearchForm" style="display:inline" action="javascript:aRoleManager.doSearch('RoleManager_SearchForm')" onkeydown="if(event.keyCode==13) aRoleManager.doSearch('RoleManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aRoleManager.doPage'/>
						<input type='hidden' name='formName' value='RoleManager_SearchForm'/>
						<input type='hidden' id='RoleManager_Master_parentId' name='parentId' value=''/>
						<input type='hidden' id='RoleManager_Master_domainId' name='domainId' value=''/>
					  
						<input type="text" name="shortPathCond" size="15" class="txt_100" value="*<util:message key='ev.prop.securityPrincipal.shortPath'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPrincipal.shortPath'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPrincipal.shortPath'/>*');"/> 
										
						<input type="text" name="principalNameCond" size="20" class="txt_100" value="*<util:message key='ev.prop.securityPrincipal.principalName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPrincipal.principalName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPrincipal.principalName'/>*');"/> 
						
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aRoleManager.doSearch('RoleManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
					</form>				
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="RoleManager_ListForm" style="display:inline" name="GroupRoleManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="*" />
						<col width="*" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th class="first" >
								<input type="checkbox" id="delCheck" onclick="aRoleManager.m_checkBox.chkAll(this)"/>
							</th>
							<th><span class="table_title">No</span></th>
						
							<th ch="0" onclick="aRoleManager.doSort(this, 'PRINCIPAL_ID');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalId'/></span>
							</th>	
							<th ch="0" onclick="aRoleManager.doSort(this, 'SHORT_PATH');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.shortPath'/></span>
							</th>	
							<th ch="0" onclick="aRoleManager.doSort(this, 'PRINCIPAL_NAME');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
							</th>	
							<th ch="0" onclick="aRoleManager.doSort(this, 'MODIFIED_DATE');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.modifiedDate'/></span>
							</th>			
						</tr>
					</thead>			
					<tbody id="RoleManager_ListBody">
						<c:forEach items="${results}" var="role" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;">
								<td class="C">
									<input type="checkbox" id="RoleManager[<c:out value="${status.index}"/>].checkRow" />
									<input type="hidden" id="RoleManager[<c:out value="${status.index}"/>].principalId" value="<c:out value='${role.principalId}'/>"/>
								</td>
								<td class="C">
									<c:out value="${status.index}"/>
								</td>
								
								<td id="RoleManager[<c:out value="${status.index}"/>].principalId.label" class="L" onclick="aRoleManager.doSelect(this)">
									<c:out value="${role.principalId}"/>
								</td>
								<td id="RoleManager[<c:out value="${status.index}"/>].shortPath.label" class="L" onclick="aRoleManager.doSelect(this)">
									<c:out value="${role.shortPath}"/>
								</td>
								<td id="RoleManager[<c:out value="${status.index}"/>].principalName.label" class="L" onclick="aRoleManager.doSelect(this)">
									<c:out value="${role.principalName}"/>
								</td>
								<td id="RoleManager[<c:out value="${status.index}"/>].modifiedDate.label" class="L" onclick="aRoleManager.doSelect(this)">
									<c:out value="${role.modifiedDateByFormat}"/>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="RoleManager_PAGE_ITERATOR" class="paging">				
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aRoleManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->		
		</div>
		<!-- board first// -->
		<!-- RoleManager_EditFormPanel -->
		<div id="RoleManager_EditFormPanel" class="board" > 
			<!-- RoleManager_propertyTabs -->
			<div id="RoleManager_propertyTabs">
				<ul>
					<li><a href="#RoleManager_DetailTabPage"><util:message key='ev.title.role.detailTab'/></a></li>   
					<li><a href="#RoleManager_RoleUserTabPage" onclick="aRoleManager.onSelectPropertyTab(1);"><util:message key='ev.title.role.roleUserTab'/></a></li>   
					<li><a href="#RoleManager_PagePermissionTabPage" onclick="aRoleManager.onSelectPropertyTab(2);"><util:message key='ev.title.role.pagePermissionTab'/></a></li>   
					<li><a href="#RoleManager_PortletPermissionTabPage" onclick="aRoleManager.onSelectPropertyTab(3);"><util:message key='ev.title.role.portletPermissionTab'/></a></li>
					<li><a href="#RoleManager_UrlPermissionTabPage" onclick="aRoleManager.onSelectPropertyTab(4);"><util:message key='ev.title.role.urlPermissionTab'/></a></li>   
				</ul>
				<!-- RoleManager_DetailTabPage -->
				<div id="RoleManager_DetailTabPage">
					<form id="RoleManager_EditForm" style="display:inline" action="" method="post">
						<input type="hidden" id="RoleManager_isCreate" />
						<input type='hidden' id="RoleManager_domainId" name="domainId" />
						<input type="hidden" id="RoleManager_parentId" name="parentId" /> 
						<input type="hidden" id="RoleManager_principalType" name="principalType" /> 
						<input type="hidden" id="RoleManager_principalOrder" name="principalOrder" /> 
						<input type="hidden" id="RoleManager_principalId" name="principalId" />
						<input type="hidden" id="SecurityPermission_principalId"/>
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="140px" />
								<col width="*" />
								<col width="140px" />
								<col width="*" />
							</colgroup>							
							<tr>
								<th class="L"><util:message key='ev.prop.securityPrincipal.shortPath'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="RoleManager_shortPath" name="shortPath" value="" style="IME-MODE:disabled;" maxLength="30" label="<util:message key='ev.prop.securityPrincipal.shortPath'/>" class="txt_100per" />
								</td>
								<th class="L"><util:message key='ev.prop.securityPrincipal.principalName'/> <em>*</em></th>
								<td class="L" colspan="3">
									<input type="text" id="RoleManager_principalName" name="principalName" value="" maxLength="40" label="<util:message key='ev.prop.securityPrincipal.principalName'/>" class="txt_100per" />
								</td>
							</tr>
							<tr style="display:none">
								<th class="L"><util:message key='ev.title.role.theme'/></th>
								<td class="L">
									<div class="sel_100">
										<select id="RoleManager_theme" name="theme" label="<util:message key='ev.title.role.theme'/>" class='txt_100'>
											<option value=""></option>
											<c:forEach items="${themeList}" var="theme">
												<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
								<th class="L"><util:message key='ev.prop.userpass.gradeCd'/></th>
								<td class="L">
									<div class="sel_100">
										<select id="RoleManager_gradeId" name="gradeId" label="<util:message key='pt.ev.property.theme'/>" class='txt_145'>
											<option value=""><util:message key='eb.title.selGrd'/></option> 
											<c:forEach items="${gradeList}" var="grade">
												<option value="<c:out value="${grade.GRADE_ID}"/>"><c:out value="${grade.GRADE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr style="display:none">
								<th class="L"><util:message key='ev.title.role.defaultPage'/></th>
								<td colspan="3" class="L">
									<input type="text" id="RoleManager_defaultPage" name="defaultPage" value="" maxLength="" label="<util:message key='ev.title.role.defaultPage'/>" class="txt_100" style="width:75%;"/>
									<span class="btn_pack small"><a href="javascript:aRoleManager.getPageChooser().doShow(aRoleManager.setPageChooserCallback)"><util:message key='ev.title.selectPage'/></a></span>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.securityPrincipal.creationDate'/></th>
								<td class="L"><input type="text" id="RoleManager_creationDate" name="creationDate" value="" label="<util:message key='ev.prop.securityPrincipal.creationDate'/>" class="txt_145" /></td>
								<th class="L"><util:message key='ev.prop.securityPrincipal.modifiedDate'/></th>
								<td class="L" colspan="3"><input type="text" id="RoleManager_modifiedDate" name="modifiedDate" value="" label="<util:message key='ev.prop.securityPrincipal.modifiedDate'/>" class="txt_145" /></td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.prop.userpass.principalInfo01'/></th>
								<td colspan="3" class="L">
									<input type="text" id="RoleManager_principalInfo01" name="principalInfo01" value="" maxLength="50" label="<util:message key='ev.prop.userpass.principalInfo01'/>" class="txt_100" />
								</td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.prop.userpass.principalInfo02'/></th>
								<td colspan="3" class="L">
									<input type="text" id="RoleManager_principalInfo02" name="principalInfo02" value="" maxLength="50" label="<util:message key='ev.prop.userpass.principalInfo02'/>" class="txt_100" />
								</td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.prop.userpass.principalInfo03'/></th>
								<td colspan="3" class="L">
									<input type="text" id="RoleManager_principalInfo03" name="principalInfo03" value="" maxLength="50" label="<util:message key='ev.prop.userpass.principalInfo03'/>" class="txt_100" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.domain.domain'/></th>
								<td colspan="5" class="L">
									<label  id="domain" style="max-width:530px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; word-wrap:normal;"></label>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.securityPrincipal.principalDesc'/></th>
								<td colspan="5" class="L">
									<textarea id="RoleManager_principalDesc" name="principalDesc" value="" cols="30" rows="2" maxLength="80" label="<util:message key='ev.prop.securityPrincipal.principalDesc'/>" class="txt_100" ></textarea>
								</td>							
							</tr>
						</table>
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea">
								<a href="javascript:aRoleManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
							</div>
						</div>
						<!-- btnArea// -->
					</form>
				</div>
				<!-- GroupRoleManager_DetailTabPage// -->				
				<div id="RoleManager_RoleUserTabPage"></div>
				<div id="RoleManager_PagePermissionTabPage"></div>
				<div id="RoleManager_PortletPermissionTabPage"></div>
				<div id="RoleManager_UrlPermissionTabPage"></div>
			</div>
			<!-- RoleManager_propertyTabs// -->
		</div>
		<!-- RoleManager_EditFormPanel// -->					
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="PageManager_PageChooser" title="Page Chooser">
	<div id="PageChooser_TreeTabPage" class="tree" style="border-right: 0px #ffffff;"></div>						
</div>
<div id="RoleManager_RoleMenu" title="Role Menu"></div>
<div id="dhtmlx_context_data">
	<div id="onRefresh" text="<util:message key="ev.info.menu.refresh" />" img="${cPath }/admin/images/Service.gif"></div>
	<div id="onCreate" text="<util:message key="ev.info.menu.addRole" />" img="${cPath }/admin/images/ic_make_page.gif"></div>
	<div id="onMoveUp" text="<util:message key="ev.info.menu.moveUp" />" img="${cPath }/admin/images/ic_up.gif"></div>
	<div id="onMoveDown" text="<util:message key="ev.info.menu.moveDown" />" img="${cPath }/admin/images/ic_down.gif"></div>
	<div id="onDelete" text="<util:message key="ev.info.menu.delete" />" img="${cPath }/admin/images/ic_del_b.gif"></div>
</div>