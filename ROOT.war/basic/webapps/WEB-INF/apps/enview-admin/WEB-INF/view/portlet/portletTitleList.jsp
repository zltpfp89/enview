
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletTitleManager.js"></script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PortletTitleManager_PortletTitleTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="PortletTitleManager_SearchForm" name="PortletTitleManager_SearchForm" style="display:inline" action="javascript:aPortletTitleManager.doSearch('PortletTitleManager_SearchForm')" method="post">
					  <table width="99%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPortletTitleManager.doPage'/>
						<input type='hidden' name='formName' value='PortletTitleManager_SearchForm'/>
					 
						<input type='hidden' id='PortletTitleManager_Master_objectId' name='objectId' value=''/>
					  <tr>
						<td align="right">
						
							<select name='pageSize'>
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<span class="btn_pack small"><a href="javascript:aPortletTitleManager.doSearch('PortletTitleManager_SearchForm')"><util:message key='ev.title.search'/></a></span>
						</td>
					  </tr>
					  </table>    
					</form>
				</div>
				<div class="webgridpanel">
				  <form id="PortletTitleManager_ListForm" style="display:inline" name="PortletTitleManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aPortletTitleManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
						
							<th class="webgridheader" ch="0" onclick="aPortletTitleManager.doSort(this, 'DISPLAY_NAME');" >
								<span ><util:message key='pt.ev.property.displayName'/></span>
							</th>	
							<th class="webgridheaderlast" ch="0" onclick="aPortletTitleManager.doSort(this, 'LOCALE_STRING');" >
								<span ><util:message key='pt.ev.property.localeString'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="PortletTitleManager_ListBody">
			
					
					<c:forEach items="${results}" var="portlettitle" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="PortletTitleManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="PortletTitleManager[<c:out value="${status.index}"/>].id" value="<c:out value='${portlettitle.id}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
							<td align="left" class="webgridbody" onclick="aPortletTitleManager.doSelect(this)">
								<span class="webgridrowlabel" id="PortletTitleManager[<c:out value="${status.index}"/>].displayName.label">&nbsp;<c:out value="${portlettitle.displayName}"/></span>
							</td>
							<td align="left" class="webgridbodylast" onclick="aPortletTitleManager.doSelect(this)">
								<span class="webgridrowlabel" id="PortletTitleManager[<c:out value="${status.index}"/>].localeString.label">&nbsp;<c:out value="${portlettitle.localeString}"/></span>
							</td>
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="PortletTitleManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:99%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="PortletTitleManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<span class="btn_pack small"><a href="javascript:aPortletTitleManager.doCreate()"><util:message key='ev.title.new'/></a></span>
							<span class="btn_pack small"><a href="javascript:aPortletTitleManager.doRemove()"><util:message key='ev.title.remove'/></a></span>
					    </td>
					</tr>
					</table>
				
					<div id="PortletTitleManager_EditFormPanel" class="webformpanel" >  
					<div id="PortletTitleManager_propertyTabs">
						<ul>
							<li><a href="#PortletTitleManager_DetailTabPage"><util:message key='pt.ev.property.detailTab'/></a></li>   
							
						</ul>
						<div id="PortletTitleManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="PortletTitleManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="PortletTitleManager_isCreate">
									
									<input type="hidden" id="PortletTitleManager_id" name="id"> 
									<input type="hidden" id="PortletTitleManager_objectId" name="objectId"> 
									<input type="hidden" id="PortletTitleManager_className" name="className"> 
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='pt.ev.property.displayName'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="PortletTitleManager_displayName" name="displayName" value="" maxLength="100" label="<util:message key='pt.ev.property.displayName'/>" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='pt.ev.property.localeString'/></td>
									
										<td class="webformfield">
											
											<select id="PortletTitleManager_localeString" name="localeString" label="<util:message key='pt.ev.property.localeString'/>" class='webdropdownlist'>
												<c:forEach items="${localeStringList}" var="localeString">
												<option value="<c:out value="${localeString.code}"/>"><c:out value="${localeString.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:99%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<span class="btn_pack small"><a href="javascript:aPortletTitleManager.doUpdate()"><util:message key='ev.title.save'/></a></span>
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End PortletTitleManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PortletTitleManager_PortletTitleTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PortletTitleManager_PortletTitleChooser"></div>

