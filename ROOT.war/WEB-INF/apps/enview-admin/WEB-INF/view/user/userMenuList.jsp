
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userMenuManager.js"></script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="UserMenuManager_UserMenuTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="UserMenuManager_SearchForm" name="UserMenuManager_SearchForm" style="display:inline" action="javascript:aUserMenuManager.doSearch('UserMenuManager_SearchForm')" method="post">
					  <table width="100%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aUserMenuManager.doPage'/>
						<input type='hidden' name='formName' value='UserMenuManager_SearchForm'/>
					
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
				  <form id="UserMenuManager_ListForm" style="display:inline" name="UserMenuManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aUserMenuManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
							
						</tr>
					</thead>
					<tbody id="UserMenuManager_ListBody">
			
					
					<c:forEach items="${results}" var="usermenu" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="UserMenuManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="UserMenuManager[<c:out value="${status.index}"/>].principalId" value="<c:out value='${usermenu.principalId}'/>"/>
								<input type="hidden" id="UserMenuManager[<c:out value="${status.index}"/>].pageId" value="<c:out value='${usermenu.pageId}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="UserMenuManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:100%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="UserMenuManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserMenuManager.doCreate()">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_delete.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserMenuManager.doRemove()">
					    </td>
					</tr>
					</table>
				
					<div id="UserMenuManager_EditFormPanel" class="webformpanel" >  
					<div id="UserMenuManager_propertyTabs">
						<ul>
							<li><a href="#UserMenuManager_DetailTabPage"><util:message key='ev.title.user.detailTab'/></a></li>   
							
						</ul>
						<div id="UserMenuManager_DetailTabPage">
							<%@include file="userMenuDetail.jsp"%>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End UserMenuManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End UserMenuManager_UserMenuTabPage -->
		</div>
	</td>
<tr>
</table>

