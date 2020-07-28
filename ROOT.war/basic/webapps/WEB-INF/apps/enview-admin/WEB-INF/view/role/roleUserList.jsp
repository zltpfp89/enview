
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleUserManager.js"></script>

<!-- RoleUserManager_RoleUserTabPage -->
<div id="RoleUserManager_RoleUserTabPage">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="RoleUserManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="RoleUserManager_SearchForm" name="RoleUserManager_SearchForm" style="display:inline" action="javascript:aRoleUserManager.doSearch('RoleUserManager_SearchForm')" onkeydown="if(event.keyCode==13) aRoleUserManager.doSearch('RoleUserManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aRoleUserManager.doPage'/>
				<input type='hidden' name='formName' value='RoleUserManager_SearchForm'/>
			 
				<input type='hidden' id='RoleUserManager_Master_roleId' name='roleId' value=''/>

				<!-- id, 이름검색 추가 -->
				<input type="text" name="shortPathCond" size="15" class="txt_100" value="*<util:message key='ev.prop.securityPrincipal.shortPath'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPrincipal.shortPath'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPrincipal.shortPath'/>*');"/> 
				<input type="text" name="principalNameCond" size="20" class="txt_100" value="*<util:message key='ev.prop.securityPrincipal.principalName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPrincipal.principalName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPrincipal.principalName'/>*');"/>						
				<div class="sel_70">
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select>
				</div>
				<a href="javascript:aRoleUserManager.doSearch('RoleUserManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
			</form>		
		</fieldset>
	</div>
	<!-- searchArea//-->
	<form id="RoleUserManager_ListForm" style="display:inline" name="RoleUserManager_ListForm" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<colgroup>
		<col width="30px">
		<col width="30px">
		<col width="200px">
		<col width="*">
		</colgroup>
			<thead>
				<tr>
					<th class="first">
						<input type="checkbox" id="delCheck" onclick="aRoleUserManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
					<th class="C" ch="0" onclick="aRoleUserManager.doSort(this, 'USER_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityUserRole.userId'/></span>
					</th>	
					<th class="C" ch="0">
					<!--th class="C" ch="0" onclick="aRoleUserManager.doSort(this, 'PRINCIPAL_NAME');" -->
						<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
					</th>		
				</tr>
			</thead>
			<tbody id="RoleUserManager_ListBody">
			</tbody>
		</table>
	</form>
	<div class="tsearchArea">
		<p id="RoleUserManager_ListMessage"><c:out value='${resultMessage}'/></p>
	</div>	
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="RoleUserManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aRoleUserManager.getUserChooser().doShow(aRoleUserManager.setUserChooserCallback)" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aRoleUserManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
	<!-- RoleUserManager_EditFormPanel -->
	<div id="RoleUserManager_EditFormPanel" class="board" >
		<!-- RoleUserManager_propertyTabs -->  
		<div id="RoleUserManager_propertyTabs">
			<ul>
				<li><a href="#RoleUserManager_DetailTabPage"><util:message key='ev.title.role.detailTab'/></a></li>   
			</ul>
			<!-- RoleUserManager_DetailTabPage -->
			<div id="RoleUserManager_DetailTabPage">
				<form id="RoleUserManager_EditForm" style="display:inline" action="" method="post">
					<input type="hidden" id="RoleUserManager_isCreate">
					<input type="hidden" id="RoleUserManager_userId" name="userId" value="" />
					<input type="hidden" id="RoleUserManager_roleId" name="roleId" value="" />
					<input type="hidden" id="RoleUserManager_mileageTag" name="mileageTag" value="" maxLength="" class="full_webtextfield" />
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<caption>게시판</caption>
						<colgroup>
							<col width="140px" />
							<col width="*" />
							<col width="140px" />
							<col width="*" />
						</colgroup>					
						<tr>
							<th class="L"><util:message key='ev.prop.securityUserRole.userId'/></th>
							<td class="L">
								<input type="text" id="RoleUserManager_shortPath" name="shortPath" value="" maxLength="" label="<util:message key='ev.prop.securityUserRole.userId'/>" class="txt_100"  readonly="readonly"/>
							</td>
							<th class="L"><util:message key='ev.prop.securityPrincipal.principalName'/></th>
							<td class="L">
								<input type="text" id="RoleUserManager_principalName0" name="principalName0" value="" maxLength="" label="<util:message key='ev.prop.securityPrincipal.principalName'/>" class="txt_100" readonly="readonly"/>
							</td>
						</tr>
					</table>
					<!-- btnArea-->
					<%--
					<div class="btnArea">
						<div class="rightArea">
							<a href="javascript:aRoleUserManager.doUpdate()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
						</div>
					</div>
					<!-- btnArea//-->
					 --%>					
				</form>
			</div>
			<!-- RoleUserManager_DetailTabPage// -->
		</div>
		<!-- RoleUserManager_propertyTabs// --> 
	</div>
	<!-- RoleUserManager_EditFormPanel// -->
</div>
<div id="UserManager_UserChooser"></div>