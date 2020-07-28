
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainLangManager.js"></script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div id="DomainLangManager_DomainLangTabPage" class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="DomainLangManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="DomainLangManager_SearchForm" name="DomainLangManager_SearchForm" style="display:inline" action="javascript:aDomainLangManager.doSearch('DomainLangManager_SearchForm')" onkeydown="if(event.keyCode==13) aDomainLangManager.doSearch('DomainLangManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aDomainLangManager.doPage'/>
						<input type='hidden' name='formName' value='DomainLangManager_SearchForm'/>
						<input type='hidden' id='DomainLangManager_Master_domainId' name='domainId' value=''/>
							<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							</div>
							<a href="javascript:aDomainLangManager.doSearch('DomainLangManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
					</form>
				</fieldset>
			</div>
			<!-- searchArea// -->
			<form id="DomainLangManager_ListForm" style="display:inline" name="DomainLangManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" class="table_board">
				<caption>게시판</caption>
					<colgroup>
						<col width="40px" />
						<col width="40px" />
						<col width="80px" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aDomainLangManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							<%-- <th class="C" ch="0" onclick="aDomainLangManager.doSort(this, 'DOMAIN_ID');" >
								<span ><util:message key='mm.prop.domainLang.domainId'/></span>
							</th> --%>
							<th class="C" ch="0" onclick="aDomainLangManager.doSort(this, 'LANG_KND');" >
								<span class="table_title"><util:message key='mm.prop.domainLang.langKnd'/></span>
							</th>		
							<th class="C" ch="0" onclick="aDomainLangManager.doSort(this, 'DOMAIN_NM');" >
								<span class="table_title"><util:message key='mm.prop.domainLang.domainNm'/></span>
							</th>		
						</tr>				
					</thead>
					<tbody id="DomainLangManager_ListBody">
						<c:forEach items="${results}" var="domainlang" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="{$status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<input type="checkbox" id="DomainLangManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
								
									<input type="hidden" id="DomainLangManager[<c:out value="${status.index}"/>].domainId" value="<c:out value='${domainlang.domainId}'/>"/>
									<input type="hidden" id="DomainLangManager[<c:out value="${status.index}"/>].langKnd" value="<c:out value='${domainlang.langKnd}'/>"/>
								</td>
								<td class="C">
									<span><c:out value="${status.index}"/></span>
								</td>
								<%-- <td class="L" onclick="aDomainLangManager.doSelect(this)">
									<span class="webgridrowlabel" id="DomainLangManager[<c:out value="${status.index}"/>].domainId.label">&nbsp;<c:out value="${domainlang.domainId}"/></span>
								</td> --%>
								<td class="L" onclick="aDomainLangManager.doSelect(this)">
									<span class="webgridrowlabel" id="DomainLangManager[<c:out value="${status.index}"/>].langKnd.label">&nbsp;<c:out value="${domainlang.langKnd}"/></span>
								</td>
								<td class="L" onclick="aDomainLangManager.doSelect(this)">
									<span class="webgridrowlabel" id="DomainLangManager[<c:out value="${status.index}"/>].domainNm.label">&nbsp;<c:out value="${domainlang.domainNm}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>						
				</table>
			</form>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="DomainLangManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aDomainLangManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aDomainLangManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->	
		<!-- DomainLangManager_EditFormPanel -->
		<div id="DomainLangManager_EditFormPanel" class="board" >
			<div id="DomainLangManager_propertyTabs">
				<ul>
					<li><a href="#DomainLangManager_DetailTabPage"><util:message key='ev.title.detailTab'/></a></li>   			
				</ul>
				<div id="DomainLangManager_DetailTabPage">
					<%@include file="domainLangDetail.jsp"%>
				</div>
			</div>		 
		</div>
		<!-- DomainLangManager_EditFormPanel// -->			
	</div>
	<!-- detail// -->
</div>
<!-- sub_contetns// -->
