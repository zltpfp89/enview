<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/clientManager.js"></script>

<script type="text/javascript">
function initClientManager() {
	if( aClientManager == null ) {
		aClientManager = new ClientManager("<c:out value="${evSecurityCode}"/>");
		aClientManager.init();
		aClientManager.doDefaultSelect();
	}
}
function finishClientManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initClientManager );
	window.attachEvent ( "onunload", finishClientManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initClientManager, false );
	window.addEventListener ( "unload", finishClientManager, false );
}
else
{
    window.onload = initClientManager;
	window.onunload = finishClientManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div id="ClientManager_ClientTabPage" class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="ConfigurationManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="ClientManager_SearchForm" name="ClientManager_SearchForm" style="display:inline" action="javascript:aClientManager.doSearch('ClientManager_SearchForm')" onkeydown="if(event.keyCode==13) aClientManager.doSearch('ClientManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aClientManager.doPage'/>
						<input type='hidden' name='formName' value='ClientManager_SearchForm'/>
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<a href="javascript:aClientManager.doSearch('ClientManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
						</div>   
					</form>			
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="ClientManager_ListForm" style="display:inline" name="ClientManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="*" />
						<col width="100px" />
						<col width="100px" />
					</colgroup>
					<thead>
						<tr>
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aClientManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							
							<th class="C" ch="0" onclick="aClientManager.doSort(this, 'NAME');" >
								<span class="table_title"><util:message key='ev.prop.batchAction.name'/></span>
							</th>	
							<th class="C" ch="0" onclick="aClientManager.doSort(this, 'EVAL_ORDER');" >
								<span class="table_title"><util:message key='ev.prop.client.evalOrder'/></span>
							</th>	
							<th class="C" ch="0" onclick="aClientManager.doSort(this, 'USE_THEME');" >
								<span class="table_title"><util:message key='ev.prop.client.useTheme'/></span>
							</th>		
						</tr>				
					</thead>
					<tbody id="ClientManager_ListBody">
						<c:forEach items="${results}" var="client" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="{$status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<input type="checkbox" id="ClientManager[<c:out value="${status.index}"/>].checkRow"/>
								
									<input type="hidden" id="ClientManager[<c:out value="${status.index}"/>].clientId" value="<c:out value='${client.clientId}'/>"/>
								</td>
								<td class="C">
									<span><c:out value="${status.index}"/></span>
								</td>
								
								<td class="L" onclick="aClientManager.doSelect(this)">
									<span class="table_title" id="ClientManager[<c:out value="${status.index}"/>].name.label">&nbsp;<c:out value="${client.name}"/></span>
								</td>
								<td class="C" onclick="aClientManager.doSelect(this)">
									<span class="table_title" id="ClientManager[<c:out value="${status.index}"/>].evalOrder.label">&nbsp;<c:out value="${client.evalOrder}"/></span>
								</td>
								<td class="C" onclick="aClientManager.doSelect(this)">
									<span class="table_title" id="ClientManager[<c:out value="${status.index}"/>].useTheme.label">&nbsp;<c:out value="${client.useTheme}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>				
				</table>
			</form>
			<div class="tsearchArea">
				<p id="ClientManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="ClientManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->	
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aClientManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aClientManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->
		<!-- ClientManager_EditFormPanel -->
		<div id="ClientManager_EditFormPanel" class="board" >
			<div id="ClientManager_propertyTabs">
				<ul>
					<li><a href="#ClientManager_DetailTabPage"><util:message key='ev.title.detailTab'/></a></li>
				</ul>
				<div id="ClientManager_DetailTabPage">
					<%@include file="clientDetail.jsp"%>
				</div>
			</div>		
		</div>
		<!-- ClientManager_EditFormPanel// -->		
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->