
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
				<div>
					<form id="CredentialManager_SearchForm" name="CredentialManager_SearchForm" style="display:inline" action="javascript:aCredentialManager.doSearch('CredentialManager_SearchForm')" method="post">
					  <table width="100%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aCredentialManager.doPage'/>
						<input type='hidden' name='formName' value='CredentialManager_SearchForm'/>
					 
						<input type='hidden' id='CredentialManager_Master_principalId' name='principalId' value=''/>
					  <tr>
						<td align="right">
						
							<select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<input type="image" src="<%=request.getContextPath()%>/admin/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand">
						</td>
					  </tr>
					  </table>    
					</form>
				</div>
				<div class="webgridpanel">
				  <form id="CredentialManager_ListForm" style="display:inline" name="CredentialManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aCredentialManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
						
							<th class="webgridheader" ch="0" onclick="aCredentialManager.doSort(this, 'CREDENTIAL_ID');" >
								<span ><util:message key='ev.prop.securityCredential.credentialId'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aCredentialManager.doSort(this, 'PRINCIPAL_ID');" >
								<span ><util:message key='ev.prop.securityCredential.principalId'/></span>
							</th>	
							<th class="webgridheaderlast" ch="0" onclick="aCredentialManager.doSort(this, 'MODIFIED_DATE');" >
								<span ><util:message key='ev.prop.securityCredential.modifiedDate'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="CredentialManager_ListBody">
			
					
					<c:forEach items="${results}" var="credential" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="CredentialManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="CredentialManager[<c:out value="${status.index}"/>].credentialId" value="<c:out value='${credential.credentialId}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
							<td align="left" class="webgridbody" onclick="aCredentialManager.doSelect(this)">
								<span class="webgridrowlabel" id="CredentialManager[<c:out value="${status.index}"/>].credentialId.label">&nbsp;<c:out value="${credential.credentialId}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aCredentialManager.doSelect(this)">
								<span class="webgridrowlabel" id="CredentialManager[<c:out value="${status.index}"/>].principalId.label">&nbsp;<c:out value="${credential.principalId}"/></span>
							</td>
							<td align="left" class="webgridbodylast" onclick="aCredentialManager.doSelect(this)">
								<span class="webgridrowlabel" id="CredentialManager[<c:out value="${status.index}"/>].modifiedDate.label">&nbsp;<c:out value="${credential.modifiedDateByFormat}"/></span>
							</td>
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="CredentialManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:100%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="CredentialManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aCredentialManager.doCreate()">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_delete.gif" hspace="2" style="cursor:hand" onclick="javascript:aCredentialManager.doRemove()">
					    </td>
					</tr>
					</table>
				
					<div id="CredentialManager_EditFormPanel" class="webformpanel" >  
					<div id="CredentialManager_propertyTabs">
						<ul>
							<li><a href="#CredentialManager_DetailTabPage"><util:message key='ev.title.user.detailTab'/></a></li>   
							
						</ul>
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
											
											<input type="text" id="CredentialManager_credentialId" name="credentialId" value="" maxLength="" label="<util:message key='ev.prop.securityCredential.credentialId'/>" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.principalId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CredentialManager_principalId" name="principalId" value="" maxLength="" label="<util:message key='ev.prop.securityCredential.principalId'/>" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.columnValue'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CredentialManager_columnValue" name="columnValue" value="" maxLength="" label="<util:message key='ev.prop.securityCredential.columnValue'/>" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.updateRequired'/></td>
									
										<td class="webformfield"><input type="checkbox" id="CredentialManager_updateRequired" name="updateRequired" value="" label="<util:message key='ev.prop.securityCredential.updateRequired'/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.authFailures'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CredentialManager_authFailures" name="authFailures" value="" maxLength="" label="<util:message key='ev.prop.securityCredential.authFailures'/>" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityCredential.modifiedDate'/></td>
									
										<td class="webformfield"><input type="text" id="CredentialManager_modifiedDate" name="modifiedDate" value="" label="<util:message key='ev.prop.securityCredential.modifiedDate'/>" class="full_webtextfield" /></td>
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aCredentialManager.doUpdate()">
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

