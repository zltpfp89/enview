
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="GroupManager_GroupTabPage">
				<br style='line-height:5px;'>

					<div id="GroupManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="GroupManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="GroupManager_EditForm" style="display:inline" action="" method="post">
									<input type="hidden" id="GroupManager_isCreate">
									<input type="hidden" id="GroupManager_parentId" name="parentId">	
									<input type="hidden" id="GroupManager_principalType" name="principalType">	
									<input type="hidden" id="GroupManager_principalOrder" name="principalOrder">	
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_principalId" name="principalId" value="<c:out value="${aGroupVO.principalId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.shortPath'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_shortPath" name="shortPath" value="<c:out value="${aGroupVO.shortPath}"/>" maxLength="30" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalName'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_principalName" name="principalName" value="<c:out value="${aGroupVO.principalName}"/>" maxLength="40" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.group.theme'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_theme" name="theme" value="<c:out value="${aGroupVO.theme}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.group.defaultPage'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_defaultPage" name="defaultPage" value="<c:out value="${aGroupVO.defaultPage}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.group.subPage'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_subPage" name="subPage" value="<c:out value="${aGroupVO.subPage}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.creationDate'/></td>
									
										<td class="webformfield"><input type="text" id="GroupManager_creationDate" name="creationDate" value="<c:out value="${aGroupVO.creationDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.modifiedDate'/></td>
									
										<td class="webformfield"><input type="text" id="GroupManager_modifiedDate" name="modifiedDate" value="<c:out value="${aGroupVO.modifiedDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.principalInfo01'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_principalInfo01" name="principalInfo01" value="<c:out value="${aGroupVO.principalInfo01}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.principalInfo02'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_principalInfo02" name="principalInfo02" value="<c:out value="${aGroupVO.principalInfo02}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.principalInfo03'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_principalInfo03" name="principalInfo03" value="<c:out value="${aGroupVO.principalInfo03}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalDesc'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupManager_principalDesc" name="principalDesc" value="<c:out value="${aGroupVO.principalDesc}"/>" maxLength="80" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aGroupManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aGroupManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
						<div id="GroupManager_GroupUserTabPage">
						</div>
							
						<div id="GroupManager_GroupRoleTabPage">
						</div>
							
						<div id="GroupManager_PagePermissionTabPage">
						</div>
							
						<div id="GroupManager_PortletPermissionTabPage">
						</div>
							
					</div>
					</div> <!-- End GroupManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End GroupManager_GroupTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="GroupManager_GroupChooser"></div>

