
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletApplicationManager.js"></script>
<script type="text/javascript">
function initPortletApplicationManager() {
	if( aPortletApplicationManager == null ) {
		aPortletApplicationManager = new PortletApplicationManager("<c:out value="${evSecurityCode}"/>");
		aPortletApplicationManager.init();
	}
}
function finishPortletApplicationManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initPortletApplicationManager );
	window.attachEvent ( "onunload", finishPortletApplicationManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initPortletApplicationManager, false );
	window.addEventListener ( "unload", finishPortletApplicationManager, false );
}
else
{
    window.onload = initPortletApplicationManager;
	window.onunload = finishPortletApplicationManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- tree2 -->
	<div id="cateTabs" class="tree2">
		<!-- treewrap -->
		<div class="treewrap resizable">
			<div class="tree_title"><util:message key='ev.prop.portletApplication.appName'/></div>
			<!-- 트리 영역 border로 구분. 지우고 사용해주세요 -->
			<!-- searchArea-->
			<div class="tsearchArea">
				<p style="background: none"></p>
				<fieldset>
					<form id="PortletApplicationManager_SearchForm" name="PortletApplicationManager_SearchForm" style="display:inline" action="javascript:aPortletApplicationManager.doSearch('PortletApplicationManager_SearchForm')" onkeydown="if(event.keyCode==13) aPortletApplicationManager.doSearch('PortletApplicationManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPortletApplicationManager.doPage'/>
						<input type='hidden' name='formName' value='PortletApplicationManager_SearchForm'/>
						
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20">20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aPortletApplicationManager.doSearch('PortletApplicationManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a> 
					</form>
				</fieldset>		
			</div>
			<!-- searchArea//-->
		</div>
		<!-- treewrap// -->
		<form id="PortletApplicationManager_ListForm" style="display:inline" name="PortletApplicationManager_ListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="30px" />
					<col width="*" />
					<col width="*" />
				</colgroup>				
				<thead>
					<tr>
						<th class="first">
							<input type="checkbox" id="delCheck" onclick="aPortletApplicationManager.m_checkBox.chkAll(this)"/>
						</th>
						<th class="C"><span class="table_title">No</span></th>
						<th class="C" ch="0" onclick="aPortletApplicationManager.doSort(this, 'TITLE');" >
							<span class="table_title"><util:message key='ev.prop.portletApplication.title'/></span>
						</th>
						<th class="C" ch="0" >
							<span class="table_title"><util:message key='ev.prop.portletApplication.version'/></span>
						</th>
					</tr>
				</thead>
				<tbody id="PortletApplicationManager_ListBody">
					<c:forEach items="${results}" var="portletapplication" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;">
							<td class="C">
								<input type="checkbox" id="PortletApplicationManager[<c:out value="${status.index}"/>].checkRow""/>
								<input type="hidden" id="PortletApplicationManager[<c:out value="${status.index}"/>].appName" value="<c:out value='${portletapplication.appName}'/>"/>
								<input type="hidden" id="PortletApplicationManager[<c:out value="${status.index}"/>].appTitle" value="<c:out value='${portletapplication.title}'/>"/>
							</td>
							<td class="L">
								<c:out value="${status.index+1}"/>
							</td>
							<td class="L" onclick="aPortletApplicationManager.doSelect(this)">
								<span id="PortletApplicationManager[<c:out value="${status.index}"/>].title.label">&nbsp;<c:out value="${portletapplication.title}"/>
							</td>
							<td class="C" >
								<span id="PortletApplicationManager[<c:out value="${status.index}"/>].running.label">&nbsp;<c:out value="${portletapplication.version}"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
		<div class="tsearchArea">
			<p id="PortletApplicationManager_ListMessage"><c:out value='${resultMessage}'/></p>
		</div>
		<!-- tcontrol-->
		<div class="tcontrol">
			<!-- paging -->
			<div id="PortletApplicationManager_PAGE_ITERATOR" class="paging">
				<c:out escapeXml='false' value='${pageIterator}'/>
			</div>
			<!-- paging//-->
		</div>
		<!-- tcontrol//-->
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
				<!--span class="btn_pack small"><a href="javascript:aPortletApplicationManager.doReload()"><util:message key='ev.title.reload'/></a></span-->
				<!--span class="btn_pack small"><a href="javascript:aPortletApplicationManager.doWrite()"><util:message key='ev.title.writeFile'/></a></span-->
				<!--span class="btn_pack small"><a href="javascript:aPortletApplicationManager.doStart()"><util:message key='ev.title.start'/></a></span-->
				<!--span class="btn_pack small"><a href="javascript:aPortletApplicationManager.doStop()"><util:message key='ev.title.stop'/></a></span-->			
			</div>
		</div>
		<!-- btnArea//-->
	</div>
	<!-- tree2// -->
	<!-- detail -->
	<div class="detail">
		<div id="PortletCategoryManager_Right">
			<%@include file="portletDefinitionList.jsp"%>
		</div>
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->	

<div id="PortletApplicationManager_PortletApplicationChooser"></div>