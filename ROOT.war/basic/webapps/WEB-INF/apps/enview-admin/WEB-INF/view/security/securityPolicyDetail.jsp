
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/securityPolicyManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="SecurityPolicyManager_SecurityPolicyTabPage">
				<br style='line-height:5px;'>

					<div id="SecurityPolicyManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="SecurityPolicyManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="SecurityPolicyManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="SecurityPolicyManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.policy.policyId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="SecurityPolicyManager_policyId" name="policyId" value="<c:out value="${aSecurityPolicyVO.policyId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.policy.ipaddress'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="SecurityPolicyManager_ipaddress" name="ipaddress" value="<c:out value="${aSecurityPolicyVO.ipaddress}"/>" maxLength="15" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.policy.authMethod'/></td>
									
										<td class="webformfield">
											
											<select id="SecurityPolicyManager_authMethod" name="authMethod" class='webdropdownlist'>
												<c:forEach items="${authMethodList}" var="authMethod">
												<option value="<c:out value="${authMethod.code}"/>"><c:out value="${authMethod.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.policy.isAllow'/></td>
									
										<td class="webformfield"><input type="checkbox" id="SecurityPolicyManager_isAllow" name="isAllow" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.policy.isEnabled'/></td>
									
										<td class="webformfield"><input type="checkbox" id="SecurityPolicyManager_isEnabled" name="isEnabled" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.policy.startDate'/></td>
									
										<td class="webformfield"><input type="text" id="SecurityPolicyManager_startDate" name="startDate" value="<c:out value="${aSecurityPolicyVO.startDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.policy.endDate'/></td>
									
										<td class="webformfield"><input type="text" id="SecurityPolicyManager_endDate" name="endDate" value="<c:out value="${aSecurityPolicyVO.endDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aSecurityPolicyManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aSecurityPolicyManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End SecurityPolicyManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End SecurityPolicyManager_SecurityPolicyTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="SecurityPolicyManager_SecurityPolicyChooser"></div>

