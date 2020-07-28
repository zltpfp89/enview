
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/totalPagePermissionManager.js"></script>


<!-- TotalPagePermissionManager_TotalPagePermissionTabPage -->
<div id="TotalPagePermissionManager_TotalPagePermissionTabPage">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="TotalPagePermissionManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="TotalPagePermissionManager_SearchForm" name="TotalPagePermissionManager_SearchForm" style="display:inline" action="javascript:aTotalPagePermissionManager.doSearch('TotalPagePermissionManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aTotalPagePermissionManager.doPage'/>
				<input type='hidden' name='formName' value='TotalPagePermissionManager_SearchForm'/>
			 
				<input type='hidden' id='TotalPagePermissionManager_Master_principalId' name='principalId' value=''/>
				
				<div class="sel_70">
					<select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="20" >20</option>
						<option value="50">50</option>
						<option value="100">100</option>
					</select> 
				</div>
				<a href="javascript:aTotalPagePermissionManager.doSearch('TotalPagePermissionManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
			</form>		
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="TotalPagePermissionManager_ListForm" style="display:inline" name="TotalPagePermissionManager_ListForm" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="30px" />
				<col width="50px" />
				<col width="*" />
				<col width="*" />
			</colgroup>			
			<thead>
				<tr>
					<th class="first">
						<input type="checkbox" id="delCheck" onclick="aTotalPagePermissionManager.m_checkBox.chkAll(this)"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
					
					<th class="C" ch="0" onclick="aTotalPagePermissionManager.doSort(this, 'TITLE');" width="200px">
						<span class="table_title"><util:message key='ev.prop.pageStatisics.title'/></span>
					</th>	
					<th class="C" ch="0" onclick="aTotalPagePermissionManager.doSort(this, 'PATH');" >
						<span class="table_title"><util:message key='ev.prop.pageStatisics.path'/></span>
					</th>		
				</tr>
			</thead>
			<tbody id="TotalPagePermissionManager_ListBody">
				<c:forEach items="${results}" var="totalpagepermission" varStatus="status">
					<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;">
						<td class="C">
							<input type="checkbox" id="TotalPagePermissionManager[<c:out value="${status.index}"/>].checkRow" />
						
							<input type="hidden" id="TotalPagePermissionManager[<c:out value="${status.index}"/>].path" value="<c:out value='${totalpagepermission.path}'/>"/>
						</td>
						<td class="C">
							<c:out value="${status.index}"/>
						</td>
						<td class="L" onclick="aTotalPagePermissionManager.doSelect(this)">
							<span id="TotalPagePermissionManager[<c:out value="${status.index}"/>].title.label">&nbsp;<c:out value="${totalpagepermission.title}"/></span>
						</td>
						<td class="L" onclick="aTotalPagePermissionManager.doSelect(this)">
							<span id="TotalPagePermissionManager[<c:out value="${status.index}"/>].path.label">&nbsp;<c:out value="${totalpagepermission.path}"/></span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	 </form>
	 <div class="tsearchArea">
		<p id="TotalPagePermissionManager_ListMessage"><c:out value='${resultMessage}'/></p>
	</div>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="TotalPagePermissionManager_PAGE_ITERATOR" class="paging">
			<c:out escapeXml='false' value='${pageIterator}'/>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->	 
</div>
<!-- TotalPagePermissionManager_TotalPagePermissionTabPage// -->

<div id="TotalPagePermissionManager_TotalPagePermissionChooser"></div>