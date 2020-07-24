
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/credentialManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="CredentialManager_CredentialTabPage">
				<br style='line-height:5px;'>

					<div id="CredentialManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="CredentialManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="CredentialManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="CredentialManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.credentialId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CredentialManager_credentialId" name="credentialId" value="<c:out value="${aCredentialVO.credentialId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.principalId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CredentialManager_principalId" name="principalId" value="<c:out value="${aCredentialVO.principalId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.columnValue'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CredentialManager_columnValue" name="columnValue" value="<c:out value="${aCredentialVO.columnValue}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.updateRequired'/></td>
									
										<td class="webformfield"><input type="checkbox" id="CredentialManager_updateRequired" name="updateRequired" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.authFailures'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CredentialManager_authFailures" name="authFailures" value="<c:out value="${aCredentialVO.authFailures}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.modifiedDate'/></td>
									
										<td class="webformfield"><input type="text" id="CredentialManager_modifiedDate" name="modifiedDate" value="<c:out value="${aCredentialVO.modifiedDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<a href="javascript:aCredentialManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
										<a href="javascript:aCredentialManager.doUpdate(true)" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End CredentialManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End CredentialManager_CredentialTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="CredentialManager_CredentialChooser"></div>

