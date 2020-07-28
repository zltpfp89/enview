
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletParamManager.js"></script>


<div id="PortletParamManager_PortletParamTabPage" class="board first">
	<div class="tsearchArea">
		<p id="PortletParamManager_ListMessage"><c:out value='${resultMessage}'/></p>
		<fieldset>
			<form id="PortletParamManager_SearchForm" name="PortletParamManager_SearchForm" style="display:inline" action="javascript:aPortletParamManager.doSearch('PortletParamManager_SearchForm')" method="post">
				<input type='hidden' name='sortMethod' value='ASC'/>                    
				<input type='hidden' name='sortColumn' value=''/>  
				<input type='hidden' name='pageNo' value='1'/>
				<!--input type='hidden' name='pageSize' value='10'/-->
				<input type='hidden' name='pageFunction' value='aPortletParamManager.doPage'/>
				<input type='hidden' name='formName' value='PortletParamManager_SearchForm'/>
				<input type='hidden' id='PortletParamManager_applicationName' name='applicationName' value=''/>
				<input type='hidden' id='PortletParamManager_portletName' name='portletName' value=''/>

				<div class="sel_70">
				    <select name='pageSize' class="txt_70">
						<option value="5">5</option>
						<option value="10" selected="selected">10</option>
						<option value="20">20</option>
						<option value="50">50</option>
						<option value="100">100</option>
				    </select>
			    </div>
				
				<a href="javascript:aPortletParamManager.doSearch('PortletParamManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
			</form>
		</fieldset>
	</div>
	<form id="PortletParamManager_ListForm" style="display:inline" name="PortletParamManager_ListForm" action="" method="post">
		<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0" class="list table_board">
		<caption>게시판리스트</caption>
			<colgroup>
				<col width="30px" />
				<col width="30px" />
				<col width="200px" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr style="cursor: pointer;">
					<th class="first" >
						<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aPortletParamManager.m_checkBox.chkAll(this)"/>
					</th>
					<th><span class="table_title">No</span></th>
			
					<th ch="0" onclick="aPortletParamManager.doSort(this, 'PARAMETER_NAME');" >
						<span class="table_title"><util:message key='ev.prop.portletDefinition.paramName'/></span>
					</th>	
					<th class="webgridheaderlast" ch="0" onclick="aPortletParamManager.doSort(this, 'PARAMETER_VALUE');" >
						<span class="table_title"><util:message key='ev.prop.portletDefinition.paramValue'/></span>
					</th>		
				</tr>
			</thead>
			<tbody id="PortletParamManager_ListBody">
			<c:forEach items="${results}" var="portletparam" varStatus="status">
			<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
				<td class="C">
					<input type="checkbox" id="PortletParamManager[<c:out value="${status.index}"/>].checkRow"/>
					<input type="hidden" id="PortletParamManager[<c:out value="${status.index}"/>].parameterName" value="<c:out value='${portletparam.parameterName}'/>"/>
				</td>
				<td class="C fixed">
					<c:out value="${status.index}"/>
				</td>
				<td id="PortletParamManager[<c:out value="${status.index}"/>].name.label" class="L"onclick="aPortletParamManager.doSelect(this)">
					<c:out value="${portletparam.name}"/>
				</td>
				<td id="PortletParamManager[<c:out value="${status.index}"/>].parameterValue.label" class="L" onclick="aPortletParamManager.doSelect(this)">
					<c:out value="${portletparam.parameterValue}"/>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<!-- tcontrol-->
		<div class="tcontrol">
			<!-- paging -->
			<div class="paging" id="PortletParamManager_PAGE_ITERATOR">
				<c:out escapeXml='false' value='${pageIterator}'/>				
			</div>
			<!-- paging//-->
		</div>
		<!-- tcontrol//-->
		<!-- btnArea-->
		<div class="btnArea"> 
			<div class="rightArea">
				<a href="javascript:aPortletParamManager.doCreate()" class="btn_B"><span><util:message key='ev.title.new'/></span></a>
				<a href="javascript:aPortletParamManager.doRemove()" class="btn_B"><span><util:message key='ev.title.remove'/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</form>
</div>

<div id="PortletParamManager_EditFormPanel" class="board" >  
	<div id="PortletParamManager_propertyTabs">
		<ul>
			<li><a href="#PortletParamManager_DetailTabPage"><util:message key='ev.title.portlet.detailTab'/></a></li>   
		</ul>
		<div id="PortletParamManager_DetailTabPage">
			<form id="PortletParamManager_EditForm" style="display:inline" action="" method="post">
				<input type="hidden" id="PortletParamManager_isCreate">
				<table cellpadding=0 cellspacing=0 border=0 class="table_board">
				<caption>게시판리스트</caption>
					<colgroup>
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tr >
						<th class="L"><util:message key='ev.prop.portletDefinition.paramName'/> *</th>
						<td class="L">
							<input type="text" id="PortletParamManager_parameterName" name="parameterName" value="" maxLength="80" label="<util:message key='ev.prop.portletDefinition.paramName'/>" class="txt_145" />
							<div class="sel_145">
								<select id="PortletParamManager_name_select" class="txt_145" onchange="aPortletParamManager.changeSelectItem(this)">
									<!--option value=""></option-->
									<option value="ViewPage">View Page</option>
									<option value="EditPage">Edit Page</option>
									<option value="HelpPage">Help Page</option>
								</select>
							</div>
						</td>
					</tr>
					<tr >
						<th class="L"><util:message key='ev.prop.portletDefinition.paramValue'/> *</th>
						<td class="L">
							<input type="text" id="PortletParamManager_parameterValue" name="parameterValue" value="" maxLength="100" label="<util:message key='ev.prop.portletDefinition.paramValue'/>" class="txt_100per" />
						</td>
					</tr>
				</table>
				<!-- btnArea-->
				<div class="btnArea"> 
					<div class="rightArea">
						<a href="javascript:aPortletParamManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
					</div>
				</div>
				<!-- btnArea//-->
			</form>
		</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
	
	</div>
</div> <!-- End PortletParamManager_EditFormPanel -->

<div id="PortletParamManager_PortletParamChooser"></div>