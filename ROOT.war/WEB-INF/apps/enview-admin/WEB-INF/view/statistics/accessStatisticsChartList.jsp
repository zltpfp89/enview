<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/dhtmlx/dhtmlx.css">
<%-- <script language="JavaScript" src="<%=request.getContextPath()%>/javascript/tree/dhtmlxcommon.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/tree/dhtmlXTree.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/tree/dhtmlXTreeMenu.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/accessStatisticsChartManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dhtmlx/dhtmlx.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dhtmlx/thirdparty/excanvas/excanvas.js"></script>

<script type="text/javascript">
function initAccessStatisticsManager() {
	if( aAccessStatisticsManager == null ) {
		aAccessStatisticsManager = new AccessStatisticsChartManager("<c:out value="${evSecurityCode}"/>");
		aAccessStatisticsManager.init();
	}
}
function finishAccessStatisticsManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initAccessStatisticsManager );
	window.attachEvent ( "onunload", finishAccessStatisticsManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initAccessStatisticsManager, false );
	window.addEventListener ( "unload", finishAccessStatisticsManager, false );
}
else
{
    window.onload = initAccessStatisticsManager;
	window.onunload = finishAccessStatisticsManager;
}

var barChart = null;
var pieChart = null;

function chartDraw(data, size, columnDivId, pieDivId) {
	if (barChart != null) {
		barChart.destructor();
	} 
	if (pieChart != null) {
		pieChart.destructor();
	}
//	var widthsize = size-800;
//	alert( $("#AccessStatisticsManager_EditFormPanel").width());
	var widthsize = $("#AccessStatisticsManager_EditFormPanel").width() - 400 - 80;

	$("#" + columnDivId).width(widthsize);
	$("#" + columnDivId).height(300);
	$("#" + pieDivId).height(300);
	
	barChart = new dhtmlXChart({
		view : "bar",
		container : columnDivId,
		radius : 0,
		border :true,
		value : "#count#",
		tooltip : "#row# #count#",
		label : "#count#",
		xAxis : {
			template: function (obj) {
				return obj.row;
			}
		},
		yAxis:{
			start:0
		}
	});	
	
	pieChart = new dhtmlXChart({
		view : "pie",
		container : pieDivId,
		radius : 0,
		border :true,
		value : "#count#",
		tooltip : "#row# #count#",
		label : "#row#",
		pieInnerText:"#count#",
		marker:{
	        type:"round",
	        width:15
	    },
		shadow:0
	});
	
	//onMouseMove
	barChart.parse(data, "json");
	pieChart.parse(data, "json");
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
				<p style="background: none"></p>
				<fieldset>
					<form id="AccessStatisticsManager_SearchForm" name="AccessStatisticsManager_SearchForm" style="display:inline" action="javascript:aAccessStatisticsManager.doSearch('AccessStatisticsManager_SearchForm')" onkeydown="if(event.keyCode==13) aAccessStatisticsManager.doSearch('AccessStatisticsManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aAccessStatisticsManager.doPage'/>
						<input type='hidden' name='formName' value='AccessStatisticsManager_SearchForm'/>
						
						<input type='hidden' id="AccessStatisticsManager_queryType" name='queryType' value='1'/>
						<input type="hidden" id="AccessStatisticsManager_groupIdCond" name="groupIdCond" value=''/>
						<input type="hidden" id="AccessStatisticsManager_roleIdCond" name="roleIdCond" value=''/>
						<c:if test="${isSuperAdmin}">
							<div class="sel_100">
								<select id="AccessStatisticsManager_domainCond" name="domainId" class='txt_100' onchange="aAccessStatisticsManager.doChange();">
									<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }"><option value="0">*<util:message key='ev.prop.domain.domain'/>*</option></c:if>
									<c:forEach items="${domainList}" var="domainInfo">
										<c:if test="${domainInfo.domainId != 0}">
											<option value="<c:out value="${domainInfo.domainId}"/>"><c:out value="${domainInfo.domainNm}"/></option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</c:if>
						<c:if test="${!isSuperAdmin}"><input id="AccessStatisticsManager_domainCond" name="domainId" type="hidden" value="${domainId}"/></c:if>
							<input type="text" id="AccessStatisticsManager_groupIdCond2" name="groupIdCond2" size="15" class="txt_100" value="*<util:message key='ev.title.statistics.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.groupId'/>*');" onclick="aAccessStatisticsManager.getGroupChooser().doShow(aAccessStatisticsManager.setGroupChooserCallback)"/>
							<input type="text" id="AccessStatisticsManager_roleIdCond2" name="roleIdCond2" size="15" class="txt_100" value="*<util:message key='ev.prop.securityGroupRole.roleId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityGroupRole.roleId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityGroupRole.roleId'/>*');" onclick="aAccessStatisticsManager.getRoleChooser().doShow(aAccessStatisticsManager.setRoleChooserCallback)"/>
							<input type="text" name="userIdCond" size="8" class="txt_100" value="*<util:message key='ev.title.statistics.userId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.userId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.userId'/>*');"/> 
							<input type="text" name="userNameCond" size="12" class="txt_100" value="*<util:message key='ev.title.statistics.userName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.userName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.userName'/>*');"/> 
							<%-- &nbsp;
							<input type="text" name="domain" size="12" class="txt_100" value="*<util:message key='ev.prop.domain.domain'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.domain.domain'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.domain.domain'/>*');"/>  --%>
							
							<span id="AccessStatisticsManager.SELECT_DATE">
								<input type="text" id="AccessStatisticsManager_startTimeStampCond" name="startTimeStampCond" size="8" class="txt_100" value="*<util:message key='pt.ev.property.startTime'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.startTime'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.startTime'/>*');"/>
								<input type="text" id="AccessStatisticsManager_endTimeStampCond" name="endTimeStampCond" size="8" class="txt_100" value="*<util:message key='pt.ev.property.endTime'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.endTime'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.endTime'/>*');"/>
							</span>
							<span id="AccessStatisticsManager.SELECT_YEAR" style="display:none;">
								<div class="sel_100">
									<select name='searchYear' id="AccessStatisticsManager_searchYear" class="txt_100">
										<option value="2007">2007</option>
										<option value="2008">2008</option>
										<option value="2009">2009</option>
										<option value="2010">2010</option>
										<option value="2011">2011</option>
										<option value="2012">2012</option>
										<option value="2013">2013</option>
										<option value="2014">2014</option>
										<option value="2015">2015</option>
										<option value="2016">2016</option>
										<option value="2017">2017</option>
										<option value="2018">2018</option>
										<option value="2019">2019</option>
										<option value="2020">2020</option>
									</select>
								</div>
							</span>
							<span id="AccessStatisticsManager.SELECT_MONTH" style="display:none;">
								<div class="sel_100">
									<select name='searchMonth' id="AccessStatisticsManager_searchMonth" class="txt_100">
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>
								</div>	
							</span>
						<a href="javascript:aAccessStatisticsManager.doSearch('AccessStatisticsManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
						<a href="javascript:aAccessStatisticsManager.doExportExcel()" class="btn_B"><span><util:message key='ev.title.saveExcel'/></span></a>  
					</form>			
				</fieldset>
			</div>
			<!-- searchArea//-->	
		</div>
		<!-- board first// -->
		<!-- AccessStatisticsManager_EditFormPanel -->
		<div id="AccessStatisticsManager_EditFormPanel" class="board" >  
			<form id="AccessStatisticsManager_EditForm" style="display:inline" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="130px" />
						<col width="*" />
						<col width="130px" />
						<col width="*" />
					</colgroup>
					<input type="hidden" id="AccessStatisticsManager_isCreate">
					<tr>
						<th class="L"><util:message key='ev.title.statistics.domainNm'/></th>
						<td class="L">
							<input type="text" id="AccessStatisticsManager_domainNm" name="domainNm" value="<c:out value="${domainNm}"/>" maxLength="" class="txt_100" readonly="readonly"/>
						</td>
						<th class="L"><util:message key='ev.title.statistics.domain'/></th>
						<td class="L">
							<input type="text" id="AccessStatisticsManager_domain" name="domain" value="<c:out value="${domain}"/>" maxLength="" class="txt_100" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th class="L"><util:message key='ev.title.statistics.currentUser'/></th>
						<td class="L">
							<input type="text" id="AccessStatisticsManager_currentUser" name="currentUser" value="<c:out value="${currentUserCount}"/>" maxLength="" class="txt_100" readonly="readonly"/>
						</td>
						<th class="L"><util:message key='ev.title.statistics.todayUser'/></th>
						<td class="L">
							<input type="text" id="AccessStatisticsManager_todayUser" name="todayUser" value="<c:out value="${todayAccessCount}"/>" maxLength="" class="txt_100" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th class="L"><util:message key='ev.title.statistics.averageUser'/></th>
						<td class="L">
							<input type="text" id="AccessStatisticsManager_averageUser" name="averageUser" value="<c:out value="${averageAccessCount}"/>" maxLength="" class="txt_100" readonly="readonly"/>
						</td>
						<th class="L"><util:message key='ev.title.statistics.accumulateUser'/></th>
						<td class="L">
							<input type="text" id="AccessStatisticsManager_accumulateUser" name="accumulateUser" value="<c:out value="${accumulateAccessCount}"/>" maxLength="" class="txt_100" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th class="L"><util:message key='ev.title.statistics.registUser'/></th>
						<td class="L">
							<input type="text" id="AccessStatisticsManager_registUser" name="registUser" value="<c:out value="${registUserCount}"/>" maxLength="" class="txt_100" readonly="readonly"/>
						</td>
						<th class="L"><util:message key='ev.title.statistics.secessionUser'/></th>
						<td class="L">
							<input type="text" id="AccessStatisticsManager_secessionUser" name="secessionUser" value="<c:out value="${secessionUserCount}"/>" maxLength="" class="txt_100" readonly="readonly"/>
						</td>
					</tr>
				</table>
			</form>
			<!-- AccessStatisticsManager_propertyTabs -->
			<div id="AccessStatisticsManager_propertyTabs">
				<ul>
					<li><a href="#AccessStatisticsManager_TimeTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(0);"><util:message key='ev.title.statistics.accessByTimeTab'/></a></li>
					<li><a href="#AccessStatisticsManager_DayTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(1);"><util:message key='ev.title.statistics.accessByDayTab'/></a></li>
					<li><a href="#AccessStatisticsManager_MonthTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(2);"><util:message key='ev.title.statistics.accessByMonthTab'/></a></li>
					<li><a href="#AccessStatisticsManager_YearTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(3);"><util:message key='ev.title.statistics.accessByYearTab'/></a></li>
					<li><a href="#AccessStatisticsManager_WeekTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(4);"><util:message key='ev.title.statistics.accessByWeekTab'/></a></li>
				</ul>
				<!-- AccessStatisticsManager_TimeTabPage -->
				<div id="AccessStatisticsManager_TimeTabPage" style="height:300px;">
					<form id="AccessStatisticsManager.TimeListForm" style="display:inline" name="AccessStatisticsManager.TimeListForm" action="" method="post">
						<%--
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						    <tr>
							    <td><div id="TimeListBody_column" style="width:800px;height:250px;margin:20px;border:1px solid #A4BED4"></div></td>
							    <td><div id="TimeListBody_pie" style="width:400px;height:250px;margin:20px;border:1px solid #A4BED4"></div></td>
						    </tr>
						</table>
						 --%>
							    <div id="TimeListBody_column" style="width:800px;height:250px;margin:1px;border:1px solid #A4BED4;float: left"></div>
							    <div id="TimeListBody_pie" style="width:400px;height:250px;margin:1px;border:1px solid #A4BED4;float: right"></div>
					</form>
				</div>
				<!-- AccessStatisticsManager_TimeTabPage// -->
				<!-- AccessStatisticsManager_DayTabPage -->
				<div id="AccessStatisticsManager_DayTabPage" style="height:300px;"> 
					<form id="AccessStatisticsManager.DayListForm" style="display:inline" name="AccessStatisticsManager.DayListForm" action="" method="post">
							    <div id="DayListBody_column" style="width:800px;height:250px;margin:1px;border:1px solid #A4BED4;float: left"></div>
							    <div id="DayListBody_pie" style="width:400px;height:250px;margin:1px;border:1px solid #A4BED4;float: right"></div>
					</form>
				</div>
				<!-- AccessStatisticsManager_DayTabPage// -->
				<!-- AccessStatisticsManager_MonthTabPage -->
				<div id="AccessStatisticsManager_MonthTabPage" style="height:300px;">
					<form id="AccessStatisticsManager.MonthListForm" style="display:inline" name="AccessStatisticsManager.MonthListForm" action="" method="post">
				    <div id="MonthListBody_column" style="width:800px;height:250px;margin:1px;border:1px solid #A4BED4;float: left"></div>
				    <div id="MonthListBody_pie" style="width:400px;height:250px;margin:1px;border:1px solid #A4BED4;float: right"></div>
					</form>
				</div>
				<!-- AccessStatisticsManager_MonthTabPage// -->
				<!-- AccessStatisticsManager_YearTabPage -->
				<div id="AccessStatisticsManager_YearTabPage" style="height:300px;">
					<form id="AccessStatisticsManager.YearListForm" style="display:inline" name="AccessStatisticsManager.YearListForm" action="" method="post">
				    <div id="YearListBody_column" style="width:800px;height:250px;margin:1px;border:1px solid #A4BED4;float: left"></div>
				    <div id="YearListBody_pie" style="width:400px;height:250px;margin:1px;border:1px solid #A4BED4;float: right"></div>
					</form>
				</div>
				<!-- AccessStatisticsManager_YearTabPage// -->
				<!-- AccessStatisticsManager_WeekTabPage -->
				<div id="AccessStatisticsManager_WeekTabPage" style="height:300px;">
					<form id="AccessStatisticsManager.WeekListForm" style="display:inline" name="AccessStatisticsManager.WeekListForm" action="" method="post">
				    <div id="WeekListBody_column" style="width:800px;height:250px;margin:1px;border:1px solid #A4BED4;float: left"></div>
				    <div id="WeekListBody_pie" style="width:300px;height:250px;margin:1px;border:1px solid #A4BED4;float: right"></div>
					</form>
				</div>
				<!-- AccessStatisticsManager_WeekTabPage/ -->
			</div>
			<!-- AccessStatisticsManager_propertyTabs// -->	
		</div>
		<!-- AccessStatisticsManager_EditFormPanel// -->	
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="GroupManager_GroupChooser" title="Group Chooser"></div>	<!-- 그룹ID선택 창 -->
<div id="RoleManager_RoleChooser" title="Role Chooser"></div>	<!-- 역할ID선택 창 -->
<iframe id='exportExcelIF' frameborder=0 width=0 height=0></iframe>