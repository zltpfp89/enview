
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupRoleManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="GroupRoleManager_GroupRoleTabPage">
				<br style='line-height:5px;'>

					<div id="GroupRoleManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="GroupRoleManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="GroupRoleManager_EditForm" style="display:inline" action="" method="post">
									<input type="hidden" id="GroupRoleManager_isCreate">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityGroupRole.groupId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupRoleManager_roleId" name="roleId" value="<c:out value="${aGroupRoleVO.roleId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityGroupRole.groupId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupRoleManager_groupId" name="groupId" value="<c:out value="${aGroupRoleVO.groupId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalName'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupRoleManager_principalName0" name="principalName0" value="<c:out value="${aGroupRoleVO.principalName0}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aGroupRoleManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aGroupRoleManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End GroupRoleManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End GroupRoleManager_GroupRoleTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="GroupRoleManager_GroupRoleChooser"></div>

