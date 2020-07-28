
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletServiceManager.js"></script>

<script type="text/javascript">
function initPortletServiceManager() {
	if( aPortletServiceManager == null ) {
		aPortletServiceManager = new PortletServiceManager();
		aPortletServiceManager.init();
		aPortletServiceManager.doDefaultSelect();
	}
}
function finishPortletServiceManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initPortletServiceManager );
	window.attachEvent ( "onunload", finishPortletServiceManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initPortletServiceManager, false );
	window.addEventListener ( "unload", finishPortletServiceManager, false );
}
else
{
    window.onload = initPortletServiceManager;
	window.onunload = finishPortletServiceManager;
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
				<p id="PortletServiceManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="PortletServiceManager_SearchForm" name="PortletServiceManager_SearchForm" style="display:inline" action="javascript:aPortletServiceManager.doSearch('PortletServiceManager_SearchForm')" onkeydown="if(event.keyCode==13) aPortletServiceManager.doSearch('PortletServiceManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPortletServiceManager.doPage'/>
						<input type='hidden' name='formName' value='PortletServiceManager_SearchForm'/>
						<input type="text" name="searchField" size="15" class="txt_100" value="*<util:message key='ev.prop.portletService.serviceName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.portletService.serviceName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.portletService.serviceName'/>*');"/> 
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aPortletServiceManager.doSearch('PortletServiceManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>	
					</form>
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="PortletServiceManager_ListForm" style="display:inline" name="PortletServiceManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="300px" />
						<col width="*" />
					</colgroup>			 
					<thead>
						<tr>
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aPortletServiceManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							<th class="C" ch="0" onclick="aPortletServiceManager.doSort(this, 'SERVICE_ID');" >
								<span class="table_title"><util:message key='ev.prop.portletService.serviceId'/></span>
							</th>	
							<th class="C" ch="0" onclick="aPortletServiceManager.doSort(this, 'SERVICE_NAME');" >
								<span class="table_title"><util:message key='ev.prop.portletService.serviceName'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="PortletServiceManager_ListBody">
						<c:forEach items="${results}" var="portletservice" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="{$status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<input type="checkbox" id="PortletServiceManager[<c:out value="${status.index}"/>].checkRow" />
								
									<input type="hidden" id="PortletServiceManager[<c:out value="${status.index}"/>].serviceId" value="<c:out value='${portletservice.serviceId}'/>"/>
								</td>
								<td class="C">
									<c:out value="${status.index}"/>
								</td>
								
								<td class="L" onclick="aPortletServiceManager.doSelect(this)">
									<span id="PortletServiceManager[<c:out value="${status.index}"/>].serviceId.label">&nbsp;<c:out value="${portletservice.serviceId}"/></span>
								</td>
								<td class="L" onclick="aPortletServiceManager.doSelect(this)">
									<span id="PortletServiceManager[<c:out value="${status.index}"/>].serviceName.label">&nbsp;<c:out value="${portletservice.serviceName}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
			 	</table>
			 </form>
			<div class="tsearchArea">
				<p id="PortletServiceManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="PortletServiceManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->	
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aPortletServiceManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aPortletServiceManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->
		<div id="PortletServiceManager_EditFormPanel" class="board" >  
			<div id="PortletServiceManager_propertyTabs">
				<ul>
					<li><a href="#PortletServiceManager_DetailTabPage"><util:message key='ev.title.detailTab'/></a></li>   
				</ul>
				<div id="PortletServiceManager_DetailTabPage">
					<%@include file="portletServiceDetail.jsp"%>
				</div>
			</div>
		</div>		
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->	