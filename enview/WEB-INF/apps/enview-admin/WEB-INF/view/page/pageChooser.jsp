
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css"> --%>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>

<!-- contents -->
<div class="contents" style="min-height:300px;">
	<!-- sub_contents -->
	<div class="sub_contents">
		<div class="tree">
			<!-- treewrap -->
			<div class="treewrap resizable">
				<div class="tree_title"><util:message key='ev.title.page.pageTree'/></div>
				<!-- 트리 영역 border로 구분. 지우고 사용해주세요 -->
				<div id="PageMultiChooser_TreeTabPage" class="tree" style="border-right: 0px #ffffff;"></div>
			</div>
			<!-- treewrap// -->
		</div>
		<!-- detail -->
		<div class="detail">
			<!-- board first -->
			<div class="board first">
				<!-- searchArea -->
				<div class="tsearchArea">
					<p id="PageMultiChooser_ListMessage"></p>
					<fieldset style="position: relative;float: right;margin-bottom: 5px;
					">
						<form id="PageMultiChooser_SearchForm" name="PageMultiChooser_SearchForm" style="display:inline" action="javascript:aPageMultiChooser.doSearch('PageMultiChooser_SearchForm')" onkeydown="if(event.keyCode==13) aPageMultiChooser.doSearch('PageMultiChooser_SearchForm')" method="post">
							<input type='hidden' name='sortMethod' value='ASC'/>                    
							<input type='hidden' name='sortColumn' value=''/>  
							<input type='hidden' name='pageNo' value='1'/>
							<!--input type='hidden' name='pageSize' value='10'/-->
							<input type='hidden' name='pageFunction' value='aPageMultiChooser.doPage'/>
							<input type='hidden' name='formName' value='PageMultiChooser_SearchForm'/>
						 	<input type='hidden' id='PageMultiChooser_Master_domainId' name='domainId'/>
							<input type='hidden' id='PageMultiChooser_Master_parentId' name='parentId' value=''/>
						  	<input type="text" name="pathCond" size="" class="txt_100" value="*<util:message key='ev.prop.page.path'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.page.path'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.page.path'/>*');"/> 
											
							<div class="sel_70">
								<select name='pageSize' class="txt_70">
									<option value="5" selected>5</option>
									<option value="10">10</option>
									<option value="20" >20</option>
									<option value="50">50</option>
									<option value="100">100</option>
								</select>
							</div>
							<a href="javascript:aPageMultiChooser.doSearch('PageMultiChooser_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
							<!--input type="image" src="<%=request.getContextPath()%>/admin/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand" -->
						</form>					
					</fieldset>
				</div>				
				<!-- searchArea// -->
				<form id="PageMultiChooser_ListForm" style="display:inline" name="PageMultiChooser_ListForm" action="" method="post">
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<caption>게시판</caption>
						<colgroup>
							<col width="30px" />
							<col width="30px" />
							<col width="*" />
							<col width="*" />
						</colgroup>
						<thead>
							<tr style="cursor: pointer;">
								<th class="first">
									<input type="checkbox" id="delCheck" onclick="aPageMultiChooser.m_checkBox.chkAll(this)"/>
								</th>
								<th class="C"><span class="table_title">No</span></th>
								
								<th class="C" ch="0" onclick="aPageMultiChooser.doSort(this, 'PATH');" >
									<span class="table_title"><util:message key='ev.prop.page.path'/></span>
								</th>	
								<th class="C" ch="0" onclick="aPageMultiChooser.doSort(this, 'SHORT_TITLE');" >
									<span class="table_title"><util:message key='ev.prop.page.title'/></span>
								</th>	
							</tr>
						</thead>
						<tbody id="PageMultiChooser_ListBody">
						</tbody>
					</table>
					<!-- tcontrol-->
					<div class="tcontrol">
						<!-- paging -->
						<div class="paging" id="PageMultiChooser_PAGE_ITERATOR">
						</div>
						<!-- paging//-->
					</div>
					<!-- tcontrol//-->				
				</form>
				<form id="PageMultiChooser_EditForm" style="display:inline" action="" method="post">
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<caption>게시판</caption>
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>				
						<tr>
							<th class="L"><util:message key='ev.prop.page.path'/></th>
							<td class="L">
								<input type="text" id="aPageMultiChooser_path" value="" maxLength="120" style="IME-MODE:disabled;width:100%;" class="txt_100">
							</td>
						</tr>
						<tr id="PageMultiChooser_AllowPane">
							<th class="L"><util:message key='ev.title.page.checkType'/></th>
							<td class="L">
								<input type="radio" id="PageMultiChooser_allow" name="perm_allowed" checked value="1" class="webradiogroup"><util:message key='ev.title.page.allow'/> &nbsp;&nbsp;
								<input type="radio" id="PageMultiChooser_deny" name="perm_allowed" value="0" class="webradiogroup"><util:message key='ev.title.page.deny'/> &nbsp;&nbsp;
							</td>
						</tr>
						<tr id="PageMultiChooser_Permission">
							<th class="L"><util:message key='ev.title.page.authority'/><input type="checkbox" onclick="aPageMultiChooser.m_checkBox.chkAll(this)"/></th>
							<td class="L">
								<div>
									<c:forEach items="${authorityCategory}" var="authority">
										<input type="checkbox" id="PageMultiChooser_authority_<c:out value="${authority.code}"/>" value="<c:out value="${authority.code}"/>"><c:out value="${authority.codeName}"/> &nbsp;&nbsp;
									</c:forEach>
								</div>
							</td>
						</tr>
					</table>
				</form>					
			</div>
			<!-- board first// -->
		</div>
		<!-- detail// -->
	</div>
	<!-- sub_contents// -->
</div>
<!-- contents// -->

