
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletPermissionManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="PortletPermissionChooser_ListTabPage" style="width:100%; height:300px;"> 
							<div class="webformpanel">
								<form id="PortletPermissionChooser_SearchForm" name="PortletPermissionChooser_SearchForm" style="display:inline" action="javascript:aPortletPermissionChooser.doSearch('PortletPermissionChooser_SearchForm')" method="post">
									<div>
									  <table width="100%">
										<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aPortletPermissionChooser.doPage'/>
										<input type='hidden' name='formName' value='PortletPermissionChooser_SearchForm'/>
										 
										<input type='hidden' id='PortletPermissionChooser_Master_principalId' name='principalId' value=''/>
									  <tr>
										<td align="right">
										
											<input type="text" name="titleCond" size="30" class="webtextfield" value="*<util:message key='ev.prop.securityPermission.title'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPermission.title'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPermission.title'/>*');"/> 
														
											<select name='pageSize'>
												<option value="5">5</option>
												<option value="10">10</option>
												<option value="20">20</option>
												<option value="50">50</option>
												<option value="100">100</option>
											</select>
											<input type="image" src="<%=request.getContextPath()%>/admin/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand">
										</td>
									  </tr>
									  </table>    
									</div>
								</form>
								<form id="PortletPermissionChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aPortletPermissionChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aPortletPermissionChooser.doSort(this, 'PERMISSION_ID');" >
														<span ><util:message key='ev.prop.securityPermission.permissionId'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aPortletPermissionChooser.doSort(this, 'PRINCIPAL_ID');" >
														<span ><util:message key='ev.prop.securityPermission.principalId'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aPortletPermissionChooser.doSort(this, 'TITLE');" >
														<span ><util:message key='ev.prop.securityPermission.title'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aPortletPermissionChooser.doSort(this, 'RES_URL');" >
														<span ><util:message key='ev.prop.securityPermission.resUrl'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="PortletPermissionChooser_ListBody"></tbody>
										</table>
										<div id="PortletPermissionChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="PortletPermissionChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
											</td>   
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>

