
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/tree/dhtmlxcommon.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/tree/dhtmlXTree.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/tree/dhtmlXTreeMenu.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/accessStatisticsManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>

<script type="text/javascript">
function initAccessStatisticsManager() {
	if( aAccessStatisticsManager == null ) {
		aAccessStatisticsManager = new AccessStatisticsManager("<c:out value="${evSecurityCode}"/>");
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
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="AccessStatisticsManager_AccessStatisticsTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="AccessStatisticsManager_SearchForm" name="AccessStatisticsManager_SearchForm" style="display:inline" action="javascript:aAccessStatisticsManager.doSearch('AccessStatisticsManager_SearchForm')" onkeydown="if(event.keyCode==13) aAccessStatisticsManager.doSearch('AccessStatisticsManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aAccessStatisticsManager.doPage'/>
						<input type='hidden' name='formName' value='AccessStatisticsManager_SearchForm'/>
						<input type='hidden' id="AccessStatisticsManager_queryType" name='queryType' value='1'/>
					  <table width="99%">
					  <tr>
					  <td align="right">
							<select id="AccessStatisticsManager_domainCond" name="domainId" class='webdropdownlist'>
								<option value="-1">*<util:message key='ev.prop.domain.domain'/>*</option>
								<c:forEach items="${domainList}" var="domainInfo">
									<c:if test="${domainInfo.domainId != 0}">
										<option value="<c:out value="${domainInfo.domainId}"/>"><c:out value="${domainInfo.domainNm}"/></option>
									</c:if>
								</c:forEach>
							</select>
						
							<input type="text" id="AccessStatisticsManager_groupIdCond" name="groupIdCond" size="15" class="webtextfield" value="*<util:message key='pt.ev.property.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.groupId'/>*');" onclick="aAccessStatisticsManager.getGroupChooser().doShow(aAccessStatisticsManager.setGroupChooserCallback)"/> 
							<input type="text" name="userIdCond" size="8" class="webtextfield" value="*<util:message key='pt.ev.property.userId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.userId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.userId'/>*');"/> 
							<input type="text" name="userNameCond" size="12" class="webtextfield" value="*<util:message key='pt.ev.property.userName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.userName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.userName'/>*');"/> 

							<span id="AccessStatisticsManager.SELECT_DATE">
							<input type="text" id="AccessStatisticsManager_startTimeStampCond" name="startTimeStampCond" size="8" class="webtextfield" value="*<util:message key='pt.ev.property.startTime'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.startTime'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.startTime'/>*');"/>
							<input type="text" id="AccessStatisticsManager_endTimeStampCond" name="endTimeStampCond" size="8" class="webtextfield" value="*<util:message key='pt.ev.property.endTime'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.endTime'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.endTime'/>*');"/>
							</span>
							<span id="AccessStatisticsManager.SELECT_YEAR" style="display:none;">
								<select name='searchYear' id="AccessStatisticsManager_searchYear">
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
							</span>
							<span id="AccessStatisticsManager.SELECT_MONTH" style="display:none;">
								<select name='searchMonth' id="AccessStatisticsManager_searchMonth">
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
							</span>
							<span class="btn_pack small"><a href="javascript:aAccessStatisticsManager.doSearch('AccessStatisticsManager_SearchForm')"><util:message key='ev.title.search'/></a></span>
						</td>
					  </tr>
					  </table>    
					</form>
				</div>
				<div id="AccessStatisticsManager_EditFormPanel" class="webformpanel" >  
					<div class="webformpanel" style="width:100%;">
						<form id="AccessStatisticsManager_EditForm" style="display:inline" action="" method="post">
							<table cellpadding=0 cellspacing=0 border=0 width='100%'>
							<input type="hidden" id="AccessStatisticsManager_isCreate">
							<tr> 
								<td colspan="4" width="100%" class="webformheaderline"></td>    
							</tr>
							
							<tr >
								<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.currentUser'/></td>
								<td width="30%" class="webformfield">
									<input type="text" id="AccessStatisticsManager_currentUser" name="currentUser" value="<c:out value="${currentUserCount}"/>" maxLength="" class="full_webtextfield" />
								</td>
								<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.todayUser'/></td>
								<td class="webformfield">
									<input type="text" id="AccessStatisticsManager_todayUser" name="todayUser" value="<c:out value="${todayAccessCount}"/>" maxLength="" class="full_webtextfield" />
								</td>
							</tr>
							<tr >
								<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.averageUser'/></td>
								<td class="webformfield">
									<input type="text" id="AccessStatisticsManager_averageUser" name="averageUser" value="<c:out value="${averageAccessCount}"/>" maxLength="" class="full_webtextfield" />
								</td>
								<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.accumulateUser'/></td>
								<td class="webformfield">
									<input type="text" id="AccessStatisticsManager_accumulateUser" name="accumulateUser" value="<c:out value="${accumulateAccessCount}"/>" maxLength="" class="full_webtextfield" />
								</td>
							</tr>
							<tr >
								<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.registUser'/></td>
								<td class="webformfield">
									<input type="text" id="AccessStatisticsManager_registUser" name="registUser" value="<c:out value="${registUserCount}"/>" maxLength="" class="full_webtextfield" />
								</td>
								<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.secessionUser'/></td>
								<td class="webformfield">
									<input type="text" id="AccessStatisticsManager_secessionUser" name="secessionUser" value="<c:out value="${secessionUserCount}"/>" maxLength="" class="full_webtextfield" />
								</td>
							</tr>
						</table>
						</form>
					</div>
				</div>
				<br style='line-height:5px;'>
				<div id="AccessStatisticsManager_propertyTabs">
					<ul>
						<li><a href="#AccessStatisticsManager_TimeTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(0);"><util:message key='ev.title.statistics.accessByTimeTab'/></a></li>
						<li><a href="#AccessStatisticsManager_DayTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(1);"><util:message key='ev.title.statistics.accessByDayTab'/></a></li>
						<li><a href="#AccessStatisticsManager_MonthTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(2);"><util:message key='ev.title.statistics.accessByMonthTab'/></a></li>
						<li><a href="#AccessStatisticsManager_YearTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(3);"><util:message key='ev.title.statistics.accessByYearTab'/></a></li>
						<li><a href="#AccessStatisticsManager_WeekTabPage" onclick="aAccessStatisticsManager.onSelectPropertyTab(4);"><util:message key='ev.title.statistics.accessByWeekTab'/></a></li>
					</ul>
					<div id="AccessStatisticsManager_TimeTabPage" class="webgridpanel"> 
						<br style='line-height:5px;'>
						<form id="AccessStatisticsManager.TimeListForm" style="display:inline" name="AccessStatisticsManager.TimeListForm" action="" method="post">
						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<thead>
						  <tr> 
							<td colspan="2" class="webgridheaderline"></td>
						  </tr>
						  <tr style="cursor: pointer;">
							<th class="webgridheader" ch="0" align="left" width="100px"><util:message key='pt.ev.property.item'/>&nbsp;</th>
							<th class="webgridheaderlast" ch="0" align="center"><util:message key='pt.ev.property.count'/>&nbsp;</th>
						  </tr>
						</thead>
						<tbody id="AccessStatisticsManager.TimeListBody">

						</tbody>
						</table>
						</form>
					</div> <!-- StatisticsManager.ResultTabPage -->
					<div id="AccessStatisticsManager_DayTabPage" class="webgridpanel"> 
						<br style='line-height:5px;'>
						<form id="AccessStatisticsManager.DayListForm" style="display:inline" name="AccessStatisticsManager.DayListForm" action="" method="post">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<thead>
						  <tr> 
							<td colspan="2" class="webgridheaderline"></td>
						  </tr>
						  <tr style="cursor: pointer;">
							<th class="webgridheader" ch="0" align="left" width="100px"><util:message key='pt.ev.property.item'/>&nbsp;</th>
							<th class="webgridheaderlast" ch="0" align="center"><util:message key='pt.ev.property.count'/>&nbsp;</th>
						  </tr>
						</thead>
						<tbody id="AccessStatisticsManager.DayListBody">

						</tbody>
						</table>
						</form>
					</div>
					<div id="AccessStatisticsManager_MonthTabPage" class="webgridpanel"> 
						<br style='line-height:5px;'>
						<form id="AccessStatisticsManager.MonthListForm" style="display:inline" name="AccessStatisticsManager.MonthListForm" action="" method="post">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<thead>
						  <tr> 
							<td colspan="2" class="webgridheaderline"></td>
						  </tr>
						  <tr style="cursor: pointer;">
							<th class="webgridheader" ch="0" align="left" width="100px"><util:message key='pt.ev.property.item'/>&nbsp;</th>
							<th class="webgridheaderlast" ch="0" align="center"><util:message key='pt.ev.property.count'/>&nbsp;</th>
						  </tr>
						</thead>
						<tbody id="AccessStatisticsManager.MonthListBody">

						</tbody>
						</table>
						</form>
					</div>
					<div id="AccessStatisticsManager_YearTabPage" class="webgridpanel"> 
						<br style='line-height:5px;'>
						<form id="AccessStatisticsManager.YearListForm" style="display:inline" name="AccessStatisticsManager.YearListForm" action="" method="post">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<thead>
						  <tr> 
							<td colspan="2" class="webgridheaderline"></td>
						  </tr>
						  <tr style="cursor: pointer;">
							<th class="webgridheader" ch="0" align="left" width="100px"><util:message key='pt.ev.property.item'/>&nbsp;</th>
							<th class="webgridheaderlast" ch="0" align="center"><util:message key='pt.ev.property.count'/>&nbsp;</th>
						  </tr>
						</thead>
						<tbody id="AccessStatisticsManager.YearListBody">

						</tbody>
						</table>
						</form>
					</div>
					<div id="AccessStatisticsManager_WeekTabPage" class="webgridpanel"> 
						<br style='line-height:5px;'>
						<form id="AccessStatisticsManager.WeekListForm" style="display:inline" name="AccessStatisticsManager.WeekListForm" action="" method="post">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<thead>
						  <tr> 
							<td colspan="2" class="webgridheaderline"></td>
						  </tr>
						  <tr style="cursor: pointer;">
							<th class="webgridheader" ch="0" align="left" width="100px"><util:message key='pt.ev.property.item'/>&nbsp;</th>
							<th class="webgridheaderlast" ch="0" align="center"><util:message key='pt.ev.property.count'/>&nbsp;</th>
						  </tr>
						</thead>
						<tbody id="AccessStatisticsManager.WeekListBody">

						</tbody>
						</table>
						</form>
					</div>
				</div>
			</div> <!-- End AccessStatisticsManager_AccessStatisticsTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="GroupManager_GroupChooser"></div>

