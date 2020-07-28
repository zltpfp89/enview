
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainPortletManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="DomainPortletChooser_ListTabPage" style="width:100%; height:300px;"> 
							<div class="webformpanel">
								<form id="DomainPortletChooser_SearchForm" name="DomainPortletChooser_SearchForm" style="display:inline" action="javascript:aDomainPortletChooser.doSearch('DomainPortletChooser_SearchForm')" onkeydown="if(event.keyCode==13) aDomainPortletChooser.doSearch('DomainPortletChooser_SearchForm')" method="post">
									<div>
									  <table width="100%">
										<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aDomainPortletChooser.doPage'/>
										<input type='hidden' name='formName' value='DomainPortletChooser_SearchForm'/>
										 
										<input type='hidden' id='DomainPortletChooser_Master_domainId' name='domainId' value=''/>
									  <tr>
										<td align="right">
										
											<select name='pageSize'>
												<option value="5">5</option>
												<option value="10">10</option>
												<option value="20">20</option>
												<option value="50">50</option>
												<option value="100">100</option>
											</select>
											<span class="btn_pack small"><a href="javascript:aDomainPortletChooser.doSearch('DomainPortletChooser_SearchForm')"><util:message key='ev.title.search'/></a></span>
										</td>
									  </tr>
									  </table>    
									</div>
								</form>
								<form id="DomainPortletChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aDomainPortletChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aDomainPortletChooser.doSort(this, 'DOMAIN_ID');" >
														<span ><util:message key='mm.prop.domainPortlet.domainId'/></span>
													</th>	
													<th class="webgridheaderlast" ch="0" onclick="aDomainPortletChooser.doSort(this, 'PORTLET_NM');" >
														<span ><util:message key='mm.prop.domainPortlet.portletNm'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="DomainPortletChooser_ListBody"></tbody>
										</table>
										<div id="DomainPortletChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="DomainPortletChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
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

