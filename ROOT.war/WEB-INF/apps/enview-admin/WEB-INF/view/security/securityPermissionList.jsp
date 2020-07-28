
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/securityPermissionManager.js"></script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="SecurityPermissionManager_SecurityPermissionTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="SecurityPermissionManager_SearchForm" name="SecurityPermissionManager_SearchForm" style="display:inline" action="javascript:aSecurityPermissionManager.doSearch('SecurityPermissionManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aSecurityPermissionManager.doPage'/>
						<input type='hidden' name='formName' value='SecurityPermissionManager_SearchForm'/>
					 
						<input type='hidden' id='SecurityPermissionManager_Master_principalId' name='principalId' value=''/>
					  <table width="100%">
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
				  <form id="SecurityPermissionManager_ListForm" style="display:inline" name="SecurityPermissionManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aSecurityPermissionManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
						
							<th class="webgridheader" ch="0" onclick="aSecurityPermissionManager.doSort(this, 'PERMISSION_ID');" >
								<span ><util:message key='ev.prop.securityPermission.permissionId'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aSecurityPermissionManager.doSort(this, 'PRINCIPAL_ID');" >
								<span ><util:message key='ev.prop.securityPermission.principalId'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aSecurityPermissionManager.doSort(this, 'TITLE');" >
								<span ><util:message key='ev.prop.securityPermission.title'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aSecurityPermissionManager.doSort(this, 'RES_URL');" >
								<span ><util:message key='ev.prop.securityPermission.resUrl'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="SecurityPermissionManager_ListBody">
			
					
					<c:forEach items="${results}" var="securitypermission" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="SecurityPermissionManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="SecurityPermissionManager[<c:out value="${status.index}"/>].permissionId" value="<c:out value='${securitypermission.permissionId}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
							<td align="left" class="webgridbody" onclick="aSecurityPermissionManager.doSelect(this)">
								<span class="webgridrowlabel" id="SecurityPermissionManager[<c:out value="${status.index}"/>].permissionId.label">&nbsp;<c:out value="${securitypermission.permissionId}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aSecurityPermissionManager.doSelect(this)">
								<span class="webgridrowlabel" id="SecurityPermissionManager[<c:out value="${status.index}"/>].principalId.label">&nbsp;<c:out value="${securitypermission.principalId}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aSecurityPermissionManager.doSelect(this)">
								<span class="webgridrowlabel" id="SecurityPermissionManager[<c:out value="${status.index}"/>].title.label">&nbsp;<c:out value="${securitypermission.title}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aSecurityPermissionManager.doSelect(this)">
								<span class="webgridrowlabel" id="SecurityPermissionManager[<c:out value="${status.index}"/>].resUrl.label">&nbsp;<c:out value="${securitypermission.resUrl}"/></span>
							</td>
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="SecurityPermissionManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:100%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="SecurityPermissionManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aSecurityPermissionManager.doCreate()">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_delete.gif" hspace="2" style="cursor:hand" onclick="javascript:aSecurityPermissionManager.doRemove()">
					    </td>
					</tr>
					</table>
				
					<div id="SecurityPermissionManager_EditFormPanel" class="webformpanel" >  
					<div id="SecurityPermissionManager_propertyTabs">
						<ul>
							<li><a href="#SecurityPermissionManager_DetailTabPage"><util:message key='ev.title.security.detailTab'/></a></li>   
							
						</ul>
						<div id="SecurityPermissionManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="SecurityPermissionManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="SecurityPermissionManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.permissionId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="SecurityPermissionManager_permissionId" name="permissionId" value="" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.principalId'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="SecurityPermissionManager_principalId" name="principalId" value="" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.title'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="SecurityPermissionManager_title" name="title" value="" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.resUrl'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="SecurityPermissionManager_resUrl" name="resUrl" value="" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.resType'/></td>
									
										<td class="webformfield"><input type="checkbox" id="SecurityPermissionManager_resType" name="resType" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.actionMask'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="SecurityPermissionManager_actionMask" name="actionMask" value="" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.isAllow'/></td>
									
										<td class="webformfield"><input type="checkbox" id="SecurityPermissionManager_isAllow" name="isAllow" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.creationDate'/></td>
									
										<td class="webformfield"><input type="text" id="SecurityPermissionManager_creationDate" name="creationDate" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.securityPermission.modifiedDate'/></td>
									
										<td class="webformfield"><input type="text" id="SecurityPermissionManager_modifiedDate" name="modifiedDate" value="" class="full_webtextfield" /></td>
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aSecurityPermissionManager.doUpdate()">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End SecurityPermissionManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End SecurityPermissionManager_SecurityPermissionTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="SecurityPermissionManager_SecurityPermissionChooser"></div>

