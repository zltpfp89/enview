
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchResultManager.js"></script>

<script type="text/javascript">
function initBatchResultManager() {
	if( aBatchResultManager == null ) {
		aBatchResultManager = new BatchResultManager("<c:out value="${evSecurityCode}"/>");
		aBatchResultManager.init();
		aBatchResultManager.doDefaultSelect();
	}
}
function finishBatchResultManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initBatchResultManager );
	window.attachEvent ( "onunload", finishBatchResultManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initBatchResultManager, false );
	window.addEventListener ( "unload", finishBatchResultManager, false );
}
else
{
    window.onload = initBatchResultManager;
	window.onunload = finishBatchResultManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div id="BatchResultManager_BatchResultTabPage" class="board first">
			<!-- tab_list -->
			<div class="tab_list">
				<!-- searchArea-->
				<div class="tsearchArea">
					<p id="BatchResultManager_ListMessage"><c:out value='${resultMessage}'/></p>
					<fieldset>
						<form id="BatchResultManager_SearchForm" name="BatchResultManager_SearchForm" style="display:inline" action="javascript:aBatchResultManager.doSearch('BatchResultManager_SearchForm')" onkeydown="if(event.keyCode==13) aBatchResultManager.doSearch('BatchResultManager_SearchForm')" method="post">
							<input type='hidden' name='sortMethod' value='ASC'/>                    
							<input type='hidden' name='sortColumn' value=''/>  
							<input type='hidden' name='pageNo' value='1'/>
							<!--input type='hidden' name='pageSize' value='10'/-->
							<input type='hidden' name='pageFunction' value='aBatchResultManager.doPage'/>
							<input type='hidden' name='formName' value='BatchResultManager_SearchForm'/>
						 
							<div class="sel_100">
								<select name="statusCond" class='txt_100'>
									<c:forEach items="${statusList}" var="status">
										<option value="<c:out value="${status.code}"/>"><c:out value="${status.codeName}"/></option>
									</c:forEach>
								</select>
							</div>
											
							<input type="text" name="name0Cond" size="30" class="txt_100" value="*<util:message key='ev.prop.batchAction.name'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchAction.name'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchAction.name'/>*');"/> 
											
							<input type="text" id="BatchResultManager_executStartCond" name="executStartCond" class="txt_100" value="*<util:message key='ev.prop.batchResult.executStart'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchResult.executStart'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchResult.executStart'/>*');"/>
							<input type="text" id="BatchResultManager_executEndCond" name="executEndCond" class="txt_100" value="*<util:message key='ev.prop.batchResult.executEnd'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchResult.executEnd'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchResult.executEnd'/>*');"/>
						
							<div class="sel_70">
								<select name='pageSize' class="txt_70">
									<option value="5">5</option>
									<option value="10" selected>10</option>
									<option value="20" >20</option>
									<option value="50">50</option>
									<option value="100">100</option>
								</select>
							</div>
							<a href="javascript:aBatchResultManager.doSearch('BatchResultManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
						</form>			
					</fieldset>
				</div>
				<!-- searchArea// -->
				<!-- BatchResultManager_ListForm -->	
				<form id="BatchResultManager_ListForm" style="display:inline" name="BatchResultManager_ListForm" action="" method="post">
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
									<input type="checkbox" id="delCheck" onclick="aBatchResultManager.m_checkBox.chkAll(this)"/>
								</th>
								<th class="C"><span class="table_title">No</span></th>
							
								<th class="C" ch="0" onclick="aBatchResultManager.doSort(this, 'RESULT_ID');" >
									<span class="table_title"><util:message key='ev.prop.batchResult.resultId'/></span>
								</th>	
								<th class="C" ch="0" onclick="aBatchResultManager.doSort(this, 'NAME');" >
									<span class="table_title"><util:message key='ev.prop.batchAction.actionName'/></span>
								</th>	
								<th class="C" ch="0" onclick="aBatchResultManager.doSort(this, 'STATUS');" >
									<span class="table_title"><util:message key='ev.prop.batchResult.status'/></span>
								</th>	
								<th class="C" ch="0" onclick="aBatchResultManager.doSort(this, 'EXECUT_START');" >
									<span class="table_title"><util:message key='ev.prop.batchResult.executStart'/></span>
								</th>	
								<th class="C" ch="0" onclick="aBatchResultManager.doSort(this, 'EXECUT_END');" >
									<span class="table_title"><util:message key='ev.prop.batchResult.executEnd'/></span>
								</th>	
								<th class="C" ch="0" onclick="aBatchResultManager.doSort(this, 'a.UPD_USER_ID');" >
									<span class="table_title"><util:message key='ev.prop.batchResult.updUserId'/></span>
								</th>	
								<th class="C" ch="0" onclick="aBatchResultManager.doSort(this, 'a.UPD_DATIM');" >
									<span class="table_title"><util:message key='ev.prop.batchResult.updDatim'/></span>
								</th>		
							</tr>
						</thead>
						<tbody id="BatchResultManager_ListBody">
							<c:forEach items="${results}" var="batchresult" varStatus="status">
								<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;">
									<td class="C">
										<input type="checkbox" id="BatchResultManager[<c:out value="${status.index}"/>].checkRow"/>
									
										<input type="hidden" id="BatchResultManager[<c:out value="${status.index}"/>].resultId" value="<c:out value='${batchresult.resultId}'/>"/>
									</td>
									<td class="C">
										<span class="table_title"><c:out value="${status.index}"/></span>
									</td>
									<td class="L" onclick="aBatchResultManager.doSelect(this)">
										<span class="table_title" id="BatchResultManager[<c:out value="${status.index}"/>].resultId.label">&nbsp;<c:out value="${batchresult.resultId}"/></span>
									</td>
									<td class="L" onclick="aBatchResultManager.doSelect(this)">
										<span class="table_title" id="BatchResultManager[<c:out value="${status.index}"/>].actionName0.label">&nbsp;<c:out value="${batchresult.actionName0}"/></span>
									</td>
									<td class="L" onclick="aBatchResultManager.doSelect(this)">
										<span class="table_title" id="BatchResultManager[<c:out value="${status.index}"/>].status.label">&nbsp;<c:out value="${batchresult.status}"/></span>
									</td>
									<td class="L" onclick="aBatchResultManager.doSelect(this)">
										<span class="table_title" id="BatchResultManager[<c:out value="${status.index}"/>].executStart.label">&nbsp;<c:out value="${batchresult.executStartByFormat}"/></span>
									</td>
									<td class="L" onclick="aBatchResultManager.doSelect(this)">
										<span class="table_title" id="BatchResultManager[<c:out value="${status.index}"/>].executEnd.label">&nbsp;<c:out value="${batchresult.executEndByFormat}"/></span>
									</td>
									<td class="L" onclick="aBatchResultManager.doSelect(this)">
										<span class="table_title" id="BatchResultManager[<c:out value="${status.index}"/>].updUserId.label">&nbsp;<c:out value="${batchresult.updUserId}"/></span>
									</td>
									<td class="L" onclick="aBatchResultManager.doSelect(this)">
										<span class="table_title" id="BatchResultManager[<c:out value="${status.index}"/>].updDatim.label">&nbsp;<c:out value="${batchresult.updDatimByFormat}"/></span>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<!-- BatchResultManager_ListForm// -->
				<div class="tsearchArea">
					<p id="BatchResultManager_ListMessage"><c:out value='${resultMessage}'/></p>
				</div>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div id="BatchResultManager_PAGE_ITERATOR" class="paging">
						<c:out escapeXml='false' value='${pageIterator}'/>
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->			
			</div>
			<!-- tab_list// -->
		</div>
		<!-- board first// -->
		<!-- BatchResultManager_EditFormPanel -->
		<div id="BatchResultManager_EditFormPanel" class="board" >  
			<div id="BatchResultManager_propertyTabs">
				<ul>
					<li><a href="#BatchResultManager_DetailTabPage"><util:message key='ev.title.batchSchedule.detailTab'/></a></li>   
				</ul>
				<div id="BatchResultManager_DetailTabPage">
					<%@include file="batchResultDetail.jsp"%>
				</div>
			</div>
		</div>	
		<!-- BatchResultManager_EditFormPanel/ -->		
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->
