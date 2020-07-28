
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupUserManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupRoleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pagePermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletPermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorPermissionApp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorApp.js"></script>
<script type="text/javascript">
function initGroupManager() {
	if( aGroupManager == null ) {
		aGroupManager = new GroupManager("<c:out value="${evSecurityCode}"/>");
		aGroupManager.init();
	}
}
function finishGroupManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initGroupManager );
	window.attachEvent ( "onunload", finishGroupManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initGroupManager, false );
	window.addEventListener ( "unload", finishGroupManager, false );
}
else
{
    window.onload = initGroupManager;
	window.onunload = finishGroupManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<input type="hidden" id="showPublic" value="Y"/>
	<div id="cateTabs" class="tree">
		<!-- treewrap -->
		<div class="treewrap resizable">
			<div class="tree_title"><util:message key='ev.title.group.groupTree'/></div>
			<!-- 트리 영역 border로 구분. 지우고 사용해주세요 -->
			<div id="GroupManager_TreeTabPage" class="category" style="overflow:auto; padding:2px;"></div>
		</div>
		<!-- treewrap// -->
	</div>
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="GroupManager_ListMessage"></p>
				<fieldset>
					<form id="GroupManager_SearchForm" name="GroupManager_SearchForm" style="display:inline" action="javascript:aGroupManager.doSearch('GroupManager_SearchForm')" onkeydown="if(event.keyCode==13) aGroupManager.doSearch('GroupManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aGroupManager.doPage'/>
						<input type='hidden' name='formName' value='GroupManager_SearchForm'/>
						<input type='hidden' id='GroupManager_Master_parentId' name='parentId' value=''/>
						<input type='hidden' id='GroupManager_Master_domainId' name='domainId' value=''/>
					  
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
						<a href="javascript:aGroupManager.doSearch('GroupManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
					</form>
				</fieldset>
			</div>
			<!-- searchArea// -->
			<form id="GroupManager_ListForm" style="display:inline" name="GroupManager_ListForm" action="" method="post">
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
							<th class="first">
								<span class="table_title"><input type="checkbox" id="delCheck" onclick="aGroupManager.m_checkBox.chkAll(this)"/></span>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							
							<th class="C" ch="0" onclick="aGroupManager.doSort(this, 'PRINCIPAL_ID');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalId'/></span>
							</th>	
							<th class="C" ch="0" onclick="aGroupManager.doSort(this, 'SHORT_PATH');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.shortPath'/></span>
							</th>	
							<th class="C" ch="0" onclick="aGroupManager.doSort(this, 'PRINCIPAL_NAME');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
							</th>	
							<th class="C" ch="0" onclick="aGroupManager.doSort(this, 'MODIFIED_DATE');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.modifiedDate'/></span>
							</th>			
						</tr>
					</thead>
					<tbody id="GroupManager_ListBody">
					</tbody>
				</table>
			</form>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="GroupManager_PAGE_ITERATOR" class="paging">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
			    	<a href="javascript:aGroupManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->		
		</div>
		<!-- board first// -->
		<!-- GroupManager_EditFormPanel -->
		<div id="GroupManager_EditFormPanel" class="board" >  
			<div id="GroupManager_propertyTabs">
				<ul>
					<li><a href="#GroupManager_DetailTabPage"><util:message key='ev.title.group.detailTab'/></a></li>   
					<li><a href="#GroupManager_GroupUserTabPage" onclick="aGroupManager.onSelectPropertyTab(1);"><util:message key='ev.title.group.groupUserTab'/></a></li>   
					<li><a href="#GroupManager_GroupRoleTabPage" onclick="aGroupManager.onSelectPropertyTab(2);"><util:message key='ev.title.group.groupRoleTab'/></a></li>   
					<!--li><a href="#GroupManager_PagePermissionTabPage" onclick="aGroupManager.onSelectPropertyTab(3);"><util:message key='pt.ev.property.pagePermissionTab'/></a></li-->   
					<!--li><a href="#GroupManager_PortletPermissionTabPage" onclick="aGroupManager.onSelectPropertyTab(4);"><util:message key='pt.ev.property.portletPermissionTab'/></a></li-->   
				</ul>
				<!-- GroupManager_DetailTabPage -->
				<div id="GroupManager_DetailTabPage">
					<form id="GroupManager_EditForm" style="display:inline" action="" method="post">
						<input type="hidden" id="GroupManager_isCreate" />
						<input type="hidden" id="GroupManager_domainId" name="domainId" />
						<input type="hidden" id="GroupManager_parentId" name="parentId" />
						<input type="hidden" id="GroupManager_principalType" name="principalType" /> 
						<input type="hidden" id="GroupManager_principalOrder" name="principalOrder" /> 
						<input type="hidden" id="GroupManager_principalId" name="principalId" />
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
									<input type="text" id="GroupManager_shortPath" name="shortPath" value="" style="IME-MODE:disabled;" maxLength="30" label="<util:message key='ev.prop.securityPrincipal.shortPath'/>" class="txt_200" />
								</td>
								<th class="L"><util:message key='ev.prop.securityPrincipal.principalName'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="GroupManager_principalName" name="principalName" value="" maxLength="40" label="<util:message key='ev.prop.securityPrincipal.principalName'/>" class="txt_200" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.domain.domain'/></th>
							    <td class="L">
							        <label  id="domain"></label>
								</td>
								<th class="L"><util:message key='ev.title.group.theme'/></th>
								<td class="L">
									<div class="sel_100">
										<select id="GroupManager_theme" name="theme" label="<util:message key='ev.title.group.theme'/>" class='txt_100'>
											<option value=""></option>
											<c:forEach items="${themeList}" var="theme">
												<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
								
								<th style="display:none;" class="L"><util:message key='ev.prop.userpass.gradeCd'/></th>
								<td style="display:none;" class="L">
									<div class="sel_100">
										<select id="GroupManager_gradeId" name="gradeId" label="<util:message key='pt.ev.property.theme'/>" class='txt_100'>
											<option value=""><util:message key='eb.title.selGrd'/></option> 
											<c:forEach items="${gradeList}" var="grade">
												<option value="<c:out value="${grade.GRADE_ID}"/>"><c:out value="${grade.GRADE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.group.defaultPage'/></th>
	                            <td colspan="3" class="L">
									<input type="text" id="GroupManager_defaultPage" name="defaultPage" readonly="readonly" value="" maxLength="" label="<util:message key='ev.title.group.defaultPage'/>" class="txt_400"/>
									<a href="javascript:aGroupManager.getPageChooser().doShow(aGroupManager.setDefaultPageChooserCallback)" class="btn_B"><span><util:message key='ev.title.selectPage'/></span></a>
								</td>
								
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.group.subPage'/></th>
                               	<td colspan="3" class="L">
									<input type="text" id="GroupManager_subPage" name="subPage" readonly="readonly" value="" maxLength="" label="<util:message key='ev.title.group.subPage'/>" class="txt_400"/>
									<a href="javascript:aGroupManager.getPageChooser().doShow(aGroupManager.setSubPageChooserCallback)" class="btn_B"><span><util:message key='ev.title.selectPage'/></span></a>
								</td>
								
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.group.rootPath'/></th>
								<td colspan="3" class="L">
									<input type="text" id="GroupManager_siteName" name="siteName" readonly="readonly" value="" maxLength="" label="<util:message key='ev.title.group.rootPath'/>" class="txt_400"/>
									<a href="javascript:aGroupManager.getPageChooser().doShow(aGroupManager.setSiteChooserCallback)" class="btn_B"><span><util:message key='ev.title.selectSite'/></span></a>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.securityPermission.creationDate'/></th>
								<td class="L"><input type="text" id="GroupManager_creationDate" name="creationDate" value="" label="<util:message key='ev.prop.securityPermission.creationDate'/>" class="txt_200" /></td>
								<th class="L"><util:message key='ev.prop.securityPrincipal.modifiedDate'/></th>
								<td class="L"><input type="text" id="GroupManager_modifiedDate" name="modifiedDate" value="" label="<util:message key='ev.prop.securityPrincipal.modifiedDate'/>" class="txt_200" /></td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.prop.userpass.principalInfo01'/></th>
								<td colspan="3" class="L">
									<input type="text" id="GroupManager_principalInfo01" name="principalInfo01" value="" maxLength="50" label="<util:message key='ev.prop.userpass.principalInfo01'/>" class="txt_400" />
								</td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.prop.userpass.principalInfo02'/></th>
								<td colspan="3" class="L">
									<input type="text" id="GroupManager_principalInfo02" name="principalInfo02" value="" maxLength="50" label="<util:message key='ev.prop.userpass.principalInfo02'/>" class="txt_400" />
								</td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.prop.userpass.principalInfo03'/></th>
								<td colspan="3" class="L">
									<input type="text" id="GroupManager_principalInfo03" name="principalInfo03" value="" maxLength="50" label="<util:message key='ev.prop.userpass.principalInfo03'/>" class="txt_400" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.securityPrincipal.principalDesc'/></th>
								<td colspan="3" class="L">
									<textarea id="GroupManager_principalDesc" name="principalDesc" value="" cols="65" rows="2" maxLength="80" label="<util:message key='ev.prop.securityPrincipal.principalDesc'/>" class="txt_100" ></textarea>
								</td>
							</tr>
						</table>
					</form>
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea">
					    	<a href="javascript:aGroupManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
						</div>
					</div>
					<!-- btnArea//-->						
				</div>
				<!-- GroupManager_DetailTabPage// -->
				<div id="GroupManager_GroupUserTabPage"></div>
				<div id="GroupManager_GroupRoleTabPage"></div>
				<div id="GroupManager_PagePermissionTabPage" style="width:100%; display:none;"></div>
				<div id="GroupManager_PortletPermissionTabPage" style="width:100%; display:none;"></div>
			</div>
		</div>
		<!-- GroupManager_EditFormPanel// -->			
	</div>
	<!-- detail// -->
	<div id="PageManager_PageChooser" title="Page Chooser">
		<div id="PageChooser_TreeTabPage" class="tree" style="border-right: 0px #ffffff;"></div>
	</div>
	<div id="GroupManager_GroupMenu" title="Group Menu">
	</div>
	<div id="dhtmlx_context_data">
		<div id="onRefresh" text="<util:message key="ev.info.menu.refresh" />" img="${cPath }/admin/images/Service.gif"></div>
		<div id="onCreate" text="<util:message key="ev.info.menu.addGroup" />" img="${cPath }/admin/images/ic_make_page.gif"></div>
		<div id="onMoveUp" text="<util:message key="ev.info.menu.moveUp" />" img="${cPath }/admin/images/ic_up.gif"></div>
		<div id="onMoveDown" text="<util:message key="ev.info.menu.moveDown" />" img="${cPath }/admin/images/ic_down.gif"></div>
		<div id="onDelete" text="<util:message key="ev.info.menu.delete" />" img="${cPath }/admin/images/ic_del_b.gif"></div>
	</div>		
</div>
<!-- sub_contents// -->