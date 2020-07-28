
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletDescriptionManager.js"></script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PortletDescriptionManager_PortletDescriptionTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="PortletDescriptionManager_SearchForm" name="PortletDescriptionManager_SearchForm" style="display:inline" action="javascript:aPortletDescriptionManager.doSearch('PortletDescriptionManager_SearchForm')" method="post">
					  <table width="100%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPortletDescriptionManager.doPage'/>
						<input type='hidden' name='formName' value='PortletDescriptionManager_SearchForm'/>
					 
						<input type='hidden' id='PortletDescriptionManager_Master_objectId' name='objectId' value=''/>
					  <tr>
						<td align="right">
						
							<select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<input type="image" src="<%=request.getContextPath()%>/admin/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand" >
						</td>
					  </tr>
					  </table>    
					</form>
				</div>
				<div class="webgridpanel">
				  <form id="PortletDescriptionManager_ListForm" style="display:inline" name="PortletDescriptionManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aPortletDescriptionManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
							
						</tr>
					</thead>
					<tbody id="PortletDescriptionManager_ListBody">
			
					
					<c:forEach items="${results}" var="portletdescription" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="PortletDescriptionManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="PortletDescriptionManager[<c:out value="${status.index}"/>].id" value="<c:out value='${portletdescription.id}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="PortletDescriptionManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:100%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="PortletDescriptionManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletDescriptionManager.doCreate()">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_delete.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletDescriptionManager.doRemove()">
					    </td>
					</tr>
					</table>
				
					<div id="PortletDescriptionManager_EditFormPanel" class="webformpanel" >  
					<div id="PortletDescriptionManager_propertyTabs">
						<ul>
							<li><a href="#PortletDescriptionManager_DetailTabPage"><util:message key='pt.ev.property.detailTab'/></a></li>   
							
						</ul>
						<div id="PortletDescriptionManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="PortletDescriptionManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="PortletDescriptionManager_isCreate">
									
									<input type="hidden" id="PortletDescriptionManager_id" name="id"> 
									<input type="hidden" id="PortletDescriptionManager_objectId" name="objectId"> 
									<input type="hidden" id="PortletDescriptionManager_className" name="className"> 
									<input type="hidden" id="PortletDescriptionManager_description" name="description"> 
									<input type="hidden" id="PortletDescriptionManager_localeString" name="localeString"> 
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletDescriptionManager.doUpdate()">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End PortletDescriptionManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PortletDescriptionManager_PortletDescriptionTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PortletDescriptionManager_PortletDescriptionChooser"></div>

