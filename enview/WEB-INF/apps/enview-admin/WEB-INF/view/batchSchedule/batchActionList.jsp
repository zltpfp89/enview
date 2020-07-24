<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchActionManager.js"></script>

<script type="text/javascript">
function initBatchActionManager() {
	if( aBatchActionManager == null ) {
		aBatchActionManager = new BatchActionManager("<c:out value="${evSecurityCode}"/>");
		aBatchActionManager.init();
		aBatchActionManager.doDefaultSelect();
	}
}
function finishBatchActionManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initBatchActionManager );
	window.attachEvent ( "onunload", finishBatchActionManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initBatchActionManager, false );
	window.addEventListener ( "unload", finishBatchActionManager, false );
}
else
{
    window.onload = initBatchActionManager;
	window.onunload = finishBatchActionManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div id="BatchActionManager_BatchActionTabPage" class="board first">
			<!-- tab_list -->
			<div class="tab_list">
				<!-- searchArea-->
				<div class="tsearchArea">
					<p id="BatchActionManager_ListMessage"><c:out value='${resultMessage}'/></p>
					<fieldset>
						<form id="BatchActionManager_SearchForm" name="BatchActionManager_SearchForm" style="display:inline" action="javascript:aBatchActionManager.doSearch('BatchActionManager_SearchForm')" onkeydown="if(event.keyCode==13) aBatchActionManager.doSearch('BatchActionManager_SearchForm')" method="post">
							<input type='hidden' name='sortMethod' value='ASC'/>                    
							<input type='hidden' name='sortColumn' value=''/>  
							<input type='hidden' name='pageNo' value='1'/>
							<!--input type='hidden' name='pageSize' value='10'/-->
							<input type='hidden' name='pageFunction' value='aBatchActionManager.doPage'/>
							<input type='hidden' name='formName' value='BatchActionManager_SearchForm'/>
							
							<input type="text" name="nameCond" size="30" class="webtextfield" value="*<util:message key='ev.prop.batchAction.name'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchAction.name'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchAction.name'/>*');"/> 
							
							<div class="sel_70">
								<select name='pageSize' class="txt_70">
									<option value="5">5</option>
									<option value="10" selected>10</option>
									<option value="20" >20</option>
									<option value="50">50</option>
									<option value="100">100</option>
								</select>
							</div>
							<a href="javascript:aBatchActionManager.doSearch('BatchActionManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>									
						</form>			
					</fieldset>
				</div>
				<!-- searchArea// -->
				<!-- BatchActionManager_ListForm -->
				<form id="BatchActionManager_ListForm" style="display:inline" name="BatchActionManager_ListForm" action="" method="post">
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
								<th class="first">
									<input type="checkbox" id="delCheck" onclick="aBatchActionManager.m_checkBox.chkAll(this)"/>
								</th>
								<th class="C"><span class="table_title">No</span></th>
							
								<th class="C" ch="0" onclick="aBatchActionManager.doSort(this, 'ACTION_ID');" >
									<span class="table_title"><util:message key='ev.prop.batchSchedule.actionId'/></span>
								</th>	
								<th class="C" ch="0" onclick="aBatchActionManager.doSort(this, 'NAME');" >
									<span class="table_title"><util:message key='ev.prop.batchAction.name'/></span>
								</th>	
								<th class="C" ch="0" onclick="aBatchActionManager.doSort(this, 'UPD_USER_ID');" >
									<span class="table_title"><util:message key='ev.prop.batchAction.updUserId'/></span>
								</th>	
								<th class="C" ch="0" onclick="aBatchActionManager.doSort(this, 'UPD_DATIM');" >
									<span class="table_title"><util:message key='ev.prop.batchAction.updDatim'/></span>
								</th>		
							</tr>
						</thead>
						<tbody id="BatchActionManager_ListBody">
							<c:forEach items="${results}" var="batchaction" varStatus="status">
								<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;">
									<td class="C">
										<input type="checkbox" id="BatchActionManager[<c:out value="${status.index}"/>].checkRow" />
									
										<input type="hidden" id="BatchActionManager[<c:out value="${status.index}"/>].actionId" value="<c:out value='${batchaction.actionId}'/>"/>
									</td>
									<td class="C">
										<span class="table_title"><c:out value="${status.index}"/></span>
									</td>
									
									<td class="L" onclick="aBatchActionManager.doSelect(this)">
										<span class="table_title" id="BatchActionManager[<c:out value="${status.index}"/>].actionId.label">&nbsp;<c:out value="${batchaction.actionId}"/></span>
									</td>
									<td class="L" onclick="aBatchActionManager.doSelect(this)">
										<span class="table_title" id="BatchActionManager[<c:out value="${status.index}"/>].name.label">&nbsp;<c:out value="${batchaction.name}"/></span>
									</td>
									<td class="L" onclick="aBatchActionManager.doSelect(this)">
										<span class="table_title" id="BatchActionManager[<c:out value="${status.index}"/>].updUserId.label">&nbsp;<c:out value="${batchaction.updUserId}"/></span>
									</td>
									<td class="L" onclick="aBatchActionManager.doSelect(this)">
										<span class="table_title" id="BatchActionManager[<c:out value="${status.index}"/>].updDatim.label">&nbsp;<c:out value="${batchaction.updDatimByFormat}"/></span>
									</td>
								</tr>
							</c:forEach>
						</tbody>				
					</table>		
				</form>
				<!-- BatchActionManager_ListForm// -->
				<div class="tsearchArea">
					<p id="BatchActionManager_ListMessage"><c:out value='${resultMessage}'/></p>
				</div>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div id="BatchActionManager_PAGE_ITERATOR" class="paging">
						<c:out escapeXml='false' value='${pageIterator}'/>
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
				<!-- btnArea-->
				<div class="btnArea">
					<div class="rightArea">
						<a href="javascript:aBatchActionManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
						<a href="javascript:aBatchActionManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
					</div>
				</div>
				<!-- btnArea//-->			
			</div>
			<!-- tab_list// -->
		</div>
		<!-- board first// -->
		<!-- BatchActionManager_EditFormPanel -->
		<div id="BatchActionManager_EditFormPanel" class="board" >  
			<div id="BatchActionManager_propertyTabs">
				<ul>
					<li><a href="#BatchActionManager_DetailTabPage"><util:message key='ev.title.batchSchedule.detailTab'/></a></li>   
				</ul>
				<div id="BatchActionManager_DetailTabPage">
					<%@include file="batchActionDetail.jsp"%>
				</div>
			</div>
		</div>	
		<!-- BatchActionManager_EditFormPanel// -->	
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->