
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/sessionDataManager.js"></script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="SessionDataManager_SessionDataTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="SessionDataManager_SearchForm" name="SessionDataManager_SearchForm" style="display:inline" action="javascript:aSessionDataManager.doSearch('SessionDataManager_SearchForm')" method="post">
					  <table width="100%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aSessionDataManager.doPage'/>
						<input type='hidden' name='formName' value='SessionDataManager_SearchForm'/>
					
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
				  <form id="SessionDataManager_ListForm" style="display:inline" name="SessionDataManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aSessionDataManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
							
						</tr>
					</thead>
					<tbody id="SessionDataManager_ListBody">
			
					
					<c:forEach items="${results}" var="sessiondata" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="SessionDataManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="SessionDataManager[<c:out value="${status.index}"/>].sid" value="<c:out value='${sessiondata.sid}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="SessionDataManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:100%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="SessionDataManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aSessionDataManager.doCreate()">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_delete.gif" hspace="2" style="cursor:hand" onclick="javascript:aSessionDataManager.doRemove()">
					    </td>
					</tr>
					</table>
				
					<div id="SessionDataManager_EditFormPanel" class="webformpanel" >  
					<div id="SessionDataManager_propertyTabs">
						<ul>
							<li><a href="#SessionDataManager_DetailTabPage"><util:message key='ev.title.sessionData.detailTab'/></a></li>   
							
						</ul>
						<div id="SessionDataManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="SessionDataManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="SessionDataManager_isCreate">
									
									<input type="hidden" id="SessionDataManager_sid" name="sid"> 
									<input type="hidden" id="SessionDataManager_userId" name="userId"> 
									<input type="hidden" id="SessionDataManager_userDate" name="userDate"> 
									<input type="hidden" id="SessionDataManager_creationDate" name="creationDate"> 
									<input type="hidden" id="SessionDataManager_modifiedDate" name="modifiedDate"> 
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aSessionDataManager.doUpdate()">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End SessionDataManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End SessionDataManager_SessionDataTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="SessionDataManager_SessionDataChooser"></div>

