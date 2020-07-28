
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/syncManager.js"></script>

<script type="text/javascript">
function initSyncManager() {
	if( aSyncManager == null ) {
		aSyncManager = new SyncManager("<c:out value="${evSecurityCode}"/>");
		aSyncManager.init();
		aSyncManager.doDefaultSelect();
	}
}
function finishSyncManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initSyncManager );
	window.attachEvent ( "onunload", finishSyncManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initSyncManager, false );
	window.addEventListener ( "unload", finishSyncManager, false );
}
else
{
    window.onload = initSyncManager;
	window.onunload = finishSyncManager;
}
</script>

<!-- board first -->
<div id="SyncManager_SyncTabPage" class="board first">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="SyncManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="SyncManager_SearchForm" name="SyncManager_SearchForm" style="display:inline" action="javascript:aSyncManager.doSearch('SyncManager_SearchForm')" onkeydown="if(event.keyCode==13) aSyncManager.doSearch('SyncManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aSyncManager.doPage'/>
				<input type='hidden' name='formName' value='SyncManager_SearchForm'/>
				<div class="sel_70">
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select>
				</div>
				<a href="javascript:aSyncManager.doSearch('SyncManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>    
			</form>				
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="SyncManager_ListForm" style="display:inline" name="SyncManager_ListForm" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	 		<caption>게시판</caption>
			<colgroup>
				<col width="30px" />
				<col width="30px" />
				<col width="100px" />
				<col width="*" />
				<col width="*" />
			</colgroup>				
			<thead>
				<tr>
					<th class="C">
						<input type="checkbox" id="delCheck" onclick="aSyncManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
				
					<th class="C" ch="0" onclick="aSyncManager.doSort(this, 'CONNECT');" >
						<span class="table_title"><util:message key='ev.title.sync.connect'/></span>
					</th>	
					<th class="C" ch="0" onclick="aSyncManager.doSort(this, 'ADDRESS');" >
						<span class="table_title"><util:message key='ev.title.sync.address'/></span>
					</th>	
					<th class="C" ch="0" onclick="aSyncManager.doSort(this, 'SESSION_COUNT');" >
						<span class="table_title"><util:message key='ev.title.sync.sessionCount'/></span>
					</th>	
				</tr>
			</thead>
			<tbody id="SyncManager_ListBody">
				<c:forEach items="${results}" var="sync" varStatus="status">
					<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
						<td class="C">
							<input type="checkbox" id="SyncManager[<c:out value="${status.index}"/>].checkRow"/>
						
							<input type="hidden" id="SyncManager[<c:out value="${status.index}"/>].address" value="<c:out value='${sync.systemKey}'/>"/>
						</td>
						<td class="C">
							<span class="table_title"><c:out value="${status.index}"/></span>
						</td>
						
						<td class="C" onclick="aSyncManager.doSelect(this)">
							<span class="table_title" id="SyncManager[<c:out value="${status.index}"/>].connect.label">&nbsp;<c:out value="${sync.result}"/></span>
						</td>
						<td class="C" onclick="aSyncManager.doSelect(this)">
							<span class="table_title" id="SyncManager[<c:out value="${status.index}"/>].address.label">&nbsp;<c:out value="${sync.systemKey}"/></span>
						</td>
						<td class="C" onclick="aSyncManager.doSelect(this)">
							<span class="table_title" id="SyncManager[<c:out value="${status.index}"/>].sessionCount.label">&nbsp;<c:out value="${sync.count}"/></span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
	<div class="tsearchArea">
		<p id="SyncManager_ListMessage"><c:out value='${resultMessage}'/></p>
	</div>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="SyncManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
</div>
<!-- board first// -->
<!-- SyncManager_EditFormPanel -->
<div id="SyncManager_EditFormPanel" class="board" >
	<!-- SyncManager_propertyTabs -->
	<div id="SyncManager_propertyTabs">
		<ul>
			<li><a href="#SyncManager_DetailTabPage"><span><util:message key='ev.title.sync.detailTab'/></span></a></li>   
		</ul>
		<!-- SyncManager_DetailTabPage -->
		<div id="SyncManager_DetailTabPage">
			<form id="SyncManager_EditForm" style="display:inline" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판리스트" class="table_board">									
				<input type="hidden" id="SyncManager_isCreate">
				<input type="hidden" id="SyncManager_connect" name="connect">
				<caption>게시판리스트</caption>
					<colgroup>
						<col width="140px" />
						<col width="*" />
						<col width="140px" />
						<col width="*" />
					</colgroup>									
				<tr class="first">
					<th class="L"><util:message key='ev.title.sync.address'/></th>
					<td class="L">
						<input type="text" id="SyncManager_address" name="address" value="" maxLength="" class="txt_200" disabled="true"/>
					</td>
					<th class="L"><util:message key='ev.title.sync.sessionCount'/></th>
					<td class="L">
						<input type="text" id="SyncManager_sessionCount" name="sessionCount" value="" maxLength="" class="txt_200" disabled="true"/>
					</td>
				</tr>
				<tr >
					<th class="L">
						<util:message key='ev.title.sync.syncTarget'/>
						<input type="checkbox" id="SyncManager_syncAll" onclick="aSyncManager.m_checkBox.chkAll(this)"/>
					</th>
					<td class="L" colspan="3">
						<label for="SyncManager_page" draggable="false"><input type="checkbox" id="SyncManager_page" class="first" />Page</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_portlet" /><label for="SyncManager_portlet" draggable="false">Portlet</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_notice" /><label for="SyncManager_notice" draggable="false">Notice</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_decorator" /><label for="SyncManager_decorator" draggable="false">Decorator</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_codebase" /><label for="SyncManager_codebase" draggable="false">Codebase</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_language" /><label for="SyncManager_language" draggable="false">Language</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_accesspolicy" /><label for="SyncManager_accesspolicy" draggable="false">AccessPolicy</label>&nbsp;&nbsp;
						<!-- ThemeMapping<input type="checkbox" id="SyncManager_thememapping" class="webcheckbox" >&nbsp;&nbsp;-->
						<input type="checkbox" id="SyncManager_enboard" /><label for="SyncManager_enboard" draggable="false">EnBoard</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_encola" /><label for="SyncManager_encola" draggable="false">EnCola</label><br />
						<input type="checkbox" id="SyncManager_configuration" /><label for="SyncManager_configuration" draggable="false">Configuration</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_scheduler" /><label for="SyncManager_scheduler" draggable="false">Scheduler</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_permission" /><label for="SyncManager_scheduler" draggable="false">Permission</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_domain" /><label for="SyncManager_domain" draggable="false">Domain</label>&nbsp;&nbsp;
						<input type="checkbox" id="SyncManager_portletService" /><label for="SyncManager_portletService" draggable="false">PortletService</label>&nbsp;&nbsp;
					</td>
				</tr>
				</table>
				<!-- btnArea-->
				<div class="btnArea">
					<div class="rightArea">
						<a href="javascript:aSyncManager.doInvalidateCache()" class="btn_B"><span><util:message key='ev.title.sync'/></span></a>
					</div>
				</div>
				<!-- btnArea//-->								
			</form>
		</div>
		<!-- SyncManager_DetailTabPage// -->
	</div>
	<!-- SyncManager_propertyTabs// -->
</div>
<!-- SyncManager_EditFormPanel// -->

<div id="SyncManager_SyncChooser"></div>