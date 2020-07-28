
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchResultManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="BatchResultChooser_ListTabPage" height:300px;"> 
							<div class="webformpanel">
								<form id="BatchResultChooser_SearchForm" name="BatchResultChooser_SearchForm" style="display:inline" action="javascript:aBatchResultChooser.doSearch('BatchResultChooser_SearchForm')" method="post">
									<div>
									  <table width="100%">
										<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aBatchResultChooser.doPage'/>
										<input type='hidden' name='formName' value='BatchResultChooser_SearchForm'/>
										
									  <tr>
										<td align="right">
										
											<select name="statusCond" class='webdropdownlist'>
														<c:forEach items="${statusList}" var="status">
														<option value="<c:out value="${status.code}"/>"><c:out value="${status.codeName}"/></option>
														</c:forEach>
											</select>
														
											<input type="text" name="name0Cond" size="30" class="webtextfield" value="*<util:message key='ev.prop.batchAction.name'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchAction.name'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchAction.name'/>*');"/> 
														
											<input type="text" name="executStartCond" class="webtextfield" value="*<util:message key='ev.prop.batchResult.executStart'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchResult.executStart'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchResult.executStart'/>*');"/>
											<input type="text" name="executEndCond" class="webtextfield" value="*<util:message key='ev.prop.batchResult.executEnd'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchResult.executEnd'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchResult.executEnd'/>*');"/>
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
								<form id="BatchResultChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aBatchResultChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aBatchResultChooser.doSort(this, 'RESULT_ID');" >
														<span ><util:message key='ev.prop.batchResult.resultId'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aBatchResultChooser.doSort(this, 'ACTION_NAME');" >
														<span ><util:message key='ev.prop.batchAction.name'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aBatchResultChooser.doSort(this, 'STATUS');" >
														<span ><util:message key='ev.prop.batchResult.status'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aBatchResultChooser.doSort(this, 'EXECUT_START');" >
														<span ><util:message key='ev.prop.batchResult.executStart'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aBatchResultChooser.doSort(this, 'EXECUT_END');" >
														<span ><util:message key='ev.prop.batchResult.executEnd'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aBatchResultChooser.doSort(this, 'UPD_USER_ID');" >
														<span ><util:message key='ev.prop.batchResult.updUserId'/></span>
													</th>	
													<th class="webgridheaderlast" ch="0" onclick="aBatchResultChooser.doSort(this, 'UPD_DATIM');" >
														<span ><util:message key='ev.prop.batchResult.updDatim'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="BatchResultChooser_ListBody"></tbody>
										</table>
										<div id="BatchResultChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="BatchResultChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
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

