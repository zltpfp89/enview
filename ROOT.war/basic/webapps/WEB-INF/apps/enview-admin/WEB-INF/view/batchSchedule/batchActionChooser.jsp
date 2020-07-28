<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchActionManager.js"></script>

<!-- board -->
<div id="BatchActionChooser_ListTabPage" class="board first" >
	<!-- tab_list -->
	<div class="tab_list">
		<!-- searchArea-->
		<div class="tsearchArea">
			<p id="CodebaseManager_ListMessage"><c:out value='${resultMessage}'/></p>
			<fieldset>	
				<form id="BatchActionChooser_SearchForm" name="BatchActionChooser_SearchForm" style="display:inline" action="javascript:aBatchActionChooser.doSearch('BatchActionChooser_SearchForm')" method="post">
					<input type='hidden' name='sortMethod' value='ASC'/>                    
					<input type='hidden' name='sortColumn' value=''/>  
					<input type='hidden' name='pageNo' value='1'/>
					<!--input type='hidden' name='pageSize' value='10'/-->
					<input type='hidden' name='pageFunction' value='aBatchActionChooser.doPage'/>
					<input type='hidden' name='formName' value='BatchActionChooser_SearchForm'/>

					<input type="text" name="nameCond" size="30" class="txt_100" value="*<util:message key='ev.prop.batchAction.name'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchAction.name'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchAction.name'/>*');"/> 
					<div class="sel_70">
						<select name='pageSize' class="txt_70">
							<option value="5">5</option>
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="50">50</option>
							<option value="100">100</option>
						</select>
					</div>
					<input type="image" src="<%=request.getContextPath()%>/admin/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand">
				</form>
			</fieldset>
		</div>
		<!-- searchArea//-->
		<!-- BatchActionChooser_ListForm -->
		<form id="BatchActionChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<colgroup>
					<col width="40px" />
					<col width="40px" />
					<col width="100px" />
					<col width="*" />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
				<thead>
					<tr>
						<th class="C">
							<input type="checkbox" id="delCheck" onclick="aBatchActionChooser.m_checkBox.chkAll(this)"/>
						</th>
						<th class="C">No</th>
					
						<th class="C" ch="0" onclick="aBatchActionChooser.doSort(this, 'ACTION_ID');" >
							<span class="table_title"><util:message key='ev.prop.batchAction.actionId'/></span>
						</th>	
						<th class="C" ch="0" onclick="aBatchActionChooser.doSort(this, 'NAME');" >
							<span class="table_title"><util:message key='ev.prop.batchAction.name'/></span>
						</th>	
						<th class="C" ch="0" onclick="aBatchActionChooser.doSort(this, 'UPD_USER_ID');" >
							<span class="table_title"><util:message key='ev.prop.batchAction.updUserId'/></span>
						</th>	
						<th class="C" ch="0" onclick="aBatchActionChooser.doSort(this, 'UPD_DATIM');" >
							<span class="table_title"><util:message key='ev.prop.batchAction.updDatim'/></span>
						</th>				
					</tr>
				</thead>
				<tbody id="BatchActionChooser_ListBody"></tbody>				
			</table>			
		</form>
		<!-- BatchActionChooser_ListForm// -->
		<div class="tsearchArea">
			<p id="BatchActionChooser_ListMessage"><c:out value='${resultMessage}'/></p>
		</div>
		<!-- tcontrol-->
		<div class="tcontrol">
			<!-- paging -->
			<div id="BatchActionChooser_PAGE_ITERATOR" class="paging">
				<c:out escapeXml='false' value='${pageIterator}'/>
			</div>
			<!-- paging//-->
		</div>
		<!-- tcontrol//-->		
	</div>
	<!-- tab_list// -->
</div>
<!-- board// -->