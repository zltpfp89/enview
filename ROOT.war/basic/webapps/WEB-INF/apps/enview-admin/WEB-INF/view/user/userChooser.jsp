
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userManager.js"></script>

<!-- contents -->
<div class="contents" style="min-height: 200px;">
	<!-- board first -->
	<div class="board first">
		<!-- searchArea-->
		<div class="tsearchArea">
			<p style="background: none; width: 0px;"></p>
			<fieldset>
				<form id="UserChooser_SearchForm" name="UserChooser_SearchForm" style="display:inline" action="javascript:aUserChooser.doSearch('UserChooser_SearchForm')" method="post">
					<input type='hidden' name='sortMethod' value='ASC'/>                    
					<input type='hidden' name='sortColumn' value=''/>  
					<input type='hidden' name='pageNo' value='1'/>
					<!--input type='hidden' name='pageSize' value='10'/-->
					<input type='hidden' name='pageFunction' value='aUserChooser.doPage'/>
					<input type='hidden' name='formName' value='UserChooser_SearchForm'/>
					
					<input type="text" name="shortPathCond" size="15" class="txt_100" value="*<util:message key='ev.prop.securityPrincipal.shortPath'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPrincipal.shortPath'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPrincipal.shortPath'/>*');"/> 
								
					<input type="text" name="principalNameCond" size="20" class="txt_100" value="*<util:message key='ev.prop.securityPrincipal.principalName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.securityPrincipal.principalName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.securityPrincipal.principalName'/>*');"/> 
									
					<div class="sel_70">				
						<select name='pageSize' class="txt_70">
							<option value="5">5</option>
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="50">50</option>
							<option value="100">100</option>
						</select>
					</div>
					<a href="javascript:aUserChooser.doSearch('UserChooser_SearchForm');" class="btn_search"><span><util:message key='ev.title.search'/></span></a>   
				</form>
			</fieldset>
		</div>
		<!-- searchArea// -->				
		<form id="UserChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="30px" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
				</colgroup>
				<thead>
					<tr>
						<th class="first">
							<input type="checkbox" id="delCheck" onclick="aUserChooser.m_checkBox.chkAll(this)"/>
						</th>
						<th class="C"><span class="table_title">No</span></th>
					
						<th class="C" ch="0" onclick="aUserChooser.doSort(this, 'PRINCIPAL_ID');" >
							<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalId'/></span>
						</th>	
						<th class="C" ch="0" onclick="aUserChooser.doSort(this, 'SHORT_PATH');" >
							<span class="table_title"><util:message key='ev.prop.securityPrincipal.shortPath'/></span>
						</th>	
						<th class="C" ch="0" onclick="aUserChooser.doSort(this, 'PRINCIPAL_NAME');" >
							<span class="table_title"><util:message key='ev.prop.securityPrincipal.principalName'/></span>
						</th>	
						<th class="C" ch="0" onclick="aUserChooser.doSort(this, 'MODIFIED_DATE');" >
							<span class="table_title"><util:message key='ev.prop.securityPrincipal.modifiedDate'/></span>
						</th>				
					</tr>
				</thead>
				<tbody id="UserChooser_ListBody"></tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="UserChooser_PAGE_ITERATOR">				
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
		</form>	
	</div>
	<!-- board first// -->
</div>
<!-- contents// -->