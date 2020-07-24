
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageMetadataManager.js"></script>

<!-- board -->
<div class="board">
	<div id="PageMetadataManager_PageMetadataTabPage">
		<!-- tsearchArea -->
		<div class="tsearchArea">
			<p id="PageMetadataManager_ListMessage"><c:out value='${resultMessage}'/></p>
			<fieldset>
				<form id="PageMetadataManager_SearchForm" name="PageMetadataManager_SearchForm" style="display:inline" action="javascript:aPageMetadataManager.doSearch('PageMetadataManager_SearchForm')" method="post">
					<input type='hidden' name='sortMethod' value='ASC'/>                    
					<input type='hidden' name='sortColumn' value=''/>  
					<input type='hidden' name='pageNo' value='1'/>
					<!--input type='hidden' name='pageSize' value='10'/-->
					<input type='hidden' name='pageFunction' value='aPageMetadataManager.doPage'/>
					<input type='hidden' name='formName' value='PageMetadataManager_SearchForm'/>
				 	<input type='hidden' id='PageMetadataManager_Master_pageId' name='pageId' value=''/>
					<div class="sel_70">
						<select name='pageSize' class="txt_70">
							<option value="5">5</option>
							<option value="10" selected>10</option>
							<option value="20" >20</option>
							<option value="50">50</option>
							<option value="100">100</option>
						</select>
					</div>
					<a href="javascript:aPageMetadataManager.doSearch('PageMetadataManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
				</form>
			</fieldset>
		</div>
		<!-- tsearchArea// -->
		<form id="PageMetadataManager_ListForm" style="display:inline" name="PageMetadataManager_ListForm" action="" method="post">
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
						<th class="first" >
							<input type="checkbox" id="delCheck" onclick="aPageMetadataManager.m_checkBox.chkAll(this)"/>
						</th>
						<th class="C" ><span class="table_title">No</span></th>
					
						<th class="C" ch="0" onclick="aPageMetadataManager.doSort(this, 'LOCALE');" >
							<span class="table_title"><util:message key='ev.prop.pageMetadata.locale'/></span>
						</th>		
						<th class="C" ch="0" onclick="aPageMetadataManager.doSort(this, 'NAME');" >
							<span class="table_title"><util:message key='ev.prop.pageMetadata.name'/></span>
						</th>	
						<th class="C" ch="0" onclick="aPageMetadataManager.doSort(this, 'VALUE');" >
							<span class="table_title"><util:message key='ev.prop.pageMetadata.value'/></span>
						</th>	
					</tr>
				</thead>
				<tbody id="PageMetadataManager_ListBody">
					<c:forEach items="${results}" var="pagemetadata" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" >
							<td class="C">
								<input type="checkbox" id="PageMetadataManager[<c:out value="${status.index}"/>].checkRow" />
								<input type="hidden" id="PageMetadataManager[<c:out value="${status.index}"/>].metadataId" value="<c:out value='${pagemetadata.metadataId}'/>"/>
							</td>
							<td class="C">
								<c:out value="${status.index}"/>
							</td>
							<td class="C" id="PageMetadataManager[<c:out value="${status.index}"/>].locale.label" class="L" onclick="aPageMetadataManager.doSelect(this)">
								<c:out value="${pagemetadata.locale}"/>
							</td>
							<td class="C" id="PageMetadataManager[<c:out value="${status.index}"/>].name.label" class="L" onclick="aPageMetadataManager.doSelect(this)">
								<c:out value="${pagemetadata.name}"/>
							</td>
							<td class="C" id="PageMetadataManager[<c:out value="${status.index}"/>].value.label" class="L" onclick="aPageMetadataManager.doSelect(this)">
								<c:out value="${pagemetadata.value}"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
		<!-- tcontrol -->
		<div class="tcontrol">
			<!-- paging -->
			<div id="PageMetadataManager_PAGE_ITERATOR" class="paging">
				<c:out escapeXml='false' value='${pageIterator}'/>
		    </div>
		    <!-- paging// -->
		</div>   
		<!-- tcontrol// -->
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
				<a href="javascript:aPageMetadataManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
				<a href="javascript:aPageMetadataManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</div>
</div>
<!-- board// -->

<div id="PageMetadataManager_EditFormPanel" class="board" >  
	<div id="PageMetadataManager_propertyTabs">
		<ul>
			<li><a href="#PageMetadataManager_DetailTabPage"><util:message key='ev.title.page.detailTab'/></a></li>   
		</ul>
		<div id="PageMetadataManager_DetailTabPage">
			<%@include file="pageMetadataDetail.jsp"%>
		</div>
	</div>
</div>