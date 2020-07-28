
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/codebaseManager.js"></script>

<script type="text/javascript">

var userDomainId = '<c:out value="${userDomainId}"/>';
var isAdmin = <c:out value="${isAdmin}"/>;


function initCodebaseManager() {
	if( aCodebaseManager == null ) {
		aCodebaseManager = new CodebaseManager("<c:out value="${evSecurityCode}"/>");
		aCodebaseManager.init();
		aCodebaseManager.doDefaultSelect();
	}
}
function finishCodebaseManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initCodebaseManager );
	window.attachEvent ( "onunload", finishCodebaseManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initCodebaseManager, false );
	window.addEventListener ( "unload", finishCodebaseManager, false );
}
else
{
    window.onload = initCodebaseManager;
	window.onunload = finishCodebaseManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="CodebaseManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="CodebaseManager_SearchForm" name="CodebaseManager_SearchForm" style="display:inline" action="javascript:aCodebaseManager.doSearch('CodebaseManager_SearchForm')" onkeydown="if(event.keyCode==13) aCodebaseManager.doSearch('CodebaseManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aCodebaseManager.doPage'/>
						<input type='hidden' name='formName' value='CodebaseManager_SearchForm'/>
						<div class="sel_100">
							<select name="domainIdCond" label="<util:message key='ev.prop.lang.domainId'/>" class='txt_100'>
								<option value="">*<util:message key='ev.prop.lang.domain'/>*</option> 
								<c:forEach items="${domainList}" var="domain">
									<option value="<c:out value="${domain.domainId}"/>"><c:out value="${domain.domainNm}"/></option>
								</c:forEach>
							</select>
						</div>
						<input type="text" name="codeIdCond" size="" class="txt_100" value="*<util:message key='ev.prop.codebase.codeId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.codebase.codeId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.codebase.codeId'/>*');"/> 
						<input type="text" name="codeNameCond" size="" class="txt_100" value="*<util:message key='ev.prop.codebase.codeName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.codebase.codeName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.codebase.codeName'/>*');"/> 
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aCodebaseManager.doSearch('CodebaseManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>  
					</form>
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="CodebaseManager_ListForm" style="display:inline" name="CodebaseManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="100px" />
						<col width="100px" />
						<col width="*" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aCodebaseManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							<th class="C" ch="0" >
								<span class="table_title"><util:message key='ev.prop.codebase.domain'/></span>
							</th>		
							<th class="C" ch="0" onclick="aCodebaseManager.doSort(this, 'SYSTEM_CODE');" >
								<span class="table_title"><util:message key='ev.prop.codebase.systemCode'/></span>
							</th>	
							<th class="C" ch="0" onclick="aCodebaseManager.doSort(this, 'CODE_ID');" >
								<span class="table_title"><util:message key='ev.prop.codebase.codeId'/></span>
							</th>	
							<th class="C" ch="0" onclick="aCodebaseManager.doSort(this, 'CODE');" >
								<span class="table_title"><util:message key='ev.prop.codebase.code'/></span>
							</th>	
							<th class="C" ch="0" onclick="aCodebaseManager.doSort(this, 'CODE_NAME');" >
								<span class="table_title"><util:message key='ev.prop.codebase.codeName'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="CodebaseManager_ListBody">
						<c:forEach items="${results}" var="codebase" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C fixed">
									<input type="checkbox" id="CodebaseManager[<c:out value="${status.index}"/>].checkRow" />
									<input type="hidden" id="CodebaseManager[<c:out value="${status.index}"/>].systemCode" value="<c:out value='${codebase.systemCode}'/>"/>
									<input type="hidden" id="CodebaseManager[<c:out value="${status.index}"/>].codeId" value="<c:out value='${codebase.codeId}'/>"/>
									<input type="hidden" id="CodebaseManager[<c:out value="${status.index}"/>].code" value="<c:out value='${codebase.code}'/>"/>
									<input type="hidden" id="CodebaseManager[<c:out value="${status.index}"/>].langKnd" value="<c:out value='${codebase.langKnd}'/>"/>
									<input type="hidden" id="CodebaseManager[<c:out value="${status.index}"/>].domainId" value="<c:out value='${codebase.domainId}'/>"/>
								</td>
								<td class="C fixed">
									<span><c:out value="${status.index}"/></span>
								</td>
								
								<td class="L" onclick="aCodebaseManager.doSelect(this)">
									<span id="CodebaseManager[<c:out value="${status.index}"/>].domainId.label">&nbsp;<c:out value="${codebase.domainNm}"/></span>
								</td>
								<td class="L" onclick="aCodebaseManager.doSelect(this)">
									<span id="CodebaseManager[<c:out value="${status.index}"/>].systemCode.label">&nbsp;<c:out value="${codebase.systemCode}"/></span>
								</td>
								<td class="L" onclick="aCodebaseManager.doSelect(this)">
									<span id="CodebaseManager[<c:out value="${status.index}"/>].codeId.label">&nbsp;<c:out value="${codebase.codeId}"/></span>
								</td>
								<td class="L" onclick="aCodebaseManager.doSelect(this)">
									<span id="CodebaseManager[<c:out value="${status.index}"/>].code.label">&nbsp;<c:out value="${codebase.code}"/></span>
								</td>
								<td class="L" onclick="aCodebaseManager.doSelect(this)">
									<span id="CodebaseManager[<c:out value="${status.index}"/>].codeName.label">&nbsp;<c:out value="${codebase.codeName}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			<div class="tsearchArea">
				<p id="CodebaseManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="CodebaseManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aCodebaseManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aCodebaseManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first//-->
		<!-- CodebaseManager_EditFormPanel -->
		<div id="CodebaseManager_EditFormPanel" class="board" >
			<!-- CodebaseManager_propertyTabs -->
			<div id="CodebaseManager_propertyTabs">
				<ul>
					<li><a href="#CodebaseManager_DetailTabPage" onclick="aCodebaseManager.onSelectPropertyTab(0)"><util:message key='ev.title.codebase.detailTab'/></a></li>  
					<li><a href="#CodebaseManager_Sub_TabPage" onclick="aCodebaseManager.onSelectPropertyTab(1)"><util:message key='ev.title.codebase.subCodesTab'/></a></li>
				</ul>
				<!-- CodebaseManager_DetailTabPage -->
				<div id="CodebaseManager_DetailTabPage">
					<div>
						<form id="CodebaseManager_Child_SearchForm" name="CodebaseManager_Child_SearchForm" style="display:inline" action="javascript:aCodebaseManager.doChildSearch('CodebaseManager_Child_SearchForm')" method="post">
							<input type='hidden' name='sortMethod' value='ASC'/>                    
							<input type='hidden' name='sortColumn' value=''/>  
							<input type='hidden' name='pageNo' value='1'/>
							<input type='hidden' name='pageSize' value='10'/>
							<input type='hidden' name='pageFunction' value='aCodebaseManager.doChildCodesPage'/>
							<input type='hidden' name='formName' value='CodebaseManager_Child_SearchForm'/>
						</form>
					</div>
					<!-- CodebaseManager_Child_ListForm -->
					<form id="CodebaseManager_Child_ListForm" style="display:inline" name="CodebaseManager_Child_ListForm" action="" method="post">
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="30px" />
								<col width="30px" />
								<col width="100px" />
								<col width="100px" />
								<col width="*" />
								<col width="*" />
								<col width="200px" />
							</colgroup>						
							<thead>
								<tr>
									<th class="first">
										<input type="checkbox" id="delCheck" onclick="aCodebaseManager.m_checkBox.chkAll(this)"/>
									</th>
									<th class="C"><span class="table_title">No</span></th>
									<th class="C" ch="0" >
										<span class="table_title"><util:message key='ev.prop.codebase.domain'/></span>
									</th>		
									<th class="C" ch="0" onclick="aCodebaseManager.doChildSort(this, 'SYSTEM_CODE');" >
										<span class="table_title"><util:message key='ev.prop.codebase.systemCode'/></span>
									</th>	
									<th class="C" ch="0" onclick="aCodebaseManager.doChildSort(this, 'CODE_ID');" >
										<span class="table_title"><util:message key='ev.prop.codebase.codeId'/></span>
									</th>	
									<th class="C" ch="0" onclick="aCodebaseManager.doChildSort(this, 'CODE');" >
										<span class="table_title"><util:message key='ev.prop.codebase.code'/></span>
									</th>	
									<th class="C" ch="0" onclick="aCodebaseManager.doChildSort(this, 'CODE_NAME');" >
										<span class="table_title"><util:message key='ev.prop.codebase.codeName'/></span>
									</th>		
								</tr>
							</thead>
							<tbody id="CodebaseManager_Child_ListBody"> </tbody>
						</table>
						<!-- tcontrol-->
						<div class="tcontrol">						
							<!-- paging -->
							<div id="CodebaseManager_Child_PAGE_ITERATOR" class="paging">
								<c:out escapeXml='false' value='${pageIterator}'/>
							</div>
							<!-- paging//-->
						</div>
						<!-- tcontrol//-->
						<!-- btnArea-->
						<div class="btnArea">
							<div id="CodebaseManager_Child_ListButtons" class="rightArea">
								<a href="javascript:aCodebaseManager.doChildCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
								<a href="javascript:aCodebaseManager.doChildRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>
					<!-- CodebaseManager_Child_ListForm//-->
					<!-- CodebaseManager_Child_EditForm -->
					<form id="CodebaseManager_Child_EditForm" style="display:inline" action="" method="post">
						<input type="hidden" id="CodebaseManager_Child_isCreate">
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판리스트</caption>
							<colgroup>
								<col width="140px" />
								<col width="*" />
								<col width="140px" />
								<col width="*" />
							</colgroup>   									
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.domain'/></td></th>
								<td colspan="3" class="L">
									<div class="sel_100">
										<select id="CodebaseManager_Child_domainId" name="domainId" label="<util:message key='pt.ev.property.domainId'/>" class='txt_100'>
											<c:forEach items="${domainList}" var="domain">
												<option value="<c:out value="${domain.domainId}"/>"><c:out value="${domain.domainNm}"/></option>
											</c:forEach>
										</select>
									</div>								
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.langKnd'/> <em>*</em></th>
								<td class="L">
									<div class="sel_100">
										<select id="CodebaseManager_Child_langKnd" name="langKnd" label="<util:message key='ev.property.langKnd'/>" class='txt_100'>
											<c:forEach items="${langKndList}" var="langKnd">
											<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
								<th class="L"><util:message key='ev.prop.codebase.systemCode'/> <em>*</em></th>
								<td class="L">
									<div class="sel_100">
										<select id="CodebaseManager_Child_systemCode" name="systemCode" label="<util:message key='pt.ev.property.systemCode'/>" class='txt_145'>
											<c:forEach items="${systemCodeList}" var="systemCode">
												<option value="<c:out value="${systemCode.code}"/>"><c:out value="${systemCode.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>								
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.codeId'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Child_codeId" name="codeId" value="" maxLength="20" label="<util:message key='ev.prop.codebase.codeId'/>" class="full_webtextfield" />
								</td>
								<th class="L"><util:message key='ev.prop.codebase.code'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Child_code" name="code" value="" maxLength="20" label="<util:message key='ev.prop.codebase.code'/>" class="full_webtextfield" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.codeName'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Child_codeName" name="codeName" value="" maxLength="20" label="<util:message key='ev.prop.codebase.codeName'/>" class="full_webtextfield" />
								</td>
								<th class="L"><util:message key='ev.prop.codebase.codeName2'/></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Child_codeName2" name="codeName2" value="" maxLength="20" label="<util:message key='ev.prop.codebase.codeName2'/>" class="full_webtextfield" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.codeTag1'/></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Child_codeTag1" name="codeTag1" value="" maxLength="10" label="<util:message key='ev.prop.codebase.codeTag1'/>" class="full_webtextfield" />
								</td>
								<th class="L"><util:message key='ev.prop.codebase.codeTag2'/></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Child_codeTag2" name="codeTag2" value="" maxLength="10" label="<util:message key='ev.prop.codebase.codeTag2'/>" class="full_webtextfield" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.remark'/></th>
								<td class="L" colspan="3">
									<input type="text" id="CodebaseManager_Child_remark" name="remark" value="" maxLength="60" label="<util:message key='ev.prop.codebase.remark'/>" class="full_webtextfield" />
								</td>
							</tr>				
						</table>
						<!-- btnArea-->
						<div class="btnArea">
							<div id="CodebaseManager_Child_EditButtons" class="rightArea">
								<a href="javascript:aCodebaseManager.doChildUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>					
					<!-- CodebaseManager_Child_EditForm//-->
				</div>
				<!-- CodebaseManager_DetailTabPage// -->
				<!-- CodebaseManager_Sub_TabPage -->
				<div id="CodebaseManager_Sub_TabPage">
					<form id="CodebaseManager_Sub_SearchForm" name="CodebaseManager_Sub_SearchForm" style="display:inline" action="javascript:aCodebaseManager.doSubSearch('CodebaseManager_Sub_SearchForm')" method="post">
						<table width="100%">
							<input type='hidden' name='sortMethod' value='ASC'/>                    
							<input type='hidden' name='sortColumn' value=''/>  
							<input type='hidden' name='pageNo' value='1'/>
							<input type='hidden' name='pageSize' value='10'/>
							<input type='hidden' name='pageFunction' value='aCodebaseManager.doSubPage'/>
							<input type='hidden' name='formName' value='CodebaseManager_Sub_SearchForm'/>
						</table>    
					</form>
					<!-- CodebaseManager_Sub_ListForm -->
					<form id="CodebaseManager_Sub_ListForm" style="display:inline" name="CodebaseManager_Sub_ListForm" action="" method="post">
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="30px" />
								<col width="30px" />
								<col width="100px" />
								<col width="100px" />
								<col width="*" />
								<col width="*" />
								<col width="200px" />
							</colgroup>	
							<thead>
								<tr>
									<th class="first C">
										<input type="checkbox" id="delCheck" onclick="aCodebaseManager.m_checkBox.chkAll(this)"/>
									</th>
									<th class="C"><span class="table_title">No</span></th>
									<th class="C" ch="0" onclick="aCodebaseManager.doSubSort(this, 'SYSTEM_CODE');" >
										<span class="table_title"><util:message key='ev.prop.codebase.systemCode'/></span>
									</th>	
									<th class="C" ch="0" onclick="aCodebaseManager.doSubSort(this, 'DOMAIN_ID');" >
										<span class="table_title"><util:message key='ev.prop.codebase.domainId'/></span>
									</th>		
									<th class="C" ch="0" onclick="aCodebaseManager.doSubSort(this, 'CODE_ID');" >
										<span class="table_title"><util:message key='ev.prop.codebase.codeId'/></span>
									</th>	
									<th class="C" ch="0" onclick="aCodebaseManager.doSubSort(this, 'CODE');" >
										<span class="table_title"><util:message key='ev.prop.codebase.code'/></span>
									</th>	
									<th class="C" ch="0" onclick="aCodebaseManager.doSubSort(this, 'CODE_NAME');" >
										<span class="table_title"><util:message key='ev.prop.codebase.codeName'/></span>
									</th>		
								</tr>
							</thead>
							<tbody id="CodebaseManager_Sub_ListBody"> </tbody>
						</table>
						<!-- tcontrol-->
						<div id="CodebaseManager_Sub_ListButtons" class="tcontrol">
							<!-- paging -->
							<div id="CodebaseManager_Sub_PAGE_ITERATOR" class="paging">
								<c:out escapeXml='false' value='${pageIterator}'/>
							</div>
							<!-- paging//-->
						</div>
						<!-- tcontrol//-->
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea">
								<a href="javascript:aCodebaseManager.doSubCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
								<a href="javascript:aCodebaseManager.doSubRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
							</div>
						</div>
						<!-- btnArea//-->		
					</form>
					<!-- CodebaseManager_Sub_ListForm// -->
					<!-- CodebaseManager_Sub_EditForm -->
					<form id="CodebaseManager_Sub_EditForm" style="display:inline" action="" method="post">
						<input type="hidden" id="CodebaseManager_Sub_isCreate">
						<table cellpadding='0' cellspacing='0' border='0' class="table_board">
						<caption>게시판</caption>
							<colgroup>
								<col width="140px" />
								<col width="*" />
								<col width="140px" />
								<col width="*" />
							</colgroup>   
							<tr class="first">
								<th class="L"><util:message key='ev.prop.codebase.domainId'/></th>
								<td class="L" colspan="3">
									<div class="sel_100">
										<select id="CodebaseManager_Sub_domainId" name="domainId" label="<util:message key='ev.prop.codebase.domainId'/>" class='txt_100'>
											<c:forEach items="${domainList}" var="domain">
											<option value="<c:out value="${domain.domainId}"/>"><c:out value="${domain.domainNm}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.langKnd'/> <em>*</em></th>
								<td class="L">
									<div class="sel_100">
										<select id="CodebaseManager_Sub_langKnd" name="langKnd" label="<util:message key='ev.prop.codebase.langKnd'/>" class='txt_100'>
											<c:forEach items="${langKndList}" var="langKnd">
											<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
								<th class="L"><util:message key='ev.prop.codebase.systemCode'/> <em>*</em></th>
								<td class="L">
									<div class="sel_100">
										<select id="CodebaseManager_Sub_systemCode" name="systemCode" label="<util:message key='ev.prop.codebase.systemCode'/>" class='txt_145'>
											<c:forEach items="${systemCodeList}" var="systemCode">
												<option value="<c:out value="${systemCode.code}"/>"><c:out value="${systemCode.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.codeId'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Sub_codeId" name="codeId" value="" maxLength="20" label="<util:message key='ev.prop.codebase.codeId'/>" class="full_webtextfield" />
								</td>
								<th class="L"><util:message key='ev.prop.codebase.code'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Sub_code" name="code" value="" maxLength="20" label="<util:message key='ev.prop.codebase.code'/>" class="full_webtextfield" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.codeName'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Sub_codeName" name="codeName" value="" maxLength="20" label="<util:message key='ev.prop.codebase.codeName'/>" class="full_webtextfield" />
								</td>
								<th class="L"><util:message key='ev.prop.codebase.codeName2'/></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Sub_codeName2" name="codeName2" value="" maxLength="20" label="<util:message key='ev.prop.codebase.codeName2'/>" class="full_webtextfield" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.codeTag1'/></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Sub_codeTag1" name="codeTag1" value="" maxLength="10" label="<util:message key='ev.prop.codebase.codeTag1'/>" class="full_webtextfield" />
								</td>
								<th class="L"><util:message key='ev.prop.codebase.codeTag2'/></th>
								<td class="L">
									<input type="text" id="CodebaseManager_Sub_codeTag2" name="codeTag2" value="" maxLength="10" label="<util:message key='ev.prop.codebase.codeTag2'/>" class="full_webtextfield" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.codebase.remark'/></th>
								<td  class="L" colspan="3">
									<input type="text" id="CodebaseManager_Sub_remark" name="remark" value="" maxLength="60" label="<util:message key='ev.prop.codebase.remark'/>" class="full_webtextfield txt_600" />
								</td>
							</tr>
						</table>
						<!-- btnArea-->
						<div class="btnArea">
							<div id="CodebaseManager_Sub_EditButtons" class="rightArea">
								<a href="javascript:aCodebaseManager.doSubUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>
					<!-- CodebaseManager_Sub_EditForm//-->
				</div>
				<!-- CodebaseManager_Sub_TabPage// -->
			</div>
			<!-- CodebaseManager_propertyTabs// -->
		</div>
		<!-- CodebaseManager_EditFormPanel//-->
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="CodebaseManager_CodebaseChooser"></div>