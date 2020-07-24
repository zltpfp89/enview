
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pagePermissionManager.js"></script>

<!-- PagePermissionManager_PagePermissionTabPage -->
<div id="PagePermissionManager_PagePermissionTabPage">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="PagePermissionManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="PagePermissionManager_SearchForm" name="PagePermissionManager_SearchForm" style="display:inline" action="javascript:aPagePermissionManager.doSearch('PagePermissionManager_SearchForm')" onkeydown="if(event.keyCode==13) aPagePermissionManager.doSearch('PagePermissionManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aPagePermissionManager.doPage'/>
				<input type='hidden' name='formName' value='PagePermissionManager_SearchForm'/>
				<input type='hidden' id='PagePermissionManager_Master_principalId' name='principalId' value=''/>
				<input type="hidden" id="PagePermissionManager_Master_principalType" name="principalType" />
				<input type='hidden' id='PagePermissionManager_Master_domainId' name='domainId' />
				
				<input type="text" name="titleCond" size="30" class="txt_100" value="*<util:message key='ev.prop.securityPermission.title'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPermission.title'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPermission.title'/>*');"/> 
								
				<div class="sel_70">
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select>
				</div>
				<a href="javascript:aPagePermissionManager.doSearch('PagePermissionManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
			</form>		
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="PagePermissionManager_ListForm" style="display:inline" name="PagePermissionManager_ListForm" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="30px" />
				<col width="30px" />
				<col width="10%" />
				<col width="10%" />
				<col width="*" />
				<col width="*" />
			</colgroup>		
			<thead>
				<tr>
					<th class="first">
						<input type="checkbox" id="delCheck" onclick="aPagePermissionManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
					
					<th class="C" ch="0" onclick="aPagePermissionManager.doSort(this, 'PERMISSION_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.permissionId'/></span>
					</th>	
					<th class="C" ch="0" onclick="aPagePermissionManager.doSort(this, 'PRINCIPAL_ID');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.principalId'/></span>
					</th>	
					<th class="C" ch="0" onclick="aPagePermissionManager.doSort(this, 'TITLE');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.title'/></span>
					</th>	
					<th class="C" ch="0" onclick="aPagePermissionManager.doSort(this, 'RES_URL');" >
						<span class="table_title"><util:message key='ev.prop.securityPermission.resUrl'/></span>
					</th>		
				</tr>
			</thead>
			<tbody id="PagePermissionManager_ListBody">
				<c:forEach items="${results}" var="pagepermission" varStatus="status">
					<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
						<td class="C">
							<input type="checkbox" id="PagePermissionManager[<c:out value="${status.index}"/>].checkRow" />
							
							<input type="hidden" id="PagePermissionManager[<c:out value="${status.index}"/>].permissionId" value="<c:out value='${pagepermission.permissionId}'/>"/>
						</td>
						<td class="L">
							<c:out value="${status.index}"/>
						</td>
						<td class="L" onclick="aPagePermissionManager.doSelect(this)">
							<span id="PagePermissionManager[<c:out value="${status.index}"/>].permissionId.label">&nbsp;<c:out value="${pagepermission.permissionId}"/></span>
						</td>
						<td class="L" onclick="aPagePermissionManager.doSelect(this)">
							<span id="PagePermissionManager[<c:out value="${status.index}"/>].principalId.label">&nbsp;<c:out value="${pagepermission.principalId}"/></span>
						</td>
						<td class="L" onclick="aPagePermissionManager.doSelect(this)">
							<span id="PagePermissionManager[<c:out value="${status.index}"/>].title.label">&nbsp;<c:out value="${pagepermission.title}"/></span>
						</td>
						<td class="L" onclick="aPagePermissionManager.doSelect(this)">
							<span id="PagePermissionManager[<c:out value="${status.index}"/>].resUrl.label">&nbsp;<c:out value="${pagepermission.resUrl}"/></span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>	
	<div class="tsearchArea">
		<p id="PagePermissionManager_ListMessage"><c:out value='${resultMessage}'/></p>
	</div>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="PagePermissionManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aPagePermissionManager.getPageMultiChooser().doShow(aPagePermissionManager.setPageMultiChooserCallback)" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
			<a href="javascript:aPagePermissionManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
	<!-- PagePermissionManager_EditFormPanel -->
	<div id="PagePermissionManager_EditFormPanel" class="board" > 
		<!-- PagePermissionManager_propertyTabs -->
		<div id="PagePermissionManager_propertyTabs">
			<ul>
				<li><a href="#PagePermissionManager_DetailTabPage"><util:message key='ev.title.security.detailTab'/></a></li>   
			</ul>
			<!-- PagePermissionManager_DetailTabPage -->
			<div id="PagePermissionManager_DetailTabPage">
				<form id="PagePermissionManager_EditForm" style="display:inline" action="" method="post">
					<input type="hidden" id="PagePermissionManager_isCreate">
					<input type="hidden" id="PagePermissionManager_permissionId" name="permissionId" />
					<input type="hidden" id="PagePermissionManager_principalId" name="principalId" />
					<input type="hidden" id="PagePermissionManager_title" name="title" />
					<input type='hidden' id='PagePermissionManager_domainId' name='domainId' />
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<caption>게시판</caption>
						<colgroup>
							<col width="140px" />
							<col width="*" />
							<col width="140px" />
							<col width="*" />
						</colgroup>					
						<tr>
							<th class="L"><util:message key='ev.prop.securityPermission.resType'/></th>
							<td class="L">
								<div class="sel_100">
									<select id='PagePermissionManager_resType' name='resType' class='txt_100'>
										<option value="0">Page</option>
										<!--option value="1">Page Pattern</option-->
									</select>
								</div>
							</td>
							<th class="L"><util:message key='ev.prop.securityPermission.isAllow'/></th>
							<td class="L"><input type="checkbox" id="PagePermissionManager_isAllow" name="isAllow" value="" class="txt_100" /></td>
						</tr>
						<tr>
							<th class="L"><util:message key='ev.prop.securityPermission.resUrl'/></th>
							<td colspan="3" class="L">
								<input type="text" id="PagePermissionManager_resUrl" name="resUrl" value="" maxLength="250" class="txt_100" style="width:99%;" label="<util:message key='ev.prop.securityPermission.resUrl'/>"/>
								<!--span class="btn_pack small"><a href="javascript:aPagePermissionManager.getPageMultiChooser().doShow(aPagePermissionManager.setMultipagePageChooserCallback)"><util:message key='ev.title.selectPage'/></a></span-->
							</td>
						</tr>
						<tr>
							<th class="L"><util:message key='ev.prop.securityPermission.actionMask'/> <input id="PagePermissionManager_actionMask_check" type="checkbox" onclick="aPagePermissionManager.toggleAllPermission()"/></th>
							<td colspan="3" class="L">
								<input type="hidden" id="PagePermissionManager_actionMask" name="actionMask" value="" maxLength="" />
								<c:forEach items="${authorityCategory}" var="authority">
									<input type="checkbox" id="PagePermissionManager_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>" class="webradiogroup"><c:out value="${authority.codeName}"/> &nbsp;&nbsp;
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th class="L"><util:message key='ev.prop.securityPermission.creationDate'/></th>
							<td class="L"><input type="text" id="PagePermissionManager_creationDate" name="creationDate" value="" class="txt_145" /></td>
							<th class="L"><util:message key='ev.prop.securityPermission.modifiedDate'/></th>
							<td class="L"><input type="text" id="PagePermissionManager_modifiedDate" name="modifiedDate" value="" class="txt_145" /></td>
						</tr>
					</table>
				</form>
				<!-- btnArea-->
				<div class="btnArea">
					<div class="rightArea">
						<a href="javascript:aPagePermissionManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
					</div>
				</div>
				<!-- btnArea//-->				
			</div>
			<!-- PagePermissionManager_DetailTabPage// -->
		</div>
		<!-- PagePermissionManager_propertyTabs// -->
	</div>
	<!-- PagePermissionManager_EditFormPanel// -->
</div>
<!-- PagePermissionManager_PagePermissionTabPage// -->

<div id="PageManager_PageMultiChooser" title="Page Chooser" style="display:none;"></div>
<div id="PageManager_MultiplePageChooser" style="display:none;">
	<div id="MultiplePageChooser_TreeTabPage" style="width:100%; height:200px; overflow:auto;"></div>
	<form id="PageManager_MultiplePageChooser_EditForm" style="display:inline" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<!--tr>
				<th class="L">
					<util:message key='pt.ev.property.page.path'/>
				</th>
				<td class="L">
					<input type="text" id="MultiplePageChooser_path" value="" maxLength="120" onblur="return userManager.doCheckAsciiCode(this);" style="IME-MODE:disabled;width:100%;" class="txt_100">
				</td>
			</tr-->
			<tr id="PageChooser.AllowPane">
				<th class="L"><util:message key='ev.title.security.checkType'/></th>
				<td class="L">
					<input type="radio" id="MultiplePageChooser_allow" name="perm_allowed" checked value="1"><util:message key='ev.prop.securityPermission.isAllow'/> &nbsp;&nbsp;
					<input type="radio" id="MultiplePageChooser_deny" name="perm_allowed" value="0"><util:message key='ev.title.security.deny'/> &nbsp;&nbsp;
				</td>
			</tr>
			<tr id="PageChooser.Permission">
				<th class="L">
					<util:message key='pt.ev.property.page.authority'/>
					<input type="checkbox" align="right" onclick="aPagePermissionManager.m_checkBox.chkAll(this)"/>
				</th>
				<td class="L" colspan="3">
					<c:forEach items="${authorityCategory}" var="authority">
						<input type="checkbox" id="MultiplePageChooser_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>" ><c:out value="${authority.codeName}"/> &nbsp;&nbsp;
					</c:forEach>
				</td>
			</tr>
		</table>
	</form>
</div>
