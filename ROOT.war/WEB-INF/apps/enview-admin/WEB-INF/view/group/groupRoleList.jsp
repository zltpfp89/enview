
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupRoleManager.js"></script>


<!-- GroupUserManager_GroupUserTabPage -->
<div id="GroupRoleManager_GroupRoleTabPage">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="GroupRoleManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="GroupRoleManager_SearchForm" name="GroupRoleManager_SearchForm" style="display:inline" action="javascript:aGroupRoleManager.doSearch('GroupRoleManager_SearchForm')" onkeydown="if(event.keyCode==13) aGroupRoleManager.doSearch('GroupRoleManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aGroupRoleManager.doPage'/>
				<input type='hidden' name='formName' value='GroupRoleManager_SearchForm'/>
			 
				<input type='hidden' id='GroupRoleManager_Master_groupId' name='groupId' value=''/>

				<div class="sel_70">				
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select>
				</div>
				<a href="javascript:aGroupRoleManager.doSearch('GroupRoleManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>   
			</form>		
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="GroupRoleManager_ListForm" style="display:inline" name="GroupRoleManager_ListForm" action="" method="post">
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
						<input type="checkbox" id="delCheck" onclick="aGroupRoleManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
					
					<th class="C" ch="0" onclick="aGroupRoleManager.doSort(this, 'ROLE_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityGroupRole.groupId'/></span>
					</th>	
					<th class="C" ch="0">
					<!--th class="webgridheaderlast" ch="0" onclick="aGroupRoleManager.doSort(this, 'PRINCIPAL_NAME');" -->
						<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
					</th>		
				</tr>
			</thead>
			<tbody id="GroupRoleManager_ListBody">
			</tbody>
		</table>
	</form>
	<div class="tsearchArea">
		<p id="GroupRoleManager_ListMessage"><c:out value='${resultMessage}'/></p>
	</div>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="GroupRoleManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea" <c:if test="${ !(userInfo.hasAdminRole || userInfo.hasManagerRole)  }">style="display:none"</c:if>>
			<a href="javascript:aGroupRoleManager.getRoleChooser().doShow(aGroupRoleManager.setRoleChooserCallback)" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aGroupRoleManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
	<!-- GroupRoleManager_EditFormPanel -->
	<div id="GroupRoleManager_EditFormPanel" class="board" >
		<!-- GroupRoleManager_propertyTabs -->
		<div id="GroupRoleManager_propertyTabs">
			<ul>
				<li><a href="#GroupRoleManager_DetailTabPage"><util:message key='ev.title.group.detailTab'/></a></li>   
			</ul>
			<!-- GroupRoleManager_DetailTabPage -->
			<div id="GroupRoleManager_DetailTabPage">
				<form id="GroupRoleManager_EditForm" style="display:inline" action="" method="post">
					<input type="hidden" id="GroupRoleManager_isCreate">
					<input type="hidden" id="GroupRoleManager_roleId" name="roleId"  />
					<input type="hidden" id="GroupRoleManager_groupId" name="groupId" />
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<caption>게시판</caption>
						<colgroup>
							<col width="140px" />
							<col width="*" />
							<col width="140px" />
							<col width="*" />
						</colgroup>					
						<tr>
							<th class="L"><util:message key='ev.prop.securityGroupRole.groupId'/></td>
							<td class="L">
								<input type="text" id="GroupRoleManager_shortPath" name="shortPath" readonly="readonly" value="" maxLength="" label="<util:message key='ev.prop.securityGroupRole.groupId'/>" class="txt_100per" />
							</td>
							<th class="L"><util:message key='ev.prop.securityPrincipal.principalName'/></th>
							<td class="L">
								<input type="text" id="GroupRoleManager_principalName0" name="principalName0" readonly="readonly" value="" maxLength="" label="<util:message key='ev.prop.securityPrincipal.principalName'/>" class="txt_100per" />
							</td>
						</tr>
					</table>
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea" <c:if test="${ !(userInfo.hasAdminRole || userInfo.hasManagerRole)  }">style="display:none"</c:if>>
							<a href="javascript:aGroupRoleManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
						</div>
					</div>
					<!-- btnArea// -->
				</form>
			</div>
			<!-- GroupRoleManager_DetailTabPage// -->		
		</div>
		<!-- GroupRoleManager_propertyTabs// -->
	</div>
	<!-- GroupRoleManager_EditFormPanel// -->	
</div>
<!-- GroupUserManager_GroupUserTabPage// -->

<div id="RoleManager_RoleChooser" title="Role Chooser"></div>