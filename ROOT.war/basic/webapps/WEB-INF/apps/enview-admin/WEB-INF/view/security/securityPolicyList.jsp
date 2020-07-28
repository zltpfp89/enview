
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/securityPolicyManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageManager.js"></script>

<script type="text/javascript">
function initSecurityPolicyManager() {
	if( aSecurityPolicyManager == null ) {
		aSecurityPolicyManager = new SecurityPolicyManager("<c:out value="${evSecurityCode}"/>");
		aSecurityPolicyManager.init();
		aSecurityPolicyManager.doDefaultSelect();
	}
}
function finishSecurityPolicyManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initSecurityPolicyManager );
	window.attachEvent ( "onunload", finishSecurityPolicyManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initSecurityPolicyManager, false );
	window.addEventListener ( "unload", finishSecurityPolicyManager, false );
}
else
{
    window.onload = initSecurityPolicyManager;
	window.onunload = finishSecurityPolicyManager;
}
</script>

<!-- sub_contents -->
<div class="sub_contents">
	<!-- detail -->
	<div class="detail">
		<!-- board first -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p id="SecurityPolicyManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="SecurityPolicyManager_SearchForm" name="SecurityPolicyManager_SearchForm" style="display:inline" action="javascript:aSecurityPolicyManager.doSearch('SecurityPolicyManager_SearchForm')" onkeydown="if(event.keyCode==13) aSecurityPolicyManager.doSearch('SecurityPolicyManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aSecurityPolicyManager.doPage'/>
						<input type='hidden' name='formName' value='SecurityPolicyManager_SearchForm'/>
						<input type="text" name="ipaddressCond" size="15" class="txt_100" value="*<util:message key='ev.prop.policy.ipaddress'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.policy.ipaddress'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.policy.ipaddress'/>*');"/> 
						<div class="sel_70">				
							<select name='pageSize' class="txt_70">
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aSecurityPolicyManager.doSearch('SecurityPolicyManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>  
					</form>		
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="SecurityPolicyManager_ListForm" style="display:inline" name="SecurityPolicyManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="*" />
						<col width="*" />
					</colgroup>			
					<thead>
						<tr>
							<th class="first">
								<span class="table_title"><input type="checkbox" id="delCheck" onclick="aSecurityPolicyManager.m_checkBox.chkAll(this)"/></span>
							</th>
							<th class="C"><span class="table_title">No</span></th>
						
							<th class="C" ch="0" onclick="aSecurityPolicyManager.doSort(this, 'POLICY_ID');" >
								<span class="table_title"><util:message key='ev.prop.policy.policyId'/></span>
							</th>	
							<th class="C" ch="0" onclick="aSecurityPolicyManager.doSort(this, 'IPADDRESS');" >
								<span class="table_title"><util:message key='ev.prop.policy.ipaddress'/></span>
							</th>	
							<th class="C" ch="0" onclick="aSecurityPolicyManager.doSort(this, 'START_DATE');" >
								<span class="table_title"><util:message key='ev.prop.policy.startDate'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="SecurityPolicyManager_ListBody">
						<c:forEach items="${results}" var="securitypolicy" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<input type="checkbox" id="SecurityPolicyManager[<c:out value="${status.index}"/>].checkRow"/>
									<input type="hidden" id="SecurityPolicyManager[<c:out value="${status.index}"/>].policyId" value="<c:out value='${securitypolicy.policyId}'/>"/>
								</td>
								<td class="C">
									<c:out value="${status.index}"/>
								</td>
								
								<td class="L" onclick="aSecurityPolicyManager.doSelect(this)">
									<span id="SecurityPolicyManager[<c:out value="${status.index}"/>].policyId.label">&nbsp;<c:out value="${securitypolicy.policyId}"/></span>
								</td>
								<td class="L" onclick="aSecurityPolicyManager.doSelect(this)">
									<span id="SecurityPolicyManager[<c:out value="${status.index}"/>].ipaddress.label">&nbsp;<c:out value="${securitypolicy.ipaddress}"/></span>
								</td>
								<td class="L" onclick="aSecurityPolicyManager.doSelect(this)">
									<span id="SecurityPolicyManager[<c:out value="${status.index}"/>].startDate.label">&nbsp;<c:out value="${securitypolicy.startDateByFormat}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			<div class="tsearchArea">
				<p id="SecurityPolicyManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="SecurityPolicyManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aSecurityPolicyManager.doCreate()" class="btn_W"><span><util:message key='ev.title.new'/></span></a>
					<a href="javascript:aSecurityPolicyManager.doRemove()" class="btn_W"><span><util:message key='ev.title.remove'/></span></a>
				</div>
			</div>
			<!-- btnArea//-->	
		</div>
		<!-- board first// -->
		<!-- SecurityPolicyManager_EditFormPanel -->
		<div id="SecurityPolicyManager_EditFormPanel" class="board" > 
			<!-- SecurityPolicyManager_propertyTabs -->
			<div id="SecurityPolicyManager_propertyTabs">
				<ul>
					<li><a href="#SecurityPolicyManager_DetailTabPage"><util:message key='ev.title.security.detailTab'/></a></li>   
				</ul>
				<!-- SecurityPolicyManager_DetailTabPage -->
				<div id="SecurityPolicyManager_DetailTabPage">
					<form id="SecurityPolicyManager_EditForm" style="display:inline" action="" method="post">
						<input type="hidden" id="SecurityPolicyManager_isCreate">
						<input type="hidden" id="SecurityPolicyManager_policyId" name="policyId"/>
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판리스트</caption>
							<colgroup>
								<col width="140px" />
								<col width="*" />
								<col width="140px" />
								<col width="*" />
							</colgroup>
							<tr >
								<th class="L"><util:message key='ev.prop.policy.ipaddress'/> *</th>
								<td colspan="3" class="L">
									<input type="text" id="securityPolicyManager_ipaddress1" name="ipaddress1" maxLength="3" size="2" value="" class="txt_100" label="<util:message key='ev.prop.policy.ipaddress'/> 1"><span style="float:left">.</span>
									<input type="text" id="securityPolicyManager_ipaddress2" name="ipaddress2" maxLength="3" size="2" value="" class="txt_100" label="<util:message key='ev.prop.policy.ipaddress'/> 2"><span style="float:left">.</span>
									<input type="text" id="securityPolicyManager_ipaddress3" name="ipaddress3" maxLength="3" size="2" value="" class="txt_100" label="<util:message key='ev.prop.policy.ipaddress'/> 3"><span style="float:left">.</span>
									<input type="text" id="securityPolicyManager_ipaddress4" name="ipaddress4" maxLength="3" size="2" value="" class="txt_100" label="<util:message key='ev.prop.policy.ipaddress'/> 4">
								</td>
							</tr>
							<tr style="display:none">
								<th class="L"><util:message key='ev.prop.policy.resUrl'/> *</th>
								<td colspan="3" class="L">
									<input type="text" id="securityPolicyManager_resUrl" name="resUrl" maxLength="126" value="" style="width:80%;" label="<util:message key='pt.ev.property.resUrl'/>" class="txt_100">
									<img src="<%=request.getContextPath()%>/admin/images/button/btn_select.gif" align="absmiddle" onclick="javascript:aSecurityPolicyManager.getPageChooser().doShow()">
								</td>
							</tr>
							<tr >
								<th class="L"><util:message key='ev.title.security.optionTab'/></th>
								<td class="L">
									<input type="checkbox" id="SecurityPolicyManager_isAllow" name="isAllow" value="" /><util:message key='ev.prop.policy.isAllow'/>&nbsp;
									<input type="checkbox" id="SecurityPolicyManager_isEnabled" name="isEnabled" value="" /><util:message key='ev.prop.policy.isEnabled'/>
								</td>
								<th class="L"><util:message key='ev.prop.policy.authMethod'/></th>
								<td class="L">
									<div class="sel_100">
										<select id="SecurityPolicyManager_authMethod" name="authMethod" label="<util:message key='ev.prop.policy.authMethod'/>" class='txt_100'>
											<c:forEach items="${authMethodList}" var="authMethod">
												<option value="<c:out value="${authMethod.code}"/>"><c:out value="${authMethod.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr >
								<th class="L"><util:message key='ev.prop.policy.startDate'/></th>
								<td class="L">
									<input type="text" id="SecurityPolicyManager_startDate" name="startDate" value="" maxLength="10" size="10" class="txt_100" />
									<div class="sel_100">
										<select id="SecurityPolicyManager_startHour" class='txt_100'> 
											<option value="00">00</option>
											<option value="01">01</option>
											<option value="02">02</option>
											<option value="03">03</option>
											<option value="04">04</option>
											<option value="05">05</option>
											<option value="06">06</option>
											<option value="07">07</option>
											<option value="08">08</option>
											<option value="09">09</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
											<option value="21">21</option>
											<option value="22">22</option>
											<option value="23">23</option>
										</select>
									</div>
									<div class="sel_100">
										<select id="SecurityPolicyManager_startMin" class='txt_100'> 
											<option value="00">00</option>
											<option value="05">05</option>
											<option value="10">10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option>
											<option value="30">30</option>
											<option value="35">35</option>
											<option value="40">40</option>
											<option value="45">45</option>
											<option value="50">50</option>
											<option value="55">55</option>
										</select>
									</div>
								</td>
								<th class="L"><util:message key='ev.prop.policy.endDate'/></th>
								<td class="L">
									<input type="text" id="SecurityPolicyManager_endDate" name="endDate" value="" maxLength="10" size="10" class="txt_100" />
									<div class="sel_100">
										<select id="SecurityPolicyManager_endHour" class='txt_100'> 
											<option value="00">00</option>
											<option value="01">01</option>
											<option value="02">02</option>
											<option value="03">03</option>
											<option value="04">04</option>
											<option value="05">05</option>
											<option value="06">06</option>
											<option value="07">07</option>
											<option value="08">08</option>
											<option value="09">09</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
											<option value="21">21</option>
											<option value="22">22</option>
											<option value="23">23</option>
										</select>
									</div>
									<div class="sel_100">
										<select id="SecurityPolicyManager_endMin" class='txt_100'> 
											<option value="00">00</option>
											<option value="05">05</option>
											<option value="10">10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option>
											<option value="30">30</option>
											<option value="35">35</option>
											<option value="40">40</option>
											<option value="45">45</option>
											<option value="50">50</option>
											<option value="55">55</option>
										</select>
									</div>
								</td>
							</tr>
						</table>
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea">
								<a href="javascript:aSecurityPolicyManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</form>
				</div>
				<!-- SecurityPolicyManager_DetailTabPage// -->
			</div>
			<!-- SecurityPolicyManager_propertyTabs// -->
		</div>
		<!-- SecurityPolicyManager_EditFormPanel// -->	
	</div>
	<!-- detail// -->
</div>
<!-- sub_contents// -->

<div id="PageManager_PageChooser" class="tree" style="border-right: 0px #ffffff;"></div>