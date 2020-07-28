
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletMetadataManager.js"></script>


<!-- board -->
<div class="sub_contents">
	<div class="detail">
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="PortletMetadataManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="PortletMetadataManager_SearchForm" name="PortletMetadataManager_SearchForm" style="display:inline" action="javascript:aPortletMetadataManager.doSearch('PortletMetadataManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPortletMetadataManager.doPage'/>
						<input type='hidden' name='formName' value='PortletMetadataManager_SearchForm'/>
					 
						<input type='hidden' id='PortletMetadataManager_applicationName' name='applicationName' value=''/>
						<input type='hidden' id='PortletMetadataManager_portletName' name='portletName' value=''/>
						
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>	
						<a href="javascript:aPortletMetadataManager.doSearch('PortletMetadataManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>    
					</form>
				</fieldset>
			</div>
			<!-- searchArea//-->
			<!-- table-->
			<form id="PortletMetadataManager_ListForm" style="display:inline" name="PortletMetadataManager_ListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판리스트" class="table_board list">
			<caption>게시판리스트</caption>
				<colgroup>
					<col width="30px" />
					<col width="30px" />
					<col width="30px" />
					<col width="*" />
					<col width="*" />
				</colgroup>	
				<thead>
					<tr>
						<th class="first C">
							<input type="checkbox" id="delCheck" onclick="aPortletMetadataManager.m_checkBox.chkAll(this)"/>
						</th>
						<th class="C"><span class="table_title">No</span></th>
					
						<th class="C" ch="0" onclick="aPortletMetadataManager.doSort(this, 'LOCALE_STRING');" >
							<span class="table_title"><util:message key='ev.prop.portletDefinition.localeString'/></span>
						</th>	
						<th class="C" ch="0" onclick="aPortletMetadataManager.doSort(this, 'META_NAME');" >
							<span class="table_title"><util:message key='ev.prop.portletDefinition.metaName'/></span>
						</th>	
						<th class="C" ch="0" onclick="aPortletMetadataManager.doSort(this, 'META_VALUE');" >
							<span class="table_title"><util:message key='ev.prop.portletDefinition.metaValue'/></span>
						</th>		
					</tr>
				</thead>
				<tbody id="PortletMetadataManager_ListBody">
					<c:forEach items="${results}" var="portletmetadata" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td class="C fixed">
								<input type="checkbox" id="PortletMetadataManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="PortletMetadataManager[<c:out value="${status.index}"/>].id" value="<c:out value='${portletmetadata.id}'/>"/>
							</td>
							<td class="C fixed"><c:out value="${status.index}"/></td>
							
							<td class="L" onclick="aPortletMetadataManager.doSelect(this)">
								<span id="PortletMetadataManager[<c:out value="${status.index}"/>].localeString.label">&nbsp;<c:out value="${portletmetadata.localeString}"/></span>
							</td>
							<td class="L" onclick="aPortletMetadataManager.doSelect(this)">
								<span id="PortletMetadataManager[<c:out value="${status.index}"/>].name.label">&nbsp;<c:out value="${portletmetadata.name}"/></span>
							</td>
							<td class="L" onclick="aPortletMetadataManager.doSelect(this)">
								<span id="PortletMetadataManager[<c:out value="${status.index}"/>].columnValue.label">&nbsp;<c:out value="${portletmetadata.columnValue}"/></span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</form>
			<!-- table//-->
			<div class="tsearchArea">
				<p id="PortletMetadataManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
			    <div id="PortletMetadataManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
			    </div>
			    <!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aPortletMetadataManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aPortletMetadataManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->	
			<div id="PortletMetadataManager_EditFormPanel" >  
				<div id="PortletMetadataManager_propertyTabs">
					<ul>
						<li><a href="#PortletMetadataManager_DetailTabPage"><util:message key='ev.title.portlet.detailTab'/></a></li>   
						
					</ul>
					<div id="PortletMetadataManager_DetailTabPage">
						<div class="webformpanel">
							<form id="PortletMetadataManager_EditForm" style="display:inline" action="" method="post">
								<table cellpadding='0' cellspacing='0' border='0' class="table_board">
								<input type="hidden" id="PortletMetadataManager_isCreate">
								<caption>게시판리스트</caption>
								<colgroup>
									<col width="140px" />
									<col width="*" />
								</colgroup> 									
								<tr class="first">
									<th class="L"><util:message key='ev.prop.portletDefinition.localeString'/></th>
									<td class="L">
										<div class="sel_100">
											<select id="PortletMetadataManager_localeString" name="localeString" label="<util:message key='pt.ev.property.localeString'/>" class='txt_100'>
												<c:forEach items="${localeStringList}" var="localeString">
												<option value="<c:out value="${localeString.code}"/>"><c:out value="${localeString.codeName}"/></option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.portletDefinition.metaName'/> <em>*</em></th>
									<td class="L">
										<input type="text" id="PortletMetadataManager_metaName" name="metaName" value="" maxLength="100" label="<util:message key='ev.prop.portletDefinition.metaName'/>" class="txt_145" />
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key='ev.prop.portletDefinition.metaValue'/> <em>*</em></th>
									<td class="L">
										<input type="text" id="PortletMetadataManager_metaValue" name="metaValue" value="" cols="80" rows="3" maxLength="1000" label="<util:message key='ev.prop.portletDefinition.metaValue'/>" class="txt_145" />
									</td>
								</tr>
							</table>								
							<!-- btnArea-->
							<div class="btnArea">
								<div id="PortletMetadataManager_Child_EditButtons" class="rightArea">
									<a href="javascript:aPortletMetadataManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
								</div>
							</div>
							<!-- btnArea//-->
							</form>
						</div>
					</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
				</div>
			</div> <!-- End PortletMetadataManager_EditFormPanel -->
		</div>
	</div>
</div>

<div id="PortletMetadataManager_PortletMetadataChooser"></div>