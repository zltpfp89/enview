
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/urlPermissionManager.js"></script>

<!-- UrlPermissionManager_UrlPermissionTabPage -->
<div id="UrlPermissionManager_UrlPermissionTabPage">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="UrlPermissionManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="UrlPermissionManager_SearchForm" name="UrlPermissionManager_SearchForm" style="display:inline" action="javascript:aUrlPermissionManager.doSearch('UrlPermissionManager_SearchForm')"  onkeydown="if(event.keyCode==13) aUrlPermissionManager.doSearch('UrlPermissionManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aUrlPermissionManager.doPage'/>
				<input type='hidden' name='formName' value='UrlPermissionManager_SearchForm'/>
			 	<input type='hidden' id='UrlPermissionManager_Master_principalId' name='principalId' value=''/>
				<input type='hidden' id='UrlPermissionManager_Master_domainId' name='domainId' value=''/>
				<input type="hidden" id="UrlPermissionManager_Master_principalType" name="principalType" />
				
				<input type="text" name="titleCond" size="30" class="txt_100" value="*<util:message key='ev.prop.securityPermission.title'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPermission.title'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPermission.title'/>*');"/> 
				
				<div class="sel_70">
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select>
				</div>
				<a href="javascript:aUrlPermissionManager.doSearch('UrlPermissionManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
			</form>						
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="UrlPermissionManager_ListForm" style="display:inline" name="UrlPermissionManager_ListForm" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="30px" />
				<col width="30px" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
			</colgroup>		
			<thead>
				<tr>
					<th class="first">
						<input type="checkbox" id="delCheck" onclick="aUrlPermissionManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
					
					<th class="C" ch="0" onclick="aUrlPermissionManager.doSort(this, 'PERMISSION_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.permissionId'/></span>
					</th>	
					<th class="C" ch="0" onclick="aUrlPermissionManager.doSort(this, 'PRINCIPAL_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.principalId'/></span>
					</th>	
					<th class="C" ch="0" onclick="aUrlPermissionManager.doSort(this, 'TITLE');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.title'/></span>
					</th>	
					<th class="C" ch="0" onclick="aUrlPermissionManager.doSort(this, 'RES_URL');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.resUrl'/></span>
					</th>		
				</tr>
			</thead>
			<tbody id="UrlPermissionManager_ListBody">
				<c:forEach items="${results}" var="urlpermission" varStatus="status">
					<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;">
						<td class="C">
							<input type="checkbox" id="UrlPermissionManager[<c:out value="${status.index}"/>].checkRow" />
						
							<input type="hidden" id="UrlPermissionManager[<c:out value="${status.index}"/>].permissionId" value="<c:out value='${urlpermission.permissionId}'/>"/>
						</td>
						<td class="C">
							<span><c:out value="${status.index}"/></span>
						</td>
						
						<td class="L" onclick="aUrlPermissionManager.doSelect(this)">
							<span id="UrlPermissionManager[<c:out value="${status.index}"/>].permissionId.label">&nbsp;<c:out value="${urlpermission.permissionId}"/></span>
						</td>
						<td class="L" onclick="aUrlPermissionManager.doSelect(this)">
							<span id="UrlPermissionManager[<c:out value="${status.index}"/>].principalId.label">&nbsp;<c:out value="${urlpermission.principalId}"/></span>
						</td>
						<td class="L" onclick="aUrlPermissionManager.doSelect(this)">
							<span id="UrlPermissionManager[<c:out value="${status.index}"/>].title.label">&nbsp;<c:out value="${urlpermission.title}"/></span>
						</td>
						<td class="L" onclick="aUrlPermissionManager.doSelect(this)">
							<span id="UrlPermissionManager[<c:out value="${status.index}"/>].resUrl.label">&nbsp;<c:out value="${urlpermission.resUrl}"/></span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	 </form>
	<div class="tsearchArea">
		<p id="UrlPermissionManager_ListMessage"><c:out value='${resultMessage}'/></p>
	</div>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="UrlPermissionManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aUrlPermissionManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aUrlPermissionManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
	<!-- UrlPermissionManager_EditFormPanel -->
	<div id="UrlPermissionManager_EditFormPanel" class="board" > 
		<!-- UrlPermissionManager_propertyTabs -->
		<div id="UrlPermissionManager_propertyTabs">
			<ul>
				<li><a href="#UrlPermissionManager_DetailTabPage"><util:message key='ev.title.security.detailTab'/></a></li>   
			</ul>
			<!-- UrlPermissionManager_DetailTabPage -->
			<div id="UrlPermissionManager_DetailTabPage">
				<form id="UrlPermissionManager_EditForm" style="display:inline" action="" method="post">
					<input type="hidden" id="UrlPermissionManager_isCreate">
					<input type="hidden" id="UrlPermissionManager_permissionId" name="permissionId"/>
					<input type="hidden" id="UrlPermissionManager_principalId" name="principalId"/>
					<input type="hidden" id="UrlPermissionManager_domainId" name="domainId"/>
					<input type="hidden" id="UrlPermissionManager_title" name="title"/>
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<caption>게시판</caption>
						<colgroup>
							<col width="140px" />
							<col width="*" />
							<col width="140px" />
							<col width="*" />
						</colgroup>					
						<tr >
							<th class="L"><util:message key='ev.prop.securityPermission.resType'/></th>
							<td class="L">
								<div class="sel_100">
									<select id="UrlPermissionManager_resType" name="resType" class='txt_100'>
										<option value="4">URL</option>
									</select>
								</div>
							</td>
							<th class="L"><util:message key='ev.prop.securityPermission.isAllow'/></th>
							<td class="L"><input type="checkbox" id="UrlPermissionManager_isAllow" name="isAllow" value="" /></td>
						</tr>
						<tr >
							<th class="L"><util:message key='ev.prop.securityPermission.resUrl'/></th>
							<td colspan="3" class="L">
								<input type="text" id="UrlPermissionManager_resUrl" name="resUrl" value="" maxLength="250" class="txt_100" style="width:99%;"/>
								<!--span class="btn_pack small"><a href="javascript:aUrlPermissionManager.getUrlChooser().doShow(aUrlPermissionManager.setMultipleUrlChooserCallback)"><util:message key='ev.title.selectUrl'/></a></span-->
							</td>
						</tr>
						<tr >
							<th class="L"><util:message key='ev.prop.securityPermission.actionMask'/> <input id="UrlPermissionManager_actionMask_check" type="checkbox" onclick="aUrlPermissionManager.toggleAllPermission()" ></th>
							<td colspan="3" class="L">
								<input type="hidden" id="UrlPermissionManager_actionMask" name="actionMask" value="" maxLength="" />
								<c:forEach items="${authorityCategory}" var="authority">
									<input type="checkbox" id="UrlPermissionManager_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>" ><c:out value="${authority.codeName}"/> &nbsp;&nbsp;
								</c:forEach>
							</td>
						</tr>
						<tr >
							<th class="L"><util:message key='ev.prop.securityPermission.creationDate'/></th>
							<td class="L"><input type="text" id="UrlPermissionManager_creationDate" name="creationDate" value="" class="txt_145" /></td>
							<th class="L"><util:message key='ev.prop.securityPermission.modifiedDate'/></th>
							<td class="L"><input type="text" id="UrlPermissionManager_modifiedDate" name="modifiedDate" value="" class="txt_145" /></td>
						</tr>
					</table>
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea">
							<a href="javascript:aUrlPermissionManager.doUpdate()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
						</div>
					</div>
					<!-- btnArea//-->
				</form>
			</div>
			<!-- UrlPermissionManager_DetailTabPage// -->
		</div>
		<!-- UrlPermissionManager_propertyTabs// -->
	</div>
	<!-- UrlPermissionManager_EditFormPanel// -->	
</div>
<!-- UrlPermissionManager_UrlPermissionTabPage// -->

<div id="UrlSelectorAppDialog" title="<util:message key='ev.title.security.urlSelectorName'/>" style="display:none;">
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td width="180px" style="background:#FFFFFF;" valign="top">
					<span>
						<select id='UrlSelectorCategoryTypeSelect' name='type' style='width:100%' class='webdropdownlist' onchange='javascript:portalUrlSelectorApp.changeCategory(this)'>
						<option value='url'><util:message key='ev.title.security.urlSelectorUrlCategory'/></option>
						<option value='enview-bbs'><util:message key='ev.title.security.urlSelectorBBSCategory'/></option>
						<option value='enview-cms'><util:message key='ev.title.security.urlSelectorCMSCategory'/></option>
						</select>
					</span>
					<div class="webpanel">
						<div id="UrlSelectorAppTreeTabPage" style="width:100%; height:250px;"></div>
					</div>
				</td>
				<td valign="top">
					<form id='UrlSelectorAppSearchForm' name='UrlSelectorAppSearchForm' style='display:inline' action="javascript:portalUrlSelectorApp.doUrlSearch('UrlSelectorAppSearchForm')" method='post'>
						<input type='hidden' name='sortMethod' value='ASC'/>
						<input type='hidden' name='sortColumn' value=''/>
						<input type='hidden' name='pageNo' value='1'/>
						<input type='hidden' name='pageSize' value='7'/> 
						<input type='hidden' name='pageFunction' value='portalUrlSelectorApp.doUrlPage'/>
						<input type='hidden' name='formName' value='UrlSelectorAppSearchForm'/>
						<input type='hidden' id='UrlSelectorApp_categoryId' name='categoryId' >
						<input type='hidden' id='UrlSelectorApp_categoryType' name='categoryType'  value='url'>
						<table width='100%' border='0' cellspacing='0' cellpadding='0'>
						<tr>
							<td align='right'>
								<input type='text' name='title0Cond' size='20' class='url-form-field-label' value="*<util:message key='ev.title.security.urlSelectorUrlName'/>*" onfocus="portalPage.getUtility().setFieldFocus(this,'*<util:message key='pt.ev.urlSelectorUrlName'/>*');" onblur="portalPage.getUtility().setFieldBlur(this,'*<util:message key='pt.ev.urlSelectorUrlName'/>*');">
								<input type='image' src='<%=request.getContextPath()%>/decorations/layout/images/button/<c:out value="${langKnd}"/>/btn_search.gif' hspace='2' align='absmiddle' style='cursor:hand'>
							</td>
						</tr>
						</table>
					</form>
					<form id='UrlSelectorAppListForm' style='display:inline' name='UrlSelectorListForm' action='' method='post'>
						<table class='webgridpanel' style='width:100%;' cellpadding='0' cellspacing='0' id='grid-table'>
							<thead>
								<tr> <td colspan='3' class='webgridheaderline'></td></tr>
								<tr style='cursor: pointer;'>
									<th class="webgridheader" align="center" width="30px"></th>
									<th ch='0' class='webgridheader' width='30px'>&nbsp;</th>
									<th ch='0' class='webgridheaderlast' width='250px' onclick="portalUrlSelectorApp.doUrlSort(this, 'DISPLAY_NAME');" >
										<span><util:message key='ev.title.security.urlSelectorUrlName'/></span>
									</th>
								</tr>
							</thead>
							<tbody id='UrlSelectorAppListBody'></tbody>
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

<div id="UrlSelectorPermissionAppDialog" title="<util:message key='ev.title.security.urlSelectorName'/>" style="display:none;">
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<!--td width="180px" style="background:#FFFFFF;" valign="top">
					<span style="width:100%; height:22px;"><font size="2"><util:message key='pt.ev.property.urlCategoryTree'/></font>
						<select id='UrlSelectorPermissionAppCategoryTypeSelect' name='type' style='width:100%' class='webdropdownlist' onchange='javascript:portalUrlSelectorPermissionAppApp.changeCategory(this)'>
						<option value='url'><util:message key='pt.ev.urlSelectorUrlCategory'/></option>
						<option value='enview-bbs'><util:message key='pt.ev.urlSelectorBBSCategory'/></option>
						<option value='enview-cms'><util:message key='pt.ev.urlSelectorCMSCategory'/></option>
						</select>
					</span>
					<div class="webpanel">
						<div id="UrlSelectorPermissionAppTreeTabPage" style="width:100%; height:250px;"></div>
					</div>
				</td-->
				<td valign="top">
					<form id='UrlSelectorPermissionAppSearchForm' name='UrlSelectorPermissionAppSearchForm' style='display:inline' action="javascript:portalUrlSelectorPermissionApp.doUrlSearch('UrlSelectorPermissionAppSearchForm')" onkeydown="if(event.keyCode==13) portalUrlSelectorPermissionAppApp.doUrlSearch('UrlSelectorPermissionAppSearchForm')" method='post'>
						<input type='hidden' name='sortMethod' value='ASC'/>
						<input type='hidden' name='sortColumn' value=''/>
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='7'/--> 
						<input type='hidden' name='pageFunction' value='portalUrlSelectorPermissionApp.doUrlPage'/>
						<input type='hidden' name='formName' value='UrlSelectorPermissionAppSearchForm'/>
						<input type='hidden' id='UrlSelectorPermissionApp_categoryId' name='categoryId' >
						<input type='hidden' id='UrlSelectorPermissionApp_categoryType' name='categoryType'  value='url'>
						<table width='100%' border='0' cellspacing='0' cellpadding='0'>
						<tr>
							<td align='right'>
								<select id="UrlSelectorPermissionApp__urlCategory" name="urlCategory" class='webdropdownlist'>
									<option value=""><util:message key='ev.title.security.urlCategoryTree'/></option> 
									<c:forEach items="${urlCategory}" var="category">
									<option value="<c:out value="${category}"/>"><c:out value="${category}"/></option>
									</c:forEach>
								</select>
								<input type='text' name='title0Cond' size='20' class='url-form-field-label' value="*<util:message key='ev.title.security.urlSelectorUrlName'/>*" onfocus="portalPage.getUtility().setFieldFocus(this,'*<util:message key='ev.title.security.urlSelectorUrlName'/>*');" onblur="portalPage.getUtility().setFieldBlur(this,'*<util:message key='ev.title.security.urlSelectorUrlName'/>*');">
								<select name='pageSize'>
									<option value="5">5</option>
									<option value="10" selected>10</option>
									<option value="20" >20</option>
									<option value="50">50</option>
									<option value="100">100</option>
								</select>
								<span class="btn_pack small"><a href="javascript:portalUrlSelectorPermissionApp.doUrlSearch('UrlSelectorPermissionAppSearchForm')"><util:message key='ev.title.search'/></a></span>
							</td>
						</tr>
						</table>
					</form>
					<form id='UrlSelectorPermissionAppListForm' style='display:inline' name='UrlSelectorPermissionAppListForm' action='' method='post'>
						<div style="overflow:auto; width:100%; height:230px;">
						<table class='webgridpanel' style='width:100%;' cellpadding='0' cellspacing='0' id='grid-table'>
							<thead>
								<tr> <td colspan='3' class='webgridheaderline'></td></tr>
								<tr style='cursor: pointer;'>
									<th class="webgridheader" align="center" width="30px">
										<input type="checkbox" id="delCheck" class="webcheckbox" onclick="portalUrlSelectorPermissionApp.m_checkBox.chkAll(this)"/>
									</th>
									<th class="webgridheader" align="center" width="30px"></th>
									<th ch='0' class='webgridheaderlast' width='250px' onclick="portalUrlSelectorPermissionApp.doUrlSort(this, 'DISPLAY_NAME');" >
										<span><util:message key='ev.title.security.urlSelectorUrlName'/></span>
									</th>
								</tr>
							</thead>
							<tbody id='UrlSelectorPermissionAppListBody'></tbody>
						</table>
						</div>
							<table style='width:100%;' class='webbuttonpanel'>
								<tr>
									<td align='center'>
										<div id='PORTLETSELECTOR_PAGE_ITERATOR' class="webnavigationpanel"></div>
									</td>
								</tr>
							</table>
					</form>
				</td>
			</tr>
			
			</table>
		</td>
	</tr>
	</table>
	<form id="UrlSelectorPermissionChooser_EditForm" style="display:inline" action="" method="post">
	<table style="width:100%;" height="50px" class="webformpanel">
		<tr> 
			<td colspan="2" width="100%" class="webformheaderline"></td>
		</tr>
		<tr id="UrlSelectorPermission.AllowPane">
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;<util:message key='ev.title.security.checkType'/></td>
			<td class="webformfield">
				<input type="radio" id="UrlSelectorPermission_allow" name="perm_allowed" checked value="1" class="webradiogroup"><util:message key='ev.title.security.allow'/> &nbsp;&nbsp;
				<input type="radio" id="UrlSelectorPermission_deny" name="perm_allowed" value="0" class="webradiogroup"><util:message key='ev.title.security.deny'/> &nbsp;&nbsp;
			</td>
		</tr>
		<tr id="UrlSelectorPermission.Permission">
			<td width="20%" class="webformlabel">
				<img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;<util:message key='ev.title.security.page.authority'/>
				<input type="checkbox" align="right" class="webcheckbox" onclick="aUrlPermissionManager.m_checkBox.chkAll(this)"/>
			</td>
			<td>
				<div class="webpanel">
			<c:forEach items="${authorityCategory}" var="authority">
				<input type="checkbox" id="UrlSelectorPermission_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>" class="webradiogroup"><c:out value="${authority.codeName}"/> &nbsp;&nbsp;
			</c:forEach>
				</div>
			</td>
		</tr>
	</table>
	</form>
</div>