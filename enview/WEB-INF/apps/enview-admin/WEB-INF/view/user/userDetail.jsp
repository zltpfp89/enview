
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="UserManager_UserTabPage">
				<br style='line-height:5px;'>

					<div id="UserManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="UserManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="UserManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="UserManager_isCreate">
									
									<input type="hidden" id="UserManager_principalType" name="principalType">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.principalId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_principalId" name="principalId" value="<c:out value="${aUserVO.principalId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.shortPath'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_shortPath" name="shortPath" value="<c:out value="${aUserVO.shortPath}"/>" maxLength="30" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalName'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_principalName" name="principalName" value="<c:out value="${aUserVO.principalName}"/>" maxLength="40" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr style="display:none">
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.themeMapping.themeName'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_theme" name="theme" value="<c:out value="${aUserVO.theme}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr style="display:none">
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.user.defaultPage'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_defaultPage" name="defaultPage" value="<c:out value="${aUserVO.defaultPage}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.columnValue'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_columnValue0" name="columnValue0" value="<c:out value="${aUserVO.columnValue0}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.policy.isEnabled'/></td>
									
										<td class="webformfield"><input type="checkbox" id="UserManager_isEnabled" name="isEnabled" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.updateRequired'/></td>
									
										<td class="webformfield"><input type="checkbox" id="UserManager_updateRequired0" name="updateRequired0" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.authFailures'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_authFailures0" name="authFailures0" value="<c:out value="${aUserVO.authFailures0}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.modifiedDate'/></td>
									
										<td class="webformfield"><input type="text" id="UserManager_modifiedDate0" name="modifiedDate0" value="<c:out value="${aUserVO.modifiedDate0}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.policy.authMethod'/></td>
									
										<td class="webformfield">
											
											<select id="UserManager_authMethod" name="authMethod" class='webdropdownlist'>
												<c:forEach items="${authMethodList}" var="authMethod">
												<option value="<c:out value="${authMethod.code}"/>"><c:out value="${authMethod.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.principalInfo01'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_principalInfo01" name="principalInfo01" value="<c:out value="${aUserVO.principalInfo01}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.principalInfo02'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_principalInfo02" name="principalInfo02" value="<c:out value="${aUserVO.principalInfo02}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.principalInfo03'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_principalInfo03" name="principalInfo03" value="<c:out value="${aUserVO.principalInfo03}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.creationDate'/></td>
									
										<td class="webformfield"><input type="text" id="UserManager_creationDate" name="creationDate" value="<c:out value="${aUserVO.creationDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.modifiedDate'/></td>
									
										<td class="webformfield"><input type="text" id="UserManager_modifiedDate" name="modifiedDate" value="<c:out value="${aUserVO.modifiedDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalDesc'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="UserManager_principalDesc" name="principalDesc" value="<c:out value="${aUserVO.principalDesc}"/>" maxLength="80" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
						<div id="UserManager_UserpassTabPage">
						</div>
							
						<div id="UserManager_CredentialTabPage">
						</div>
							
						<div id="UserManager_UserGroupTabPage">
						</div>
							
						<div id="UserManager_UserRoleTabPage">
						</div>
							
						<div id="UserManager_PagePermissionTabPage">
						</div>
							
						<div id="UserManager_PortletPermissionTabPage">
						</div>
						
						<div id="UserManager_UrlPermissionTabPage">
						</div>
							
						<div id="UserManager_TotalPagePermissionTabPage">
						</div>
							
						<div id="UserManager_UserStatisticsTabPage">
						</div>
							
					</div>
					</div> <!-- End UserManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End UserManager_UserTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="UserManager_UserChooser"></div>

