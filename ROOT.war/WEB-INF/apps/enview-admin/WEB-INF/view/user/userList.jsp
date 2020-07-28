
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userManager.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userpassManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/credentialManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userGroupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userRoleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pagePermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletPermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/urlPermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/totalPagePermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userStatisticsManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorPermissionApp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorApp.js"></script>

<script type="text/javascript">
function initUserManager() {
	if( aUserManager == null ) {
		aUserManager = new UserManager();
		aUserManager.init("<c:out value="${evSecurityCode}"/>");
		aUserManager.doDefaultSelect();
	}
}
function finishUserManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initUserManager );
	window.attachEvent ( "onunload", finishUserManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initUserManager, false );
	window.addEventListener ( "unload", finishUserManager, false );
}
else
{
    window.onload = initUserManager;
	window.onunload = finishUserManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="UserManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="UserManager_SearchForm" name="UserManager_SearchForm" style="display:inline" action="javascript:aUserManager.doSearch('UserManager_SearchForm')" onkeydown="if(event.keyCode==13) aUserManager.doSearch('UserManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aUserManager.doPage'/>
						<input type='hidden' name='formName' value='UserManager_SearchForm'/>
						<input type="hidden" id="UserManager_groupIdJoinCond" name="groupIdJoinCond" value=''/>
						<input type="hidden" id="UserManager_roleIdJoinCond" name="roleIdJoinCond" value=''/>
		
						<c:if test="${isSuperAdmin}">
							<div class="sel_100">
								<select id="UserManager_domainCond" name="domainId" class='txt_100' onchange="aUserManager.doRetrieve();">
									<c:forEach items="${domainList}" var="domainInfo">
										<c:if test="${domainInfo.domainId != 0}">
											<option value="<c:out value="${domainInfo.domainId}"/>"><c:out value="${domainInfo.domainNm}"/></option>
										</c:if>
									</c:forEach>
									<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }"><option value="0"><util:message key='ev.prop.securityPrincipal.noDomain'/></option></c:if>
								</select>
							</div>
						</c:if>
						<c:if test="${!isSuperAdmin}"><input id="UserManager_domainCond" name="domainId" type="hidden" value="${inform.domainId}"/></c:if>
						<input type="text" id="UserManager_groupIdJoinCond2" name="groupIdJoinCond2" size="15" class="txt_100" value="*<util:message key='ev.prop.securityGroupRole.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityGroupRole.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityGroupRole.groupId'/>*');" onclick="aUserManager.getGroupChooser().doShow(aUserManager.setGroupChooserCallback)"/> 
						<input type="text" id="UserManager_roleIdJoinCond2" name="roleIdJoinCond2" size="15" class="txt_100" value="*<util:message key='ev.prop.securityGroupRole.roleId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityGroupRole.roleId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityGroupRole.roleId'/>*');" onclick="aUserManager.getRoleChooser().doShow(aUserManager.setRoleChooserCallback)"/> 
						<input type="text" name="shortPathCond" size="15" class="txt_100" value="*<util:message key='ev.prop.securityPrincipal.shortPath'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPrincipal.shortPath'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPrincipal.shortPath'/>*');"/> 
						<!--input type="text" name="principalInfo02Cond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.extraUserId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.extraUserId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.extraUserId'/>*');"/--> 
						<input type="text" name="principalNameCond" size="20" class="txt_100" value="*<util:message key='ev.prop.securityPrincipal.principalName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPrincipal.principalName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPrincipal.principalName'/>*');"/> 
						<!--input type="text" name="domain" size="20" class="webtextfield" value="*<util:message key='ev.prop.domain.domain'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.domain.domain'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.domain.domain'/>*');"/-->
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected="selected">10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>	
						<a href="javascript:aUserManager.doSearch('UserManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
						<a href="javascript:aUserManager.doExportExcel()" class="btn_B"><span><util:message key='ev.title.saveExcel'/></span></a>
						<a href="javascript:aUserManager.doGenerateUserMenu()" class="btn_B"><span><util:message key='ev.title.generateUserMenu'/></span></a>  
					</form>		
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="UserManager_ListForm" style="display:inline" name="UserManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="120px" />
						<col width="100px" />
						<col width="*" />
						<col width="*" />
						<col width="200px" />
					</colgroup>			
					<thead>
						<tr>
							<th class="C">
								<input type="checkbox" id="delCheck" onclick="aUserManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
						
							<th class="C" ch="0">
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.domainNm'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserManager.doSort(this, 'a.PRINCIPAL_ID');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalId'/></span>
							</th>
							<th class="C" ch="0" onclick="aUserManager.doSort(this, 'SHORT_PATH');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.shortPath'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserManager.doSort(this, 'PRINCIPAL_NAME');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserManager.doSort(this, 'MODIFIED_DATE');" >
								<span class="table_title"><util:message key='ev.prop.securityPrincipal.modifiedDate'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="UserManager_ListBody">
						<c:forEach items="${results}" var="user" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<input type="checkbox" id="UserManager[<c:out value="${status.index}"/>].checkRow"/>
									<input type="hidden" id="UserManager[<c:out value="${status.index}"/>].principalId" value="<c:out value='${user.principalId}'/>"/>
									<input type="hidden" id="UserManager[<c:out value="${status.index}"/>].shortPath" value="<c:out value='${user.shortPath}'/>"/>
									<input type="hidden" id="UserManager[<c:out value="${status.index}"/>].domainId" value="<c:out value='${user.domainId}'/>"/>
									<input type="hidden" id="UserManager[<c:out value="${status.index}"/>].domainNm" value="<c:out value='${user.domainNm}'/>"/>
								</td>
								<td class="C">
									<c:out value="${status.index}"/>
								</td>
								
								<td class="L" onclick="aUserManager.doSelect(this)">
									<span id="UserManager[<c:out value="${status.index}"/>].domain.label">&nbsp;
									<c:if test="${user.domainNm == '' }"><util:message key='ev.prop.securityPrincipal.noDomain'/></c:if>
									<c:if test="${user.domainNm != '' }"><c:out value="${user.domainNm}"/></c:if></span>
								</td>
								<td class="L" onclick="aUserManager.doSelect(this)">
									<span id="UserManager[<c:out value="${status.index}"/>].principalId.label">&nbsp;<c:out value="${user.principalId}"/></span>
								</td>
								<td class="L" onclick="aUserManager.doSelect(this)">
									<span id="UserManager[<c:out value="${status.index}"/>].shortPath.label">&nbsp;<c:out value="${user.shortPath}"/></span>
								</td>
								<td class="L" onclick="aUserManager.doSelect(this)">
									<span id="UserManager[<c:out value="${status.index}"/>].principalName.label">&nbsp;<c:out value="${user.principalName}"/></span>
								</td>
								<td class="L" onclick="aUserManager.doSelect(this)">
									<span id="UserManager[<c:out value="${status.index}"/>].modifiedDate.label">&nbsp;<c:out value="${user.modifiedDateByFormat}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			<div class="tsearchArea">
				<p id="UserManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="UserManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<c:if test="${isSuperAdmin }">
				<div class="UserManager_EditFormButtons" style="display:none;">
					<div class="rightArea">
						<a href="javascript:aUserManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
						<a href="javascript:aUserManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
					</div>
				</div>
			</c:if>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->
		<!-- UserManager_EditFormPanel -->
		<div id="UserManager_EditFormPanel" class="board" >  
			<!-- UserManager_propertyTabs -->
			<div id="UserManager_propertyTabs">
				<ul>
					<li><a href="#UserManager_DetailTabPage"><util:message key='ev.title.user.detailTab'/></a></li>   
					<li><a href="#UserManager_UserpassTabPage" onclick="aUserManager.onSelectPropertyTab(1);"><util:message key='ev.title.user.userpassTab'/></a></li>   
					<li><a href="#UserManager_UserGroupTabPage" onclick="aUserManager.onSelectPropertyTab(2);"><util:message key='ev.title.user.userGroupTab'/></a></li>   
					<li><a href="#UserManager_UserRoleTabPage" onclick="aUserManager.onSelectPropertyTab(3);"><util:message key='ev.title.user.userRoleTab'/></a></li>
					<%--   
					<li><a href="#UserManager_PagePermissionTabPage" onclick="aUserManager.onSelectPropertyTab(4);"><util:message key='ev.title.user.pagePermissionTab'/></a></li>   
					<li><a href="#UserManager_PortletPermissionTabPage" onclick="aUserManager.onSelectPropertyTab(5);"><util:message key='ev.title.user.portletPermissionTab'/></a></li>
					<li><a href="#UserManager_UrlPermissionTabPage" onclick="aUserManager.onSelectPropertyTab(6);"><util:message key='ev.title.user.urlPermissionTab'/></a></li>
					 --%>   
					<li><a href="#UserManager_TotalPagePermissionTabPage" onclick="aUserManager.onSelectPropertyTab(4);"><util:message key='ev.title.user.totalPagePermissionTab'/></a></li>   
					<li><a href="#UserManager_UserStatisticsTabPage" onclick="aUserManager.onSelectPropertyTab(5);"><util:message key='ev.title.user.userStatisticsTab'/></a></li>   
				</ul>
				<!-- UserManager_DetailTabPage -->
				<div id="UserManager_DetailTabPage">
					<form id="UserManager_EditForm" style="display:inline" action="" method="post">
						<input type="hidden" id="UserManager_isCreate">
						<input type="hidden" id="UserManager_principalType" name="principalType"> 
						<input type="hidden" id="UserManager_principalId" name="principalId"/>
						<input type="hidden" id="SecurityPermission_principalId"/>
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="140px" />
								<col width="*" />
								<col width="140px" />
								<col width="*" />
							</colgroup>					
							<tr >
								<th class="L"><util:message key='ev.prop.securityPrincipal.shortPath'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="UserManager_shortPath" name="shortPath" value="" style="IME-MODE:disabled;" maxLength="30" label="<util:message key='ev.prop.securityPrincipal.shortPath'/>" class="txt_145" />
									<input type="hidden" id="UserManager_domainId" name="domainId" value="" style="display:none;"/>
								</td>
								<th class="L"><util:message key='ev.prop.securityPrincipal.principalName'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="UserManager_principalName" name="principalName" value="" maxLength="40" label="<util:message key='pt.ev.property.principalName'/>" class="txt_145" />	
								</td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.prop.themeMapping.themeName'/></th>
								<td class="L">
									<div class="sel_100">
										<select id="UserManager_theme" name="theme" label="<util:message key='ev.prop.themeMapping.themeName'/>" class='txt_100'>
											<option value=""></option>
											<c:forEach items="${themeList}" var="theme">
												<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
								<th class="L"><util:message key='ev.prop.userpass.gradeCd'/></th>
								<td class="L">
									<div class="sel_100">
										<select id="UserManager_gradeId" name="gradeId" label="<util:message key='pt.ev.property.theme'/>" class='txt_145'>
											<c:forEach items="${gradeList}" var="grade">
												<option value="<c:out value="${grade.GRADE_ID}"/>"><c:out value="${grade.GRADE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.title.user.defaultPage'/></th>
								<td colspan="3" class="L">
									<input type="text" id="UserManager_defaultPage" name="defaultPage" value="" maxLength="" label="<util:message key='ev.title.user.defaultPage'/>" class="txt_145" />	
									<a href="javascript:aUserManager.getPageChooser().doShow(aUserManager.setPageChooserCallback)" class="btn_B"><span><util:message key='ev.title.selectPage'/></span></a>
								</td>
							</tr>
							<tr >
								<th class="L"><util:message key='ev.prop.securityCredential.columnValue'/></th>
								<td class="L">
									<input type="password" id="UserManager_columnValue0" name="columnValue0" value="" maxLength="" label="<util:message key='ev.prop.securityCredential.columnValue'/>" class="txt_145" />	
								</td>
								<th class="L"><util:message key='ev.title.user.password.confirm'/></th>
								<td class="L">
									<input type="password" id="UserManager_columnValueConfirm" name="columnValueConfirm" value="" maxLength="" label="<util:message key='ev.title.user.confirm'/>" class="txt_145" />	
								</td>
							</tr>
							<tr >
								<th class="L"><util:message key='ev.title.user.optionTab'/></th>
								<td colspan="3" class="L">
									<util:message key='ev.prop.policy.isEnabled'/><input type="checkbox" id="UserManager_isEnabled" name="isEnabled" value="" class="txt_145" /> &nbsp;&nbsp;
									<util:message key='ev.prop.securityCredential.updateRequired'/><input type="checkbox" id="UserManager_updateRequired0" name="updateRequired0" value="" label="<util:message key='pt.ev.property.optionTab'/>" class="txt_145" />
								</td>
							</tr>
							<tr >
								<th class="L"><util:message key='ev.prop.securityCredential.authFailures'/></th>
								<td class="L">
									<input type="text" id="UserManager_authFailures0" name="authFailures0" value="" maxLength="" label="<util:message key='ev.prop.securityCredential.authFailures'/>" class="txt_145" />	
								</td>
								<th class="L"><util:message key='ev.title.user.password.modified_date'/></th>
								<td class="L"><input type="text" id="UserManager_modifiedDate0" name="modifiedDate0" value="" label="<util:message key='ev.title.user.password.modified_date'/>" class="txt_145" /></td>
							</tr>
							<tr >
								<th class="L"><util:message key='ev.prop.policy.authMethod'/> <em>*</em></th>
								<td class="L">
									<div class="sel_100">
										<select id="UserManager_authMethod" name="authMethod" label="<util:message key='ev.prop.policy.authMethod'/>" class='txt_100'>
											<c:forEach items="${authMethodList}" var="authMethod">
												<option value="<c:out value="${authMethod.code}"/>"><c:out value="${authMethod.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
								<td class="L">&nbsp;</td>
								<td class="L">&nbsp;</td>
							</tr>
							<tr >
								<th class="L"><util:message key='ev.prop.securityPrincipal.creationDate'/></th>
								<td class="L"><input type="text" id="UserManager_creationDate" name="creationDate" value="" label="<util:message key='ev.prop.securityPrincipal.creationDate'/>" class="txt_145" /></td>
								<th class="L"><util:message key='ev.prop.securityPrincipal.modifiedDate'/></th>
								<td class="L"><input type="text" id="UserManager_modifiedDate" name="modifiedDate" value="" label="<util:message key='ev.prop.securityPrincipal.modifiedDate'/>" class="txt_145" /></td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.userpass.principalInfo01'/></th>
								<td colspan="3" class="L">
									<input type="text" id="UserManager_principalInfo01" name="principalInfo01" value="" maxLength="50" label="<util:message key='ev.prop.userpass.principalInfo01'/>" class="txt_145" />
								</td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.prop.userpass.principalInfo02'/></th>
								<td colspan="3" class="L">
									<input type="text" id="UserManager_principalInfo02" name="principalInfo02" value="" maxLength="50" label="<util:message key='ev.prop.userpass.principalInfo02'/>" class="txt_145" />
								</td>
							</tr>
							<tr style="display:none;">
								<th class="L"><util:message key='ev.prop.userpass.principalInfo03'/></th>
								<td colspan="3" class="L">
									<input type="text" id="UserManager_principalInfo03" name="principalInfo03" value="" maxLength="50" label="<util:message key='ev.prop.userpass.principalInfo03'/>" class="txt_145" />
								</td>
							</tr>
							<tr >
								<th class="L"><util:message key='ev.prop.securityPrincipal.principalDesc'/></th>
								<td colspan="3" class="L">
									<textarea id="UserManager_principalDesc" name="principalDesc" value="" cols="80" rows="2" maxLength="80" label="<util:message key='ev.prop.securityPrincipal.principalDesc'/>" class="txt_100"> </textarea>
								</td>
							</tr>
						</table>			
						<!-- btnArea-->
						<c:if test="${isSuperAdmin}">
							<div class="btnArea">
								<div id="CodebaseManager_Child_ListButtons" class="rightArea">
									<a href="javascript:aUserManager.doInitializePassword()" class="btn_B"><span><util:message key='ev.title.initPassword'/></span></a>
									<a href="javascript:aUserManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
								</div>
							</div>
						</c:if>
						<!-- btnArea//-->				
					</form>
				</div>
				<!-- UserManager_DetailTabPage// -->
				<div id="UserManager_UserpassTabPage"></div>
				<div id="UserManager_UserGroupTabPage"></div>
				<div id="UserManager_UserRoleTabPage"></div>
				<%--   
				<div id="UserManager_PagePermissionTabPage"></div>
				<div id="UserManager_PortletPermissionTabPage"></div>
				<div id="UserManager_UrlPermissionTabPage"></div>
				--%>
				<div id="UserManager_TotalPagePermissionTabPage"></div>
				<div id="UserManager_UserStatisticsTabPage"></div>
			</div>
			<!-- UserManager_propertyTabs// -->
		</div>
		<!-- UserManager_EditFormPanel// -->
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="PageManager_PageChooser">
	<div id="PageChooser_TreeTabPage" class="tree" style="border-right: 0px #ffffff;"></div>
</div>
<div id="GroupManager_GroupChooser" title="Group Chooser"></div>
<div id="RoleManager_RoleChooser" title="Role Chooser"></div>
<iframe id='exportExcelIF' frameborder=0 width=0 height=0></iframe>	