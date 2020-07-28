
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/codebaseManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userGroupManager.js"></script>

<!-- UserGroupManager_UserGroupTabPage -->
<div id="UserGroupManager_UserGroupTabPage">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="UserGroupManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="UserGroupManager_SearchForm" name="UserGroupManager_SearchForm" style="display:inline" action="javascript:aUserGroupManager.doSearch('UserGroupManager_SearchForm')" onkeydown="if(event.keyCode==13) aUserGroupManager.doSearch('UserGroupManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aUserGroupManager.doPage'/>
				<input type='hidden' name='formName' value='UserGroupManager_SearchForm'/>
			 	<input type='hidden' id='UserGroupManager_Master_domainId' name='domainId' />
				<input type='hidden' id='UserGroupManager_Master_userId' name='userId' value=''/>
				
				<div class="sel_70">
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select>
				</div>	
				<a href="javascript:aUserGroupManager.doSearch('UserGroupManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>    
			</form>		
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="UserGroupManager_ListForm" style="display:inline" name="UserGroupManager_ListForm" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="30px" />
				<col width="30px" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
			</colgroup>		
			<thead>
				<tr>
					<th class="first">
						<input type="checkbox" id="delCheck" onclick="aUserGroupManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
					<th class="C" ch="0" >
						<span class="table_title"><util:message key='ev.prop.securityPrincipal.DomainName'/></span>
					</th>
					
					<th class="C" ch="0" onclick="aUserGroupManager.doSort(this, 'SORT_ORDER');" >
						<span class="table_title"><util:message key='ev.prop.securityUserGroup.groupId'/></span>
					</th>	
					<!--th class="C" ch="0" onclick="aUserGroupManager.doSort(this, 'PRINCIPAL_NAME');" -->
					<th class="C" ch="0" >
						<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
					</th>
				</tr>
			</thead>
			<tbody id="UserGroupManager_ListBody">
			</tbody>
		</table>
	</form>
	<div class="tsearchArea">
		<p id="UserGroupManager_ListMessage"><c:out value='${resultMessage}'/></p>
	</div>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="UserGroupManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aUserGroupManager.getGroupChooser().doShow(aUserGroupManager.setGroupChooserCallback)" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aUserGroupManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->	
</div>
<!-- UserGroupManager_UserGroupTabPage// -->	
<!-- UserGroupManager_EditFormPanel -->
<div id="UserGroupManager_EditFormPanel" class="board" >
	<!-- UserGroupManager_propertyTabs --> 
	<div id="UserGroupManager_propertyTabs">
		<ul>
			<li><a href="#UserGroupManager_DetailTabPage"><util:message key='ev.title.user.detailTab'/></a></li>
		</ul>
		<!-- UserGroupManager_DetailTabPage -->
		<div id="UserGroupManager_DetailTabPage">
			<form id="UserGroupManager_EditForm" style="display:inline" action="" method="post">
				<input type="hidden" id="UserGroupManager_isCreate">
				<input type="hidden" id="UserGroupManager_groupId" name="groupId" value="" />
				<input type="hidden" id="UserGroupManager_userId" name="userId" value="" />
				<input type="hidden" id="UserGroupManager_domainId" name="domainId" />
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="140px" />
						<col width="*" />
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tr>
						<th class="L"><util:message key='ev.prop.securityUserGroup.groupId'/></th>
						<td class="L">
							<input type="text" id="UserGroupManager_shortPath" name="shortPath" value="" maxLength="" label="<util:message key='ev.prop.securityUserGroup.groupId'/>" class="txt_200" readOnly="true"/>
						</td>
						<th class="L"><util:message key='ev.prop.securityPrincipal.principalName'/></th>
						<td class="L">
							<input type="text" id="UserGroupManager_principalName0" name="principalName0" value="" maxLength="" label="<util:message key='ev.prop.securityPrincipal.principalName'/>" class="txt_200" readOnly="true"/>
						</td>
					</tr>
					<tr>
						<th class="L"><util:message key='ev.prop.securityUserGroup.mileageTag'/></th>
						<td class="L">
							<div class="sel_100">
								<select id="UserGroupManager_mileageTag" name="mileageTag" label="<util:message key='pt.ev.property.mileageTag'/>" class='txt_100'>
									<option value="N">No</option>
									<option value="Y">Yes</option>
								</select>
							</div>	
						</td>
						<th class="L"><util:message key='ev.prop.securityUserGroup.sortOrder'/></th>
						<td class="L">
							<input type="text" id="UserGroupManager_sortOrder" name="sortOrder" value="" maxLength="10" readonly="true" label="<util:message key='pt.ev.property.sortOrder'/>" class="txt_200" />
						</td>
					</tr>
					<tr >
						<th class="L"><util:message key='ev.prop.securityUserGroup.domainName'/></th>
						<td colspan="3" class="L">
		                	<input type="text" id="UserGroupManager_domainName" name="domain" value="" maxLength="10" readonly="true" label="<util:message key='pt.ev.property.domain'/>" class="txt_200" />
						</td>
						<%-- <th class="L"><util:message key=''/></td>
						<td class="L">
						</td> --%>
					</tr>
					<tr >
						<th class="L"><util:message key='ev.prop.securityUserGroup.empNo'/></th>
						<td class="L">
		               		<input type="text" id="UserGroupManager_empNo" name="empNo" value="" maxLength="" label="<util:message key='pt.ev.property.empNo'/>" class="txt_200" onPropertyChange="javascript:aUserGroupManager.doInputNumCheck()"/>
						</td>
						<th class="L"><util:message key='ev.prop.securityUserGroup.orgCd'/></th>
						<td class="L">
							<input type="text" id="UserGroupManager_orgCd" name="orgCd" value="" maxLength="" label="<util:message key='pt.ev.property.orgCd'/>" class=""  onPropertyChange="javascript:aUserGroupManager.doInputNumCheck()"/>
							<%-- <a href="javascript:aUserGroupManager.doCodeBaseChooser()" class="btn_B"><span><util:message key='ev.title.orgCd'/></span></a> --%>
						</td>
						<%-- <th class="L"><util:message key=''/></td>
						<td class="L">
						</td> --%>
					</tr>
				</table>
			</form>
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aUserGroupManager.doMoveUp()" class="btn_W"><span><util:message key='ev.info.menu.moveUp'/></span></a>
					<a href="javascript:aUserGroupManager.doMoveDown()" class="btn_W"><span><util:message key='ev.info.menu.moveDown'/></span></a>
					<a href="javascript:aUserGroupManager.doUpdate()" class="btn_W"><span><util:message key='ev.title.save'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->			
		</div>
		<!-- UserGroupManager_DetailTabPage// -->
	</div>
	<!-- UserGroupManager_propertyTabs// -->
</div> 				
<!-- UserGroupManager_EditFormPanel// -->