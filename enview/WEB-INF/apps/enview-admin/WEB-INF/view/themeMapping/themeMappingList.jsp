
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/themeMappingManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>

<script type="text/javascript">
function initThemeMappingManager() {
	if( aThemeMappingManager == null ) {
		aThemeMappingManager = new ThemeMappingManager("<c:out value="${evSecurityCode}"/>");
		aThemeMappingManager.init();
		aThemeMappingManager.doDefaultSelect();
	}
}
function finishThemeMappingManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initThemeMappingManager );
	window.attachEvent ( "onunload", finishThemeMappingManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initThemeMappingManager, false );
	window.addEventListener ( "unload", finishThemeMappingManager, false );
}
else
{
    window.onload = initThemeMappingManager;
	window.onunload = finishThemeMappingManager;
}
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="ThemeMappingManager_ThemeMappingTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="ThemeMappingManager_SearchForm" name="ThemeMappingManager_SearchForm" style="display:inline" action="javascript:aThemeMappingManager.doSearch('ThemeMappingManager_SearchForm')" onkeydown="if(event.keyCode==13) aThemeMappingManager.doSearch('ThemeMappingManager_SearchForm')" method="post">
					  <table width="99%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aThemeMappingManager.doPage'/>
						<input type='hidden' name='formName' value='ThemeMappingManager_SearchForm'/>
					
					  <tr>
						<td align="right">
						
							<input type="text" name="themeNameCond" size="" class="webtextfield" value="*<util:message key='ev.prop.themeMapping.themeName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.themeMapping.themeName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.themeMapping.themeName'/>*');"/> 
										
							<select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<span class="btn_pack small"><a href="javascript:aThemeMappingManager.doSearch('ThemeMappingManager_SearchForm')"><util:message key='ev.title.search'/></a></span>
						</td>
					  </tr>
					  </table>    
					</form>
				</div>
				<div class="webgridpanel">
				  <form id="ThemeMappingManager_ListForm" style="display:inline" name="ThemeMappingManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aThemeMappingManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
						
							<th class="webgridheader" ch="0" onclick="aThemeMappingManager.doSort(this, 'PRINCIPAL_ID');" >
								<span ><util:message key='ev.prop.themeMapping.principalId'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aThemeMappingManager.doSort(this, 'SEASON_TYPE');" >
								<span ><util:message key='ev.prop.themeMapping.seasonType'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aThemeMappingManager.doSort(this, 'PAGE_TYPE');" >
								<span ><util:message key='ev.prop.themeMapping.pageType'/></span>
							</th>	
							<th class="webgridheaderlast" ch="0" onclick="aThemeMappingManager.doSort(this, 'THEME_NAME');" >
								<span ><util:message key='ev.prop.themeMapping.themeName'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="ThemeMappingManager_ListBody">
			
					
					<c:forEach items="${results}" var="thememapping" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="ThemeMappingManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="ThemeMappingManager[<c:out value="${status.index}"/>].principalId" value="<c:out value='${thememapping.principalId}'/>"/>
								<input type="hidden" id="ThemeMappingManager[<c:out value="${status.index}"/>].seasonType" value="<c:out value='${thememapping.seasonType}'/>"/>
								<input type="hidden" id="ThemeMappingManager[<c:out value="${status.index}"/>].pageType" value="<c:out value='${thememapping.pageType}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
							<td align="left" class="webgridbody" onclick="aThemeMappingManager.doSelect(this)">
								<span class="webgridrowlabel" id="ThemeMappingManager[<c:out value="${status.index}"/>].principalId.label">&nbsp;<c:out value="${thememapping.groupId}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aThemeMappingManager.doSelect(this)">
								<span class="webgridrowlabel" id="ThemeMappingManager[<c:out value="${status.index}"/>].seasonType.label">&nbsp;<c:out value="${thememapping.seasonType}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aThemeMappingManager.doSelect(this)">
								<span class="webgridrowlabel" id="ThemeMappingManager[<c:out value="${status.index}"/>].pageType.label">&nbsp;<c:out value="${thememapping.pageType}"/></span>
							</td>
							<td align="left" class="webgridbodylast" onclick="aThemeMappingManager.doSelect(this)">
								<span class="webgridrowlabel" id="ThemeMappingManager[<c:out value="${status.index}"/>].themeName.label">&nbsp;<c:out value="${thememapping.themeName}"/></span>
							</td>
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="ThemeMappingManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:99%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="ThemeMappingManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<span class="btn_pack small"><a href="javascript:aThemeMappingManager.doCreate()"><util:message key='ev.title.new'/></a></span>
							<span class="btn_pack small"><a href="javascript:aThemeMappingManager.doRemove()"><util:message key='ev.title.remove'/></a></span>
					    </td>
					</tr>
					</table>
				
					<div id="ThemeMappingManager_EditFormPanel" class="webformpanel" >  
					<div id="ThemeMappingManager_propertyTabs">
						<ul>
							<li><a href="#ThemeMappingManager_DetailTabPage"><util:message key='ev.title.themeMapping.detailTab'/></a></li>   
							
						</ul>
						<div id="ThemeMappingManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="ThemeMappingManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="ThemeMappingManager_isCreate">
									<input type="hidden" id="ThemeMappingManager_principalId" name="principalId" />
									<tr> 
										<td colspan="4" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.themeMapping.id'/> *</td>
										<td class="webformfield">
											<input type="text" id="ThemeMappingManager_groupId" name="groupId" value="" maxLength="" label="<util:message key='ev.title.themeMapping.id'/>" class="webtextfield" style="width:70%;"/>
											<span id="ThemeMappingManager_groupId_select" class="btn_pack small"><a href="javascript:aThemeMappingManager.getGroupChooser().doShow(aThemeMappingManager.setGroupChooserCallback);"><util:message key='ev.title.selectGroup'/></a></span>
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.themeMapping.seasonType'/> *</td>
										<td class="webformfield">
											<select id="ThemeMappingManager_seasonType" name="seasonType" label="<util:message key='ev.prop.themeMapping.seasonType'/>" class='webdropdownlist'>
												<c:forEach items="${seasonTypeList}" var="seasonType">
												<option value="<c:out value="${seasonType.code}"/>"><c:out value="${seasonType.codeName}"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.themeMapping.pageType'/> *</td>
										<td class="webformfield">
											<select id="ThemeMappingManager_pageType" name="pageType" label="<util:message key='ev.prop.themeMapping.pageType'/>" class='webdropdownlist'>
												<c:forEach items="${pageTypeList}" var="pageType">
												<option value="<c:out value="${pageType.code}"/>"><c:out value="${pageType.codeName}"/></option>
												</c:forEach>
											</select>
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.themeMapping.themeName'/> *</td>
										<td class="webformfield">
											<select id="ThemeMappingManager_themeName" name="themeName" label="<util:message key='ev.prop.themeMapping.themeName'/>" class='webdropdownlist'>
												<c:forEach items="${themeList}" var="theme">
												<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									
								</table>
								<table style="width:99%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<span class="btn_pack small"><a href="javascript:aThemeMappingManager.doUpdate()"><util:message key='ev.title.save'/></a></span>
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End ThemeMappingManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End ThemeMappingManager_ThemeMappingTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="GroupManager_GroupChooser"></div>

