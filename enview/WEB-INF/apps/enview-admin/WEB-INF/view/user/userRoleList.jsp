
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userRoleManager.js"></script>

<!-- UserRoleManager_UserRoleTabPage -->
<div id="UserRoleManager_UserRoleTabPage">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="UserRoleManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="UserRoleManager_SearchForm" name="UserRoleManager_SearchForm" style="display:inline" action="javascript:aUserRoleManager.doSearch('UserRoleManager_SearchForm')" onkeydown="if(event.keyCode==13) aUserRoleManager.doSearch('UserRoleManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aUserRoleManager.doPage'/>
				<input type='hidden' name='formName' value='UserRoleManager_SearchForm'/>
			 	<input type='hidden' id='UserRoleManager_Master_domainId' name='domainId' />
				<input type='hidden' id='UserRoleManager_Master_userId' name='userId' value=''/>
				
				<div class="sel_70">
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select>
				</div>	
				<a href="javascript:aUserRoleManager.doSearch('UserRoleManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>    
			</form>		
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="UserRoleManager_ListForm" style="display:inline" name="UserRoleManager_ListForm" action="" method="post">
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
						<input type="checkbox" id="delCheck" onclick="aUserRoleManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
				
					<th class="C" ch="0" onclick="aUserRoleManager.doSort(this, 'ROLE_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityUserRole.roleId'/></span>
					</th>	
					<!--th class="webgridheader" ch="0" onclick="aUserRoleManager.doSort(this, 'PRINCIPAL_NAME');" -->
					<th class="C" ch="0" >
						<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
					</th>		
				</tr>
			</thead>
		<tbody id="UserRoleManager_ListBody">
		</tbody>
		</table>
	</form>	
	<div class="tsearchArea">
		<p id="UserRoleManager_ListMessage"><c:out value='${resultMessage}'/></p>
	</div>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="UserRoleManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aUserRoleManager.getRoleChooser().doShow(aUserRoleManager.setRoleChooserCallback)" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aUserRoleManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->		
</div>
<!-- UserRoleManager_UserRoleTabPage// -->
<!-- UserRoleManager_EditFormPanel -->				
<div id="UserRoleManager_EditFormPanel" class="board" > 
	<!-- UserRoleManager_propertyTabs -->
	<div id="UserRoleManager_propertyTabs">
		<ul>
			<li><a href="#UserRoleManager_DetailTabPage"><util:message key='ev.title.user.detailTab'/></a></li>   
		</ul>
		<!-- UserRoleManager_DetailTabPage -->
		<div id="UserRoleManager_DetailTabPage">
			<form id="UserRoleManager_EditForm" style="display:inline" action="" method="post">
				<input type="hidden" id="UserRoleManager_isCreate">
				<input type="hidden" id="UserRoleManager_roleId" name="roleId" value="" />
				<input type="hidden" id="UserRoleManager_userId" name="userId" value="" />
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="140px" />
						<col width="*" />
						<col width="140px" />
						<col width="*" />
					</colgroup>		
					<tr>
						<th class="L"><util:message key='ev.prop.securityUserRole.roleId'/></th>
						<td class="L">
							<input type="text" id="UserRoleManager_shortPath" name="shortPath" value="" maxLength="" label="<util:message key='ev.prop.securityUserRole.roleId'/>" class="txt_100per" />
						</td>
						<th class="L"><util:message key='ev.prop.securityPrincipal.principalName'/></th>
						<td class="L">
							<input type="text" id="UserRoleManager_principalName0" name="principalName0" value="" maxLength="" label="<util:message key='ev.prop.securityPrincipal.principalName'/>" class="txt_100per" />
						</td>
					</tr>
					<tr>
						<th class="L"><util:message key='ev.prop.securityUserRole.mileageTag'/></th>
						<td class="L">
							<div class="sel_100">
								<select id="UserRoleManager_mileageTag" name="mileageTag" label="<util:message key='ev.prop.securityUserRole.mileageTag'/>" class='txt_100'>
									<option value="N">No</option>
									<option value="Y">Yes</option>
								</select>
							</div>	
						</td>
						<th class="L"><util:message key='ev.prop.securityUserRole.sortOrder'/></th>
						<td class="L">
							<input type="text" id="UserRoleManager_sortOrder" name="sortOrder" value="" maxLength="10" label="<util:message key='ev.prop.securityUserRole.sortOrder'/>" class="txt_200" />
						</td>
					</tr>
				</table>
				<!-- btnArea-->
				<div class="btnArea">
					<div class="rightArea">
						<a href="javascript:aUserRoleManager.doUpdate()" class="btn_W"><span><util:message key='ev.title.save'/></span></a></span>
					</div>
				</div>
				<!-- btnArea//-->					
			</form>
		</div>
		<!-- UserRoleManager_DetailTabPage// -->
	</div>
	<!-- UserRoleManager_propertyTabs// -->
</div>
<!-- UserRoleManager_EditFormPanel// -->