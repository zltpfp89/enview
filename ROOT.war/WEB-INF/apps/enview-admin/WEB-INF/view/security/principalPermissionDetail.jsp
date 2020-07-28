
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/principalPermissionManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PrincipalPermissionManager_PagePermissionTabPage">
				<br style='line-height:5px;'>

					<div id="PrincipalPermissionManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="PrincipalPermissionManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="PrincipalPermissionManager_EditForm" style="display:inline" action="" method="post">
									<input type="hidden" id="PrincipalPermissionManager_isCreate">
									<input type="hidden" id="PrincipalPermissionManager_domainId">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.permissionId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PrincipalPermissionManager_permissionId" name="permissionId" value="<c:out value="${aPagePermissionVO.permissionId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.principalId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PrincipalPermissionManager_principalId" name="principalId" value="<c:out value="${aPagePermissionVO.principalId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.title'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PrincipalPermissionManager_title" name="title" value="<c:out value="${aPagePermissionVO.title}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.resUrl'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PrincipalPermissionManager_resUrl" name="resUrl" value="<c:out value="${aPagePermissionVO.resUrl}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.resType'/></td>
									
										<td class="webformfield"><input type="checkbox" id="PrincipalPermissionManager_resType" name="resType" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.actionMask'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PrincipalPermissionManager_actionMask" name="actionMask" value="<c:out value="${aPagePermissionVO.actionMask}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.isAllow'/></td>
									
										<td class="webformfield"><input type="checkbox" id="PrincipalPermissionManager_isAllow" name="isAllow" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.creationDate'/></td>
									
										<td class="webformfield"><input type="text" id="PrincipalPermissionManager_creationDate" name="creationDate" value="<c:out value="${aPagePermissionVO.creationDate}"/>" class="txt_145" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.modifiedDate'/></td>
									
										<td class="webformfield"><input type="text" id="PrincipalPermissionManager_modifiedDate" name="modifiedDate" value="<c:out value="${aPagePermissionVO.modifiedDate}"/>" class="txt_145" /></td>
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aPrincipalPermissionManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPrincipalPermissionManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End PrincipalPermissionManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PrincipalPermissionManager_PagePermissionTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PrincipalPermissionManager_PagePermissionChooser"></div>

