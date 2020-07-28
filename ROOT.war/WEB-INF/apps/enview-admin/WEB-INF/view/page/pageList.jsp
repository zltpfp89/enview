<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorPermissionApp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageMetadataManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageComponentManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/principalPermissionManager.js"></script>

<script type="text/javascript">
function initPageManager() {
	if( aPageManager == null ) {
		aPageManager = new PageManager("<c:out value="${evSecurityCode}"/>");
		aPageManager.init();
	}
}
function finishPageManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initPageManager );
	window.attachEvent ( "onunload", finishPageManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initPageManager, false );
	window.addEventListener ( "unload", finishPageManager, false );
}
else
{
    window.onload = initPageManager;
	window.onunload = finishPageManager;
}
</script>



<!-- sub_contents -->
<div class="sub_contents">
	<!-- treeArea -->
	<div class="tree">
		<!-- treewrap -->
		<div class="treewrap resizable">
			<div class="tree_title"><util:message key='ev.title.page.pageTree'/></div>
			<!-- 트리 영역 border로 구분. 지우고 사용해주세요 -->
			<div id="PageManager_TreeTabPage" class="category" style="position:absolute;" >
			</div>
		</div>
		<!-- treewrap //-->
	</div>
	<!-- treeArea //-->
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div class="board first" id="PageManager_mainTabs">
			<ul>
				<li><a href="#PageManager_PreviewTabPage" onclick="aPageManager.doPageEdit();"><util:message key='ev.title.page.pageEdit.tabTitle'/></a></li>
				<li><a href="#PageManager_PageTabPage" ><util:message key='ev.title.page.pageTabTitle'/></a></li>
			</ul>
			<!-- 페이지 편집 -->
			<div id="PageManager_PreviewTabPage" style="display:none;">
				<br style='line-height:5px;'>
				<div style="float:left;">
					<img src='<%=request.getContextPath()%>/decorations/layout/images/magnifier.jpg' hspace='2' align='absmiddle' border='0' style='cursor:hand' title='Maximize Screen' onclick='javascript:aPageManager.toggleMaximize()'>
					<!--img src='<%=request.getContextPath()%>/decorations/layout/images/edit.gif' hspace='2' align='absmiddle' border='0' style='cursor:hand' title='Edit Page' onclick='javascript:aPageManager.togglePageEdit(this)'-->
					<img src='<%=request.getContextPath()%>/decorations/layout/images/save.jpg' hspace='2' align='absmiddle' border='0' style='cursor:hand' title='Save Page' onclick='javascript:aPageManager.doSavePageEdit()'>
				</div>
				<div style="float:right;">
					<util:message key='ev.title.page.pageEditingPageTheme'/> : 
					<select id='PageManager_SelectTheme' name='layout' onchange2='javascript:aPageManager.doChangeTheme(this);'>
						<c:forEach items="${decorationList}" var="decoration">
							<option value='<c:out value="${decoration}"/>' selected><c:out value="${decoration}"/></option>
						</c:forEach>
					</select>
					<img src='<%=request.getContextPath()%>/decorations/layout/images/preview.gif' hspace='2' align='absmiddle' border='0' style='cursor:hand' title='Preview' onclick='javascript:aPageManager.doPreview()'>
				</div>
		
				<IFRAME NAME="PageManagerPageEditPane" ID="PageManager_PreviewPane" SRC="" style="background:#FFFFFF; overflow:auto; width:100%;" ALIGN="BOTTOM" FRAMEBORDER="0" MARGINHEIGHT="0" MARGINWIDTH="0" HEIGHT="900px" SCROLLING="yes">
				</IFRAME>
			</div>
			<!-- 페이지 편집// -->
			
			<!-- 페이지 정보 -->
			<div id="PageManager_PageTabPage">				
				<!-- searchArea-->
				<div class="tsearchArea">
					<p id="PageManager_ListMessage"></p>
					<fieldset>
						<form id="PageManager_SearchForm" name="PageManager_SearchForm" action="javascript:aPageManager.doSearch('PageManager_SearchForm')" onkeydown="if(event.keyCode==13) aPageManager.doSearch('PageManager_SearchForm')" method="post">
							<input type='hidden' name='sortMethod' value='ASC'/>                    
							<input type='hidden' name='sortColumn' value=''/>  
							<input type='hidden' name='pageNo' value='1'/>
							<!--input type='hidden' name='pageSize' value='10'/-->
							<input type='hidden' name='pageFunction' value='aPageManager.doPage'/>
							<input type='hidden' name='formName' value='PageManager_SearchForm'/>
							<input type='hidden' id='PageManager_Master_pageId' name='pageId' value=''/>
							<input type='hidden' id='PageManager_Master_parentId' name='parentId' value=''/>
							<input type='hidden' id='PageManager_Master_domainId' name='domainId' value=''/>
							
							<input type="text" name="pathCond" size="" class="txt_100" value="*<util:message key='ev.prop.page.path'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.property.path'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.property.path'/>*');"/> 
							
							<div class="sel_70">
								<select name="pageSize" class="txt_70">
									<option value="5" selected>5</option>
									<option value="10">10</option>
									<option value="50">50</option>
									<option value="100">100</option>
								</select>
							</div>
							<a href="javascript:aPageManager.doSearch('PageManager_SearchForm');" class="btn_search">
								<span><util:message key='ev.title.search'/></span>
							</a>
						</form>
					</fieldset>
				</div>
				<!-- searchArea//-->
				
				<form id="PageManager_ListForm" style="display:inline" name="PageManager_ListForm" action="" method="post">	
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">  
					<caption>게시판</caption>
						<colgroup>
							<col width="30px" />
							<col width="30px" />
							<col width="*" />
							<col width="*" />
						</colgroup>
						<thead>
							<tr>
								<th class="first">
									<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aPageManager.m_checkBox.chkAll(this)"/>
								</th>
								<th ><span class="table_title">No</span></th>
							
								<th ch="0" onclick="aPageManager.doSort(this, 'PATH');" >
									<span class="table_title"><util:message key='ev.prop.page.path'/></span>
								</th>	
								<th ch="0" onclick="aPageManager.doSort(this, 'NAME');" >
									<span class="table_title"><util:message key='ev.prop.page.name'/></span>
								</th>	
								<th ch="0" onclick="aPageManager.doSort(this, 'SHORT_TITLE');" >
									<span class="table_title"><util:message key='ev.title.property.shortTitle'/></span>
								</th>
							</tr>			
						</thead>
						<tbody id="PageManager_ListBody">
						</tbody>
					</table>
				</form>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="PageManager_PAGE_ITERATOR">				
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
  
				<!-- btnArea-->
				<div class="btnArea"> 
					<div class="rightArea">
						<a href="javascript:aPageManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
					</div>
				</div>
				<!-- btnArea//-->				
			</div>
			<!-- 페이지 정보// -->
		</div>
		<!-- board first// -->
		<!-- board -->
		<div class="board">
			<div id="PageManager_EditFormPanel">
				<div id="PageManager_propertyTabs">
					<ul>
						<li><a href="#PageManager_DetailTabPage"><util:message key='ev.title.page.detailTab'/></a></li>   
						<li><a href="#PageManager_PageMetadataTabPage" onclick="aPageManager.onSelectPropertyTab(1);"><util:message key='ev.title.page.pageMetadataTab'/></a></li>   
						<li><a href="#PageManager_PageComponentTabPage" onclick="aPageManager.onSelectPropertyTab(2);"><util:message key='ev.title.page.pageComponentTab'/></a></li>   
						<li><a href="#PageManager_PrincipalPermissionTabPage" onclick="aPageManager.onSelectPropertyTab(3);"><util:message key='ev.title.page.principalPermission'/></a></li>     
					</ul>

					<div id="PageManager_DetailTabPage">
						<form id="PageManager_EditForm" style="display:inline" action="" method="post">
							<input type="hidden" id="PageManager_isCreate">
							<input type="hidden" id="PageManager_depth" name="depth">	
							<input type="hidden" id="PageManager_sortOrder" name="sortOrder">	
							<input type="hidden" id="PageManager_pageInfo02" name="pageInfo02">	
							<input type="hidden" id="PageManager_pageInfo03" name="pageInfo03">	
							<input type="hidden" id="PageManager_skin" name="skin" value=""/>
							<input type="hidden" id="PageManager_defaultPortletDecorator" name="defaultPortletDecorator"/>
							<input type="hidden" id="PageManager_masterPagePath" name="masterPagePath" />
							<input type="hidden" id="PageManager_isAllowGuest" name="isAllowGuest">
							<input type="hidden" id="PageManager_domainId" name="domainId">
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
								<caption>게시판</caption>
								<colgroup>
									<col width="120px" />
									<col width="*" />
									<col width="120px" />
									<col width="*" />
								</colgroup>							
								<tr>
									<th class="L"><util:message key='ev.prop.page.pageId'/></th>
									<td class="L">
										<input type="text" id="PageManager_pageId" name="pageId" value="<c:out value="${aPageVO.pageId}"/>" maxLength="" label="<util:message key='ev.prop.page.pageId'/>" class="txt_100" />
									</td>
									<th class="L"><util:message key='ev.prop.page.parentId'/></th>
									<td class="L">
										<input type="text" id="PageManager_parentId" name="parentId" value="<c:out value="${aPageVO.parentId}"/>" maxLength="" label="<util:message key='ev.prop.page.parentId'/>" class="txt_100" />
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.page.path'/> <em>*</em></th>
									<td class="L">
										<input type="text" id="PageManager_path" name="path" value="<c:out value="${aPageVO.path}"/>" maxLength="240" label="<util:message key='ev.prop.page.pathh'/>" class="txt_200" readOnly="true"/>
									</td>
									<th class="L"><util:message key='ev.prop.page.name'/> <em>*</em></th>
									<td class="L">
										<input type="text" id="PageManager_name" name="name" value="<c:out value="${aPageVO.name}"/>" maxLength="80" style="IME-MODE:disabled;" onblur="return aPageManager.doCheckPageName(this);" label="<util:message key='ev.prop.page.name'/>" class="txt_200" />
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.page.title'/> <em>*</em></th>
									<td colspan="3" class="L">
										<input type="text" id="PageManager_shortTitle" name="shortTitle" value="<c:out value="${aPageVO.shortTitle}"/>" cols="80" rows="1" maxLength="150" label="<util:message key='ev.prop.page.title'/>" class="txt_400" />
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.title.page.description'/> <em>*</em></th>
									<td colspan="3" class="L">
										<textarea id="PageManager_title" name="title" value="<c:out value="${aPageVO.title}"/>" cols="60" rows="2" maxLength="300" label="<util:message key='ev.title.page.description'/>" class="txt_600" >	</textarea>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.page.systemCode'/> <em>*</em></th>
									<td class="L">
										<div class="sel_100">
											<select id="PageManager_systemCode" name="systemCode" label="<util:message key='ev.prop.page.systemCode'/>" class='txt_100' onchange="javascript:aPageManager.doChangeSystemCode(this)">
												<c:forEach items="${systemCodeList}" var="systemCode">
													<option value="<c:out value="${systemCode.code}"/>"><c:out value="${systemCode.codeName}"/></option>
												</c:forEach>
											</select>
										</div>
									</td>
									<th class="L"><util:message key='ev.prop.page.target'/></th>
									<td class="L">
										<div class="sel_100">
											<select id="PageManager_target" name="target" label="<util:message key='ev.prop.page.target'/>" class='txt_100'>
												<c:forEach items="${targetList}" var="target">
													<option value="<c:out value="${target.code}"/>"><c:out value="${target.codeName}"/></option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.page.pageType'/></th>
									<td class="L">
										<div class="sel_100">
											<select id="PageManager_pageType" name="pageType" label="<util:message key='ev.prop.page.pageType'/>" class='txt_100'>
												<c:forEach items="${pageTypeList}" var="pageType">
													<option value="<c:out value="${pageType.code}"/>"><c:out value="${pageType.codeName}"/></option>
												</c:forEach>
											</select>
										</div>
									</td>
									<th class="L"><util:message key='ev.prop.page.defaultLayoutDecorator'/></th>
									<td class="L">
										<div class="sel_100">
											<select id="PageManager_defaultLayoutDecorator" name="defaultLayoutDecorator" label="<util:message key='ev.prop.page.defaultLayoutDecorator'/>" class='txt_100'>
												<option value=""></option>
												<c:forEach items="${themeList}" var="theme">
													<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr id="PageManager_type_select">
									<th class="L"><util:message key='ev.prop.page.type'/></th>
									<td class="L">
										<div class="sel_100">
											<select id="PageManager_type" name="type" label="<util:message key='ev.prop.page.type'/>" class='txt_100'>
												<c:forEach items="${typeList}" var="type">
													<option value="<c:out value="${type.code}"/>"><c:out value="${type.codeName}"/></option>
												</c:forEach>
											</select>
										</div>
									</td>
									<th class="L"><util:message key='ev.prop.domain.domainCd'/></th>
								    <td class="L">
								        <label  id="domainCode"></label>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.title.page.optionTab'/></th>
									<td colspan="3" class="L">
										<util:message key='ev.prop.page.isHidden'/><input type="checkbox" id="PageManager_isHidden" name="isHidden" value=""  />
										<util:message key='ev.prop.page.isQuickMenu'/><input type="checkbox" id="PageManager_isQuickMenu" name="isQuickMenu" value="" />
										<!--util:message key='ev.title.property.isAllowGuest'/><input type="checkbox" id="PageManager_isAllowGuest" name="isAllowGuest" value="" /-->
										<util:message key='ev.prop.page.isProtected'/><input type="checkbox" id="PageManager_isProtected" name="isProtected" value="" />
										<util:message key='ev.prop.page.useTheme'/><input type="checkbox" id="PageManager_useTheme" name="useTheme" value="" />
										<util:message key='ev.prop.page.useIFrame'/><input type="checkbox" id="PageManager_useIframe" name="useIframe" value="" />
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.title.page.linkPage'/></th>
									<td colspan="3" class="L">
										<input type="hidden" id="PageManager_defaultPageName" name="defaultPageName" value="<c:out value="${aPageVO.defaultPageName}"/>" label="<util:message key='ev.title.page.linkPage'/>"/>
										<input type="text" id="PageManager_defaultPagePath" name="defaultPagePath" value="<c:out value="${aPageVO.defaultPageName}"/>" maxLength="80" class="txt_600" style="width:75%;" readOnly="true"/>
										<span class="btn_pack small PageDetailManager_EditFormButtons"><a href="javascript:aPageManager.selectLinkPage('<util:message key='ev.title.selectPage'/>')"><util:message key='ev.title.selectPage'/></a></span>
										<span class="btn_pack small PageDetailManager_EditFormButtons"><a href="javascript:aPageManager.doResetDefaultPagePath()"><util:message key='ev.title.reset'/></a></span>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.page.url'/></th>
									<td colspan="3" class="L">
										<input type="text" id="PageManager_url" name="url" value="<c:out value="${aPageVO.url}"/>" maxLength="512" label="<util:message key='ev.prop.page.url'/>" class="txt_600"/>
										<!--span class="btn_pack small"><a href="javascript:aPageManager.getPortletChooser().doShow(aPageManager.setPortletChooserCallback)"><util:message key='ev.title.selectPortlet'/></a></span-->
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.page.parameter'/></th>
									<td colspan="3" class="L">
										<input type="text" id="PageManager_parameter" name="parameter" value="<c:out value="${aPageVO.parameter}"/>" maxLength="120" label="<util:message key='ev.prop.page.parameter'/>" class="txt_600" />
									</td>
								</tr>
								<tr>
									<th class="L">
										<util:message key='ev.prop.page.owner'/><br>
									</th>
									<td colspan="3" class="L">
										<input type="hidden" id="PageManager_owner" name="owner" label="<util:message key='ev.prop.page.owner'/>">
										<select id='PageManager_owner_list' size='5' multiple='true' style="width:200px;"></select>
										<a href="javascript:aPageManager.getUserChooser().doShow(aPageManager.setUserChooserCallback)" class="btn_B"><span><util:message key='ev.title.add'/></span></a>
										<a href="javascript:aPageManager.doRemoveOwner()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.page.pageInfo01'/></th>
									<td colspan="3" class="L">
										<input type="text" id="PageManager_pageInfo01" name="pageInfo01" value="<c:out value="${aPageVO.pageInfo01}"/>" maxLength="100" label="<util:message key='ev.prop.page.pageInfo01'/>" class="txt_600" />
									</td>
								</tr>
							</table>
							<!-- btnArea-->
							<div class="btnArea"> 
								<div class="rightArea">
									<a href="javascript:aPageManager.doUpdate(true)" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
								</div>
							</div>
							<!-- btnArea//-->	
						</form>
					</div>
					<div id="PageManager_PageMetadataTabPage"></div>
					<div id="PageManager_PageComponentTabPage"></div>
					<div id="PageManager_PrincipalPermissionTabPage"></div>									
				</div>
			</div>
		</div>
		<!-- board// -->
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="PageManager_PageChooser" title="Page Chooser">
	<div id="PageChooser_TreeTabPage" class="tree" style="border-right: 0px #ffffff;"></div>
</div>
<div id="PortletSelectorAppDialog" title="<util:message key='ev.title.page.portletSelectorName'/>" style="display:none;">
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
		<tr>
			<td valign='top'>
				<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
					<tr>
						<td width="180px" style="background:#FFFFFF;" valign="top">
							<span>
								<select id='PortletSelectorCategoryTypeSelect' name='type' style='width:100%' class='webdropdownlist' onchange='javascript:portalPortletSelectorApp.changeCategory(this)'>
								<option value='portlet'><util:message key='ev.title.page.portletSelectorPortletCategory'/></option>
								<option value='enview-bbs'><util:message key='ev.title.page.portletSelectorBBSCategory'/></option>
								<option value='enview-cms'><util:message key='ev.title.page..portletSelectorCMSCategory'/></option>
								</select>
							</span>
							<div class="webpanel">
								<div id="PortletSelectorAppTreeTabPage" style="width:100%; height:250px;"></div>
							</div>
						</td>
						<td valign="top">
							<form id='PortletSelectorAppSearchForm' name='PortletSelectorAppSearchForm' style='display:inline' action="javascript:portalPortletSelectorApp.doPortletSearch('PortletSelectorAppSearchForm')" method='post'>
								<input type='hidden' name='sortMethod' value='ASC'/>
								<input type='hidden' name='sortColumn' value=''/>
								<input type='hidden' name='pageNo' value='1'/>
								<input type='hidden' name='pageSize' value='7'/> 
								<input type='hidden' name='pageFunction' value='portalPortletSelectorApp.doPortletPage'/>
								<input type='hidden' name='formName' value='PortletSelectorAppSearchForm'/>
								<input type='hidden' id='PortletSelectorApp_categoryId' name='categoryId' >
								<input type='hidden' id='PortletSelectorApp_categoryType' name='categoryType'  value='portlet'>
								<table width='100%' border='0' cellspacing='0' cellpadding='0'>
									<tr>
										<td align='right'>
											<input type='text' name='title0Cond' size='20' class='portlet-form-field-label' value="*<util:message key='ev.title.page.portletSelectorPortletName'/>*" onfocus="portalPage.getUtility().setFieldFocus(this,'*<util:message key='ev.title.page.portletSelectorPortletName'/>*');" onblur="portalPage.getUtility().setFieldBlur(this,'*<util:message key='ev.title.page.portletSelectorPortletName'/>*');">
											<input type='image' src='<%=request.getContextPath()%>/decorations/layout/images/button/<c:out value="${langKnd}"/>/btn_search.gif' hspace='2' align='absmiddle' style='cursor:hand'>
										</td>
									</tr>
								</table>
							</form>
							<form id='PortletSelectorAppListForm' style='display:inline' name='PortletSelectorListForm' action='' method='post'>
								<table class='webgridpanel' style='width:100%;' cellpadding='0' cellspacing='0' id='grid-table'>
									<thead>
										<tr><td colspan='3' class='webgridheaderline'></td></tr>
										<tr style='cursor: pointer;'>
											<th class="webgridheader" align="center" width="30px"></th>
											<th ch='0' class='webgridheader' width='30px'>&nbsp;</th>
											<th ch='0' class='webgridheaderlast' width='250px' onclick="portalPortletSelectorApp.doPortletSort(this, 'DISPLAY_NAME');" >
												<span><util:message key='ev.title.page.portletSelectorPortletName'/></span>
											</th>
										</tr>
									</thead>
									<tbody id='PortletSelectorAppListBody'></tbody>
									<table style='width:100%;' class='webbuttonpanel'>
										<tr>
											<td align='center'>
												<div id='PORTLETSELECTOR_APP_PAGE_ITERATOR' class="webnavigationpanel"></div>
											</td>
										</tr>
									</table>
								</table>
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<div id="UserManager_UserChooser" title="User Chooser"></div>
<div id="GroupManager_GroupChooser" title="Group Chooser"></div>
<div id="RoleManager_RoleChooser" title="Role Chooser"></div>
<div id="PortletCategoryManager_PortletCategoryChooser"></div>
<div id="PageManager_ExcelUploader" title="<util:message key='ev.title.excelUpload'/>" style="display:none;">
	<form id="PageManager_excelFileForm" name="PageManager_excelFileForm" style="display:inline" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
		<table cellpadding=0 cellspacing=0 border=0 width='100%'>
			<tr>
	  			<td class="L">&nbsp;</td>
			</tr>
			<tr>
	  			<td class="L"><util:message key='ev.title.selectExcelFile'/></td>
			</tr>
			<tr>
	  			<td class="L">
					<input type="file" id="PageManager_excelFile" name="file" class="full_webtextfield" style="width:98%"/>
		  		</td>
			</tr>
		</table>
	</form>
	<iframe name='importExcelIF' frameborder=0 width=0 height=0></iframe>
</div>
<iframe id='exportExcelIF' frameborder=0 width=0 height=0></iframe>
<div id="PageManager_PageMenu" title="Page Menu"></div>
<div id="dhtmlx_context_data">
	<div id="onRefresh" text="<util:message key="ev.info.menu.refresh" />" img="${cPath }/admin/images/Service.gif"></div>
	<div id="onCreate" text="<util:message key="ev.info.menu.addPage" />" img="${cPath }/admin/images/ic_make_page.gif"></div>
	<div id="onDelete" text="<util:message key="ev.info.menu.delete" />" img="${cPath }/admin/images/ic_del_b.gif"></div>
	<div id="onMoveUp" text="<util:message key="ev.info.menu.moveUp" />" img="${cPath }/admin/images/ic_up.gif"></div>
	<div id="onMoveDown" text="<util:message key="ev.info.menu.moveDown" />" img="${cPath }/admin/images/ic_down.gif"></div>
	
	<div id="onMove" text="<util:message key="ev.info.menu.movePage" />" img="${cPath }/admin/images/movePage.png"></div>
	<div id="onCopy" text="<util:message key="ev.info.menu.copyPage" />" img="${cPath }/admin/images/copyPage.png"></div>
	
	<div id="onImportExcel" text="<util:message key="ev.info.menu.loadExcel" />" img="${cPath }/admin/images/import.png"></div>
	<div id="onExportExcel" text="<util:message key="ev.info.menu.saveExcel" />" img="${cPath }/admin/images/export.png"></div>
</div>