
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletPermissionManager.js"></script>

<!-- PortletPermissionManager_PortletPermissionTabPage -->
<div id="PortletPermissionManager_PortletPermissionTabPage">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="PortletPermissionManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="PortletPermissionManager_SearchForm" name="PortletPermissionManager_SearchForm" style="display:inline" action="javascript:aPortletPermissionManager.doSearch('PortletPermissionManager_SearchForm')"  onkeydown="if(event.keyCode==13) aPortletPermissionManager.doSearch('PortletPermissionManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aPortletPermissionManager.doPage'/>
				<input type='hidden' name='formName' value='PortletPermissionManager_SearchForm'/>
			 	<input type='hidden' id='PortletPermissionManager_Master_domainId' name='domainId'/>
				<input type='hidden' id='PortletPermissionManager_Master_principalId' name='principalId' value=''/>
				<input type="hidden" id="PortletPermissionManager_Master_principalType" name="principalType" />

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
				<a href="javascript:aPortletPermissionManager.doSearch('PortletPermissionManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>  
			</form>		
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="PortletPermissionManager_ListForm" style="display:inline" name="PortletPermissionManager_ListForm" action="" method="post">
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
						<input type="checkbox" id="delCheck" onclick="aPortletPermissionManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
					
					<th class="C" ch="0" onclick="aPortletPermissionManager.doSort(this, 'PERMISSION_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.permissionId'/></span>
					</th>	
					<th class="C" ch="0" onclick="aPortletPermissionManager.doSort(this, 'PRINCIPAL_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.principalId'/></span>
					</th>	
					<th class="C" ch="0" onclick="aPortletPermissionManager.doSort(this, 'TITLE');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.title'/></span>
					</th>	
					<th class="C" ch="0" onclick="aPortletPermissionManager.doSort(this, 'RES_URL');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.resUrl'/></span>
					</th>		
				</tr>
			</thead>
			<tbody id="PortletPermissionManager_ListBody">
				<c:forEach items="${results}" var="portletpermission" varStatus="status">
					<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;">
						<td class="C">
							<input type="checkbox" id="PortletPermissionManager[<c:out value="${status.index}"/>].checkRow"/>
						
							<input type="hidden" id="PortletPermissionManager[<c:out value="${status.index}"/>].permissionId" value="<c:out value='${portletpermission.permissionId}'/>"/>
						</td>
						<td class="C">
							<c:out value="${status.index}"/>
						</td>
						<td class="L" onclick="aPortletPermissionManager.doSelect(this)">
							<span id="PortletPermissionManager[<c:out value="${status.index}"/>].permissionId.label">&nbsp;<c:out value="${portletpermission.permissionId}"/></span>
						</td>
						<td class="L" onclick="aPortletPermissionManager.doSelect(this)">
							<span id="PortletPermissionManager[<c:out value="${status.index}"/>].principalId.label">&nbsp;<c:out value="${portletpermission.principalId}"/></span>
						</td>
						<td class="L" onclick="aPortletPermissionManager.doSelect(this)">
							<span id="PortletPermissionManager[<c:out value="${status.index}"/>].title.label">&nbsp;<c:out value="${portletpermission.title}"/></span>
						</td>
						<td class="L" onclick="aPortletPermissionManager.doSelect(this)">
							<span id="PortletPermissionManager[<c:out value="${status.index}"/>].resUrl.label">&nbsp;<c:out value="${portletpermission.resUrl}"/></span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="PortletPermissionManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aPortletPermissionManager.getPortletChooser().doShow(aPortletPermissionManager.setMultiplePortletChooserCallback)" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aPortletPermissionManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
	<!-- PortletPermissionManager_EditFormPanel -->
	<div id="PortletPermissionManager_EditFormPanel" class="board" >
		<!-- PortletPermissionManager_propertyTabs -->
		<div id="PortletPermissionManager_propertyTabs">
			<ul>
				<li><a href="#PortletPermissionManager_DetailTabPage"><util:message key='ev.title.security.detailTab'/></a></li>   
			</ul>
			<!-- PortletPermissionManager_DetailTabPage -->
			<div id="PortletPermissionManager_DetailTabPage">
				<form id="PortletPermissionManager_EditForm" style="display:inline" action="" method="post">
					<input type="hidden" id="PortletPermissionManager_isCreate">
					<input type="hidden" id="PortletPermissionManager_permissionId" name="permissionId"/>
					<input type="hidden" id="PortletPermissionManager_principalId" name="principalId"/>
					<input type="hidden" id="PortletPermissionManager_title" name="title"/>
					<input type='hidden' id='PortletPermissionManager_domainId' name='domainId'/>
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<caption>게시판</caption>
						<colgroup>
							<col width="140px" />
							<col width="*" />
							<col width="140px" />
							<col width="*" />
						</colgroup>					
						<tr>
							<th class="L"><util:message key='ev.prop.securityPermission.resType'/></th>
							<td class="L">
								<div class="sel_100">
									<select id="PortletPermissionManager_resType" name="resType" class='txt_100'>
										<option value="2">Portlet</option>
										<!--option value="3">Portlet Pattern</option-->
									</select>
								</div>
							</td>
							<th class="L"><util:message key='ev.prop.securityPermission.isAllow'/></th>
							<td class="L"><input type="checkbox" id="PortletPermissionManager_isAllow" name="isAllow" value="" class="txt_100" /></td>
						</tr>
						<tr>
							<th class="L"><util:message key='ev.prop.securityPermission.resUrl'/></th>
							<td colspan="3" class="L">
								<input type="text" id="PortletPermissionManager_resUrl" name="resUrl" value="" maxLength="250" class="txt_100" style="width:99%;"/>
								<!--span class="btn_pack small"><a href="javascript:aPortletPermissionManager.getPortletChooser().doShow(aPortletPermissionManager.setMultiplePortletChooserCallback)"><util:message key='ev.title.selectPortlet'/></a></span-->
							</td>
						</tr>
						<tr>
							<th class="L"><util:message key='ev.prop.securityPermission.actionMask'/> <input id="PortletPermissionManager_actionMask_check" type="checkbox" onclick="aPortletPermissionManager.toggleAllPermission()"></th>
							<td colspan="3" class="L">
								<input type="hidden" id="PortletPermissionManager_actionMask" name="actionMask" value="" maxLength="" class="txt_100" />
								<c:forEach items="${authorityCategory}" var="authority">
									<input type="checkbox" id="PortletPermissionManager_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>"><c:out value="${authority.codeName}"/> &nbsp;&nbsp;
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th class="L"><util:message key='ev.prop.securityPermission.creationDate'/></th>
							<td class="L"><input type="text" id="PortletPermissionManager_creationDate" name="creationDate" value="" class="txt_145" /></td>
							<th class="L"><util:message key='ev.prop.securityPermission.modifiedDate'/></th>
							<td class="L"><input type="text" id="PortletPermissionManager_modifiedDate" name="modifiedDate" value="" class="txt_145" /></td>
						</tr>
					</table>
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea">
							<a href="javascript:aPortletPermissionManager.doUpdate()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
						</div>
					</div>
					<!-- btnArea//-->					
				</form>
			</div>
			<!-- PortletPermissionManager_DetailTabPage// -->
		</div>
		<!-- PortletPermissionManager_propertyTabs// -->
	</div>
	<!-- PortletPermissionManager_EditFormPanel// -->
</div>
<!-- PortletPermissionManager_PortletPermissionTabPage// -->

<div id="PortletSelectorAppDialog" title="<util:message key='ev.title.security.portletSelectorName'/>" style="display:none;">
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td width="180px" style="background:#FFFFFF;" valign="top">
					<span>
						<select id='PortletSelectorCategoryTypeSelect' name='type' style='width:100%' class='webdropdownlist' onchange='javascript:portalPortletSelectorApp.changeCategory(this)'>
						<option value='portlet'><util:message key='ev.title.security.portletSelectorPortletCategory'/></option>
						<option value='enview-bbs'><util:message key='ev.title.security.portletSelectorBBSCategory'/></option>
						<option value='enview-cms'><util:message key='ev.title.security.portletSelectorCMSCategory'/></option>
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
								<input type='text' name='title0Cond' size='20' class='portlet-form-field-label' value="*<util:message key='ev.title.security.portletSelectorPortletName'/>*" onfocus="portalPage.getUtility().setFieldFocus(this,'*<util:message key='pt.ev.portletSelectorPortletName'/>*');" onblur="portalPage.getUtility().setFieldBlur(this,'*<util:message key='pt.ev.portletSelectorPortletName'/>*');">
								<input type='image' src='<%=request.getContextPath()%>/decorations/layout/images/button/<c:out value="${langKnd}"/>/btn_search.gif' hspace='2' align='absmiddle' style='cursor:hand'>
							</td>
						</tr>
						</table>
					</form>
					<form id='PortletSelectorAppListForm' style='display:inline' name='PortletSelectorListForm' action='' method='post'>
						<table class='webgridpanel' style='width:100%;' cellpadding='0' cellspacing='0' id='grid-table'>
							<thead>
								<tr> <td colspan='3' class='webgridheaderline'></td></tr>
								<tr style='cursor: pointer;'>
									<th class="webgridheader" align="center" width="30px"></th>
									<th ch='0' class='webgridheader' width='30px'>&nbsp;</th>
									<th ch='0' class='webgridheaderlast' width='250px' onclick="portalPortletSelectorApp.doPortletSort(this, 'DISPLAY_NAME');" >
										<span><util:message key='ev.title.security.portletSelectorPortletName'/></span>
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

<div id="PortletSelectorPermissionAppDialog" title="<util:message key='ev.title.security.portletSelectorName'/>" class="board" style="display:none;">
	<form id='PortletSelectorPermissionAppSearchForm' name='PortletSelectorPermissionAppSearchForm' style='display:inline' action="javascript:portalPortletSelectorPermissionApp.doPortletSearch('PortletSelectorPermissionAppSearchForm')" onkeydown="if(event.keyCode==13) portalPortletSelectorPermissionApp.doPortletSearch('PortletSelectorPermissionAppSearchForm')" method='post'>
		<input type='hidden' name='sortMethod' value='ASC'/>
		<input type='hidden' name='sortColumn' value=''/>
		<input type='hidden' name='pageNo' value='1'/>
		<!--input type='hidden' name='pageSize' value='7'/--> 
		<input type='hidden' name='pageFunction' value='portalPortletSelectorPermissionApp.doPortletPage'/>
		<input type='hidden' name='formName' value='PortletSelectorPermissionAppSearchForm'/>
		<input type='hidden' id='PortletSelectorPermissionApp_categoryId' name='categoryId' >
		<input type='hidden' id='PortletSelectorPermissionApp_categoryType' name='categoryType'  value='portlet'>
		
		<div class="sel_120">
			<select id="PortletSelectorPermissionApp__portletCategory" name="portletCategory" class='txt_120'>
				<option value=""><util:message key='ev.title.security.portletCategoryTree'/></option> 
				<c:forEach items="${portletCategory}" var="category">
					<option value="<c:out value="${category}"/>"><c:out value="${category}"/></option>
				</c:forEach>
			</select>
		</div>	
					
		<input type='text' name='title0Cond' size="20" class='txt_100' value="*<util:message key='ev.title.security.portletSelectorPortletName'/>*" onfocus="portalPage.getUtility().setFieldFocus(this,'*<util:message key='ev.title.security.portletSelectorPortletName'/>*');" onblur="portalPage.getUtility().setFieldBlur(this,'*<util:message key='ev.title.security.portletSelectorPortletName'/>*');">
		
		<div class="sel_70">
			<select name='pageSize' class="txt_70">
				<option value="5">5</option>
				<option value="10" selected>10</option>
				<option value="20" >20</option>
				<option value="50">50</option>
				<option value="100">100</option>
			</select>
		</div>
		<a href="javascript:portalPortletSelectorPermissionApp.doPortletSearch('PortletSelectorPermissionAppSearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
	</form>
	<form id='PortletSelectorPermissionAppListForm' style='display:inline' name='PortletSelectorPermissionAppListForm' action='' method='post'>
		<div style="overflow:auto; width:100%; height:230px;">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="30px" />
					<col width="250px" />
					<col width="148px" />
				</colgroup>			
				<thead>
					<tr style='cursor: pointer;'>
						<th class="C">
							<input type="checkbox" id="delCheck" onclick="portalPortletSelectorPermissionApp.m_checkBox.chkAll(this)"/>
						</th>
						<th class="C"></th>
						<th ch='0' class='C' onclick="portalPortletSelectorPermissionApp.doPortletSort(this, 'DISPLAY_NAME');" >
							<span class="table_title"><util:message key='ev.title.security.portletSelectorPortletName'/></span>
						</th>
						<th class="C"></th>
					</tr>
				</thead>
				<tbody id='PortletSelectorPermissionAppListBody'></tbody>
			</table>
		</div>
		<!-- tcontrol-->
		<div class="tcontrol">
			<!-- paging -->
			<div id="PORTLETSELECTOR_PAGE_ITERATOR" class="paging">
				<c:out escapeXml='false' value='${pageIterator}'/>
			</div>
			<!-- paging//-->
		</div>
		<!-- tcontrol//-->		
	</form>
	<form id="PortletSelectorPermissionChooser_EditForm" style="display:inline" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="25%" />
				<col width="*" />
			</colgroup>		
			<tr id="PortletSelectorPermission.AllowPane">
				<th class="L"><util:message key='ev.title.security.checkType'/></th>
				<td class="L">
					<input type="radio" id="PortletSelectorPermission_allow" name="perm_allowed" checked value="1" class="webradiogroup"><util:message key='ev.title.security.allow'/> &nbsp;&nbsp;
					<input type="radio" id="PortletSelectorPermission_deny" name="perm_allowed" value="0" class="webradiogroup"><util:message key='ev.title.security.deny'/> &nbsp;&nbsp;
				</td>
			</tr>
			<tr id="PortletSelectorPermission.Permission">
				<th class="L">
					<util:message key='ev.title.security.page.authority'/>
					<input type="checkbox" align="right" class="webcheckbox" onclick="aPortletPermissionManager.m_checkBox.chkAll(this)"/>
				</th>
				<td class="L">
					<div>
						<c:forEach items="${authorityCategory}" var="authority">
							<input type="checkbox" id="PortletSelectorPermission_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>"><c:out value="${authority.codeName}"/> &nbsp;&nbsp;
						</c:forEach>
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>