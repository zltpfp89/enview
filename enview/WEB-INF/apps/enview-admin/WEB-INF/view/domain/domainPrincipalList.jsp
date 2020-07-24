<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainPrincipalManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletSelectorApp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/principalPermissionManager.js"></script>
<script type="text/javascript">
function initDomainPrincipalManager() 
{
	if( aDomainPrincipalManager == null ) {
		aDomainPrincipalManager = new aDomainPrincipalManager("<c:out value="${evSecurityCode}"/>");
		aDomainPrincipalManager.init();
	}
}

function finishDomainPrincipalManager() 
{
	
}

if (window.attachEvent)
{
    window.attachEvent ( "onload", initDomainPrincipalManager );
	window.attachEvent ( "onunload", finishDomainPrincipalManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initDomainPrincipalManager, false );
	window.addEventListener ( "unload", finishDomainPrincipalManager, false );
}
else
{
    window.onload = initDomainPrincipalManager;
	window.onunload = finishDomainPrincipalManager;
}

</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div id="LangManager_EditFormPanel" class="board first" >
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="DomainPrincipalManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>	
					<form id="DomainPrincipalManager_SearchForm" name="DomainPrincipalManager_SearchForm" style="display:inline" action="javascript:aDomainPrincipalManager.doSearch('DomainPrincipalManager_SearchForm')" onkeydown="if(event.keyCode==13) aDomainPrincipalManager.doSearch('DomainPrincipalManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aDomainPrincipalManager.doPage'/>
						<input type='hidden' name='formName' value='DomainPrincipalManager_SearchForm'/>
						
						<input type='hidden' id='DomainPrincipalManager_Master_domainId' name='domainId' value=''/>
			
						<div class="sel_100">
							<select id='PrincipalPermissionManager_principalType' name='principalType' onchange="aDomainPrincipalManager.changePrincipal(this)" class="txt_100">
								<option value="U" selected>User</option>
								<!-- <option value="G">Group</option>
								<option value="R" >Role</option> -->
							</select>
						</div>
						<input type="text" name="titleCond" size="20" class="txt_100" value="*<util:message key='mm.prop.securityPrincipal.principalName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='mm.prop.securityPrincipal.principalName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='mm.prop.securityPrincipal.principalName'/>*');"/> 
					
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aDomainPrincipalManager.doSearch('DomainPrincipalManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>				
					</form>
				</fieldset>
			</div>
			<!-- searchArea// -->
			<form id="DomainPrincipalManager_ListForm" style="display:inline" name="DomainPrincipalManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
					<colgroup>
						<col width="40px" />
						<col width="40px" />
						<col width="40%" />
						<col width="60%" />
					</colgroup>
					<thead>
						<tr>
							<th class="first">
								<input type="checkbox" id="delCheck" class="txt_100" onclick="aDomainPrincipalManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							<th class="C" ch="0" onclick="aDomainPrincipalManager.doSort(this, 'a.PRINCIPAL_ID');" >
								<span class="table_title"><util:message key='mm.title.id'/></span>
							</th>		
							<th class="C" ch="0" onclick="aDomainPrincipalManager.doSort(this, 'PRINCIPAL_NAME');" >
								<span class="table_title"><util:message key='mm.prop.domainPrincipal.userNm'/></span>
							</th>
							
						</tr>				
					</thead>
					<tbody id="DomainPrincipalManager_ListBody">
						<c:forEach items="${results}" var="domainprincipal" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="{$status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<input type="checkbox" id="DomainPrincipalManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
								
									<input type="hidden" id="DomainPrincipalManager[<c:out value="${status.index}"/>].domainId" value="<c:out value='${domainprincipal.domainId}'/>"/>
									<input type="hidden" id="DomainPrincipalManager[<c:out value="${status.index}"/>].principalId" value="<c:out value='${domainprincipal.principalId}'/>"/>
								</td>
								<td class="C">
									<span class="table_title"><c:out value="${status.index}"/></span>
								</td>
								
								<td class="L" onclick="aDomainPrincipalManager.doSelect(this)">
									<span class="table_title" id="DomainPrincipalManager[<c:out value="${status.index}"/>].domainId.label">&nbsp;<c:out value="${domainprincipal.domain}"/></span>
								</td>
								<td class="L" onclick="aDomainPrincipalManager.doSelect(this)">
									<span class="table_title" id="DomainPrincipalManager[<c:out value="${status.index}"/>].principalId.label">&nbsp;<c:out value="${domainprincipal.principal}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="DomainPrincipalManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea"> 
				<div class="rightArea">
					<a id="DomainPrincipalManager_UserChooser" href="javascript:aDomainPrincipalManager.getUserChooser().doShow(aDomainPrincipalManager.setUserChooserCallback)" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
					<a id="DomainPrincipalManager_GroupChooser" href="javascript:aDomainPrincipalManager.getGroupChooser().doShow(aDomainPrincipalManager.setGroupChooserCallback)" class="btn_B" style="display: none;"><span><util:message key='ev.title.new'/></span></a>
					<a id="DomainPrincipalManager_RoleChooser" href="javascript:aDomainPrincipalManager.getRoleChooser().doShow(aDomainPrincipalManager.setRoleChooserCallback)" class="btn_B" style="display: none;"><span><util:message key='ev.title.new'/></span></a>
					<a id="DomainPrincipalManager_Remove" href="javascript:aDomainPrincipalManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->
		<!-- DomainPrincipalManager_EditFormPanel -->
		<div id="DomainPrincipalManager_EditFormPanel" class="board" >
			<div id="DomainPrincipalManager_propertyTabs">
				<ul>
					<li><a href="#DomainPrincipalManager_DetailTabPage"><util:message key='ev.title.detailTab'/></a></li>   
				</ul>
				<div id="DomainPrincipalManager_DetailTabPage">
					<%@include file="domainPrincipalDetail.jsp"%>
				</div>
			</div>
		</div>
		<!-- DomainPrincipalManager_EditFormPanel// -->		
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="UserManager_UserChooser" title="User Chooser"></div>
<div id="GroupManager_GroupChooser" title="Group Chooser"></div>
<div id="RoleManager_RoleChooser" title="Role Chooser"></div>
<div id="PortletCategoryManager_PortletCategoryChooser"></div>