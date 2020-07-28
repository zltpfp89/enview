
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/capabilityManager.js"></script>

<script type="text/javascript">
function initCapabilityManager() {
	if( aCapabilityManager == null ) {
		aCapabilityManager = new CapabilityManager();
		aCapabilityManager.init();
	}
}
function finishCapabilityManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initCapabilityManager );
	window.attachEvent ( "onunload", finishCapabilityManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initCapabilityManager, false );
	window.addEventListener ( "unload", finishCapabilityManager, false );
}
else
{
    window.onload = initCapabilityManager;
	window.onunload = finishCapabilityManager;
}
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="CapabilityManager_CapabilityTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="CapabilityManager_SearchForm" name="CapabilityManager_SearchForm" style="display:inline" action="javascript:aCapabilityManager.doSearch('CapabilityManager_SearchForm')" method="post">
					  <table width="100%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aCapabilityManager.doPage'/>
						<input type='hidden' name='formName' value='CapabilityManager_SearchForm'/>
					
					  <tr>
						<td align="right">
						
							<select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<input type="image" src="<%=request.getContextPath()%>/admin/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand">
						</td>
					  </tr>
					  </table>    
					</form>
				</div>
				<div class="webgridpanel">
				  <form id="CapabilityManager_ListForm" style="display:inline" name="CapabilityManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aCapabilityManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
							
						</tr>
					</thead>
					<tbody id="CapabilityManager_ListBody">
			
					
					<c:forEach items="${results}" var="capability" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="CapabilityManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="CapabilityManager[<c:out value="${status.index}"/>].capabilityId" value="<c:out value='${capability.capabilityId}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="CapabilityManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:100%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="CapabilityManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aCapabilityManager.doCreate()">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_delete.gif" hspace="2" style="cursor:hand" onclick="javascript:aCapabilityManager.doRemove()">
					    </td>
					</tr>
					</table>
				
					<div id="CapabilityManager_EditFormPanel" class="webformpanel" >  
					<div id="CapabilityManager_propertyTabs">
						<ul>
							<li><a href="#CapabilityManager_DetailTabPage"><util:message key='pt.ev.property.detailTab'/></a></li>   
							
						</ul>
						<div id="CapabilityManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="CapabilityManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="CapabilityManager_isCreate">
									
									<input type="hidden" id="CapabilityManager_capabilityId" name="capabilityId"> 
									<input type="hidden" id="CapabilityManager_capability" name="capability"> 
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aCapabilityManager.doUpdate()">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End CapabilityManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End CapabilityManager_CapabilityTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="CapabilityManager_CapabilityChooser"></div>

