
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<div id="PrincipalPermissionManager_UserGroupTabPage">
	<div class="tsearchArea">
		<p id="PrincipalPermissionManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="PrincipalPermissionManager_SearchForm" name="PrincipalPermissionManager_SearchForm" style="display:inline" action="javascript:aPrincipalPermissionManager.doSearch('PrincipalPermissionManager_SearchForm')" onkeydown="if(event.keyCode==13) aPrincipalPermissionManager.doSearch('PrincipalPermissionManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aPrincipalPermissionManager.doPage'/>
				<input type='hidden' name='formName' value='PrincipalPermissionManager_SearchForm'/>
			 	<input type='hidden' id='PrincipalPermissionManager_Master_domainId' name='domainId'/>
				<input type='hidden' id='PrincipalPermissionManager_Master_title' name='title' value=''/>
				<input type='hidden' id='PrincipalPermissionManager_Master_resUrl' name='resUrl' value=''/>
				<input type='hidden' id='PrincipalPermissionManager_Master_resType' name='resType' value=''/>
				<input type='hidden' id='PrincipalPermissionManager_Master_isPage' name='isPage' value=''/>
				
				<div class="sel_100">
					<select id='PrincipalPermissionManager_principalType' name='principalType' onchange="aPrincipalPermissionManager.changePrincipal(this)" class="txt_100">
						<option value="U" selected>User</option>
						<!--option value="G">Group</option-->
						<option value="R" >Role</option>
					</select>
				</div>
				<input type="text" name="titleCond" size="20" class="txt_100" value="*<util:message key='ev.title.property.key'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.property.key'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.property.key'/>*');"/> 
				
				<div class="sel_70">
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select>
				</div>
				
				<a href="javascript:aPrincipalPermissionManager.doSearch('PrincipalPermissionManager_SearchForm')" class="btn_search">
					<span><util:message key='ev.title.search'/></span>
				</a>
			</form>
		</fieldset>
	</div>
	<form id="PrincipalPermissionManager_ListForm" style="display:inline" name="PrincipalPermissionManager_ListForm" action="" method="post">
	<table id="grid-table" border="0" cellspacing="0" cellpadding="0" class="list table_board">
	<caption>게시판리스트</caption>
		<colgroup>
			<col width="30px" />
			<col width="30px" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
		</colgroup>
		<thead>
			<tr style="cursor: pointer;">
				<th class="first">
					<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aPrincipalPermissionManager.m_checkBox.chkAll(this)"/>
				</th>
				<th ><span class="table_title">No</span></th>
				<th ch="0" onclick="aPrincipalPermissionManager.doSort(this, 'PERMISSION_ID');" >
					<span class="table_title"><util:message key='ev.prop.securityPermission.permissionId'/></span>
				</th>
				<th ch="0" onclick="aPrincipalPermissionManager.doSort(this, 'SHORT_PATH');" >
					<span class="table_title">ID</span>
				</th>	
				<th ch="0" onclick="aPrincipalPermissionManager.doSort(this, 'PRINCIPAL_NAME');" >
					<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
				</th>		
			</tr>
		</thead>
		<tbody id="PrincipalPermissionManager_ListBody">
		</tbody>
	</table>
	
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div class="paging" id="PrincipalPermissionManager_PAGE_ITERATOR">
			<c:out escapeXml='false' value='${pageIterator}'/>			
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	
	<!-- btnArea-->
	<div class="btnArea"> 
		<div class="rightArea">
			<a id="PrincipalPermissionManager_UserChooser" href="javascript:aPrincipalPermissionManager.getUserChooser().doShow(aPrincipalPermissionManager.setUserChooserCallback)" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a id="PrincipalPermissionManager_GroupChooser" style="display:none" href="javascript:aPrincipalPermissionManager.getGroupChooser().doShow(aPrincipalPermissionManager.setGroupChooserCallback)" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a id="PrincipalPermissionManager_RoleChooser" style="display:none" href="javascript:aPrincipalPermissionManager.getRoleChooser().doShow(aPrincipalPermissionManager.setRoleChooserCallback)" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aPrincipalPermissionManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
	</form>
	
	<div id="PrincipalPermissionManager_EditFormPanel">
		<div id="PrincipalPermissionManager_propertyTabs">
			<ul>
				<li><a href="#PrincipalPermissionManager_DetailTabPage"><util:message key='ev.title.security.detailTab'/></a></li>   
			</ul>
			<div id="PrincipalPermissionManager_DetailTabPage" >
				<form id="PrincipalPermissionManager_EditForm" style="display:inline" action="" method="post">
					<input type="hidden" id="PrincipalPermissionManager_isCreate">
					<input type="hidden" id="PrincipalPermissionManager_permissionId" name="permissionId"/>
					<input type="hidden" id="PrincipalPermissionManager_principalId" name="principalId"/>
					<input type="hidden" id="PrincipalPermissionManager_domainId" name="domainId"/>
					<input type="hidden" id="PrincipalPermissionManager_title" name="title"/>
					<input type="hidden" id="PrincipalPermissionManager_resType" name="resType"/>
					<input type="hidden" id="PrincipalPermissionManager_resUrl" name="resUrl"/>
					
					<table cellpadding=0 cellspacing=0 border=0 width='100%' class="table_board">
					<caption>게시판</caption>
						<colgroup>
							<col width="120px" />
							<col width="*" />
							<col width="120px" />
							<col width="*" />
						</colgroup>
						<tr >
							<th class="L"><util:message key='ev.prop.securityPermission.isAllow'/></th>
							<td class="L">
								<input type="checkbox" id="PrincipalPermissionManager_isAllow" name="isAllow" value="" />
								<!-- <label for="PrincipalPermissionManager_isAllow">허용여부</label> -->
							</td>
							<th class="L"></th>
							<td class="L"></td>
						</tr>
						<tr >
							<th class="L">
								<util:message key='ev.prop.securityPermission.actionMask'/>
								<input id="PrincipalPermissionManager_actionMask_check" type="checkbox" onclick="aPrincipalPermissionManager.toggleAllPermission()">
							</th>
							<td colspan="3" class="L">
								<input type="hidden" id="PrincipalPermissionManager_actionMask" name="actionMask" value="" maxLength="" />
								<c:forEach items="${authorityCategory}" var="authority">
									<input type="checkbox" id="PrincipalPermissionManager_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>">
									<label for="PrincipalPermissionManager_authority_<c:out value="${authority.code}"/>"><c:out value="${authority.codeName}"/></label>&nbsp;&nbsp;
								</c:forEach>
							</td>
						</tr>
						<tr >
							<th class="L"><util:message key='ev.prop.securityPermission.creationDate'/></th>
							<td class="L"><input type="text" id="PrincipalPermissionManager_creationDate" name="creationDate" value="" class="txt_145" /></td>
							<th class="L"><util:message key='ev.prop.securityPermission.modifiedDate'/></th>
							<td class="L"><input type="text" id="PrincipalPermissionManager_modifiedDate" name="modifiedDate" value="" class="txt_145" /></td>
						</tr>
					</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aPrincipalPermissionManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPrincipalPermissionManager.doUpdate(true)">
									</td>
								</tr>
								</table>
				</form>
			</div>
		</div>
	</div>
</div>

