
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/configurationManager.js"></script>

<script type="text/javascript">
function initConfigurationManager() {
	if( aConfigurationManager == null ) {
		aConfigurationManager = new ConfigurationManager("<c:out value="${evSecurityCode}"/>");
		aConfigurationManager.init();
		aConfigurationManager.doDefaultSelect();
	}
}
function finishConfigurationManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initConfigurationManager );
	window.attachEvent ( "onunload", finishConfigurationManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initConfigurationManager, false );
	window.addEventListener ( "unload", finishConfigurationManager, false );
}
else
{
    window.onload = initConfigurationManager;
	window.onunload = finishConfigurationManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div id="ConfigurationManager_ConfigurationTabPage" class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="ConfigurationManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="ConfigurationManager_SearchForm" name="ConfigurationManager_SearchForm" style="display:inline" 
					action="javascript:aConfigurationManager.doSearch('ConfigurationManager_SearchForm')" 
					onkeydown="if(event.keyCode==13) aConfigurationManager.doSearch('ConfigurationManager_SearchForm')"
					method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aConfigurationManager.doPage'/>
						<input type='hidden' name='formName' value='ConfigurationManager_SearchForm'/>
						<div class="sel_100">
							<select name="configTypeCond" class="txt_100">
								<option value="">*<util:message key='ev.prop.configuration.configType'/>*</option>
								<c:forEach items="${configTypeList}" var="configType">
									<option value="<c:out value="${configType.code}"/>"><c:out value="${configType.codeName}"/></option>
								</c:forEach>
							</select>
						</div>
						<input type="text" name="configCdCond" size="30" class="webtextfield" value="*<util:message key='ev.prop.configuration.configCd'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.configuration.configCd'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.configuration.configCd'/>*');"/> 
						<input type="text" name="configValueCond" size="30" class="webtextfield" value="*<util:message key='ev.prop.configuration.configValue'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.configuration.configValue'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.configuration.configValue'/>*');"/> 
						<div class="sel_70">				
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aConfigurationManager.doSearch('ConfigurationManager_SearchForm')" class="btn_search"><span>검색</span></a>  
					</form>				
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="ConfigurationManager_ListForm" style="display:inline" name="ConfigurationManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="*" />
						<col width="100px" />
						<col width="200px" />
					</colgroup>
					<thead>
						<tr>
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aConfigurationManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="C"><span class="table_title">No</span></th>
						
							<th class="C" ch="0" onclick="aConfigurationManager.doSort(this, 'CONFIG_CD');" >
								<span class="table_title"><util:message key='ev.prop.configuration.configCd'/></span>
							</th>	
							<th class="C" ch="0" onclick="aConfigurationManager.doSort(this, 'UPD_USER_ID');" >
								<span class="table_title"><util:message key='ev.prop.configuration.updUserId'/></span>
							</th>	
							<th class="C" ch="0" onclick="aConfigurationManager.doSort(this, 'UPD_DATIM');" >
								<span class="table_title"><util:message key='ev.prop.configuration.updDatim'/></span>
							</th>		
						</tr>				
					</thead>
					<tbody id="ConfigurationManager_ListBody">
						<c:forEach items="${results}" var="configuration" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<input type="checkbox" id="ConfigurationManager[<c:out value="${status.index}"/>].checkRow" />
								
									<input type="hidden" id="ConfigurationManager[<c:out value="${status.index}"/>].configCd" value="<c:out value='${configuration.configCd}'/>"/>
								</td>
								<td class="C">
									<span class="table_title"><c:out value="${status.index}"/></span>
								</td>
								
								<td class="L" onclick="aConfigurationManager.doSelect(this)">
									<span class="table_title" id="ConfigurationManager[<c:out value="${status.index}"/>].configCd.label">&nbsp;<c:out value="${configuration.configCd}"/></span>
								</td>
								<td class="C" onclick="aConfigurationManager.doSelect(this)">
									<span class="table_title" id="ConfigurationManager[<c:out value="${status.index}"/>].updUserId.label">&nbsp;<c:out value="${configuration.updUserId}"/></span>
								</td>
								<td class="C" onclick="aConfigurationManager.doSelect(this)">
									<span class="table_title" id="ConfigurationManager[<c:out value="${status.index}"/>].updDatim.label">&nbsp;<c:out value="${configuration.updDatimByFormat}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>					
				</table>
			</form>
			<div class="tsearchArea">
				<p id="ConfigurationManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="ConfigurationManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aConfigurationManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aConfigurationManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->
		<!-- ConfigurationManager_EditFormPanel -->
		<div id="ConfigurationManager_EditFormPanel" class="board" > 
			<div id="ConfigurationManager_propertyTabs">
				<ul>
					<li><a href="#ConfigurationManager_DetailTabPage"><util:message key='ev.title.configuration.detailTab'/></a></li>   
				</ul>
				<div id="ConfigurationManager_DetailTabPage">
					<%@include file="configurationDetail.jsp"%>
				</div>			
			</div>
		</div>
		<!-- ConfigurationManager_EditFormPanel// -->		
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->