
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupUserManager.js"></script>

<!-- GroupUserManager_GroupUserTabPage -->
<div id="GroupUserManager_GroupUserTabPage">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="GroupUserManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="GroupUserManager_SearchForm" name="GroupUserManager_SearchForm" style="display:inline" action="javascript:aGroupUserManager.doSearch('GroupUserManager_SearchForm')" onkeydown="if(event.keyCode==13) aGroupUserManager.doSearch('GroupUserManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aGroupUserManager.doPage'/>
				<input type='hidden' name='formName' value='GroupUserManager_SearchForm'/>
			 
				<input type='hidden' id='GroupUserManager_Master_groupId' name='groupId' value=''/>
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
				<a href="javascript:aGroupUserManager.doSearch('GroupUserManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>   
			</form>
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="GroupUserManager_ListForm" style="display:inline" name="GroupUserManager_ListForm" action="" method="post">
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
						<input type="checkbox" id="delCheck" onclick="aGroupUserManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
					
					<th class="C" ch="0" onclick="aGroupUserManager.doSort(this, 'USER_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityGroupUser.userId'/></span>
					</th>	
					<th class="C" ch="0">
					<!--th class="webgridheader" ch="0" onclick="aGroupUserManager.doSort(this, 'PRINCIPAL_NAME');" -->
						<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
					</th>		
				</tr>
			</thead>
			<tbody id="GroupUserManager_ListBody">
			</tbody>
		</table>
	</form>
	<div class="tsearchArea">
		<p id="GroupUserManager_ListMessage"><c:out value='${resultMessage}'/></p>
	</div>	 
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="GroupUserManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->	
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aGroupUserManager.getUserChooser().doShow(aGroupUserManager.setUserChooserCallback)" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aGroupUserManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->	
	<!-- GroupUserManager_EditFormPanel -->
	<div id="GroupUserManager_EditFormPanel" class="board" >  
		<!-- GroupUserManager_propertyTabs -->
		<div id="GroupUserManager_propertyTabs">
			<ul>
				<li><a href="#GroupUserManager_DetailTabPage"><util:message key='ev.title.group.detailTab'/></a></li>   
			</ul>
			<!-- GroupUserManager_DetailTabPage -->
			<div id="GroupUserManager_DetailTabPage">
				<form id="GroupUserManager_EditForm" style="display:inline" action="" method="post">
					<input type="hidden" id="GroupUserManager_isCreate">
					<input type="hidden" id="GroupUserManager_userId" name="userId" value="" />
					<input type="hidden" id="GroupUserManager_groupId" name="groupId" value="" />
					<input type="hidden" id="GroupUserManager_sortOrder" name="sortOrder" value="" maxLength="10" />
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<caption>게시판</caption>
						<colgroup>
							<col width="140px" />
							<col width="*" />
							<col width="140px" />
							<col width="*" />
						</colgroup>					
						<tr>
							<th class="L"><util:message key='ev.prop.securityGroupUser.userId'/></th>
							<td class="L">
								<input type="text" id="GroupUserManager_shortPath" name="shortPath" value="" maxLength="" label="<util:message key='ev.prop.securityGroupUser.userId'/>" class="txt_100" readOnly="true"/>
							</td>
							<th class="L"><util:message key='ev.prop.securityPrincipal.principalName'/></th>
							<td class="L">
								<input type="text" id="GroupUserManager_principalName0" name="principalName0" value="" maxLength="" label="<util:message key='ev.prop.securityPrincipal.principalName'/>" class="txt_100" readOnly="true"/>
							</td>
						</tr>
						<tr>
							<th class="L"><util:message key='ev.prop.securityUserGroup.mileageTag'/></th>
							<td class="L">
								<input type="text" id="GroupUserManager_mileageTag" name="mileageTag" value="" maxLength="" label="<util:message key='pt.ev.property.mileageTag'/>" class="full_webtextfield" />
							</td>
							<td class="L">&nbsp;</td>
							<td class="L">&nbsp;</td>
						</tr>
					</table>
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea" <c:if test="${ !(userInfo.hasAdminRole || userInfo.hasManagerRole)  }">style="display:none"</c:if>>
							<a href="javascript:aGroupUserManager.doUpdate()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
						</div>
					</div>
					<!-- btnArea//-->				
				</form>
			</div>
			<!-- GroupUserManager_DetailTabPage// -->
		</div>
		<!-- GroupUserManager_propertyTabs// -->
	</div>
	<!-- GroupUserManager_EditFormPanel// -->
</div>
<!-- GroupUserManager_GroupUserTabPage// -->

<div id="UserManager_UserChooser"></div>