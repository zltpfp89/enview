
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/securityPolicyManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="SecurityPolicyChooser_ListTabPage" style="width:100%; height:300px;"> 
							<div class="webformpanel">
								<form id="SecurityPolicyChooser_SearchForm" name="SecurityPolicyChooser_SearchForm" style="display:inline" action="javascript:aSecurityPolicyChooser.doSearch('SecurityPolicyChooser_SearchForm')" method="post">
									<div>
									  <table width="100%">
										<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aSecurityPolicyChooser.doPage'/>
										<input type='hidden' name='formName' value='SecurityPolicyChooser_SearchForm'/>
										
									  <tr>
										<td align="right">
										
											<input type="text" name="ipaddressCond" size="15" class="webtextfield" value="*<util:message key='ev.prop.policy.ipaddress'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.policy.ipaddress'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.policy.ipaddress'/>*');"/> 
														
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
								<form id="SecurityPolicyChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aSecurityPolicyChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aSecurityPolicyChooser.doSort(this, 'POLICY_ID');" >
														<span ><util:message key='ev.prop.policy.policyId'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aSecurityPolicyChooser.doSort(this, 'IPADDRESS');" >
														<span ><util:message key='ev.prop.policy.ipaddress'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aSecurityPolicyChooser.doSort(this, 'IS_ALLOW');" >
														<span ><util:message key='ev.prop.policy.isAllow'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="SecurityPolicyChooser_ListBody"></tbody>
										</table>
										<div id="SecurityPolicyChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="SecurityPolicyChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
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

