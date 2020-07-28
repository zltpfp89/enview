
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/propertyManager.js"></script>

<script type="text/javascript">
function initPropertyManager() {
	if( aPropertyManager == null ) {
		aPropertyManager = new PropertyManager("<c:out value="${evSecurityCode}"/>");
		aPropertyManager.init();
		aPropertyManager.doDefaultSelect();
	}
}
function finishPropertyManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initPropertyManager );
	window.attachEvent ( "onunload", finishPropertyManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initPropertyManager, false );
	window.addEventListener ( "unload", finishPropertyManager, false );
}
else
{
    window.onload = initPropertyManager;
	window.onunload = finishPropertyManager;
}
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PropertyManager_PropertyTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="PropertyManager_SearchForm" name="PropertyManager_SearchForm" style="display:inline" action="javascript:aPropertyManager.doSearch('PropertyManager_SearchForm')" onkeydown="if(event.keyCode==13) aPropertyManager.doSearch('PropertyManager_SearchForm')" method="post">
					  <table width="99%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPropertyManager.doPage'/>
						<input type='hidden' name='formName' value='PropertyManager_SearchForm'/>
					
					  <tr>
						<td align="right">
						
							<input type="text" name="keyCond" size="" class="webtextfield" value="*<util:message key='ev.title.property.key'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.property.key'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.property.key'/>*');"/> 
										
							<select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<span class="btn_pack small"><a href="javascript:aPropertyManager.doSearch('PropertyManager_SearchForm')"><util:message key='ev.title.search'/></a></span>
						</td>
					  </tr>
					  </table>    
					</form>
				</div>
				<div class="webgridpanel">
				  <form id="PropertyManager_ListForm" style="display:inline" name="PropertyManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aPropertyManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
						
							<th class="webgridheader" ch="0" onclick="aPropertyManager.doSort(this, 'KEY');" >
								<span ><util:message key='ev.title.property.key'/></span>
							</th>	
							<th class="webgridheaderlast" ch="0" onclick="aPropertyManager.doSort(this, 'VALUE');" >
								<span ><util:message key='ev.title.property.value'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="PropertyManager_ListBody">
			
					
					<c:forEach items="${results}" var="property" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="PropertyManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="PropertyManager[<c:out value="${status.index}"/>].key" value="<c:out value='${property.key}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
							<td align="left" class="webgridbody" onclick="aPropertyManager.doSelect(this)">
								<span class="webgridrowlabel" id="PropertyManager[<c:out value="${status.index}"/>].key.label">&nbsp;<c:out value="${property.key}"/></span>
							</td>
							<td align="left" class="webgridbodylast" onclick="aPropertyManager.doSelect(this)">
								<span class="webgridrowlabel" id="PropertyManager[<c:out value="${status.index}"/>].value.label">&nbsp;<c:out value="${property.value}"/></span>
							</td>
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="PropertyManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:99%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="PropertyManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<!--tr>
					    <td align="right">
							<span class="btn_pack small"><a href="javascript:aPropertyManager.doCreate()"><util:message key='ev.title.new'/></a></span>
							<span class="btn_pack small"><a href="javascript:aPropertyManager.doRemove()"><util:message key='ev.title.remove'/></a></span>
					    </td>
					</tr-->
					</table>
				
					<div id="PropertyManager_EditFormPanel" class="webformpanel" >  
					<div id="PropertyManager_propertyTabs">
						<ul>
							<li><a href="#PropertyManager_DetailTabPage"><util:message key='ev.title.property.detailTab'/></a></li>   
							
						</ul>
						<div id="PropertyManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="PropertyManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="PropertyManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.property.key'/> *</td>
									
										<td width="30%" class="webformfield">
											
											<input type="text" id="PropertyManager_key" name="key" value="" maxLength="250" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.property.value'/> *</td>
									
										<td class="webformfield">
											
											<textarea id="PropertyManager_value" name="value" value="" cols="80" rows="3" maxLength="1024" class="webtextarea" >	</textarea>
												
										</td>
										
									</tr>
									
								</table>
								<!--table style="width:99%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<span class="btn_pack small"><a href="javascript:aPropertyManager.doUpdate()"><util:message key='ev.title.save'/></a></span>
									</td>
								</tr>
								</table-->
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End PropertyManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PropertyManager_PropertyTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PropertyManager_PropertyChooser"></div>

