
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/langManager.js"></script>

<script type="text/javascript">
var userDomainId = '<c:out value="${userDomainId}"/>';
var isAdmin = '<c:out value="${isAdmin}"/>';

function initLangManager() {
	if( aLangManager == null ) {
		aLangManager = new LangManager("<c:out value="${evSecurityCode}"/>");
		aLangManager.init();
		aLangManager.doDefaultSelect();
	}
}
function finishLangManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initLangManager );
	window.attachEvent ( "onunload", finishLangManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initLangManager, false );
	window.addEventListener ( "unload", finishLangManager, false );
}
else
{
    window.onload = initLangManager;
	window.onunload = finishLangManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div id="LangManager_LangTabPage" class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="CodebaseManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="LangManager_SearchForm" name="LangManager_SearchForm" style="display:inline" action="javascript:aLangManager.doSearch('LangManager_SearchForm')" onkeydown="if(event.keyCode==13) aLangManager.doSearch('LangManager_SearchForm')" method="post">					
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aLangManager.doPage'/>
						<input type='hidden' name='formName' value='LangManager_SearchForm'/>
						<div class="sel_100">	
							<select name="domainIdCond" label="<util:message key='ev.prop.lang.domainId'/>" class="txt_100">
								<option value="">*<util:message key='ev.prop.lang.domain'/>*</option> 
								<c:forEach items="${domainList}" var="domain">
									<option value="<c:out value="${domain.domainId}"/>"><c:out value="${domain.domainNm}"/></option>
								</c:forEach>
							</select>
						</div>
						<input type="text" name="langCdCond" size="" class="txt_100" value="*<util:message key='ev.prop.lang.langCd'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.lang.langCd'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.lang.langCd'/>*');"/> 
						<input type="text" name="langDescCond" size="" class="txt_100" value="*<util:message key='ev.prop.lang.langDesc'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.lang.langDesc'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.lang.langDesc'/>*');"/> 
						<div class="sel_70">
							<select name="pageSize" class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aLangManager.doSearch('LangManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
						<a href="javascript:aLangManager.writeJavascript()" class="btn_B"><span><util:message key='ev.title.writeFile'/></span></a> 
					</form>			
				</fieldset>
			</div>
			<!-- searchArea// -->
			<!-- LangManager_ListForm -->
			<form id="LangManager_ListForm" style="display:inline" name="LangManager_ListForm" action="" method="post">
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
								<input type="checkbox" id="delCheck" onclick="aLangManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C">No</th>
						
							<th class="C" ch="0"  >
								<span class="table_title"><util:message key='ev.prop.lang.domain'/></span>
							</th>
							<th class="C" ch="0" onclick="aLangManager.doSort(this, 'LANG_KND');" >
								<span class="table_title"><util:message key='ev.prop.lang.langKnd'/></span>
							</th>
							<th class="C" ch="0" onclick="aLangManager.doSort(this, 'LANG_CD');" >
								<span class="table_title"><util:message key='ev.prop.lang.langCd'/></span>
							</th>
							<th class="C" ch="0" onclick="aLangManager.doSort(this, 'LANG_DESC');" >
								<span class="table_title"><util:message key='ev.prop.lang.langShrtDesc'/></span>
							</th>
						</tr>
					</thead>
					<tbody id="LangManager_ListBody">
						<c:forEach items="${results}" var="lang" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
								<td class="C">
									<input type="checkbox" id="LangManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
								
									<input type="hidden" id="LangManager[<c:out value="${status.index}"/>].domainId" value="<c:out value='${lang.domainId}'/>"/>
									<input type="hidden" id="LangManager[<c:out value="${status.index}"/>].langKnd" value="<c:out value='${lang.langKnd}'/>"/>
									<input type="hidden" id="LangManager[<c:out value="${status.index}"/>].langCd" value="<c:out value='${lang.langCd}'/>"/>
								</td>
								<td class="C">
									<span class="table_title"><c:out value="${status.index}"/></span>
								</td>
								
								<td class="L" onclick="aLangManager.doSelect(this)">
									<span class="table_title" id="LangManager[<c:out value="${status.index}"/>].domainNm.label">&nbsp;<c:out value="${lang.domainNm}"/></span>
								</td>
								<td class="L" onclick="aLangManager.doSelect(this)">
									<span class="table_title" id="LangManager[<c:out value="${status.index}"/>].langKnd.label">&nbsp;<c:out value="${lang.langKnd}"/></span>
								</td>
								<td class="L" onclick="aLangManager.doSelect(this)">
									<span class="table_title" id="LangManager[<c:out value="${status.index}"/>].langCd.label">&nbsp;<c:out value="${lang.langCd}"/></span>
								</td>
								<td class="L" onclick="aLangManager.doSelect(this)">
									<span class="table_title" id="LangManager[<c:out value="${status.index}"/>].langDesc.label">&nbsp;<c:out value="${lang.langDesc}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			<!-- LangManager_ListForm// -->
			<div class="tsearchArea">
				<p id="LangManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="LangManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aLangManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aLangManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->
		<!-- LangManager_EditFormPanel -->
		<div id="LangManager_EditFormPanel" class="board" >
			<!-- LangManager_propertyTabs -->
			<div id="LangManager_propertyTabs">
				<ul>
					<li><a href="#LangManager_DetailTabPage"><util:message key='ev.title.lang.detailTab'/></a></li>   
				</ul>
				<!-- LangManager_DetailTabPage -->
				<div id="LangManager_DetailTabPage">
					<div>
						<form id="LangManager_Child_SearchForm" name="LangManager_Child_SearchForm" style="display:inline" action="javascript:aLangManager.doChildSearch('LangManager_Child_SearchForm')" method="post">
							<input type='hidden' name='sortMethod' value='ASC'/>                    
							<input type='hidden' name='sortColumn' value=''/>  
							<input type='hidden' name='pageNo' value='1'/>
							<input type='hidden' name='pageSize' value='10'/>
							<input type='hidden' name='pageFunction' value='aLangManager.doChildPage'/>
							<input type='hidden' name='formName' value='LangManager_Child_SearchForm'/>
						</form>					
					</div>
					<!-- LangManager_Child_ListForm -->
					<form id="LangManager_Child_ListForm" style="display:inline" name="LangManager_Child_ListForm" action="" method="post">
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
								<tr style="cursor: pointer;">
									<th class="C">
										<input type="checkbox" id="delCheck" onclick="aLangManager.m_checkBox.chkAll(this)"/>
									</th>
									<th class="C"><span class="table_title">No</span></th>						
									<th class="C" ch="0">
										<span class="table_title"><util:message key='ev.prop.lang.domain'/></span>
									</th>
									<th class="C" ch="0" onclick="aLangManager.doChildSort(this, 'LANG_KND');" >
										<span class="table_title"><util:message key='ev.prop.lang.langKnd'/></span>
									</th>	
									<th class="C" ch="0" onclick="aLangManager.doChildSort(this, 'LANG_CD');" >
										<span class="table_title"><util:message key='ev.prop.lang.langCd'/></span>
									</th>
									<th class="C" ch="0" onclick="aLangManager.doChildSort(this, 'LANG_DESC');" >
										<span class="table_title"><util:message key='ev.prop.lang.langShrtDesc'/></span>
									</th>		
								</tr>
							</thead>
							<tbody id="LangManager_Child_ListBody"> </tbody>
					 	</table>
						<!-- btnArea-->
						<div class="btnArea">
							<div id="LangManager_Child_ListButtons" class="rightArea">
								<a href="javascript:aLangManager.doChildCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
								<a href="javascript:aLangManager.doChildRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
							</div>
						</div>
						<!-- btnArea//-->					 	
					 </form>
					 <!-- LangManager_Child_ListForm// -->
					 <!-- LangManager_Child_EditForm -->
					 <form id="LangManager_Child_EditForm" style="display:inline" action="" method="post">
					 	<table cellpadding='0' cellspacing='0' border='0' summary="게시판" class="table_board">
					 		<input type="hidden" id="LangManager_Child_isCreate">
					 		<caption>게시판</caption>
							<colgroup>
								<col width="140px" />
								<col width="*" />
								<col width="140px" />
								<col width="*" />
							</colgroup>
							<tr>
								<th class="L"><util:message key='ev.prop.lang.domain'/> <em>*</em></th>
								<td colspan="3" class="L">
									<div class="sel_100">
										<select id="LangManager_Child_domainId" name="domainId" label="<util:message key='ev.prop.lang.domain'/>" class='txt_100'>
											<c:forEach items="${domainList}" var="domain">
												<option value="<c:out value="${domain.domainId}"/>"><c:out value="${domain.domainNm}"/></option>
											</c:forEach>
										</select>	
									</div>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.lang.langCd'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="LangManager_Child_langCd" name="langCd" value="" maxLength="100" label="<util:message key='pt.ev.property.langCd'/>" class="txt_200" readonly="readonly"/>
								</td>
								<th class="L"><util:message key='ev.prop.lang.langKnd'/></th>
								<td class="L">
									<div class="sel_100">
										<select id="LangManager_Child_langKnd" name="langKnd" label="<util:message key='ev.prop.lang.langKnd'/>" class='txt_100' disabled="disabled">
											<c:forEach items="${langKndList}" var="langKnd">
											<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.lang.langDesc'/> <em>*</em></th>
								<td colspan="3" class="L">
									<input type="text" id="LangManager_Child_langDesc" name="langDesc" value="" maxLength="100" label="<util:message key='ev.prop.lang.langDesc'/>" class="txt_600" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.prop.lang.langUpdDate'/></th>
								<td class="L"><input type="text" id="LangManager_Child_langUpdDate" name="langUpdDate" value="" label="<util:message key='ev.prop.lang.langUpdDate'/>" class="txt_145" /></td>
								<th class="L"><util:message key='ev.prop.lang.langUpdId'/></th>
								<td class="L"><input type="text" id="LangManager_Child_langUpdId" name="langUpdId" value="" label="<util:message key='ev.prop.lang.langUpdId'/>" class="txt_145" /></td>
							</tr>					 		
					 	</table>
						<!-- btnArea-->
						<div class="btnArea">
							<div id="LangManager_Child_EditButtons" class="rightArea">
								<a href="javascript:aLangManager.doChildUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
							</div>
						</div>
						<!-- btnArea//-->					 	
					 </form>					 
					 <!-- LangManager_Child_EditForm// -->			
				</div>
				<!-- LangManager_DetailTabPage// -->	
			</div>
			<!-- LangManager_propertyTabs// -->
		</div>
		<!-- LangManager_EditFormPanel// -->		
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="LangManager_LangChooser"></div>