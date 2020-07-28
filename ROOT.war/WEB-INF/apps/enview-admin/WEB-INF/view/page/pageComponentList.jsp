
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageComponentManager.js"></script>


<!-- board -->
<div class="board">
	<div id="PageComponentManager_PageComponentTabPage">
		<!-- tsearchArea -->
		<div class="tsearchArea">
			<p id="PageComponentManager_ListMessage"></p>
			<fieldset>
				<form id="PageComponentManager_SearchForm" name="PageComponentManager_SearchForm" style="display:inline" action="javascript:aPageComponentManager.doSearch('PageComponentManager_SearchForm')" method="post">
					<input type='hidden' name='sortMethod' value='ASC'/>                    
					<input type='hidden' name='sortColumn' value=''/>  
					<input type='hidden' name='pageNo' value='1'/>
					<!--input type='hidden' name='pageSize' value='10'/-->
					<input type='hidden' name='pageFunction' value='aPageComponentManager.doPage'/>
					<input type='hidden' name='formName' value='PageComponentManager_SearchForm'/>
					<input type='hidden' id='PageComponentManager_Master_pageId' name='pageId' value=''/>
				  	<div class="sel_70">
						<select name='pageSize' class="txt_70">
							<option value="5">5</option>
							<option value="10" selected>10</option>
							<option value="20" >20</option>
							<option value="50">50</option>
							<option value="100">100</option>
						</select>
					</div>
					<a href="javascript:aPageComponentManager.doSearch('PageComponentManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>  
				</form>
			</fieldset>
		</div>
		<form id="PageComponentManager_ListForm" style="display:inline" name="PageComponentManager_ListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">		
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="30px" />
					<col width="200px" />
					<col width="200px" />
					<col width="*" />
				</colgroup>				
				<thead>
					<tr>
						<th class="C">
							<input type="checkbox" id="delCheck" onclick="aPageComponentManager.m_checkBox.chkAll(this)"/>
						</th>
						<th class="C"><span class="table_title">No</span></th>
					
						<th class="C" ch="0" onclick="aPageComponentManager.doSort(this, 'PAGE_COMPONENT_ID');" >
							<span class="table_title"><util:message key='ev.prop.pageComponent.region'/></span>
						</th>	
						<th class="C" ch="0" onclick="aPageComponentManager.doSort(this, 'PORTLET_NAME');" >
							<span class="table_title"><util:message key='ev.prop.pageComponent.portletName'/></span>
						</th>	
						<th class="C" ch="0" onclick="aPageComponentManager.doSort(this, 'ELEMENT_ORDER');" >
							<span class="table_title"><util:message key='ev.prop.pageComponent.elementOrder'/></span>
						</th>		
					</tr>
				</thead>
				<tbody id="PageComponentManager_ListBody">		
					<c:forEach items="${results}" var="pagecomponent" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;">
							<td class="C">
								<input type="checkbox" id="PageComponentManager[<c:out value="${status.index}"/>].checkRow" />
								<input type="hidden" id="PageComponentManager[<c:out value="${status.index}"/>].pageComponentId" value="<c:out value='${pagecomponent.pageComponentId}'/>"/>
							</td>
							<td class="C">
								<c:out value="${status.index}"/>
							</td>
							
							<td class="L" onclick="aPageComponentManager.doSelect(this)">
								<span id="PageComponentManager[<c:out value="${status.index}"/>].pageComponentId.label">&nbsp;<c:out value="${pagecomponent.pageComponentId}"/></span>
							</td>
							<td class="L" onclick="aPageComponentManager.doSelect(this)">
								<span id="PageComponentManager[<c:out value="${status.index}"/>].portletName.label">&nbsp;<c:out value="${pagecomponent.portletName}"/></span>
							</td>
							<td class="L" onclick="aPageComponentManager.doSelect(this)">
								<span id="PageComponentManager[<c:out value="${status.index}"/>].elementOrder.label">&nbsp;<c:out value="${pagecomponent.elementOrder}"/></span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
		<!-- tcontrol -->
		<div class="tcontrol">
			<!-- paging -->
			<div id="PageComponentManager_PAGE_ITERATOR" class="paging">
				<c:out escapeXml='false' value='${pageIterator}'/>
		    </div>
		    <!-- paging// -->
		</div>   
		<!-- tcontrol// -->
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
				<a href="javascript:aPageComponentManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
				<a href="javascript:aPageComponentManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</div>
</div>
<!-- board// -->

<div id="PageComponentManager_EditFormPanel" class="webformpanel" >  
	<div id="PageComponentManager_propertyTabs">
		<ul>
			<li><a href="#PageComponentManager_DetailTabPage"><util:message key='ev.title.page.detailTab'/></a></li>   
		</ul>
		<div id="PageComponentManager_DetailTabPage">
			<%@include file="pageComponentDetail.jsp"%>
		</div>	
	</div>
</div>

<div id="PortletSelectorPermissionAppDialog" title="<util:message key='ev.title.security.portletSelectorName'/>" style="display:none;" class="contents">
	<form id='PortletSelectorPermissionAppSearchForm' name='PortletSelectorPermissionAppSearchForm' style='display:inline' action="javascript:portalPortletSelectorPermissionApp.doPortletSearch('PortletSelectorPermissionAppSearchForm')" onkeydown="if(event.keyCode==13) portalPortletSelectorPermissionApp.doPortletSearch('PortletSelectorPermissionAppSearchForm')" method='post'>
		<input type='hidden' name='sortMethod' value='ASC'/>
		<input type='hidden' name='sortColumn' value=''/>
		<input type='hidden' name='pageNo' value='1'/>
		<!--input type='hidden' name='pageSize' value='7'/--> 
		<input type='hidden' name='pageFunction' value='portalPortletSelectorPermissionApp.doPortletPage'/>
		<input type='hidden' name='formName' value='PortletSelectorPermissionAppSearchForm'/>
		<input type='hidden' id='PortletSelectorPermissionApp_categoryId' name='categoryId' >
		<input type='hidden' id='PortletSelectorPermissionApp_categoryType' name='categoryType'  value='portlet'>
		<div class="tsearchArea" style="float:right;margin:5px; ">
		<div class="sel_100">
			<select id="PortletSelectorPermissionApp__portletCategory" name="portletCategory" class='txt_100'>
				<option value=""><util:message key='ev.title.security.portletCategoryTree'/></option> 
				<c:forEach items="${portletCategory}" var="category">
					<option value="<c:out value="${category}"/>"><c:out value="${category}"/></option>
				</c:forEach>
			</select>
		</div>
		<input type='text' name='title0Cond' size='20' class='txt_100' value="*<util:message key='ev.title.security.portletSelectorPortletName'/>*" onfocus="portalPage.getUtility().setFieldFocus(this,'*<util:message key='ev.title.security.portletSelectorPortletName'/>*');" onblur="portalPage.getUtility().setFieldBlur(this,'*<util:message key='ev.title.security.portletSelectorPortletName'/>*');" style="height:28px">
		<div class="sel_70">
			<select name='pageSize' class="txt_70">
				<option value="5" selected>5</option>
				<option value="10" >10</option>
				<option value="20" >20</option>
				<option value="50">50</option>
				<option value="100">100</option>
			</select>
		</div>
		<a href="javascript:portalPortletSelectorPermissionApp.doPortletSearch('PortletSelectorPermissionAppSearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></</span></a>
		</div>
	</form>
	<form id='PortletSelectorPermissionAppListForm' style='display:inline' name='PortletSelectorPermissionAppListForm' action='' method='post'>
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board" style="width:99%">
			<caption>게시판</caption>
			<colgroup>
				<col width="30px" />
				<col width="30px" />
				<col width="90%" />
			</colgroup>			
			<thead>
				<tr>
					<th class="first">
						<input type="checkbox" id="delCheck" onclick="portalPortletSelectorPermissionApp.m_checkBox.chkAll(this)"/>
					</th>
					<th></th>
					<th ch='0' class='C' onclick="portalPortletSelectorPermissionApp.doPortletSort(this, 'DISPLAY_NAME');" >
						<span class="table_title"><util:message key='ev.title.security.portletSelectorPortletName'/></span>
					</th>
				</tr>
			</thead>
			<tbody id='PortletSelectorPermissionAppListBody'></tbody>
		</table>
		<!-- tcontrol-->
		<div class="tcontrol">						
			<!-- paging -->
			<div id="PORTLETSELECTOR_PAGE_ITERATOR" class="paging">
			</div>
			<!-- paging//-->
		</div>
		<!-- tcontrol//-->
	</form>
	<form id="PortletSelectorPermissionChooser_EditForm" style="display:none" action="" method="post">123412341243
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<tr id="PortletSelectorPermission.AllowPane">
				<th class="L"><util:message key='ev.title.security.checkType'/></th>
				<td class="L">
					<input type="radio" id="PortletSelectorPermission_allow" name="perm_allowed" checked value="1" class="webradiogroup"><util:message key='ev.title.security.allow'/> &nbsp;&nbsp;
					<input type="radio" id="PortletSelectorPermission_deny" name="perm_allowed" value="0" class="webradiogroup"><util:message key='ev.title.security.deny'/> &nbsp;&nbsp;
				</td>
			</tr>
			<tr id="PortletSelectorPermission.Permission">
				<th class="L">
					<util:message key='ev.title.security.page.authority'/>
					<input type="checkbox" align="right" onclick="aPortletPermissionManager.m_checkBox.chkAll(this)"/>
				</th>
				<td>
					<div>
						<c:forEach items="${authorityCategory}" var="authority">
							<div>
							<input type="checkbox" id="PortletSelectorPermission_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>" class="webradiogroup"><c:out value="${authority.codeName}"/> &nbsp;&nbsp;
							</div>
						</c:forEach>
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>