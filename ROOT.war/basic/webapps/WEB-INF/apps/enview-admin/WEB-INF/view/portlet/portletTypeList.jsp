
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletTypeManager.js"></script>


<!-- board -->
<div class="sub_contents">
	<div class="detail">
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="PortletTypeManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="PortletTypeManager_SearchForm" name="PortletTypeManager_SearchForm" style="display:inline" action="javascript:aPortletTypeManager.doSearch('PortletTypeManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aPortletTypeManager.doPage'/>
						<input type='hidden' name='formName' value='PortletTypeManager_SearchForm'/>
					 
						<input type='hidden' id='PortletTypeManager_applicationName' name='applicationName' value=''/>
						<input type='hidden' id='PortletTypeManager_portletName' name='portletName' value=''/>
						
						<div class="sel_70">
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aPortletTypeManager.doSearch('PortletTypeManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
					</form>
				</fieldset>
			</div>
			<!-- searchArea//-->
			<!-- table-->
			<form id="PortletTypeManager_ListForm" style="display:inline" name="PortletTypeManager_ListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판리스트" class="table_board list">
			<caption>게시판리스트</caption>
				<colgroup>
					<col width="30px" />
					<col width="30px" />
					<col width="100px" />
					<col width="*" />
				</colgroup>				
				<thead>
					<tr>
						<th class="first">
							<input type="checkbox" id="delCheck" onclick="aPortletTypeManager.m_checkBox.chkAll(this)"/>
						</th>
						<th class="C"><span class="table_title">No</span></th>
					
						<th class="C" ch="0" onclick="aPortletTypeManager.doSort(this, 'CONTENT_TYPE');" >
							<span class="table_title"><util:message key='ev.prop.portletDefinition.contentType'/></span>
						</th>	
						<th class="C" ch="0" onclick="aPortletTypeManager.doSort(this, 'MODES');" >
							<span class="table_title"><util:message key='ev.prop.portletDefinition.modes'/></span>
						</th>		
					</tr>
				</thead>
				<tbody id="PortletTypeManager_ListBody">
					<c:forEach items="${results}" var="portlettype" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td class="C">
								<input type="checkbox" id="PortletTypeManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="PortletTypeManager[<c:out value="${status.index}"/>].contentTypeId" value="<c:out value='${portlettype.contentTypeId}'/>"/>
							</td>
							<td class="C"><c:out value="${status.index}"/></td>
							
							<td class="L" onclick="aPortletTypeManager.doSelect(this)">
								<span id="PortletTypeManager[<c:out value="${status.index}"/>].contentType.label">&nbsp;<c:out value="${portlettype.contentType}"/></span>
							</td>
							<td class="L" onclick="aPortletTypeManager.doSelect(this)">
								<span id="PortletTypeManager[<c:out value="${status.index}"/>].modes.label">&nbsp;<c:out value="${portlettype.modes}"/></span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</form>
			<!-- table//-->
			<div class="tsearchArea">
				<p id="PortletTypeManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>			
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
			    <div id="PortletTypeManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
			    </div>
			    <!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aPortletTypeManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aPortletTypeManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->	
			<div id="PortletTypeManager_EditFormPanel">  
				<div id="PortletTypeManager_propertyTabs">
					<ul>
						<li><a href="#PortletTypeManager_DetailTabPage"><util:message key='ev.title.portlet.detailTab'/></a></li>   
						
					</ul>
					<div id="PortletTypeManager_DetailTabPage">
						<div class="webformpanel">
							<form id="PortletTypeManager_EditForm" style="display:inline" action="" method="post">
								<table cellpadding='0' cellspacing='0' border='0' class="table_board">
								<input type="hidden" id="PortletTypeManager_isCreate">
								<caption>게시판리스트</caption>
								<colgroup>
									<col width="140px" />
									<col width="*" />
								</colgroup> 										
								<tr >
									<th class="L"><util:message key='ev.prop.portletDefinition.contentType'/></th>
									<td class="L">
										<input type="text" id="PortletTypeManager_contentType" name="contentType" value="" maxLength="" label="<util:message key='ev.prop.portletDefinition.contentType'/>" class="txt_145" />
									</td>
								</tr>
								<tr >
									<th class="L"><util:message key='ev.prop.portletDefinition.modes'/></th>
									<td class="L">
										<input type="text" id="PortletTypeManager_modes" name="modes" value="" maxLength="" label="<util:message key='ev.prop.portletDefinition.modes'/>" class="txt_145" />
									</td>
								</tr>
								</table>
								<!-- btnArea-->
								<div class="btnArea">
									<div id="PortletTypeManager_Child_EditButtons" class="rightArea">
										<a href="javascript:aPortletTypeManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
									</div>
								</div>
								<!-- btnArea//-->	
							</form>
						</div>
					</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
				</div>
			</div> <!-- End PortletTypeManager_EditFormPanel -->
		</div> 
	</div> 
</div>

<div id="PortletTypeManager_PortletTypeChooser"></div>