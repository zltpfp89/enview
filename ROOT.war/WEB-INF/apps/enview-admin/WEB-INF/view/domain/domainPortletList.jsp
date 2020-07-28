
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainPortletManager.js"></script>

<script type="text/javascript">
function initDomainPortletManager() 
{
	if( aDomainPortletManager == null ) 
	{
		aDomainPortletManager = new aDomainPortletManager("<c:out value="${evSecurityCode}"/>");
		aDomainPortletManager.init();
	}
}

function finishDomainPortletManager() 
{
	
}

if (window.attachEvent)
{
    window.attachEvent ( "onload", initDomainPortletManager);
	window.attachEvent ( "onunload", finishDomainPortletManager);
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initDomainPortletManager, false );
	window.addEventListener ( "unload", finishDomainPortletManager, false );
}
else
{
    window.onload = initDomainPortletManager;
	window.onunload = finishDomainPortletManager;
}
</script>



<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="DomainPortletManager_DomainPortletTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="DomainPortletManager_SearchForm" name="DomainPortletManager_SearchForm" style="display:inline" action="javascript:aDomainPortletManager.doSearch('DomainPortletManager_SearchForm')" onkeydown="if(event.keyCode==13) aDomainPortletManager.doSearch('DomainPortletManager_SearchForm')" method="post">
					  <table width="100%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aDomainPortletManager.doPage'/>
						<input type='hidden' name='formName' value='DomainPortletManager_SearchForm'/>
					 
						<input type='hidden' id='DomainPortletManager_Master_domainId' name='domainId' value=''/>
					  <tr>
						<td align="right">
						
							<select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<span class="btn_pack small"><a href="javascript:aDomainPortletManager.doSearch('DomainPortletManager_SearchForm')"><util:message key='ev.title.search'/></a></span>
						</td>
					  </tr>
					  </table>    
					</form>
				</div>
				
				<div class="webgridpanel">
				  <form id="DomainPortletManager_ListForm" style="display:inline" name="DomainPortletManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aDomainPortletManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>

							<th class="webgridheaderlast" ch="0" onclick="aDomainPortletManager.doSort(this, 'PORTLET_NM');" >
								<span ><util:message key='mm.prop.domainPortlet.portletNm'/></span>
							</th>		
							
						</tr>
					</thead>
					<tbody id="DomainPortletManager_ListBody">
			
					
					<c:forEach items="${results}" var="domainportlet" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="{$status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="DomainPortletManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="DomainPortletManager[<c:out value="${status.index}"/>].domainId" value="<c:out value='${domainportlet.domainId}'/>"/>
								<input type="hidden" id="DomainPortletManager[<c:out value="${status.index}"/>].portletNm" value="<c:out value='${domainportlet.portletNm}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
							<td align="left" class="webgridbody" onclick="aDomainPortletManager.doSelect(this)">
								<span class="webgridrowlabel" id="DomainPortletManager[<c:out value="${status.index}"/>].domainId.label">&nbsp;<c:out value="${domainportlet.domainId}"/></span>
							</td>
							<td align="left" class="webgridbodylast" onclick="aDomainPortletManager.doSelect(this)">
								<span class="webgridrowlabel" id="DomainPortletManager[<c:out value="${status.index}"/>].portletNm.label">&nbsp;<c:out value="${domainportlet.portletNm}"/></span>
							</td>
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="DomainPortletManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:100%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="DomainPortletManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<span class="btn_pack small"><a href="javascript:aDomainPortletManager.getPortletChooser().doShow(aDomainPortletManager.setMultiplePortletChooserCallback)"><util:message key='ev.title.new'/></a></span>
							<span class="btn_pack small"><a href="javascript:aDomainPortletManager.doRemove()"><util:message key='ev.title.remove'/></a></span>
					    </td>
					</tr>
					</table>
				
					<div id="DomainPortletManager_EditFormPanel" class="webformpanel" >  
					<div id="DomainPortletManager_propertyTabs">
						<ul>
							<li><a href="#DomainPortletManager_DetailTabPage"><util:message key='ev.title.detailTab'/></a></li>   
							
						</ul>
						<div id="DomainPortletManager_DetailTabPage">
							<%@include file="domainPortletDetail.jsp"%>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End DomainPortletManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End DomainPortletManager_DomainPortletTabPage -->
		</div>
	</td>
<tr>
</table>


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


<div id="PortletSelectorPermissionAppDialog" title="<util:message key='ev.title.security.portletSelectorName'/>" style="display:none;">
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<!--td width="180px" style="background:#FFFFFF;" valign="top">
					<span style="width:100%; height:22px;"><font size="2"><util:message key='pt.ev.property.portletCategoryTree'/></font>
						<select id='PortletSelectorPermissionAppCategoryTypeSelect' name='type' style='width:100%' class='webdropdownlist' onchange='javascript:portalPortletSelectorPermissionApp.changeCategory(this)'>
						<option value='portlet'><util:message key='pt.ev.portletSelectorPortletCategory'/></option>
						<option value='enview-bbs'><util:message key='pt.ev.portletSelectorBBSCategory'/></option>
						<option value='enview-cms'><util:message key='pt.ev.portletSelectorCMSCategory'/></option>
						</select>
					</span>
					<div class="webpanel">
						<div id="PortletSelectorPermissionAppTreeTabPage" style="width:100%; height:250px;"></div>
					</div>
				</td-->
				<td valign="top">
					<form id='PortletSelectorPermissionAppSearchForm' name='PortletSelectorPermissionAppSearchForm' style='display:inline' action="javascript:portalPortletSelectorPermissionApp.doPortletSearch('PortletSelectorPermissionAppSearchForm')" onkeydown="if(event.keyCode==13) portalPortletSelectorPermissionApp.doPortletSearch('PortletSelectorPermissionAppSearchForm')" method='post'>
						<input type='hidden' name='sortMethod' value='ASC'/>
						<input type='hidden' name='sortColumn' value=''/>
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='7'/--> 
						<input type='hidden' name='pageFunction' value='portalPortletSelectorPermissionApp.doPortletPage'/>
						<input type='hidden' name='formName' value='PortletSelectorPermissionAppSearchForm'/>
						<input type='hidden' id='PortletSelectorPermissionApp_categoryId' name='categoryId' >
						<input type='hidden' id='PortletSelectorPermissionApp_categoryType' name='categoryType'  value='portlet'>
						<table width='100%' border='0' cellspacing='0' cellpadding='0'>
						<tr>
							<td align='right'>
								<select id="PortletSelectorPermissionApp__portletCategory" name="portletCategory" class='webdropdownlist'>
									<option value=""><util:message key='ev.title.security.portletCategoryTree'/></option> 
									<c:forEach items="${portletCategory}" var="category">
									<option value="<c:out value="${category}"/>"><c:out value="${category}"/></option>
									</c:forEach>
								</select>
								<input type='text' name='title0Cond' size='20' class='portlet-form-field-label' value="*<util:message key='ev.title.security.portletSelectorPortletName'/>*" onfocus="portalPage.getUtility().setFieldFocus(this,'*<util:message key='ev.title.security.portletSelectorPortletName'/>*');" onblur="portalPage.getUtility().setFieldBlur(this,'*<util:message key='ev.title.security.portletSelectorPortletName'/>*');">
								<select name='pageSize'>
									<option value="5">5</option>
									<option value="10" selected>10</option>
									<option value="20" >20</option>
									<option value="50">50</option>
									<option value="100">100</option>
								</select>
								<span class="btn_pack small"><a href="javascript:portalPortletSelectorPermissionApp.doPortletSearch('PortletSelectorPermissionAppSearchForm')"><util:message key='ev.title.search'/></a></span>
							</td>
						</tr>
						</table>
					</form>
					<form id='PortletSelectorPermissionAppListForm' style='display:inline' name='PortletSelectorPermissionAppListForm' action='' method='post'>
						<div style="overflow:auto; width:100%; height:230px;">
						<table class='webgridpanel' style='width:100%;' cellpadding='0' cellspacing='0' id='grid-table'>
							<thead>
								<tr> <td colspan='4' class='webgridheaderline'></td></tr>
								<tr style='cursor: pointer;'>
									<th class="webgridheader" align="center" width="30px">
										<input type="checkbox" id="delCheck" class="webcheckbox" onclick="portalPortletSelectorPermissionApp.m_checkBox.chkAll(this)"/>
									</th>
									<th class="webgridheader" align="center" width="30px"></th>
									<th ch='0' class='webgridheaderlast' width='250px' onclick="portalPortletSelectorPermissionApp.doPortletSort(this, 'DISPLAY_NAME');" >
										<span><util:message key='ev.title.security.portletSelectorPortletName'/></span>
									</th>
								</tr>
							</thead>
							<tbody id='PortletSelectorPermissionAppListBody'></tbody>
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
	<form id="PortletSelectorPermissionChooser_EditForm" style="display:inline" action="" method="post">
	<table style="width:100%;" height="50px" class="webformpanel">
		<tr> 
			<td colspan="2" width="100%" class="webformheaderline"></td>
		</tr>
		<tr id="PortletSelectorPermission.AllowPane">
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;<util:message key='ev.title.security.checkType'/></td>
			<td class="webformfield">
				<input type="radio" id="PortletSelectorPermission_allow" name="perm_allowed" checked value="1" class="webradiogroup"><util:message key='ev.title.security.allow'/> &nbsp;&nbsp;
				<input type="radio" id="PortletSelectorPermission_deny" name="perm_allowed" value="0" class="webradiogroup"><util:message key='ev.title.security.deny'/> &nbsp;&nbsp;
			</td>
		</tr>
		<tr id="PortletSelectorPermission.Permission">
			<td width="20%" class="webformlabel">
				<img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;<util:message key='ev.title.security.page.authority'/>
				<input type="checkbox" align="right" class="webcheckbox" onclick="aPortletPermissionManager.m_checkBox.chkAll(this)"/>
			</td>
			<td>
				<div class="webpanel">
			<c:forEach items="${authorityCategory}" var="authority">
				<div>
				<input type="checkbox" id="PortletSelectorPermission_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>" class="webradiogroup"><c:out value="${authority.codeName}"/> &nbsp;&nbsp;
				</div>
			</c:forEach>
				</div>
			</td>
		</tr>
	</table>
	</form>
</div>

