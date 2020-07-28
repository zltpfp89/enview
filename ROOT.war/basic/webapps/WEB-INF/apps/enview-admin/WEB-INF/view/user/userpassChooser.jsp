
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userpassManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="UserpassChooser_ListTabPage" style="width:100%; height:300px;"> 
							<div class="webformpanel">
								<form id="UserpassChooser_SearchForm" name="UserpassChooser_SearchForm" style="display:inline" action="javascript:aUserpassChooser.doSearch('UserpassChooser_SearchForm')" method="post">
									<div>
									  <table width="100%">
										<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aUserpassChooser.doPage'/>
										<input type='hidden' name='formName' value='UserpassChooser_SearchForm'/>
										 
										<input type='hidden' id='UserpassChooser_Master_principalId' name='principalId' value=''/>
									  <tr>
										<td align="right">
										
											<select name='pageSize'>
												<option value="5">5</option>
												<option value="10">10</option>
												<option value="20">20</option>
												<option value="50">50</option>
												<option value="100">100</option>
											</select>
											<input type="image" src="<%=request.getContextPath()%>/admin/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand">
										</td>
									  </tr>
									  </table>    
									</div>
								</form>
								<form id="UserpassChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aUserpassChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'USER_ID');" >
														<span ><util:message key='ev.prop.userpass.userId'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'NM_KOR');" >
														<span ><util:message key='ev.prop.userpass.nmKor'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'NM_NIC');" >
														<span ><util:message key='ev.prop.userpass.nmNic'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'REG_NO');" >
														<span ><util:message key='ev.prop.userpass.regNo'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'BIRTH_YMD');" >
														<span ><util:message key='ev.prop.userpass.birthYmd'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'EMAIL_ADDR');" >
														<span ><util:message key='ev.prop.userpass.emailAddr'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'OFFC_TEL');" >
														<span ><util:message key='ev.prop.userpass.offcTel'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'MILE_TOT');" >
														<span ><util:message key='ev.prop.userpass.mileTot'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'HOME_TEL');" >
														<span ><util:message key='ev.prop.userpass.homeTel'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'MOBILE_TEL');" >
														<span ><util:message key='ev.prop.userpass.mobileTel'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'HOME_ZIP');" >
														<span ><util:message key='ev.prop.userpass.homeZip'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'HOME_ADDR1');" >
														<span ><util:message key='ev.prop.userpass.homeAddr1'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'HOME_ADDR2');" >
														<span ><util:message key='ev.prop.userpass.homeAddr2'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'LANG_KND');" >
														<span ><util:message key='ev.prop.lang.langKnd'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'USER_INFO05');" >
														<span ><util:message key='ev.prop.userpass.userInfo05'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'USER_INFO06');" >
														<span ><util:message key='ev.prop.userpass.userInfo06'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserpassChooser.doSort(this, 'REG_DATIM');" >
														<span ><util:message key='ev.prop.userpass.regDatim'/></span>
													</th>	
													<th class="webgridheaderlast" ch="0" onclick="aUserpassChooser.doSort(this, 'UPD_DATIM');" >
														<span ><util:message key='ev.prop.userpass.updDatim'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="UserpassChooser_ListBody"></tbody>
										</table>
										<div id="UserpassChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="UserpassChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
											</td>   
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>

