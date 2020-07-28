<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userRoleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userGroupManager.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainLangManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainPrincipalManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainPortletManager.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorApp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/principalPermissionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorPermissionApp.js"></script>


<script type="text/javascript">
function initDomainManager() 
{
	if( aDomainManager == null ) {
		aDomainManager = new DomainManager("<c:out value="${evSecurityCode}"/>");
		aDomainManager.init();
		aDomainManager.doDefaultSelect();
	}
}
function finishDomainManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initDomainManager );
	window.attachEvent ( "onunload", finishDomainManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initDomainManager, false );
	window.addEventListener ( "unload", finishDomainManager, false );
}
else
{
    window.onload = initDomainManager;
	window.onunload = finishDomainManager;
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
				<p id="DomainManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="DomainManager_SearchForm" name="DomainManager_SearchForm" style="display:inline" action="javascript:aDomainManager.doSearch('DomainManager_SearchForm')" onkeydown="if(event.keyCode==13) aDomainManager.doSearch('DomainManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value='DOMAIN_ID'/>
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aDomainManager.doPage'/>
						<input type='hidden' name='formName' value='DomainManager_SearchForm'/>
						<input type="hidden" id='checkbox_number' value='0'/>
						<input type="hidden" id='tabclick_number' value='1'/>
					  	<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>				  	
					  	</div>
						<input type="text" name="domainCond" size="30" class="webtextfield" value="*<util:message key='mm.prop.domain.domain'/>*" onfocus="whenSrchFocus(this,'*<util:message key='mm.prop.domain.domain'/>*');" onblur="whenSrchBlur(this,'*<util:message key='mm.prop.domain.domain'/>*');"/> 
						<a href="javascript:aDomainManager.doSearch('DomainManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
					</form>			
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="DomainManager_ListForm" style="display:inline" name="DomainManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="100px" />
						<col width="100px" />
						<col width="*" />
						<col width="100px" />
					</colgroup>
					<thead>
						<tr>
							<th class="first">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aDomainManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
						
							<th class="C" ch="0" onclick="aDomainManager.doSort(this, 'DOMAIN_ID');" >
								<span class="table_title"><util:message key='mm.prop.domain.domainId'/></span>
							</th>	
						    <th class="C" ch="0" onclick="aDomainManager.doSort(this, 'DOMAIN_CODE');" >
								<span class="table_title"><util:message key='mm.prop.domain.domainCode'/></span>
							</th>
							<th class="C" ch="0" onclick="aDomainManager.doSort(this, 'DOMAIN');" >
								<span class="table_title"><util:message key='mm.prop.domain.domain'/></span>
							</th>	
							<th class="C" ch="0" onclick="aDomainManager.doSort(this, 'PAGE_PATH');" >
								<span class="table_title"><util:message key='mm.prop.domain.pagePath'/></span>
							</th>		
						</tr>				
					</thead>
					<tbody id="DomainManager_ListBody">
						<c:forEach items="${results}" var="domain" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="{$status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<input type="checkbox" id="DomainManager[<c:out value="${status.index}"/>].checkRow" />
								
									<input type="hidden" id="DomainManager[<c:out value="${status.index}"/>].domainId" value="<c:out value='${domain.domainId}'/>"/>
								</td>
								<td class="C">
									<span class="table_title"><c:out value="${status.index}"/></span>
								</td>
								<td class="C" onclick="aDomainManager.doSelect(this)">
									<span class="table_title" id="DomainManager[<c:out value="${status.index}"/>].domainId.label">&nbsp;<c:out value="${domain.domainId}"/></span>
								</td>
								<td class="L" onclick="aDomainManager.doSelect(this)">
									<span class="table_title" id="DomainManager[<c:out value="${status.index}"/>].domainCd.label">&nbsp;<c:out value="${domain.domainCode}"/></span>
								</td>
								<td class="L" onclick="aDomainManager.doSelect(this)">
									<span class="table_title" style="max-width:530px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; word-wrap:normal;" id="DomainManager[<c:out value="${status.index}"/>].domain.label">&nbsp;<c:out value="${domain.domain}"/></span>
								</td>
								<td class="C" onclick="aDomainManager.doSelect(this)">
									<span class="table_title" id="DomainManager[<c:out value="${status.index}"/>].pagePath.label">&nbsp;<c:out value="${domain.pagePath}"/></span>
								</td>
							</tr>
						</c:forEach>		
					</tbody>
				</table>
			</form>
			<div class="tsearchArea">
				<p id="DomainManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>		
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="DomainManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aDomainManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aDomainManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->
		<!-- DomainManager_EditFormPanel -->
		<div id="DomainManager_EditFormPanel" class="board" >
			<div id="DomainManager_propertyTabs">
				<ul>
					<li><a href="#DomainManager_DetailTabPage"><util:message key='ev.title.detailTab'/></a></li>   
					<li><a href="#DomainManager_DomainLangTabPage" onclick="aDomainManager.onSelectPropertyTab(1);"><util:message key='mm.prop.domain.domainLangTab'/></a></li>   
					<li><a href="#DomainManager_DomainPrincipalTabPage" onclick="aDomainManager.onSelectPropertyTab(2);"><util:message key='mm.prop.domain.domainPrincipalTab'/></a></li>
					<%--   
					<li><a href="#DomainManager_DomainPortletTabPage" onclick="aDomainManager.onSelectPropertyTab(3);"><util:message key='mm.prop.domain.domainPortletTab'/></a></li>
					 --%>   
				</ul>
				<div id="DomainManager_DetailTabPage">
					<%@include file="domainDetail.jsp"%>
				</div>
				<div id="DomainManager_DomainLangTabPage">
				</div>
				<div id="DomainManager_DomainPrincipalTabPage">
				</div>
				<div id="DomainManager_DomainPortletTabPage">
				</div>
			</div>
		</div>
		<!-- DomainManager_EditFormPanel// -->		
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->
			
<div id="PageManager_PageChooser" title="Page Chooser">
	<div id="PageChooser_TreeTabPage" class="tree" style="border-right: 0px #ffffff;"></div>
</div>