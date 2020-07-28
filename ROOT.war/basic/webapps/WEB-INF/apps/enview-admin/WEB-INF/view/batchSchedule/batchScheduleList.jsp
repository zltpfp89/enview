
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchScheduleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchActionManager.js"></script>

<script type="text/javascript">
function initBatchScheduleManager() {
	if( aBatchScheduleManager == null ) {
		aBatchScheduleManager = new BatchScheduleManager("<c:out value="${evSecurityCode}"/>");
		aBatchScheduleManager.init();
		aBatchScheduleManager.doDefaultSelect();
	}
}
function finishBatchScheduleManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initBatchScheduleManager );
	window.attachEvent ( "onunload", finishBatchScheduleManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initBatchScheduleManager, false );
	window.addEventListener ( "unload", finishBatchScheduleManager, false );
}
else
{
    window.onload = initBatchScheduleManager;
	window.onunload = finishBatchScheduleManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div id="BatchScheduleManager_BatchScheduleTabPage" class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="BatchScheduleManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="BatchScheduleManager_SearchForm" name="BatchScheduleManager_SearchForm" style="display:inline" action="javascript:aBatchScheduleManager.doSearch('BatchScheduleManager_SearchForm')" onkeydown="if(event.keyCode==13) aBatchScheduleManager.doSearch('BatchScheduleManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aBatchScheduleManager.doPage'/>
						<input type='hidden' name='formName' value='BatchScheduleManager_SearchForm'/>
	
						<input type="text" name="name0Cond" size="30" class="webtextfield" value="*<util:message key='ev.prop.batchAction.name'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchAction.name'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchAction.name'/>*');"/> 
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aBatchScheduleManager.doSearch('BatchScheduleManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
					</form>			
				</fieldset>
			</div>
			<!-- searchArea// -->
			<!-- BatchScheduleManager_ListForm -->
			<form id="BatchScheduleManager_ListForm" style="display:inline" name="BatchScheduleManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			 		<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="100px" />
						<col width="*" />
						<col width="100px" />
					</colgroup>				
					<thead>
						<tr>
							<th class="C">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aBatchScheduleManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							<th class="C" ch="0" onclick="aBatchScheduleManager.doSort(this, 'a.SCHEDULE_ID');" >
								<span class="table_title"><util:message key='ev.prop.batchSchedule.scheduleId'/></span>
							</th>	
							<th class="C" ch="0" onclick="aBatchScheduleManager.doSort(this, 'NAME');" >
								<span class="table_title"><util:message key='ev.prop.batchAction.actionName'/></span>
							</th>	
							<th class="C" ch="0" onclick="aBatchScheduleManager.doSort(this, 'a.UPD_USER_ID');" >
								<span class="table_title"><util:message key='ev.prop.batchSchedule.updUserId'/></span>
							</th>	
							<th class="C" ch="0" onclick="aBatchScheduleManager.doSort(this, 'a.UPD_DATIM');" >
								<span class="table_title"><util:message key='ev.prop.batchSchedule.updDatim'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="BatchScheduleManager_ListBody">
						<c:forEach items="${results}" var="batchschedule" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td class="C">
								<input type="checkbox" id="BatchScheduleManager[<c:out value="${status.index}"/>].checkRow" />
	
								<input type="hidden" id="BatchScheduleManager[<c:out value="${status.index}"/>].scheduleId" value="<c:out value='${batchschedule.scheduleId}'/>"/>
							</td>
							<td class="C">
								<span class="C"><c:out value="${status.index}"/></span>
							</td>
							<td class="L" onclick="aBatchScheduleManager.doSelect(this)">
							<span class="table_title" id="BatchScheduleManager[<c:out value="${status.index}"/>].scheduleId.label">&nbsp;<c:out value="${batchschedule.scheduleId}"/></span>
							</td>
							<td class="L" onclick="aBatchScheduleManager.doSelect(this)">
							<span class="table_title" id="BatchScheduleManager[<c:out value="${status.index}"/>].actionName0.label">&nbsp;<c:out value="${batchschedule.actionName0}"/></span>
							</td>
							<td class="L" onclick="aBatchScheduleManager.doSelect(this)">
							<span class="table_title" id="BatchScheduleManager[<c:out value="${status.index}"/>].updUserId.label">&nbsp;<c:out value="${batchschedule.updUserId}"/></span>
							</td>
							<td class="L" onclick="aBatchScheduleManager.doSelect(this)">
							<span class="table_title" id="BatchScheduleManager[<c:out value="${status.index}"/>].updDatim.label">&nbsp;<c:out value="${batchschedule.updDatimByFormat}"/></span>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			<!-- BatchScheduleManager_ListForm// -->
			<div class="tsearchArea">
				<p id="BatchScheduleManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="BatchScheduleManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->	
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aBatchScheduleManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aBatchScheduleManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->
		<!-- BatchScheduleManager_EditFormPanel -->
		<div id="BatchScheduleManager_EditFormPanel" class="board" >  
			<div id="BatchScheduleManager_propertyTabs">
				<ul>
					<li><a href="#BatchScheduleManager_DetailTabPage"><util:message key='ev.title.batchSchedule.detailTab'/></a></li>   
				</ul>
				<div id="BatchScheduleManager_DetailTabPage">
					<%@include file="batchScheduleDetail.jsp"%>
				</div>
			</div>
		</div>
		<!-- BatchScheduleManager_EditFormPanel// -->	
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="BatchActionManager_BatchActionChooser"></div>