<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorApp.js"></script>

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
					<form id='PortletSelectorSearchForm' name='PortletSelectorSearchForm' style='display:inline' action="javascript:portalPortletSelectorApp.doPortletSearch('PortletSelectorSearchForm')" onkeydown="if(event.keyCode==13) portalPortletSelectorApp.doPortletSearch('PortletSelectorSearchForm')" method='post'>
						<input type='hidden' name='sortMethod' value='ASC'/>
						<input type='hidden' name='sortColumn' value=''/>
						<input type='hidden' name='pageNo' value='1'/>
						<input type='hidden' name='pageSize' value='7'/> 
						<input type='hidden' name='pageFunction' value='portalPortletSelectorApp.doPortletPage'/>
						<input type='hidden' name='formName' value='PortletSelectorSearchForm'/>
						<input type='hidden' id='Enview.Portal.PortletSelector.categoryId' name='categoryId' >
						<input type='hidden' id='Enview.Portal.PortletSelector.categoryType' name='categoryType'  value='portlet'>
						<table width='100%' border='0' cellspacing='0' cellpadding='0'>
						<tr>
							<td align='right'>
								<input type='text' name='searchString' size='20' class='portlet-form-field-label' value="*<util:message key='ev.title.page.portletSelectorPortletName'/>*" onfocus="portalPage.getUtility().setFieldFocus(this,'*<util:message key='pt.ev.portletSelectorPortletName'/>*');" onblur="portalPage.getUtility().setFieldBlur(this,'*<util:message key='pt.ev.portletSelectorPortletName'/>*');">
								<span class="btn_pack small"><a href="javascript:portalPortletSelectorApp.doPortletSearch('PortletSelectorSearchForm')"><util:message key='ev.title.search'/></a></span>
							</td>
						</tr>
						</table>
					</form>
					<form id='PortletSelectorListForm' style='display:inline' name='PortletSelectorListForm' action='' method='post'>
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
							<tbody id='PortletSelectorListBody'></tbody>
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

