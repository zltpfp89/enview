
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupUserManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="GroupUserManager_GroupUserTabPage">
				<br style='line-height:5px;'>

					<div id="GroupUserManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="GroupUserManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="GroupUserManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="GroupUserManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityGroupUser.userId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupUserManager_userId" name="userId" value="<c:out value="${aGroupUserVO.userId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='securityGroupRole.groupId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupUserManager_groupId" name="groupId" value="<c:out value="${aGroupUserVO.groupId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPrincipal.principalName'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupUserManager_principalName0" name="principalName0" value="<c:out value="${aGroupUserVO.principalName0}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityUserGroup.mileageTag'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupUserManager_mileageTag" name="mileageTag" value="<c:out value="${aGroupUserVO.mileageTag}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityUserGroup.sortOrder'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="GroupUserManager_sortOrder" name="sortOrder" value="<c:out value="${aGroupUserVO.sortOrder}"/>" maxLength="10" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aGroupUserManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aGroupUserManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End GroupUserManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End GroupUserManager_GroupUserTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="GroupUserManager_GroupUserChooser"></div>

