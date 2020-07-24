
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="RoleManager_RoleTabPage">
				<br style='line-height:5px;'>

					<div id="RoleManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="RoleManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="RoleManager_EditForm" style="display:inline" action="" method="post">
									<input type="hidden" id="RoleManager_isCreate">
									<input type="hidden" id="RoleManager_parentId" name="parentId">	
									<input type="hidden" id="RoleManager_principalType" name="principalType">	
									<input type="hidden" id="RoleManager_principalOrder" name="principalOrder">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="RoleManager_principalId" name="principalId" value="<c:out value="${aRoleVO.principalId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.shortPath'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="RoleManager_shortPath" name="shortPath" value="<c:out value="${aRoleVO.shortPath}"/>" maxLength="30" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalName'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="RoleManager_principalName" name="principalName" value="<c:out value="${aRoleVO.principalName}"/>" maxLength="40" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.role.theme'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="RoleManager_theme" name="theme" value="<c:out value="${aRoleVO.theme}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.role.defaultPage'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="RoleManager_defaultPage" name="defaultPage" value="<c:out value="${aRoleVO.defaultPage}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.creationDate'/></td>
									
										<td class="webformfield"><input type="text" id="RoleManager_creationDate" name="creationDate" value="<c:out value="${aRoleVO.creationDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.modifiedDate'/></td>
									
										<td class="webformfield"><input type="text" id="RoleManager_modifiedDate" name="modifiedDate" value="<c:out value="${aRoleVO.modifiedDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.principalInfo01'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="RoleManager_principalInfo01" name="principalInfo01" value="<c:out value="${aRoleVO.principalInfo01}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.principalInfo02'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="RoleManager_principalInfo02" name="principalInfo02" value="<c:out value="${aRoleVO.principalInfo02}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.principalInfo03'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="RoleManager_principalInfo03" name="principalInfo03" value="<c:out value="${aRoleVO.principalInfo03}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalDesc'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="RoleManager_principalDesc" name="principalDesc" value="<c:out value="${aRoleVO.principalDesc}"/>" maxLength="80" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aRoleManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aRoleManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
						<div id="RoleManager_RoleUserTabPage">
						</div>
							
						<div id="RoleManager_PagePermissionTabPage">
						</div>
							
						<div id="RoleManager_PortletPermissionTabPage">
						</div>
							
						<div id="RoleManager_UrlPermissionTabPage">
						</div>
					</div>
					</div> <!-- End RoleManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End RoleManager_RoleTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="RoleManager_RoleChooser"></div>

