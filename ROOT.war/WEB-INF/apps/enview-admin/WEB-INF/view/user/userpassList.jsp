
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userpassManager.js"></script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="UserpassManager_UserpassTabPage">
				<br style='line-height:5px;'>
				<div>
					<form id="UserpassManager_SearchForm" name="UserpassManager_SearchForm" style="display:inline" action="javascript:aUserpassManager.doSearch('UserpassManager_SearchForm')" method="post">
					  <table width="100%">
						<input type='hidden' name='sortMethod' value='ASC'/>                    
						<input type='hidden' name='sortColumn' value=''/>  
						<input type='hidden' name='pageNo' value='1'/>
						<!--input type='hidden' name='pageSize' value='10'/-->
						<input type='hidden' name='pageFunction' value='aUserpassManager.doPage'/>
						<input type='hidden' name='formName' value='UserpassManager_SearchForm'/>
					 
						<input type='hidden' id='UserpassManager_Master_userId' name='userId' value=''/>
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
				  <form id="UserpassManager_ListForm" style="display:inline" name="UserpassManager_ListForm" action="" method="post">
				  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="100" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" align="center" width="30px">
								<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aUserpassManager.m_checkBox.chkAll(this)"/>
							</th>
							<th class="webgridheader" align="center" width="30px">No</th>
						
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'USER_ID');" >
								<span ><util:message key='ev.prop.userpass.userId'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'NM_KOR');" >
								<span ><util:message key='ev.prop.userpass.nmKor'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'NM_NIC');" >
								<span ><util:message key='ev.prop.userpass.nmNic'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'REG_NO');" >
								<span ><util:message key='ev.prop.userpass.regNo'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'BIRTH_YMD');" >
								<span ><util:message key='ev.prop.userpass.birthYmd'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'EMAIL_ADDR');" >
								<span ><util:message key='ev.prop.userpass.emailAddr'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'OFFC_TEL');" >
								<span ><util:message key='ev.prop.userpass.offcTel'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'MILE_TOT');" >
								<span ><util:message key='ev.prop.userpass.mileTot'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'HOME_TEL');" >
								<span ><util:message key='ev.prop.userpass.homeTel'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'MOBILE_TEL');" >
								<span ><util:message key='ev.prop.userpass.mobileTel'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'HOME_ZIP');" >
								<span ><util:message key='ev.prop.userpass.homeZip'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'HOME_ADDR1');" >
								<span ><util:message key='ev.prop.userpass.homeAddr1'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'HOME_ADDR2');" >
								<span ><util:message key='ev.prop.userpass.homeAddr2'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'LANG_KND');" >
								<span ><util:message key='ev.prop.lang.langKnd'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'USER_INFO05');" >
								<span ><util:message key='ev.prop.userpass.userInfo05'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'USER_INFO06');" >
								<span ><util:message key='ev.prop.userpass.userInfo06'/></span>
							</th>	
							<th class="webgridheader" ch="0" onclick="aUserpassManager.doSort(this, 'REG_DATIM');" >
								<span ><util:message key='ev.prop.userpass.regDatim'/></span>
							</th>	
							<th class="webgridheaderlast" ch="0" onclick="aUserpassManager.doSort(this, 'UPD_DATIM');" >
								<span ><util:message key='ev.prop.userpass.updDatim'/></span>
							</th>		
						</tr>
					</thead>
					<tbody id="UserpassManager_ListBody">
			
					
					<c:forEach items="${results}" var="userpass" varStatus="status">
						<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" onmouseover="whenListMouseOver(this)" onmouseout="whenListMouseOut(this)">
							<td align="center" class="webgridbody">
								<input type="checkbox" id="UserpassManager[<c:out value="${status.index}"/>].checkRow" class="webcheckbox"/>
							
								<input type="hidden" id="UserpassManager[<c:out value="${status.index}"/>].userId" value="<c:out value='${userpass.userId}'/>"/>
							</td>
							<td class="webgridbody">
								<span><c:out value="${status.index}"/></span>
							</td>
							
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].userId.label">&nbsp;<c:out value="${userpass.userId}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].nmKor.label">&nbsp;<c:out value="${userpass.nmKor}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].nmNic.label">&nbsp;<c:out value="${userpass.nmNic}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].regNo.label">&nbsp;<c:out value="${userpass.regNo}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].birthYmd.label">&nbsp;<c:out value="${userpass.birthYmd}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].emailAddr.label">&nbsp;<c:out value="${userpass.emailAddr}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].offcTel.label">&nbsp;<c:out value="${userpass.offcTel}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].mileTot.label">&nbsp;<c:out value="${userpass.mileTot}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].homeTel.label">&nbsp;<c:out value="${userpass.homeTel}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].mobileTel.label">&nbsp;<c:out value="${userpass.mobileTel}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].homeZip.label">&nbsp;<c:out value="${userpass.homeZip}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].homeAddr1.label">&nbsp;<c:out value="${userpass.homeAddr1}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].homeAddr2.label">&nbsp;<c:out value="${userpass.homeAddr2}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].langKnd.label">&nbsp;<c:out value="${userpass.langKnd}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].userInfo05.label">&nbsp;<c:out value="${userpass.userInfo05}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].userInfo06.label">&nbsp;<c:out value="${userpass.userInfo06}"/></span>
							</td>
							<td align="left" class="webgridbody" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].regDatim.label">&nbsp;<c:out value="${userpass.regDatim}"/></span>
							</td>
							<td align="left" class="webgridbodylast" onclick="aUserpassManager.doSelect(this)">
								<span class="webgridrowlabel" id="UserpassManager[<c:out value="${status.index}"/>].updDatim.label">&nbsp;<c:out value="${userpass.updDatim}"/></span>
							</td>
						</tr>
					</c:forEach>
				
					</tbody>
				  </table>
				  </form>
				  <div id="UserpassManager_ListMessage">
					<c:out value='${resultMessage}'/>
				  </div>
				</div>
				<div>
					<table style="width:100%;" class="webbuttonpanel">
					<tr>
					    <td align="center">
					    <div id="UserpassManager_PAGE_ITERATOR" class="webnavigationpanel">
							<c:out escapeXml='false' value='${pageIterator}'/>
					    </div>
					    </td>    
					</tr>
					<tr>
					    <td align="right">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserpassManager.doCreate()">
							<img src="<%=request.getContextPath()%>/admin/images/button/btn_delete.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserpassManager.doRemove()">
					    </td>
					</tr>
					</table>
				
					<div id="UserpassManager_EditFormPanel" class="webformpanel" >  
					<div id="UserpassManager_propertyTabs">
						<ul>
							<li><a href="#UserpassManager_DetailTabPage"><util:message key='ev.title.user.detailTab'/></a></li>   
							
						</ul>
						<div id="UserpassManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="UserpassManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="UserpassManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.userId'/> *</td>
										<td width="30%" class="webformfield">
											<input type="text" id="UserpassManager_userId" name="userId" value="" maxLength="30" class="full_webtextfield" />
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.nmKor'/> *</td>
										<td class="webformfield">
											<input type="text" id="UserpassManager_nmKor" name="nmKor" value="" maxLength="30" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.nmNic'/></td>
										<td class="webformfield">
											<input type="text" id="UserpassManager_nmNic" name="nmNic" value="" maxLength="30" class="full_webtextfield" />
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.regNo'/> *</td>
										<td class="webformfield">
											<input type="text" id="UserpassManager_regNo" name="regNo" value="" maxLength="13" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='pev.prop.userpass.birthYmd'/> *</td>
										<td class="webformfield">
											<input type="hidden" id="UserpassManager_birthYmd" name="birthYmd" value="" class="full_webtextfield" />
											<select id='UserpassManager_birthYear' class='webdropdownlist'>
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
											</select> <util:message key='ev.title.user.year'/>
											<select id='UserpassManager_birthMonth' class='webdropdownlist'>
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
											</select> <util:message key='ev.title.user.month'/>
											<select id='UserpassManager_birthDay' class='webdropdownlist'>
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
											</select> <util:message key='ev.title.user.day'/>
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.emailAddr'/> *</td>
										<td class="webformfield">
											<select id="UserpassManager_emailAddr" name="emailAddr" class='webdropdownlist'>
												<c:forEach items="${emailAddrList}" var="emailAddr">
												<option value="<c:out value="${emailAddr.code}"/>"><c:out value="${emailAddr.codeName}"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.offcTel'/> *</td>
										<td class="webformfield">
											<select id="UserpassManager_offcTel" name="offcTel" class='webdropdownlist'>
												<c:forEach items="${offcTelList}" var="offcTel">
												<option value="<c:out value="${offcTel.code}"/>"><c:out value="${offcTel.codeName}"/></option>
												</c:forEach>
											</select>
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.mileTot'/></td>
										<td class="webformfield">
											<input type="text" id="UserpassManager_mileTot" name="mileTot" value="" maxLength="" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.homeTel'/> *</td>
										<td class="webformfield">
											<select id="UserpassManager_homeTel" name="homeTel" class='webdropdownlist'>
												<c:forEach items="${homeTelList}" var="homeTel">
												<option value="<c:out value="${homeTel.code}"/>"><c:out value="${homeTel.codeName}"/></option>
												</c:forEach>
											</select>
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.mobileTel'/> *</td>
										<td class="webformfield">
											<select id="UserpassManager_mobileTel" name="mobileTel" class='webdropdownlist'>
												<c:forEach items="${mobileTelList}" var="mobileTel">
												<option value="<c:out value="${mobileTel.code}"/>"><c:out value="${mobileTel.codeName}"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.homeZip'/> *</td>
										<td class="webformfield">
											<input type="text" id="UserpassManager_homeZip" name="homeZip" value="" maxLength="" class="full_webtextfield" />
										</td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.lang.langKnd'/></td>
										<td class="webformfield">
											<select id="UserpassManager_langKnd" name="langKnd" class='webdropdownlist'>
												<c:forEach items="${langKndList}" var="langKnd">
												<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.homeAddr1'/> *</td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserpassManager_homeAddr1" name="homeAddr1" value="" size="40" maxLength="40" class="webtextfield" />-
											<input type="text" id="UserpassManager_homeAddr2" name="homeAddr2" value="" size="40" maxLength="40" class="webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.userInfo05'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserpassManager_userInfo05" name="userInfo05" value="" maxLength="50" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.userInfo06'/></td>
										<td colspan="3" class="webformfield">
											<input type="text" id="UserpassManager_userInfo06" name="userInfo06" value="" maxLength="50" class="full_webtextfield" />
										</td>
									</tr>
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.regDatim'/></td>
										<td class="webformfield"><input type="text" id="UserpassManager_regDatim" name="regDatim" value="" class="full_webtextfield" /></td>
										<td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.userpass.updDatim'/></td>
										<td class="webformfield"><input type="text" id="UserpassManager_updDatim" name="updDatim" value="" class="full_webtextfield" /></td>
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserpassManager.doUpdate()">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End UserpassManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End UserpassManager_UserpassTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="UserpassManager_UserpassChooser"></div>

