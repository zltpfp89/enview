
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userpassManager.js"></script>

<form id="UserpassManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="UserpassManager_isCreate">
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<caption>게시판</caption>
		<colgroup>
			<col width="140px" />
			<col width="*" />
			<col width="140px" />
			<col width="*" />
		</colgroup>
		<tr>
			<th class="L"><util:message key='ev.prop.userpass.userId'/> <em>*</em></th>
			<td class="L">
				<input type="text" id="UserpassManager_userId" name="userId" value="<c:out value="${aUserpassVO.userId}"/>" maxLength="30" label="<util:message key='ev.prop.userpass.userId'/>" class="txt_200" />
			</td>
			<th class="L"><util:message key='ev.prop.userpass.nmKor'/> <em>*</em></th>
			<td class="L">
				<input type="text" id="UserpassManager_nmKor" name="nmKor" value="<c:out value="${aUserpassVO.nmKor}"/>" maxLength="30" label="<util:message key='ev.prop.userpass.nmKor'/>" class="txt_200" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.userpass.nmNic'/></th>
			<td class="L">
				<input type="text" id="UserpassManager_nmNic" name="nmNic" value="<c:out value="${aUserpassVO.nmNic}"/>" maxLength="30" label="<util:message key='ev.prop.userpass.nmNic'/>" class="txt_200" />
			</td>
			<th class="L"><util:message key='ev.prop.userpass.regNo'/> <em>*</em></th>
			<td class="L">
				<input type="hidden" id="UserpassManager_regNo" name="regNo" value="" maxLength="13" label="<util:message key='ev.prop.userpass.regNo'/>" />
				<input type="text" id="UserpassManager_regNo1" name="regNo1" value="" maxLength="6" label="<util:message key='ev.prop.userpass.regNo1'/>" class="txt_100" />
				<span class="sel_txt">-</span>
				<input type="text" id="UserpassManager_regNo2" name="regNo2" value="" maxLength="7" label="<util:message key='ev.prop.userpass.regNo2'/>" class="txt_100" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.userpass.birthYmd'/> <em>*</em></th>
			<td class="L">
				<input type="hidden" id="UserpassManager_birthYmd" name="birthYmd" value="" label="<util:message key='ev.prop.userpass.birthYmd'/>" />
				<div class="sel_70">
					<select id='UserpassManager_birthYear' class='txt_70'>
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
				</div>
				<span class="sel_txt"><util:message key='ev.title.user.year'/></span>
				<div class="sel_70">
					<select id='UserpassManager_birthMonth' class='txt_70'>
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
				</div>		
				<span class="sel_txt"><util:message key='ev.title.user.month'/></span>
				<div class="sel_70">
					<select id='UserpassManager_birthDay' class='txt_70'>
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
				</div>
				<span class="sel_txt"><util:message key='ev.title.user.day'/></span>
			</td>
			<th class="L"><util:message key='ev.prop.userpass.emailAddr'/> <em>*</em></th>
			<td class="L">
				<input type="hidden" id="UserpassManager_emailAddr" name="emailAddr" label="<util:message key='ev.prop.userpass.emailAddr'/>"/>
				<input type="text" id="UserpassManager_emailAddr1" name="emailAddr1" value="" size="15" maxLength="20" class="txt_70" />
				<span class="sel_txt">@</span>
				<input type="text" id="UserpassManager_emailAddr2" name="emailAddr2" value="" size="15" maxLength="20" class="txt_70" />
				<span class="sel_txt"></span>
				<div class="sel_100">
					<select id="UserpassManager_emailAddr3" class='txt_100' onchange="javascript:aUserpassManager.doEmailChange()">
						<c:forEach items="${emailAddrList}" var="emailAddr">
							<option value="<c:out value="${emailAddr.code}"/>"><c:out value="${emailAddr.codeName}"/></option>
						</c:forEach>
					</select>
				</div>	
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.userpass.offcTel'/> <em>*</em></th>
			<td class="L">
				<input type="hidden" id="UserpassManager_offcTel" name="offcTel" label="<util:message key='ev.prop.userpass.offcTel'/>"/>
				<div class="sel_70">
					<select id="UserpassManager_offcTel1" class='txt_70'>
						<c:forEach items="${offcTelList}" var="offcTel">
							<option value="<c:out value="${offcTel.code}"/>"><c:out value="${offcTel.codeName}"/></option>
						</c:forEach>
					</select>
				</div>&nbsp;
				<span class="sel_txt"></span>
				<input type="text" id="UserpassManager_offcTel2" name="offcTel2" label="<util:message key='ev.prop.userpass.offcTel'/>" value="" size="15" maxLength="4" class="txt_70" />
				<span class="sel_txt">-</span>
				<input type="text" id="UserpassManager_offcTel3" name="offcTel3" label="<util:message key='ev.prop.userpass.offcTel'/>" value="" size="15" maxLength="4" class="txt_70" />
			</td>
			<th class="L"><util:message key='ev.prop.userpass.mobileTel'/> <em>*</em></th>
			<td class="L">
				<input type="hidden" id="UserpassManager_mobileTel" name="mobileTel" label="<util:message key='ev.prop.userpass.mobileTel'/>" />
				<div class="sel_70">
					<select id="UserpassManager_mobileTel1" class='txt_70'>
						<c:forEach items="${mobileTelList}" var="mobileTel">
							<option value="<c:out value="${mobileTel.code}"/>"><c:out value="${mobileTel.codeName}"/></option>
						</c:forEach>
					</select>
				</div>
				<span class="sel_txt"></span>
				<input type="text" id="UserpassManager_mobileTel2" name="mobileTel2" label="<util:message key='ev.prop.userpass.mobileTel'/>" value="" size="15" maxLength="4" class="txt_70" />
				<span class="sel_txt">-</span>
				<input type="text" id="UserpassManager_mobileTel3" name="mobileTel3" label="<util:message key='ev.prop.userpass.mobileTel'/>" value="" size="15" maxLength="4" class="txt_70" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.userpass.homeTel'/></th>
			<td class="L">
				<input type="hidden" id="UserpassManager_homeTel" name="homeTel" label="<util:message key='ev.prop.userpass.homeTel'/>"/>
				<div class="sel_70">
					<select id="UserpassManager_homeTel1" class='txt_70'>
						<c:forEach items="${homeTelList}" var="homeTel">
							<option value="<c:out value="${homeTel.code}"/>"><c:out value="${homeTel.codeName}"/></option>
						</c:forEach>
					</select>
				</div>	
				<span class="sel_txt"></span>
				<input type="text" id="UserpassManager_homeTel2" name="homeTel2" label="<util:message key='ev.prop.userpass.homeTel'/>" value="" size="15" maxLength="4" class="txt_70" />
				<span class="sel_txt">-</span>
				<input type="text" id="UserpassManager_homeTel3" name="homeTel3" label="<util:message key='ev.prop.userpass.homeTel'/>" value="" size="15" maxLength="4" class="txt_70" />
			</td>
			<th class="L"><util:message key='ev.prop.userpass.mileTot'/></th>
			<td class="L">
				<input type="text" id="UserpassManager_mileTot" name="mileTot" value="" maxLength="" label="<util:message key='ev.prop.userpass.mileTot'/>" class="txt_200" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.userpass.homeZip'/></th>
			<td class="L">
				<input type="hidden" id="UserpassManager_homeZip" name="homeZip" value="" maxLength="" label="<util:message key='ev.prop.userpass.homeZip'/>" />
				<input type="text" id="UserpassManager_homeZip1" name="homeZip1" label="<util:message key='ev.prop.userpass.homeZip'/>" value="" size="15" maxLength="3" class="txt_70" />
				<span class="sel_txt">-</span>
				<input type="text" id="UserpassManager_homeZip2" name="homeZip2" label="<util:message key='ev.prop.userpass.homeZip'/>" value="" size="15" maxLength="3" class="txt_70" />
			</td>
			<th class="L"><util:message key='ev.prop.lang.langKnd'/></th>
			<td class="L">
				<div class="sel_70">
					<select id="UserpassManager_langKnd" name="langKnd" label="<util:message key='ev.property.langKnd'/>" class='txt_70'>
						<c:forEach items="${langKndList}" var="langKnd">
							<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
						</c:forEach>
					</select>
				</div>	
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.userpass.homeAddr1'/></th>
			<td colspan="3" class="L">
				<input type="text" id="UserpassManager_homeAddr1" name="homeAddr1" value="" size="40" maxLength="25" label="<util:message key='ev.prop.userpass.homeAddr1'/>" class="txt_200" />
				<span class="sel_txt">-</span>
				<input type="text" id="UserpassManager_homeAddr2" name="homeAddr2" value="" size="40" maxLength="25" label="<util:message key='ev.prop.userpass.homeAddr1'/>" class="txt_200" />
			</td>
		</tr>
		<tr style="display:none;">
			<th class="L"><util:message key='ev.prop.userpass.userInfo05'/></th>
			<td colspan="3" class="L">
				<input type="text" id="UserpassManager_userInfo05" name="userInfo05" value="" maxLength="25" label="<util:message key='ev.prop.userpass.userInfo05'/>" class="txt_200" />
			</td>
		</tr>
		<tr style="display:none;">
			<th class="L"><util:message key='ev.prop.userpass.userInfo06'/></th>
			<td colspan="3" class="L">
				<input type="text" id="UserpassManager_userInfo06" name="userInfo06" value="" maxLength="25" label="<util:message key='ev.prop.userpass.userInfo06'/>" class="txt_200" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.userpass.regDatim'/></th>
			<td class="L"><input type="text" id="UserpassManager_regDatim" name="regDatim" value="" label="<util:message key='ev.prop.userpass.regDatim'/>" class="txt_200" /></td>
			<th class="L"><util:message key='ev.prop.userpass.updDatim'/></th>
			<td class="L"><input type="text" id="UserpassManager_updDatim" name="updDatim" value="" label="<util:message key='ev.prop.userpass.updDatim'/>" class="txt_200" /></td>
		</tr>
	</table>
	<!-- btnArea-->
	<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }">
		<div class="btnArea">
			<div class="rightArea">
				<a href="javascript:aUserpassManager.doUpdate()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
			</div>
		</div>
	</c:if>
	<!-- btnArea//-->	
</form>