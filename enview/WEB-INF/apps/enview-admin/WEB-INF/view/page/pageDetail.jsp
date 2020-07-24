
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>

<div class="webformpanel" style="width:100%;">
	<form id="PageManager_EditForm" style="display:inline" action="" method="post">
		<input type="hidden" id="PageManager_isCreate">
		<input type="hidden" id="PageManager_depth" name="depth">	
		<input type="hidden" id="PageManager_sortOrder" name="sortOrder">	
		<input type="hidden" id="PageManager_skin" name="skin">	
		<input type="hidden" id="PageManager_pageInfo02" name="pageInfo02">	
		<input type="hidden" id="PageManager_pageInfo03" name="pageInfo03">	
		<input type="hidden" id="PageManager_type" name="type" value="02"/>
		<input type="hidden" id="PageManager_defaultPortletDecorator" name="defaultPortletDecorator"/>
		<input type="hidden" id="PageManager_masterPagePath" name="masterPagePath" />
		<input type="hidden" id="PageManager_isAllowGuest" name="isAllowGuest">
		<input type="hidden" id="PageManager_domainId" name="domainId">
		<table cellpadding=0 cellspacing=0 border=0 width='100%'>
		<tr> 
			<td colspan="4" width="100%" class="webformheaderline"></td>    
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.pageId'/></td>
			<td width="30%" class="webformfield">
				<input type="text" id="PageManager_pageId" name="pageId" value="<c:out value="${aPageVO.pageId}"/>" maxLength="" class="full_webtextfield" />
			</td>
			<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.parentId'/></td>
			<td class="webformfield">
				<input type="text" id="PageManager_parentId" name="parentId" value="<c:out value="${aPageVO.parentId}"/>" maxLength="" class="full_webtextfield" />
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.path'/> *</td>
			<td class="webformfield">
				<input type="text" id="PageManager_path" name="path" value="<c:out value="${aPageVO.path}"/>" maxLength="240" class="full_webtextfield" readOnly="true"/>
			</td>
			<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.name'/> *</td>
			<td class="webformfield">
				<input type="text" id="PageManager_name" name="name" value="<c:out value="${aPageVO.name}"/>" maxLength="80" style="IME-MODE:disabled;" onblur="return aPageManager.doCheckPageName(this);" class="full_webtextfield" />
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.systemCode'/> *</td>
			<td class="webformfield">
				<select id="PageManager_systemCode" name="systemCode" class='webdropdownlist'>
					<c:forEach items="${systemCodeList}" var="systemCode">
					<option value="<c:out value="${systemCode.code}"/>"><c:out value="${systemCode.codeName}"/></option>
					</c:forEach>
				</select>
			</td>
			<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.target'/></td>
			<td class="webformfield">
				<select id="PageManager_target" name="target" class='webdropdownlist'>
					<c:forEach items="${targetList}" var="target">
					<option value="<c:out value="${target.code}"/>"><c:out value="${target.codeName}"/></option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.pageType'/></td>
			<td class="webformfield">
				<select id="PageManager_pageType" name="pageType" class='webdropdownlist'>
					<c:forEach items="${pageTypeList}" var="pageType">
					<option value="<c:out value="${pageType.code}"/>"><c:out value="${pageType.codeName}"/></option>
					</c:forEach>
				</select>
			</td>
			<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.defaultLayoutDecorator'/></td>
			<td class="webformfield">
				<select id="PageManager_defaultLayoutDecorator" name="defaultLayoutDecorator" class='webdropdownlist'>
					<c:forEach items="${themeList}" var="theme">
					<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.title'/> *</td>
			<td colspan="3" class="webformfield">
				<input type="text" id="PageManager_shortTitle" name="shortTitle" value="<c:out value="${aPageVO.shortTitle}"/>" cols="80" rows="1" maxLength="150" class="full_webtextfield" />
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.page.description'/> *</td>
			<td colspan="3" class="webformfield">
				<textarea id="PageManager_title" name="title" value="<c:out value="${aPageVO.title}"/>" cols="80" rows="2" maxLength="300" class="webtextarea" >	</textarea>
			</td>
		</tr>
		
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.page.optionTab'/></td>
			<td colspan="3" class="webformfield">
				<util:message key='ev.prop.page.isHidden'/><input type="checkbox" id="PageManager_isHidden" name="isHidden" value="" class="webcheckbox" />
				<util:message key='ev.prop.page.isQuickMenu'/><input type="checkbox" id="PageManager_isQuickMenu" name="isQuickMenu" value="" class="webcheckbox" />
				<!--util:message key='pt.ev.property.isAllowGuest'/><input type="checkbox" id="PageManager_isAllowGuest" name="isAllowGuest" value="" class="webcheckbox" /-->
				<util:message key='ev.prop.page.isProtected'/><input type="checkbox" id="PageManager_isProtected" name="isProtected" value="" class="webcheckbox" />
				<util:message key='ev.prop.page.useTheme'/><input type="checkbox" id="PageManager_useTheme" name="useTheme" value="" class="webcheckbox" />
				<util:message key='ev.prop.page.useIFrame'/><input type="checkbox" id="PageManager_useIframe" name="useIframe" value="" class="webcheckbox" />
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.page.linkPage'/></td>
			<td colspan="3" class="webformfield">
				<input type="hidden" id="PageManager_defaultPageName" name="defaultPageName" value="<c:out value="${aPageVO.defaultPageName}"/>"/>
				<input type="text" id="PageManager_defaultPagePath" name="defaultPagePath" value="<c:out value="${aPageVO.defaultPageName}"/>" maxLength="80" class="webtextfield" style="width:80%;" readOnly="true" onclick="javascript:aPageManager.getPageChooser().doShow(this)"/>
				<img src="<%=request.getContextPath()%>/admin/images/button/btn_refresh.gif" hspace="2" style="cursor:hand" align="absmiddle" onclick="javascript:aPageManager.doResetDefault()">
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.url'/></td>
			<td colspan="3" class="webformfield">
				<input type="text" id="PageManager_url" name="url" value="<c:out value="${aPageVO.url}"/>" maxLength="512" class="full_webtextfield" onclick="javascript:aPageManager.getPortletChooser().doShow(this)"/>
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.parameter'/></td>
			<td colspan="3" class="webformfield">
				<input type="text" id="PageManager_parameter" name="parameter" value="<c:out value="${aPageVO.parameter}"/>" maxLength="120" class="full_webtextfield" />
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel">
				<img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle">
				<util:message key='ev.prop.page.owner'/><br>
				&nbsp;&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/admin/images/button/btn_select.gif" hspace="2" style="cursor:hand" align="absmiddle" onclick="javascript:aPageManager.getUserChooser().doShow()">
			</td>
			<td colspan="3" class="webformlabelmiddle">
				<input type="hidden" id="PageManager_owner" name="owner">
				<select id='PageManager_owner_list' size='5' multiple='true' class="webtextfield" style="width:200px;"></select>
				<img src="<%=request.getContextPath()%>/admin/images/button/btn_delete.gif" hspace="2" style="cursor:hand" align="absmiddle" onclick="javascript:aPageManager.doRemoveOwner()">
			</td>
		</tr>
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.page.pageInfo01'/></td>
			<td colspan="3" class="webformfield">
				<input type="text" id="PageManager_pageInfo01" name="pageInfo01" value="<c:out value="${aPageVO.pageInfo01}"/>" maxLength="100" class="full_webtextfield" />
			</td>
		</tr>
		
	</table>
	<table style="width:100%;" class="webbuttonpanel">
	<tr>
		<td align="right">  
			<!--span class="btn_pack large icon" onclick="javascript:aPageManager.doUpdate(true)" style="width:100px;">save</span-->
			<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPageManager.doUpdate(true)">
		</td>
	</tr>
	</table>
	</form>
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
						<option value='enview-cms'><util:message key='ev.title.page.portletSelectorCMSCategory'/></option>
						</select>
					</span>
					<div class="webpanel">
						<div id="PortletSelectorTreeTabPage" style="width:100%; height:250px;"></div>
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
								<tr> <td colspan='3' class='webgridheaderline'></td></tr>
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
										<div id='PORTLETSELECTOR_PAGE_ITERATOR' class="webnavigationpanel"></div>
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
