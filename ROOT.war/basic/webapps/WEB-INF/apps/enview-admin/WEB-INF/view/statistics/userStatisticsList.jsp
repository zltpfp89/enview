<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/tree/dhtmlxcommon.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/tree/dhtmlXTree.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/tree/dhtmlXTreeMenu.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userStatisticsManager.js"></script>

<script type="text/javascript">

function initUserStatisticsManager()
{
	if( aUserStatisticsManager == null ) {
		aUserStatisticsManager = new UserStatisticsManager("<c:out value="${evSecurityCode}"/>");
		aUserStatisticsManager.init();
	}
}

function finishUserStatisticsManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initUserStatisticsManager );
	window.attachEvent ( "onunload", finishUserStatisticsManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initUserStatisticsManager, false );
	window.addEventListener ( "unload", finishUserStatisticsManager, false );
}
else
{
    window.onload = initUserStatisticsManager;
	window.onunload = finishUserStatisticsManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea" style="margin-bottom:50px;">
				<!-- <p id="UserStatisticsManager_ListMessage"></p> -->
				<fieldset style="position:relative; float:right">
					<form id="UserStatisticsManager_SearchForm" name="UserStatisticsManager_SearchForm" style="display:inline" action="javascript:aUserStatisticsManager.doSearch('UserStatisticsManager_SearchForm')" onkeydown="if(event.keyCode==13) aUserStatisticsManager.doSearch('UserStatisticsManager_SearchForm')"  method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>
						<input type='hidden' name='sortColumn' value=''/>
						<input type='hidden' name='pageNo' value='1'/>
						
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aUserStatisticsManager.doPage'/>
						<input type='hidden' name='formName' value='UserStatisticsManager_SearchForm'/>
						
						<input type='hidden' id='UserStatisticsManager_Master_userId' name='userId' value=''/>
						<input type="hidden" id="UserStatisticsManager_groupIdCond" name="groupIdCond" value=''/>
						<input type="hidden" id="UserStatisticsManager_roleIdCond" name="roleIdCond" value=''/>
		
						<c:if test="${isSuperAdmin}">
							<div class="sel_70">
								<select id="UserStatisticsManager_domainCond" name="domainId" class='txt_70' onchange="aUserStatisticsManager.doRetrieve();">
									<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }"><option value="-1">*<util:message key='ev.prop.domain.domain'/>*</option></c:if>
									<c:forEach items="${domainList}" var="domainInfo">
										<c:if test="${domainInfo.domainId != 0}">
											<option value="<c:out value="${domainInfo.domainId}"/>" <c:if test="${domainInfo.domainId == inform.domainId}">selected="selected"</c:if>><c:out value="${domainInfo.domainNm}"/></option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</c:if>
						<c:if test="${!isSuperAdmin}"><input id="UserStatisticsManager_domainCond" name="domainId" type="hidden" value="${inform.domainId }"/></c:if>
						<input type="text" id="UserStatisticsManager_groupIdCond2" name="groupIdCond2" size="13" class="txt_70" value="*<util:message key='ev.title.statistics.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.groupId'/>*');" onclick="aUserStatisticsManager.getGroupChooser().doShow(aUserStatisticsManager.setGroupChooserCallback)"/> 
						<input type="text" id="UserStatisticsManager_roleIdCond2" name="roleIdCond2" size="13" class="txt_70" value="*<util:message key='ev.prop.securityGroupRole.roleId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityGroupRole.roleId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityGroupRole.roleId'/>*');" onclick="aUserStatisticsManager.getRoleChooser().doShow(aUserStatisticsManager.setRoleChooserCallback)"/> 										
						<input type="text" name="userIdCond" size="8" class="txt_70" value="*<util:message key='ev.prop.userStatistics.userId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.userStatistics.userId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.userStatistics.userId'/>*');"/> 
									
						<input type="text" name="userNameCond" size="12" class="txt_70" value="*<util:message key='ev.prop.userStatistics.userName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.userStatistics.userName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.userStatistics.userName'/>*');"/> 
									
						<input type="text" name="userIpCond" size="8" class="txt_70" value="*<util:message key='ev.prop.userStatistics.userIp'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.userStatistics.userIp'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.userStatistics.userIp'/>*');"/> 
						<div class="sel_70">
							<select name="statusCond" class='txt_70'>
								<option value="0">*<util:message key='ev.prop.userStatistics.status'/>*</option>
								<c:forEach items="${statusList}" var="status">
									<option value="<c:out value="${status.code}"/>"><c:out value="${status.codeName}"/></option>
								</c:forEach>
							</select>								
						</div>	
								
						<input type="text" id="UserStatisticsManager_startTimeStampCond" size="8" name="startTimeStampCond" class="txt_70" value="*<util:message key='ev.title.statistics.startTime'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.startTime'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pev.title.statistics.startTime'/>*');"/>
						<input type="text" id="UserStatisticsManager_endTimeStampCond" size="8" name="endTimeStampCond" class="txt_70" value="*<util:message key='ev.title.statistics.endTime'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.endTime'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pev.title.statistics.endTime'/>*');"/>
						<div class="sel_50">
							<select name='pageSize' class="txt_50">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>								
						</div>
						<a href="javascript:aUserStatisticsManager.doSearch('UserStatisticsManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
						<a href="javascript:aUserStatisticsManager.doExportExcel()" class="btn_B"><span><util:message key='ev.title.saveExcel'/></span></a>   
					</form>			
				</fieldset>
			</div>
			<!-- searchArea// -->
			<form id="UserStatisticsManager_ListForm" style="display:inline" name="UserStatisticsManager_ListForm" action="" method="post"> <!--- 사용자 로그메뉴  -->
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="100px" />
						<col width="80px" />
						<col width="15%" />
						<col width="15%" />
						<col width="10%" />
						<col width="128px" />
						<col width="128px" />
						<col width="10%" />
						<col width="100px" />
					</colgroup>
					<thead>
						<tr>
							<th class="first">No</th>
							
							<th class="C" ch="0" onclick="aUserStatisticsManager.doSort(this, 'DOMAIN_NM');" >
								<span class="table_title"><util:message key='ev.prop.domain.domain'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserStatisticsManager.doSort(this, 'A.USER_ID');" >
								<span class="table_title"><util:message key='ev.prop.userStatistics.userId'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserStatisticsManager.doSort(this, 'USER_NAME');" >
								<span class="table_title"><util:message key='ev.prop.userStatistics.userName'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserStatisticsManager.doSort(this, 'ORG_NAME');" >
								<span class="table_title"><util:message key='ev.prop.userStatistics.orgName'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserStatisticsManager.doSort(this, 'D.PRINCIPAL_NAME');" >
								<span class="table_title"><util:message key='ev.prop.userStatistics.roleName'/></span>
							</th>
							<th class="C" ch="0" onclick="aUserStatisticsManager.doSort(this, 'IPADDRESS');" >
								<span class="table_title"><util:message key='ev.prop.userStatistics.userIp'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserStatisticsManager.doSort(this, 'STATUS');" >
								<span class="table_title"><util:message key='ev.prop.userStatistics.status'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserStatisticsManager.doSort(this, 'ACCESS_BROWSER');" >
								<span class="table_title"><util:message key='ev.prop.userStatistics.accessBrowser'/></span>
							</th>	
							<th class="C" ch="0" onclick="aUserStatisticsManager.doSort(this, 'TIME_STAMP');" >
								<span class="table_title"><util:message key='ev.prop.userStatistics.timeStamp'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="UserStatisticsManager_ListBody">
						<c:forEach items="${results}" var="userstatistics" varStatus="status">                                                          
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" >
								<td class="C">
									<input type="checkbox" id="UserStatisticsManager[<c:out value="${status.index}"/>].checkRow"/>
								</td>
								<td class="C">
									<c:out value="${status.index}"/>
								</td>
								<td class="L" onclick="aUserStatisticsManager.doSelect(this)">
									<span id="UserStatisticsManager[<c:out value="${status.index}"/>].accessBrowser.label">&nbsp;<c:out value="${userstatistics.domainNm}"/></span>
								</td>
								<td class="L" onclick="aUserStatisticsManager.doSelect(this)">
									<span id="UserStatisticsManager[<c:out value="${status.index}"/>].userId.label">&nbsp;<c:out value="${userstatistics.userId}"/></span>
								</td>
								<td class="L" onclick="aUserStatisticsManager.doSelect(this)">
									<span id="UserStatisticsManager[<c:out value="${status.index}"/>].userName.label">&nbsp;<c:out value="${userstatistics.userName}"/></span>
								</td>
								<td class="L" onclick="aUserStatisticsManager.doSelect(this)">
									<span id="UserStatisticsManager[<c:out value="${status.index}"/>].orgName.label">&nbsp;<c:out value="${userstatistics.orgName}"/></span>
								</td>
								<td class="L" onclick="aUserStatisticsManager.doSelect(this)">
									<span id="UserStatisticsManager[<c:out value="${status.index}"/>].roleName.label">&nbsp;<c:out value="${userstatistics.roleName}"/></span>
								</td>
								<td class="L" onclick="aUserStatisticsManager.doSelect(this)">
									<span id="UserStatisticsManager[<c:out value="${status.index}"/>].userIp.label">&nbsp;<c:out value="${userstatistics.userIp}"/></span>
								</td>
								<td class="L" onclick="aUserStatisticsManager.doSelect(this)">
									<span id="UserStatisticsManager[<c:out value="${status.index}"/>].status.label">&nbsp;<c:out value="${userstatistics.statusStr}"/></span>
								</td>
								<td class="L" onclick="aUserStatisticsManager.doSelect(this)">
									<span id="UserStatisticsManager[<c:out value="${status.index}"/>].accessBrowser.label">&nbsp;<c:out value="${userstatistics.accessBrowser}"/></span>
								</td>
								<td class="L" onclick="aUserStatisticsManager.doSelect(this)">
									<span id="UserStatisticsManager[<c:out value="${status.index}"/>].timeStamp.label">&nbsp;<c:out value="${userstatistics.timeStamp}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			<div class="tsearchArea">
				<p id="UserStatisticsManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="UserStatisticsManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->	
		</div>
		<!-- board first// -->
		<!-- UserStatisticsManager_EditFormPanel -->
		<div id="UserStatisticsManager_EditFormPanel" class="board" >  
		</div>
		<!-- UserStatisticsManager_EditFormPanel// -->	
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="GroupManager_GroupChooser" title="Group Chooser"></div>	<!-- 그룹ID선택 창 -->
<div id="RoleManager_RoleChooser" title="Role Chooser"></div>	<!-- 역할ID선택 창 -->
<iframe id='exportExcelIF' frameborder=0 width=0 height=0></iframe>