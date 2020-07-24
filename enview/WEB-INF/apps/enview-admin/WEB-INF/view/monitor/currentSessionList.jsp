<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/currentSessionManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userStatisticsManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/groupManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>
<script type="text/javascript">
function initCurrentSessionManager() {
	if( aCurrentSessionManager == null ) {
		aCurrentSessionManager = new CurrentSessionManager("<c:out value="${evSecurityCode}"/>");
		aCurrentSessionManager.init();
		
		if (${fn:length(results)} > 0) {
			aCurrentSessionManager.doDefaultSelect();	
		}
	}
}
function finishCurrentSessionManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initCurrentSessionManager );
	window.attachEvent ( "onunload", finishCurrentSessionManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initCurrentSessionManager, false );
	window.addEventListener ( "unload", finishCurrentSessionManager, false );
}
else
{
    window.onload = initCurrentSessionManager;
	window.onunload = finishCurrentSessionManager;
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
				<p id="CurrentSessionManager_ListMessage"><c:out value='${resultMessage}'/></p>
				<fieldset>
					<form id="CurrentSessionManager_SearchForm" name="CurrentSessionManager_SearchForm" style="display:inline" action="javascript:aCurrentSessionManager.doSearch('CurrentSessionManager_SearchForm')" onkeydown="if(event.keyCode==13) aCurrentSessionManager.doSearch('CurrentSessionManager_SearchForm')" method="post">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aCurrentSessionManager.doPage'/>
						<input type='hidden' name='formName' value='CurrentSessionManager_SearchForm'/>
						<c:if test="${isSuperAdmin}">
							<div class="sel_100">
								<select id="CurrentSessionManager_domainCond" name="domainId" class='txt_100' onchange="aCurrentSessionManager.doSearch('CurrentSessionManager_SearchForm');">
									<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }"><option value="-1">*<util:message key='ev.prop.domain.domain'/>*</option></c:if>
									<c:forEach items="${domainList}" var="domainInfo">
										<c:if test="${domainInfo.domainId != 0}">
											<option value="<c:out value="${domainInfo.domainId}"/>"><c:out value="${domainInfo.domainNm}"/></option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</c:if>
						<c:if test="${!isSuperAdmin}"><input id="CurrentSessionManager_domainCond" name="domainId" type="hidden" value="${domainInfo.domainId }"/></c:if>
						<div class="sel_100">
							<select name="clusterIp" class='txt_100'>
								<c:forEach items="${userIpList}" var="userIp">
									<option value="<c:out value="${userIp}"/>"><c:out value="${userIp}"/></option>
								</c:forEach>
							</select>
						</div>
						<input type="text" name="userIdCond" size="8" class="txt_100" value="*<util:message key='ev.title.monitor.userId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.monitor.userId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.monitor.userId'/>*');"/> 
						<input type="text" name="userNameCond" size="12" class="txt_100" value="*<util:message key='ev.title.monitor.userName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.monitor.userName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.monitor.userName'/>*');"/> 
						<div class="sel_100">
							<select name='pageSize' class='txt_100'>
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<a href="javascript:aCurrentSessionManager.doSearch('CurrentSessionManager_SearchForm')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
						<a href="javascript:aCurrentSessionManager.doExportExcel()" class="btn_B"><span><util:message key='ev.title.saveExcel'/></span></a>
					</form>			
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="CurrentSessionManager_ListForm" style="display:inline" name="CurrentSessionManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="100px" />
						<col width="*" />
						<col width="*" />
						<col width="*" />
						<col width="*" />
						<col width="*" />
					</colgroup>			
					<thead>
						<tr>
							<th class="first">No</th>
							<th class="C" ch="0" onclick="aCurrentSessionManager.doSort(this, 'DOMAINID');" >
								<span class="table_title"><util:message key='ev.title.monitor.domain'/></span>
							</th>
							<th class="C" ch="0" onclick="aCurrentSessionManager.doSort(this, 'USERID');" >
								<span class="table_title"><util:message key='ev.title.monitor.userId'/></span>
							</th>	
							<th class="C" ch="0" onclick="aCurrentSessionManager.doSort(this, 'USERNAME');" >
								<span class="table_title"><util:message key='ev.title.monitor.userName'/></span>
							</th>	
							<th class="C" ch="0" onclick="aCurrentSessionManager.doSort(this, 'USERIP');" >
								<span class="table_title"><util:message key='ev.title.monitor.userIp'/></span>
							</th>	
							<th class="C" ch="0" onclick="aCurrentSessionManager.doSort(this, 'USERAGENT');" >
								<span class="table_title"><util:message key='ev.title.monitor.userAgent'/></span>
							</th>	
							<th class="C" ch="0" onclick="aCurrentSessionManager.doSort(this, 'ELAPSEDTIME');" >
								<span class="table_title"><util:message key='ev.title.monitor.elapsedTime'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="CurrentSessionManager_ListBody">
						<c:forEach items="${results}" var="currentsession" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
								<td class="C">
									<span><c:out value="${status.count}"/></span>
									<input type="hidden" id="CurrentSessionManager[<c:out value="${status.index}"/>].domainId" value="<c:out value='${currentsession.userInfoMap.domainId}'/>"/>
									<input type="hidden" id="CurrentSessionManager[<c:out value="${status.index}"/>].userId" value="<c:out value='${currentsession.userInfoMap.user_id}'/>"/>
								</td>
								<td class="C" onclick="aCurrentSessionManager.doSelect(this)">
									<span id="CurrentSessionManager[<c:out value="${status.index}"/>].domain.label">&nbsp;<c:out value="${currentsession.userInfoMap.domainNm}"/></span>
								</td>
								<td class="L" onclick="aCurrentSessionManager.doSelect(this)">
									<span id="CurrentSessionManager[<c:out value="${status.index}"/>].userId.label">&nbsp;<c:out value="${currentsession.userInfoMap.user_id}"/></span>
								</td>
								<td class="L" onclick="aCurrentSessionManager.doSelect(this)">
									<span id="CurrentSessionManager[<c:out value="${status.index}"/>].userName.label">&nbsp;<c:out value="${currentsession.userInfoMap.nm_kor}"/></span>
								</td>
								<td class="L" onclick="aCurrentSessionManager.doSelect(this)">
									<span id="CurrentSessionManager[<c:out value="${status.index}"/>].userIp.label">&nbsp;<c:out value="${currentsession.userInfoMap.remote_address}"/></span>
								</td>
								<td class="L" onclick="aCurrentSessionManager.doSelect(this)">
									<span id="CurrentSessionManager[<c:out value="${status.index}"/>].userAgent.label">&nbsp;<c:out value="${currentsession.userInfoMap.userAgent}"/></span>
								</td>
								<td class="L" onclick="aCurrentSessionManager.doSelect(this)">
									<span id="CurrentSessionManager[<c:out value="${status.index}"/>].elapsedTime.label">&nbsp;<c:out value="${currentsession.userInfoMap.session_elapsed}"/></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			 </form>
			<div class="tsearchArea">
				<p id="CurrentSessionManager_ListMessage"><c:out value='${resultMessage}'/></p>
			</div>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="CurrentSessionManager_PAGE_ITERATOR" class="paging">
					<c:out escapeXml='false' value='${pageIterator}'/>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->	
		</div>
		<!-- board first// -->
		<!-- CurrentSessionManager_propertyTabs -->
		<div id="CurrentSessionManager_propertyTabs" class="board">
			<ul>
				<li><a href="#CurrentSessionManager_DetailTabPage"><util:message key='ev.title.monitor.detailTab'/></a></li>   
				<li><a href="#CurrentSessionManager_UserStatisticsTabPage" onclick="aCurrentSessionManager.onSelectPropertyTab(1);"><util:message key='ev.title.monitor.userStatisticsTab'/></a></li>   
			</ul>
			<!-- CurrentSessionManager_DetailTabPage -->
			<div id="CurrentSessionManager_DetailTabPage">
				<div>
					<form id="CurrentSessionManager_EditForm" style="display:inline" action="" method="post">
						<input type="hidden" id="CurrentSessionManager_isCreate">
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="140px" />
								<col width="*" />
								<col width="140px" />
								<col width="*" />
							</colgroup>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.userId'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="CurrentSessionManager_userId" name="userId" value="" maxLength="30" class="txt_200" />
								</td>
								<th class="L"><util:message key='ev.title.monitor.nmKor'/> <em>*</em></th>
								<td class="L">
									<input type="text" id="CurrentSessionManager_nmKor" name="nmKor" value="" maxLength="30" class="txt_200" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.nmNic'/></th>
								<td class="L">
									<input type="text" id="CurrentSessionManager_nmNic" name="nmNic" value="" maxLength="30" class="txt_200" />
								</td>
								<th class="L"><util:message key='ev.title.monitor.regNo'/> <em>*</em></th>
								<td class="L">
									<input type="hidden" id="CurrentSessionManager_regNo" name="regNo" value="" maxLength="13" class="txt_100" />
									<input type="text" id="CurrentSessionManager_regNo1" value="" maxLength="6" class="txt_100" /><span class="sel_txt">-</span>
									<input type="text" id="CurrentSessionManager_regNo2" value="" maxLength="7" class="txt_100" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.birthYmd'/> <em>*</em></th>
								<td class="L">
									<input type="hidden" id="CurrentSessionManager_birthYmd" name="birthYmd" value="" class="txt_100" />
									<div class="sel_100">
										<select id='CurrentSessionManager_birthYear' class='txt_100'>
											<option value="1945">1945</option>
											<option value="1946">1946</option>
											<option value="1947">1947</option>
											<option value="1948">1948</option>
											<option value="1949">1949</option>
											<option value="1950">1950</option>
											<option value="1951">1951</option>
											<option value="1952">1952</option>
											<option value="1953">1953</option>
											<option value="1954">1954</option>
											<option value="1955">1955</option>
											<option value="1956">1956</option>
											<option value="1957">1957</option>
											<option value="1958">1958</option>
											<option value="1959">1959</option>
											<option value="1960">1960</option>
											<option value="1961">1961</option>
											<option value="1962">1962</option>
											<option value="1963">1963</option>
											<option value="1964">1964</option>
											<option value="1965">1965</option>
											<option value="1966">1966</option>
											<option value="1967">1967</option>
											<option value="1968">1968</option>
											<option value="1969">1969</option>
											<option value="1970">1970</option>
											<option value="1971">1971</option>
											<option value="1972">1972</option>
											<option value="1973">1973</option>
											<option value="1974">1974</option>
											<option value="1975">1975</option>
											<option value="1976">1976</option>
											<option value="1977">1977</option>
											<option value="1978">1978</option>
											<option value="1979">1979</option>
											<option value="1980">1980</option>
											<option value="1981">1981</option>
											<option value="1982">1982</option>
											<option value="1983">1983</option>
											<option value="1984">1984</option>
											<option value="1985">1985</option>
											<option value="1986">1986</option>
											<option value="1987">1987</option>
											<option value="1988">1988</option>
											<option value="1989">1989</option>
											<option value="1990">1990</option>
											<option value="1991">1991</option>
											<option value="1992">1992</option>
											<option value="1993">1993</option>
											<option value="1994">1994</option>
											<option value="1995">1995</option>
											<option value="1996">1996</option>
											<option value="1997">1997</option>
											<option value="1998">1998</option>
											<option value="1999">1999</option>
											<option value="2000">2000</option>
											<option value="2001">2001</option>
											<option value="2002">2002</option>
											<option value="2003">2003</option>
											<option value="2004">2004</option>
											<option value="2005">2005</option>
											<option value="2006">2006</option>
											<option value="2007">2007</option>
											<option value="2008">2008</option>
											<option value="2009">2009</option>
											<option value="2010">2010</option>
											<option value="2011">2011</option>
											<option value="2012">2012</option>
											<option value="2013">2013</option>
											<option value="2014">2014</option>
											<option value="2015">2015</option>
											<option value="2016">2016</option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
										</select> 
										<util:message key='ev.title.monitor.year'/>
									</div>
									<div class="sel_100">
										<select id='CurrentSessionManager_birthMonth' class='txt_100'>
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
										</select>
										<util:message key='ev.title.monitor.month'/>
									</div>
									<div class="sel_100">
										<select id='CurrentSessionManager_birthDay' class='txt_100'>
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
											<option value="24">24</option>
											<option value="25">25</option>
											<option value="26">26</option>
											<option value="27">27</option>
											<option value="28">28</option>
											<option value="29">29</option>
											<option value="30">30</option>
											<option value="31">31</option>
										</select>
										<util:message key='ev.title.monitor.day' />
									</div>
								</td>
								<th class="L"><util:message key='ev.title.monitor.emailAddr'/> <em>*</em></th>
								<td class="L">
									<input type="hidden" id="CurrentSessionManager_emailAddr" name="emailAddr"/>
									<input type="text" id="CurrentSessionManager_emailAddr1" value="" size="15" maxLength="15" class="txt_100" /><span class="sel_txt">@</span>
									<div class="sel_100">
										<select id="CurrentSessionManager_emailAddr2" class='txt_100'>
											<c:forEach items="${emailAddrList}" var="emailAddr">
												<option value="<c:out value="${emailAddr.code}"/>"><c:out value="${emailAddr.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.offcTel'/> <em>*</em></th>
								<td class="L">
									<input type="hidden" id="CurrentSessionManager_offcTel" name="offcTel"/>
									<div class="sel_70">
										<select id="CurrentSessionManager_offcTel1" class='txt_70'>
											<c:forEach items="${offcTelList}" var="offcTel">
												<option value="<c:out value="${offcTel.code}"/>"><c:out value="${offcTel.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
									<input type="text" id="CurrentSessionManager_offcTel2" value="" size="15" maxLength="4" class="txt_70" /><span class="sel_txt">-</span>
									<input type="text" id="CurrentSessionManager_offcTel3" value="" size="15" maxLength="4" class="txt_70" />
								</td>
								<th class="L"><util:message key='ev.title.monitor.mileTot'/></th>
								<td class="L">
									<input type="text" id="CurrentSessionManager_mileTot" name="mileTot" value="" maxLength="" class="txt_100" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.homeTel'/> <em>*</em></th>
								<td class="L">
									<input type="hidden" id="CurrentSessionManager_homeTel" name="homeTel"/>
									<div class="sel_70">
										<select id="CurrentSessionManager_homeTel1" class='txt_70'>
											<c:forEach items="${homeTelList}" var="homeTel">
												<option value="<c:out value="${homeTel.code}"/>"><c:out value="${homeTel.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
									<input type="text" id="CurrentSessionManager_homeTel2" value="" size="15" maxLength="15" class="txt_70" /><span class="sel_txt">-</span>
									<input type="text" id="CurrentSessionManager_homeTel3" value="" size="15" maxLength="15" class="txt_70" />
								</td>
								<th class="L"><util:message key='ev.title.monitor.mobileTel'/> <em>*</em></th>
								<td class="L">
									<input type="hidden" id="CurrentSessionManager_mobileTel" name="mobileTel"/>
									<div class="sel_70">
										<select id="CurrentSessionManager_mobileTel1" class='txt_70'>
											<c:forEach items="${mobileTelList}" var="mobileTel">
												<option value="<c:out value="${mobileTel.code}"/>"><c:out value="${mobileTel.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
									<input type="text" id="CurrentSessionManager_mobileTel2" value="" size="15" maxLength="15" class="txt_70" /><span class="sel_txt">-</span>
									<input type="text" id="CurrentSessionManager_mobileTel3" value="" size="15" maxLength="15" class="txt_70" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.homeZip'/> <em>*</em></th>
								<td class="L">
									<input type="hidden" id="CurrentSessionManager_homeZip" name="homeZip" value="" maxLength="" class="txt_100" />
									<input type="text" id="CurrentSessionManager_homeZip1" value="" size="15" maxLength="3" class="txt_100" /><span class="sel_txt">-</span>
									<input type="text" id="CurrentSessionManager_homeZip2" value="" size="15" maxLength="3" class="txt_100" />
								</td>
								<th class="L"><util:message key='ev.title.monitor.langKnd'/></th>
								<td class="L">
									<div class="sel_100">
										<select id="CurrentSessionManager_langKnd" name="langKnd" class='txt_100'>
											<c:forEach items="${langKndList}" var="langKnd">
												<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.homeAddr1'/> <em>*</em></th>
								<td colspan="3" class="L">
									<input type="text" id="CurrentSessionManager_homeAddr1" name="homeAddr1" value="" size="40" maxLength="40" class="txt_200" /><span class="sel_txt">-</span>
									<input type="text" id="CurrentSessionManager_homeAddr2" name="homeAddr2" value="" size="40" maxLength="40" class="txt_200" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.userInfo05'/></th>
								<td colspan="3" class="L">
									<input type="text" id="CurrentSessionManager_userInfo05" name="userInfo05" value="" maxLength="50" class="txt_600" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.userInfo06'/></th>
								<td colspan="3" class="L">
									<input type="text" id="CurrentSessionManager_userInfo06" name="userInfo06" value="" maxLength="50" class="txt_600" />
								</td>
							</tr>
							<tr>
								<th class="L"><util:message key='ev.title.monitor.regDatim'/></th>
								<td class="L"><input type="text" id="CurrentSessionManager_regDatim" name="regDatim" value="" class="txt_145" /></td>
								<th class="L"><util:message key='ev.title.monitor.updDatim'/></th>
								<td class="L"><input type="text" id="CurrentSessionManager_updDatim" name="updDatim" value="" class="txt_145" /></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<!-- CurrentSessionManager_DetailTabPage// -->
			<div id="CurrentSessionManager_UserStatisticsTabPage">
			</div>
		</div>
		<!-- CurrentSessionManager_propertyTabs// -->		
	</div>
	<!-- deatil// -->
</div>
<!-- sub_contents// -->

<div id="CurrentSessionManager_CurrentSessionChooser"></div>
<iframe id='exportExcelIF' frameborder=0 width=0 height=0></iframe>