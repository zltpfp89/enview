<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/dhtmlx/dhtmlx.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/dhtmlx/dhtmlx.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dhtmlx/thirdparty/excanvas/excanvas.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageStatisticsManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>


<script type="text/javascript">
function initPageStatisticsManager() {
	if( aPageStatisticsManager == null ) {
		aPageStatisticsManager = new PageStatisticsManager("<c:out value="${evSecurityCode}"/>");
		aPageStatisticsManager.init();
	}
}
function finishPageStatisticsManager() {
	
}

function resizeChart() {
	aPageStatisticsManager.doRetrieve();
}

// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initPageStatisticsManager );
	window.attachEvent ( "onunload", finishPageStatisticsManager );
	window.attachEvent ( "onresize", resizeChart );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initPageStatisticsManager, false );
	window.addEventListener ( "unload", finishPageStatisticsManager, false );
	window.addEventListener ( "onresize", resizeChart );
}
else
{
    window.onload = initPageStatisticsManager;
	window.onunload = finishPageStatisticsManager;
	window.onresize = resizeChart;
}

var barChart = null;
var pieChart = null;

function chartDraw(data, size, columnDivId, pieDivId) {
	size = document.body.clientWidth;
	var widthsize = size-750;
	$("#" + columnDivId).width(widthsize);
	$("#" + columnDivId).height(300);
	$("#" + pieDivId).height(300);
	
	if (barChart != null) {
		barChart.destructor();
	} 
	if (pieChart != null) {
		pieChart.destructor();
	}
	
	barChart = new dhtmlXChart({
		view : "bar",
		container : columnDivId,
		radius : 0,
		border :true,
		value : "#hits#",
		tooltip : "#title# #hits#",
		label : "#hits#",
		xAxis : {
			template: function (obj) {
				return obj.title;
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
		value : "#hits#",
		tooltip : "#title# #hits#",
		label : "#title#",
		pieInnerText:"#hits#",
		marker:{
	        type:"round",
	        width:15
	    },
		shadow:0
	});
	
	barChart.parse(data, "json");
	pieChart.parse(data, "json");
}


window.onresize = resizeChart;

</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea" style="margin-bottom:30px;">
				<p style="background: none"></p>
				<fieldset>
					<form id="PageStatisticsManager_SearchForm" name="PageStatisticsManager_SearchForm" style="display:inline" action="javascript:aPageStatisticsManager.doSearch('PageStatisticsManager_SearchForm')" onkeydown="if(event.keyCode==13) aPageStatisticsManager.doSearch('PageStatisticsManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPageStatisticsManager.doPage'/>
						<input type='hidden' name='formName' value='PageStatisticsManager_SearchForm'/>
						
						<input type="hidden" id="PageStatisticsManager_groupIdCond" name="groupIdCond" value=''/>
						<input type="hidden" id="PageStatisticsManager_roleIdCond" name="roleIdCond" value=''/>				
					
						<c:if test="${isSuperAdmin}">
							<div class="sel_70">
								<select id="PageStatisticsManager_domainCond" name="domainId" class='txt_70'>
									<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }"><option value="0">*<util:message key='ev.prop.domain.domain'/>*</option></c:if>
									<c:forEach items="${domainList}" var="domainInfo">
										<c:if test="${domainInfo.domainId != 0}">
											<option value="<c:out value="${domainInfo.domainId}"/>"><c:out value="${domainInfo.domainNm}"/></option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</c:if>
						<c:if test="${!isSuperAdmin}"><input id="PageStatisticsManager_domainCond" name="domainId" type="hidden" value="${domainInfo.domainId }"/></c:if>
						<input type="text" id="PageStatisticsManager_groupIdCond2" name="groupIdCond2" size="12" class="txt_100" value="*<util:message key='ev.title.statistics.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.groupId'/>*');" onclick="aPageStatisticsManager.getGroupChooser().doShow(aPageStatisticsManager.setGroupChooserCallback)"/> 
						<input type="text" id="PageStatisticsManager_roleIdCond2" name="roleIdCond2" size="12" class="txt_100" value="*<util:message key='ev.prop.securityGroupRole.roleId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityGroupRole.roleId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityGroupRole.roleId'/>*');" onclick="aPageStatisticsManager.getRoleChooser().doShow(aPageStatisticsManager.setRoleChooserCallback)"/>
																
						<input type="text" name="userIdCond" size="8" class="txt_100" value="*<util:message key='ev.prop.pageStatistics.userId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.pageStatistics.userId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.pageStatistics.userId'/>*');"/> 
									
						<input type="text" name="userNameCond" size="12" class="txt_100" value="*<util:message key='ev.prop.pageStatistics.userName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.pageStatistics.userName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.pageStatistics.userName'/>*');"/> 
									
						<input type="text" name="titleCond" size="13" class="txt_100" value="*<util:message key='ev.prop.pageStatistics.title'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.title'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.pageStatistics.title'/>*');"/> 
									
						<input type="text" name="pathCond" size="13" class="txt_100" value="*<util:message key='ev.prop.pageStatistics.path'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.pageStatistics.path'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.pageStatistics.path'/>*');"/> 
									
						<input type="text" id="PageStatisticsManager_startTimeStampCond" name="startTimeStampCond" size="8" class="txt_70" value="*<util:message key='ev.title.statistics.startTime'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.startTime'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.startTime'/>*');"/>
						<input type="text" id="PageStatisticsManager_endTimeStampCond" name="endTimeStampCond" size="8" class="txt_70" value="*<util:message key='ev.title.statistics.endTime'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.endTime'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.endTime'/>*');"/>
						
						
						<input type="hidden" name ="pageSize2"  value="5">
						
						<div class="sel_50">
						    <select name='pageSize' class="txt_50">
								<option value="5">5</option>
								<option value="10" >10</option>
								<option value="50" >50</option>
								<option value="100">100</option>
							</select> 
						</div>	
					   
						<a href="javascript:aPageStatisticsManager.doSearch('PageStatisticsManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
						<a href="javascript:aPageStatisticsManager.doExportExcel()" class="btn_B"><span><util:message key='ev.title.saveExcel'/></span></a>	
					</form>
				</fieldset>
			</div>
			<!-- searchArea// -->
			<form id="PageStatisticsManager_EditForm" style="display:inline" action="" method="post">
				<input type="hidden" id="PageStatisticsManager_isCreate">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tr>
						<th class="L"><util:message key='ev.title.statistics.totalSession'/></th>
						<td class="L">
							<input type="text" id="PageStatisticsManager_totalSession" name="totalSession" value="<c:out value="${accumulationMap.totalSession}"/>" maxLength="" class="txt_100" />
						</td>
						<th class="L"><util:message key='ev.title.statistics.totalHits'/></th>
						<td class="L">
							<input type="text" id="PageStatisticsManager_totalHits" name="totalHits" value="<c:out value="${accumulationMap.TOTALHITS}"/>" maxLength="" class="txt_100" />
						</td>
					</tr>
					
					<tr>
						<th class="L"><util:message key='ev.title.statistics.totalMaxTime'/></th>
						<td class="L">
							<input type="text" id="PageStatisticsManager_totalMaxTime" name="totalMaxTime" value="<c:out value="${accumulationMap.TOTALMAXTIME}"/>" maxLength="" class="txt_100" />
						</td>
						<th class="L"><util:message key='ev.title.statistics.totalMinTime'/></th>
						<td class="L">
							<input type="text" id="PageStatisticsManager_totalMinTime" name="totalMinTime" value="<c:out value="${accumulationMap.TOTALMINTIME}"/>" maxLength="" class="txt_100" />
						</td>
					</tr>
					
					<tr>
						<th class="L"><util:message key='ev.title.statistics.totalAverageTime'/></th>
						<td class="webformfield" colspan="3">
							<input type="text" id="PageStatisticsManager_totalAverageTime" name="totalAverageTime" value="<c:out value="${accumulationMap.TOTALAVERAGETIME}"/>" maxLength="" class="txt_100" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- board first// -->
		<!-- PageStatisticsManager_EditFormPanel -->
		<div id="PageStatisticsManager_EditFormPanel" class="board" >
			<div id="PageStatisticsManager_propertyTabs">
				<ul>
					<li><a href="#PageStatisticsManager_listPage"><util:message key='ev.title.statistics.ListShow'/></a></li>
					<li><a href="#PageStatisticsManager_chartPage" onclick="aPageStatisticsManager.onSelectPropertyTab();"><util:message key='ev.title.statistics.ChartShow'/></a></li> 
				</ul>
				<div id="PageStatisticsManager_listPage" class="webgridpanel">
					<form id="PageStatisticsManager_ListForm" style="display:inline" name="PageStatisticsManager_ListForm" action="" method="post">
				  		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					 		<caption>게시판</caption>
							<colgroup>
								<col width="5%" />
								<col width="10%" />
								<col width="20%" />
								<col width="25%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
							</colgroup>	  		 
							<thead>
								<tr>
									<th class="C first"><span class="table_title">No</span></th>
									<th class="C" ch="0" onclick="aPageStatisticsManager.doSort(this, 'DOMAIN_ID');" >
										<span class="table_title"><util:message key='ev.prop.pageStatistics.domain'/></span>
									</th>	
									<th class="C" ch="0" onclick="aPageStatisticsManager.doSort(this, 'TITLE');" >
										<span class="table_title"><util:message key='ev.prop.pageStatistics.title'/></span>
									</th>	
									<th class="C" ch="0" onclick="aPageStatisticsManager.doSort(this, 'PATH');" >
										<span class="table_title"><util:message key='ev.prop.pageStatistics.path'/></span>
									</th>	
									<th class="C" ch="0" onclick="aPageStatisticsManager.doSort(this, 'HITS');" >
										<span class="table_title"><util:message key='ev.title.statistics.hits'/></span>
									</th>	
									<th class="C" ch="0" onclick="aPageStatisticsManager.doSort(this, 'MAX_TIME');" >
										<span class="table_title"><util:message key='ev.title.statistics.maxTime'/></span>
									</th>	
									<th class="C" ch="0" onclick="aPageStatisticsManager.doSort(this, 'MIN_TIME');" >
										<span class="table_title"><util:message key='ev.title.statistics.minTime'/></span>
									</th>	
									<th class="C" ch="0" onclick="aPageStatisticsManager.doSort(this, 'AVERAGE_TIME');" >
										<span class="table_title"><util:message key='ev.title.statistics.averageTime'/></span>
									</th>		
								</tr>
							</thead>
							<tbody id="PageStatisticsManager_ListBody">
								<c:forEach items="${results}" var="pagestatistics" varStatus="status">
									<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
										<td class="C">
											<input type="checkbox" id="PageStatisticsManager[<c:out value="${status.index}"/>].checkRow"/>
										</td>
										<!-- 결과물의 정렬 -->
										
										<td class="C">
											<c:out value="${status.index}"/>
										</td>
										
										<td class="L" onclick="aPageStatisticsManager.doSelect(this)">
											<span d="PageStatisticsManager[<c:out value="${status.index}"/>].domain.label">&nbsp;<c:out value="${pagestatistics.domainNm}"/></span>
										</td>
										<td class="L" onclick="aPageStatisticsManager.doSelect(this)">
											<span id="PageStatisticsManager[<c:out value="${status.index}"/>].title.label">&nbsp;<c:out value="${pagestatistics.title}"/></span>
										</td>
										<td class="L" onclick="aPageStatisticsManager.doSelect(this)">
											<span id="PageStatisticsManager[<c:out value="${status.index}"/>].path.label">&nbsp;<c:out value="${pagestatistics.path}"/></span>
										</td>
										<td class="L" onclick="aPageStatisticsManager.doSelect(this)">
											<span id="PageStatisticsManager[<c:out value="${status.index}"/>].hits.label">&nbsp;<c:out value="${pagestatistics.hits}"/></span>
										</td>
										<td class="R" onclick="aPageStatisticsManager.doSelect(this)">
											<span id="PageStatisticsManager[<c:out value="${status.index}"/>].maxTime.label">&nbsp;<c:out value="${pagestatistics.maxTime}"/></span>
										</td>
										<td class="R" onclick="aPageStatisticsManager.doSelect(this)">
											<span id="PageStatisticsManager[<c:out value="${status.index}"/>].minTime.label">&nbsp;<c:out value="${pagestatistics.minTime}"/></span>
										</td>
										<td class="R" onclick="aPageStatisticsManager.doSelect(this)">
											<span id="PageStatisticsManager[<c:out value="${status.index}"/>].averageTime.label">&nbsp;<c:out value="${pagestatistics.averageTime}"/></span>
										</td>
									</tr>
								</c:forEach>      
							</tbody>
				  		</table>
		          <%--     <div> <!-- <1> <2> list...... -->
						<table style="width:100%;" class="webbuttonpanel">
						<tr>
						    <td align="center">
						    <div id="PageStatisticsManager_PAGE_ITERATOR" class="webnavigationpanel">
								<c:out escapeXml='false' value='${pageIterator}'/>
						    </div>
						    </td>    
						</tr>
						</table>
					
				 </div> <!-- End webformpanel --> --%>
						<!-- tcontrol-->
						<div class="tcontrol">
							<!-- paging -->
							<div id="PageStatisticsManager_PAGE_ITERATOR" class="paging">
								<c:out escapeXml='false' value='${pageIterator}'/>
							</div>
							<!-- paging//-->
						</div>
						<!-- tcontrol//-->				  		
					</form>
				  
				<%-- <div id="PageStatisticsManager_ListMessage">
						<c:out value='${resultMessage}'/>
					</div> --%>
				</div>
				<!--차트 들어갈 자리 -->
				<div id="PageStatisticsManager_chartPage" style="width:100%; height: 300px;" class="webgridpanel"> 
					<br style='line-height:5px;'>
					<form id="PageStatisticsManager_chartPageForm" style="display:inline;" name="PageStatisticsManager_chartPageForm" action="" method="post">
				    <div id="PageListBody_column" style="width:800px;height:250px;margin:1px;border:1px solid #A4BED4;float: left"></div>
				    <div id="PageListBody_pie" style="width:400px;height:250px;margin:1px;border:1px solid #A4BED4;float: right: ;"></div>
					</form>
				</div>
		        <!--차트 페이지끝-->								
			</div>	
		</div>	
		<!-- PageStatisticsManager_EditFormPanel// -->	
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="GroupManager_GroupChooser" title="Group Chooser"></div>	<!-- 그룹ID선택 창 -->
<div id="RoleManager_RoleChooser" title="Role Chooser"></div>	<!-- 역할ID선택 창 -->
<iframe id='exportExcelIF' frameborder=0 width=0 height=0></iframe>