
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletDefinitionManager.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletTitleManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletParamManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletMetadataManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletTypeManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletOptionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletLanguageManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletDescriptionManager.js"></script>
<script type="text/javascript">
function initPortletDefinitionManager() {
	if( aPortletDefinitionManager == null ) {
		aPortletDefinitionManager = new PortletDefinitionManager("<c:out value="${evSecurityCode}"/>");
		aPortletDefinitionManager.init();
	}
}
function finishPortletDefinitionManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initPortletDefinitionManager );
	window.attachEvent ( "onunload", finishPortletDefinitionManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initPortletDefinitionManager, false );
	window.addEventListener ( "unload", finishPortletDefinitionManager, false );
}
else
{
    window.onload = initPortletDefinitionManager;
	window.onunload = finishPortletDefinitionManager;
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
				<p id="PortletDefinitionManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="PortletDefinitionManager_SearchForm" name="PortletDefinitionManager_SearchForm" style="display:inline" action="javascript:aPortletDefinitionManager.doSearch('PortletDefinitionManager_SearchForm')" onkeydown="if(event.keyCode==13) aPortletDefinitionManager.doSearch('PortletDefinitionManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' id="PortletDefinitionManager_pageNo" name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPortletDefinitionManager.doPage'/>
						<input type='hidden' name='formName' value='PortletDefinitionManager_SearchForm'/>
						<input type='hidden' id='PortletDefinitionManager_Master_applicationName' name='applicationName' value=''/>
						<input type='hidden' id='PortletDefinitionManager_Master_applicationTitle' name='applicationTitle' value=''/>
						
						<input type="checkbox" id="PortletDefinitionManager_allCond" ><util:message key='ev.prop.portletDefinition.allSearch'/>&nbsp;&nbsp;
						<input type="checkbox" id="PortletDefinitionManager_unServiceableCond" ><util:message key='ev.prop.portletDefinition.serviceable'/>&nbsp;&nbsp;
						<input type="text" name="title0Cond" size="30" class="txt_100" value="*<util:message key='ev.title.portlet.title'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.portlet.title'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.portlet.title'/>*');"/> 
						
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5" selected>5</option>
								<option value="10">10</option>
								<option value="20">20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>	
						<a href="javascript:aPortletDefinitionManager.doSearch('PortletDefinitionManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>    
					</form>				
				</fieldset>
			</div>
			<!-- searchArea// -->
			<form id="PortletDefinitionManager_ListForm" style="display:inline" name="PortletDefinitionManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="120px" />
						<col width="250px" />
						<col width="*" />
					</colgroup>					
					<thead>
						<tr>
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aPortletDefinitionManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
							
							<th class="C" ch="0" onclick="aPortletDefinitionManager.doSort(this, 'APPLICATION_NAME');" >
								<span class="table_title"><util:message key='ev.prop.portletApplication.appName'/></span>
							</th>
							<th class="C" ch="0" onclick="aPortletDefinitionManager.doSort(this, 'PORTLET_NAME');" >
								<span class="table_title"><util:message key='ev.prop.portletDefinition.name'/></span>
							</th>	
							<th class="C" ch="0" onclick="aPortletDefinitionManager.doSort(this, 'TITLE');" >
								<span class="table_title"><util:message key='ev.title.portlet.title'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="PortletDefinitionManager_ListBody">
					</tbody>
				</table>
			</form>
			<div class="tsearchArea">
				<p id="PortletDefinitionManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="PortletDefinitionManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<c:if test="${isSuperAdmin }">
			<div class="btnArea" style="display:none;">
				<div class="rightArea">
					<a href="javascript:aPortletDefinitionManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aPortletDefinitionManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
					<a href="javascript:aPortletDefinitionManager.doActive()" class="btn_W"><span><util:message key='ev.title.active'/></span></a>
				</div>
			</div>
			</c:if>
			<!-- btnArea//-->						
		</div>
		<!-- board first// -->
		<!-- board -->
		<div id="PortletDefinitionManager_EditFormPanel" class="board" >  
			<div id="PortletDefinitionManager_propertyTabs">
				<ul>
					<li><a href="#PortletDefinitionManager_DetailTabPage"><util:message key='ev.title.portlet.detailTab'/></a></li>   
					<li><a href="#PortletDefinitionManager_PortletParamTabPage" onclick="aPortletDefinitionManager.onSelectPropertyTab(1);"><util:message key='ev.title.portlet.portletParamTab'/></a></li>   
					<li><a href="#PortletDefinitionManager_PortletMetadataTabPage" onclick="aPortletDefinitionManager.onSelectPropertyTab(2);"><util:message key='ev.title.portlet.portletMetadataTab'/></a></li>   
					<li><a href="#PortletDefinitionManager_PortletTypeTabPage" onclick="aPortletDefinitionManager.onSelectPropertyTab(3);"><util:message key='ev.title.portlet.portletTypeTab'/></a></li>   
					<li><a href="#PortletDefinitionManager_PortletOptionTabPage" onclick="aPortletDefinitionManager.onSelectPropertyTab(4);"><util:message key='ev.title.portlet.portletOptionTab'/></a></li>   
				</ul>
				<div id="PortletDefinitionManager_DetailTabPage">
					<%@include file="portletDefinitionDetail.jsp"%>
				</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
			
				<div id="PortletDefinitionManager_PortletParamTabPage"></div>
				<div id="PortletDefinitionManager_PortletMetadataTabPage"></div>
				<div id="PortletDefinitionManager_PortletTypeTabPage"></div>
				<div id="PortletDefinitionManager_PortletOptionTabPage"></div>
			</div>
		</div>
		<!-- board// -->		
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="PortletDefinitionManager_CategoryChooser" title="<util:message key='ev.prop.portletDefinition.categoryChooser'/>" style="display:none;">
	<div id="PortletCategoryChooser_TreeTabPage" style="width:100%; height:250px; overflow:auto;"></div>
</div>

<div id="PortletDefinitionManager_IconChooser" title="<util:message key='ev.prop.portletDefinition.iconChooser'/>" style="display:none;">
	<form id="IconChooser_SearchForm" name="IconChooser_SearchForm" style="display:inline" action="javascript:aPortletDefinitionManager.getIconChooser().doSearch('IconChooser_SearchForm')" method="post">
		<input type='hidden' name='pageNo' value='1'/>
		<input type='hidden' name='pageSize' value='50'/>
		<input type='hidden' name='pageFunction' value='aPortletDefinitionManager.getIconChooser().doPage'/>
		<input type='hidden' name='formName' value='IconChooser_SearchForm'/>
	</form>
	<div id="IconChooser_IconListBody"></div>
	
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="IconChooser_PAGE_ITERATOR" class="paging" >
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
</div>