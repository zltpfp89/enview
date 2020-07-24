<%-- <%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pushManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userpassManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/credentialManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userGroupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userRoleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pagePermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletPermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/totalPagePermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userStatisticsManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorPermissionApp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorApp.js"></script>

<script type="text/javascript">
$(function() 
		{
	$( "#dialog" ).dialog();	
});

function initUserManager() 
{
	if( aUserManager == null ) {
		aUserManager = new UserManager();
		//aUserManager.init("<c:out value="${evSecurityCode}"/>");
		//aUserManager.doDefaultSelect();
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
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="UserManager_UserTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="UserManager_SearchForm" name="UserManager_SearchForm" style="display:inline" action="javascript:aUserManager.doSearch('UserManager_SearchForm')" onkeydown="if(event.keyCode==13) aUserManager.doSearch('UserManager_SearchForm')" method="post">
					  <table width="99%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<input type='hidden' name='pageSize' value='10'>
						<input type='hidden' name='pageFunction' value='aUserManager.doPage'/>
						<input type='hidden' name='formName' value='UserManager_SearchForm'/>
					  <tr>
						<td align="right">
						<input type="text" id="search" name="principalInfo02Cond" size="15" class="webtextfield" value="" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.extraUserId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.extraUserId'/>*');"/> 
					        <select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected="selected">8</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							
							<span class="btn_pack small"><a href="javascript:aUserManager.doSearch('UserManager_SearchForm')"><util:message key='ev.title.search'/></a></span>
							<input type="text" id="UserManager_groupIdJoinCond" name="groupIdJoinCond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.groupId'/>*');" onclick="aUserManager.getGroupChooser().doShow(aUserManager.setGroupChooserCallback)"/> 
							<input type="text" id="UserManager_roleIdJoinCond" name="roleIdJoinCond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.roleId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.roleId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.roleId'/>*');" onclick="aUserManager.getRoleChooser().doShow(aUserManager.setRoleChooserCallback)"/> 
							<input type="text" name="shortPathCond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.shortPath'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.shortPath'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.shortPath'/>*');"/> 
							<input type="text" name="principalInfo02Cond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.extraUserId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.extraUserId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.extraUserId'/>*');"/> 
							<input type="text" name="principalNameCond" size="20" class="webtextfield" value="*<util:message key='pt.ev.property.principalName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.principalName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.principalName'/>*');"/> 
							<select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected="selected">8</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<span class="btn_pack small"><a href="javascript:aUserManager.doSearch('UserManager_SearchForm')"><util:message key='ev.title.search'/></a></span>
						</td>
					  </tr>
					  </table>    
					</form>
				</div>
				<div class="webgridpanel">
				  <form id="UserManager_ListForm" style="display:inline" name="UserManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aUserManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
						
							<th class="webgridheader" ch="0" onclick="aUserManager.doSort(this, 'PRINCIPAL_ID');" >
								<span>아이디</span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserManager.doSort(this, 'SHORT_PATH');" >
								<span>디바이스번호</span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserManager.doSort(this, 'SHORT_PATH1');" >
								<span>구분</span>
							</th>	
						</tr>
					</thead>
					<tbody id="UserManager_ListBody">
			
					<c:forEach items="${results}" var="pushManager" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="UserManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							    <input type="hidden" id="UserManager[<c:out value="${status.index}"/>].userId" value="<c:out value='${pushManager.userId}'/>"/>
							    <input type="hidden" id="UserManager[<c:out value="${status.index}"/>].deviceKey" value="<c:out value='${pushManager.deviceKey}'/>"/>
							    <input type="hidden" id="UserManager[<c:out value="${status.index}"/>].phoneType" value="<c:out value='${pushManager.phoneType}'/>"/>
							</td>
							<td class="webgridbody">
							   
								<span>
								<c:out value="${status.index}"/>
								
								</span>
							</td>
							
							<td align="left" class="webgridbody" onclick="aUserManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserManager[<c:out value="${status.index}"/>].userId.label">&nbsp;<c:out value="${pushManager.userId}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserManager[<c:out value="${status.index}"/>].deviceKey.label">&nbsp;<c:out value="${pushManager.deviceKey}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserManager[<c:out value="${status.index}"/>].phoneType.label">&nbsp;<c:out value="${pushManager.phoneType}"/></span>
							</td>
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="UserManager_ListMessage">
					<c:out value='${resultMessage}'/>
			        <!-- <input type="button" value="전체" onClick="aUserManager.all()"/> -->
				  </div>
				</div>
				<div>
					<table style="width:99%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="UserManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					</tr>
					</table>

<!-- 			<input type="button" class="btn_pack small"  size="1" value=" 등록  " onClick="aUserManager.doRemove()"/>
			<input type="button" class="btn_pack small"  size="1" value=" 수정 " onClick="aUserManager.doRemove()"/>
			<input type="button" class="btn_pack small"  size="1" value=" 삭제 " onClick="aUserManager.doRemove()"/>
 -->		
			<div id="dialog" title="메세지 전송">
					    수 신  : <input type="text" readOnly="readOnly" id="pushrreciveid" name="pushrrecive"/>
					             
					             <input type="hidden" id="pushrrecivedeviceKey" name="pushrrecive"/>
					             <input type="hidden" id="pushrrecivedevicephoneType" name="pushrrecive"/>
					             
					             <br>
					     제 목 : <input type="text" id="pushtitle" ><br>
					             <textarea rows="8" cols="40" id="pushcontent"></textarea>
					             <table>
						             <tr >
							             <td align="right">
							            	 <input type="button" value="전송" onClick="aUserManager.doPushSend()"/>
							             </td>
							             <td align="right">
							             	<input type="button" value="취소"  onClick="aUserManager.doPushClear()"/>
							             </td>
						             </tr>
					             </table>
			</div>
<div id="UserManager_EditFormPanel" class="webformpanel" >  
					<div id="UserManager_propertyTabs">
						<ul>
							<li><a href="#UserManager_DetailTabPage">메세지 작성</a></li>   
							<li><a href="#UserManager_DetailTabPage">사용자 등록</a></li>   
						</ul>
						<div id="UserManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="UserManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding='0' cellspacing='0' border='0' width='100%'>
									<input type="hidden" id="UserManager_isCreate">
									<input type="hidden" id="UserManager_principalType" name="principalType"> 
									<input type="hidden" id="UserManager_principalId" name="principalId"/>
									<input type="hidden" id="SecurityPermission_principalId"/>
									<tr> 
										<td colspan="4" width="100%" class="webformheaderline"></td>    
									</tr>
							
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.shortPath'/> *</td>
										<td width="30%" class="webformfield">
											<input type="text" id="UserManager_shortPath" name="shortPath" value="" style="IME-MODE:disabled;" maxLength="30" label="<util:message key='pt.ev.property.shortPath'/>" class="full_webtextfield" />
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalName'/> *</td>
										<td class="webformfield">
											<input type="text" id="UserManager_principalName" name="principalName" value="" maxLength="40" label="<util:message key='pt.ev.property.principalName'/>" class="full_webtextfield" />	
										</td>
									</tr>
									
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.theme'/></td>
										<td class="webformfield">
											<select id="UserManager_theme" name="theme" label="<util:message key='pt.ev.property.theme'/>" class='webdropdownlist'>
												<option value=""></option>
												<c:forEach items="${themeList}" var="theme">
												<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
												</c:forEach>
											</select>
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.gradeCd'/></td>
										<td class="webformfield">
											<select id="UserManager_gradeId" name="gradeId" label="<util:message key='pt.ev.property.theme'/>" class='webdropdownlist'>
												<option value=""><util:message key='eb.title.selGrd'/></option> 
												<c:forEach items="${gradeList}" var="grade">
												<option value="<c:out value="${grade.GRADE_ID}"/>"><c:out value="${grade.GRADE_NAME}"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.defaultPage'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserManager_defaultPage" name="defaultPage" value="" maxLength="" label="<util:message key='pt.ev.property.defaultPage'/>" class="webtextfield" style="width:75%;"/>	
											<span class="btn_pack small"><a href="javascript:aUserManager.getPageChooser().doShow(aUserManager.setPageChooserCallback)"><util:message key='ev.title.selectPage'/></a></span>
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.columnValue'/></td>
										<td class="webformfield">
											<input type="password" id="UserManager_columnValue0" name="columnValue0" value="" maxLength="" label="<util:message key='pt.ev.property.columnValue'/>" class="full_webtextfield" />	
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.password.confirm'/></td>
										<td class="webformfield">
											<input type="password" id="UserManager_columnValueConfirm" name="columnValueConfirm" value="" maxLength="" label="<util:message key='pt.ev.property.password.confirm'/>" class="full_webtextfield" />	
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.optionTab'/></td>
										<td colspan="3" class="webformfield">
											<util:message key='pt.ev.property.isEnabled'/><input type="checkbox" id="UserManager_isEnabled" name="isEnabled" value="" class="webcheckbox" /> &nbsp;&nbsp;
											<util:message key='pt.ev.property.updateRequired'/><input type="checkbox" id="UserManager_updateRequired0" name="updateRequired0" value="" label="<util:message key='pt.ev.property.optionTab'/>" class="webcheckbox" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.authFailures'/></td>
										<td class="webformfield">
											<input type="text" id="UserManager_authFailures0" name="authFailures0" value="" maxLength="" label="<util:message key='pt.ev.property.authFailures'/>" class="full_webtextfield" />	
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.password.modified_date'/></td>
										<td class="webformfield"><input type="text" id="UserManager_modifiedDate0" name="modifiedDate0" value="" label="<util:message key='pt.ev.property.password.modified_date'/>" class="full_webtextfield" /></td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.authMethod'/> *</td>
										<td class="webformfield">
											<select id="UserManager_authMethod" name="authMethod" label="<util:message key='pt.ev.property.authMethod'/>" class='webdropdownlist'>
												<c:forEach items="${authMethodList}" var="authMethod">
												<option value="<c:out value="${authMethod.code}"/>"><c:out value="${authMethod.codeName}"/></option>
												</c:forEach>
											</select>
										</td>
										<td width="20%" class="webformlabelmiddle">&nbsp;</td>
										<td class="webformfield">&nbsp;</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.creationDate'/></td>
										<td class="webformfield"><input type="text" id="UserManager_creationDate" name="creationDate" value="" label="<util:message key='pt.ev.property.creationDate'/>" class="full_webtextfield" /></td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.modifiedDate'/></td>
										<td class="webformfield"><input type="text" id="UserManager_modifiedDate" name="modifiedDate" value="" label="<util:message key='pt.ev.property.modifiedDate'/>" class="full_webtextfield" /></td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalInfo01'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserManager_principalInfo01" name="principalInfo01" value="" maxLength="50" label="<util:message key='pt.ev.property.principalInfo01'/>" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalInfo02'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserManager_principalInfo02" name="principalInfo02" value="" maxLength="50" label="<util:message key='pt.ev.property.principalInfo02'/>" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalInfo03'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserManager_principalInfo03" name="principalInfo03" value="" maxLength="50" label="<util:message key='pt.ev.property.principalInfo03'/>" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalDesc'/></td>
										<td colspan="3" class="webformfield">
											<textarea id="UserManager_principalDesc" name="principalDesc" value="" cols="80" rows="2" maxLength="80" label="<util:message key='pt.ev.property.principalDesc'/>" class="full_webtextfield"> </textarea>
										</td>
									</tr> 
									
								</table>
							<table style="width:99%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<span class="btn_pack small"><a href="javascript:aUserManager.doInitializePassword()"><util:message key='ev.title.initPassword'/></a></span>
										<span class="btn_pack small"><a href="javascript:aUserManager.doUpdate()"><util:message key='ev.title.save'/></a></span>
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
						<div id="UserManager_UserpassTabPage"></div>
						<div id="UserManager_UserGroupTabPage"></div>
						<div id="UserManager_UserRoleTabPage"></div>
						<div id="UserManager_PagePermissionTabPage"></div>
						<div id="UserManager_PortletPermissionTabPage"></div>
						<div id="UserManager_TotalPagePermissionTabPage"></div>
						<div id="UserManager_UserStatisticsTabPage"></div>
					</div>
					</div> <!-- End UserManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End UserManager_UserTabPage -->
		</div>
	</td>
<tr>
</table>

<!-- <div id="PageManager_PageChooser"></div>
<div id="GroupManager_GroupChooser"></div>
<div id="RoleManager_RoleChooser"></div> -->
 --%>
 
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pushManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userpassManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/credentialManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userGroupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userRoleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pagePermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletPermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/totalPagePermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userStatisticsManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorPermissionApp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorApp.js"></script>

<script type="text/javascript">
$(function()
		{$("#dialog2").dialog(
				{width:270,
				 height:245,
				 buttons: {"지우기" : function() {aUserManager.doPushClear();},
					 "전송" : function() { aUserManager.doPushSend()}}})}
  )
		
function initUserManager() 
{
	if( aUserManager == null ) {
		aUserManager = new UserManager();
		//aUserManager.init("<c:out value="${evSecurityCode}"/>");
		//aUserManager.doDefaultSelect();
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
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="UserManager_UserTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="UserManager_SearchForm" name="UserManager_SearchForm" style="display:inline" action="javascript:aUserManager.doSearch('UserManager_SearchForm')" onkeydown="if(event.keyCode==13) aUserManager.doSearch('UserManager_SearchForm')" method="post">
					  <table width="99%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<input type='hidden' name='pageSize' value='10'>
						<input type='hidden' name='pageFunction' value='aUserManager.doPage'/>
						<input type='hidden' name='formName' value='UserManager_SearchForm'/>
					  <tr>
						<td align="right">
						<input type="text" id="search" name="principalInfo02Cond" size="15" class="webtextfield" value="" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.extraUserId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.extraUserId'/>*');"/> 
					        <select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected="selected">8</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							
							<span class="btn_pack small"><a href="javascript:aUserManager.doSearch('UserManager_SearchForm')"><util:message key='ev.title.search'/></a></span>
							<%-- <input type="text" id="UserManager_groupIdJoinCond" name="groupIdJoinCond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.groupId'/>*');" onclick="aUserManager.getGroupChooser().doShow(aUserManager.setGroupChooserCallback)"/> 
							<input type="text" id="UserManager_roleIdJoinCond" name="roleIdJoinCond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.roleId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.roleId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.roleId'/>*');" onclick="aUserManager.getRoleChooser().doShow(aUserManager.setRoleChooserCallback)"/> 
							<input type="text" name="shortPathCond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.shortPath'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.shortPath'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.shortPath'/>*');"/> 
							<input type="text" name="principalInfo02Cond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.extraUserId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.extraUserId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.extraUserId'/>*');"/> 
							<input type="text" name="principalNameCond" size="20" class="webtextfield" value="*<util:message key='pt.ev.property.principalName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.principalName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.principalName'/>*');"/> 
							<select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected="selected">8</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<span class="btn_pack small"><a href="javascript:aUserManager.doSearch('UserManager_SearchForm')"><util:message key='ev.title.search'/></a></span>
	 --%>					</td>
					  </tr>
					  </table>    
					</form>
				</div>
				<div class="webgridpanel">
				  <form id="UserManager_ListForm" style="display:inline" name="UserManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aUserManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
						
							<th class="webgridheader" ch="0" onclick="aUserManager.doSort(this, 'PRINCIPAL_ID');" >
								<span>아이디</span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserManager.doSort(this, 'SHORT_PATH');" >
								<span>디바이스번호</span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserManager.doSort(this, 'SHORT_PATH1');" >
								<span>구분</span>
							</th>	
						</tr>
					</thead>
					<tbody id="UserManager_ListBody">
			
					<c:forEach items="${results}" var="pushManager" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="UserManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							    <input type="hidden" id="UserManager[<c:out value="${status.index}"/>].userId" value="<c:out value='${pushManager.userId}'/>"/>
							    <input type="hidden" id="UserManager[<c:out value="${status.index}"/>].deviceKey" value="<c:out value='${pushManager.deviceKey}'/>"/>
							    <input type="hidden" id="UserManager[<c:out value="${status.index}"/>].phoneType" value="<c:out value='${pushManager.phoneType}'/>"/>
							</td>
							<td class="webgridbody">
							   
								<span>
								<c:out value="${status.index}"/>
								
								</span>
							</td>
							
							<td align="left" class="webgridbody" onclick="aUserManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserManager[<c:out value="${status.index}"/>].userId.label">&nbsp;<c:out value="${pushManager.userId}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserManager[<c:out value="${status.index}"/>].deviceKey.label">&nbsp;<c:out value="${pushManager.deviceKey}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserManager[<c:out value="${status.index}"/>].phoneType.label">&nbsp;<c:out value="${pushManager.phoneType}"/></span>
							</td>
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="UserManager_ListMessage">
					<%-- <c:out value='${resultMessage}'/> --%>
			        <!-- <input type="button" value="전체" onClick="aUserManager.all()"/> -->
				  </div>
				</div>
				<div>
					<table style="width:99%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="UserManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					</tr>
					</table>

<!-- 			<input type="button" class="btn_pack small"  size="1" value=" 등록  " onClick="aUserManager.doRemove()"/>
			<input type="button" class="btn_pack small"  size="1" value=" 수정 " onClick="aUserManager.doRemove()"/>
			<input type="button" class="btn_pack small"  size="1" value=" 삭제 " onClick="aUserManager.doRemove()"/>
 -->		
			<div id="dialog2" title="메세지 전송">
					    수 신  : <input type="text" readOnly="readOnly" id="pushrreciveid" name="pushrrecive"/>
					             
					             <input type="hidden" id="pushrrecivedeviceKey" name="pushrrecive"/>
					             <input type="hidden" id="pushrrecivedevicephoneType" name="pushrrecive"/>
					             
					             <br>
					     제 목 : <input type="text" id="pushtitle" ><br>
					             <textarea rows="8" cols="40" id="pushcontent"></textarea>
					         <!--     <table>
						             <tr >
							             <td align="right">
							            	 <input type="button" value="전송" onClick="aUserManager.doPushSend()"/>
							             </td>
							             <td align="right">
							             	<input type="button" value="취소"  onClick="aUserManager.doPushClear()"/>
							             </td>
						             </tr>
					             </table> -->
			</div>
<%-- <div id="UserManager_EditFormPanel" class="webformpanel" >  
					<div id="UserManager_propertyTabs">
						<ul>
							<li><a href="#UserManager_DetailTabPage">메세지 작성</a></li>   
							<li><a href="#UserManager_DetailTabPage">사용자 등록</a></li>   
						</ul>
						<div id="UserManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="UserManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding='0' cellspacing='0' border='0' width='100%'>
									<input type="hidden" id="UserManager_isCreate">
									<input type="hidden" id="UserManager_principalType" name="principalType"> 
									<input type="hidden" id="UserManager_principalId" name="principalId"/>
									<input type="hidden" id="SecurityPermission_principalId"/>
									<tr> 
										<td colspan="4" width="100%" class="webformheaderline"></td>    
									</tr>
							
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.shortPath'/> *</td>
										<td width="30%" class="webformfield">
											<input type="text" id="UserManager_shortPath" name="shortPath" value="" style="IME-MODE:disabled;" maxLength="30" label="<util:message key='pt.ev.property.shortPath'/>" class="full_webtextfield" />
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalName'/> *</td>
										<td class="webformfield">
											<input type="text" id="UserManager_principalName" name="principalName" value="" maxLength="40" label="<util:message key='pt.ev.property.principalName'/>" class="full_webtextfield" />	
										</td>
									</tr>
									
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.theme'/></td>
										<td class="webformfield">
											<select id="UserManager_theme" name="theme" label="<util:message key='pt.ev.property.theme'/>" class='webdropdownlist'>
												<option value=""></option>
												<c:forEach items="${themeList}" var="theme">
												<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
												</c:forEach>
											</select>
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.gradeCd'/></td>
										<td class="webformfield">
											<select id="UserManager_gradeId" name="gradeId" label="<util:message key='pt.ev.property.theme'/>" class='webdropdownlist'>
												<option value=""><util:message key='eb.title.selGrd'/></option> 
												<c:forEach items="${gradeList}" var="grade">
												<option value="<c:out value="${grade.GRADE_ID}"/>"><c:out value="${grade.GRADE_NAME}"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.defaultPage'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserManager_defaultPage" name="defaultPage" value="" maxLength="" label="<util:message key='pt.ev.property.defaultPage'/>" class="webtextfield" style="width:75%;"/>	
											<span class="btn_pack small"><a href="javascript:aUserManager.getPageChooser().doShow(aUserManager.setPageChooserCallback)"><util:message key='ev.title.selectPage'/></a></span>
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.columnValue'/></td>
										<td class="webformfield">
											<input type="password" id="UserManager_columnValue0" name="columnValue0" value="" maxLength="" label="<util:message key='pt.ev.property.columnValue'/>" class="full_webtextfield" />	
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.password.confirm'/></td>
										<td class="webformfield">
											<input type="password" id="UserManager_columnValueConfirm" name="columnValueConfirm" value="" maxLength="" label="<util:message key='pt.ev.property.password.confirm'/>" class="full_webtextfield" />	
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.optionTab'/></td>
										<td colspan="3" class="webformfield">
											<util:message key='pt.ev.property.isEnabled'/><input type="checkbox" id="UserManager_isEnabled" name="isEnabled" value="" class="webcheckbox" /> &nbsp;&nbsp;
											<util:message key='pt.ev.property.updateRequired'/><input type="checkbox" id="UserManager_updateRequired0" name="updateRequired0" value="" label="<util:message key='pt.ev.property.optionTab'/>" class="webcheckbox" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.authFailures'/></td>
										<td class="webformfield">
											<input type="text" id="UserManager_authFailures0" name="authFailures0" value="" maxLength="" label="<util:message key='pt.ev.property.authFailures'/>" class="full_webtextfield" />	
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.password.modified_date'/></td>
										<td class="webformfield"><input type="text" id="UserManager_modifiedDate0" name="modifiedDate0" value="" label="<util:message key='pt.ev.property.password.modified_date'/>" class="full_webtextfield" /></td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.authMethod'/> *</td>
										<td class="webformfield">
											<select id="UserManager_authMethod" name="authMethod" label="<util:message key='pt.ev.property.authMethod'/>" class='webdropdownlist'>
												<c:forEach items="${authMethodList}" var="authMethod">
												<option value="<c:out value="${authMethod.code}"/>"><c:out value="${authMethod.codeName}"/></option>
												</c:forEach>
											</select>
										</td>
										<td width="20%" class="webformlabelmiddle">&nbsp;</td>
										<td class="webformfield">&nbsp;</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.creationDate'/></td>
										<td class="webformfield"><input type="text" id="UserManager_creationDate" name="creationDate" value="" label="<util:message key='pt.ev.property.creationDate'/>" class="full_webtextfield" /></td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.modifiedDate'/></td>
										<td class="webformfield"><input type="text" id="UserManager_modifiedDate" name="modifiedDate" value="" label="<util:message key='pt.ev.property.modifiedDate'/>" class="full_webtextfield" /></td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalInfo01'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserManager_principalInfo01" name="principalInfo01" value="" maxLength="50" label="<util:message key='pt.ev.property.principalInfo01'/>" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalInfo02'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserManager_principalInfo02" name="principalInfo02" value="" maxLength="50" label="<util:message key='pt.ev.property.principalInfo02'/>" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalInfo03'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserManager_principalInfo03" name="principalInfo03" value="" maxLength="50" label="<util:message key='pt.ev.property.principalInfo03'/>" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"/> <util:message key='pt.ev.property.principalDesc'/></td>
										<td colspan="3" class="webformfield">
											<textarea id="UserManager_principalDesc" name="principalDesc" value="" cols="80" rows="2" maxLength="80" label="<util:message key='pt.ev.property.principalDesc'/>" class="full_webtextfield"> </textarea>
										</td>
									</tr> 
									
								</table>
							<table style="width:99%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<span class="btn_pack small"><a href="javascript:aUserManager.doInitializePassword()"><util:message key='ev.title.initPassword'/></a></span>
										<span class="btn_pack small"><a href="javascript:aUserManager.doUpdate()"><util:message key='ev.title.save'/></a></span>
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
						<div id="UserManager_UserpassTabPage"></div>
						<div id="UserManager_UserGroupTabPage"></div>
						<div id="UserManager_UserRoleTabPage"></div>
						<div id="UserManager_PagePermissionTabPage"></div>
						<div id="UserManager_PortletPermissionTabPage"></div>
						<div id="UserManager_TotalPagePermissionTabPage"></div>
						<div id="UserManager_UserStatisticsTabPage"></div>
					</div>
					</div> <!-- End UserManager_EditFormPanel --> --%>
				</div> <!-- End webformpanel -->
			</div> <!-- End UserManager_UserTabPage -->
		</div>
	</td>
<tr>
</table>

<!-- <div id="PageManager_PageChooser"></div>
<div id="GroupManager_GroupChooser"></div>
<div id="RoleManager_RoleChooser"></div> -->


 