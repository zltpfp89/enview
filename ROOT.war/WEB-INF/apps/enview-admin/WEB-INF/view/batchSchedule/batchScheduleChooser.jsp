
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchScheduleManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="BatchScheduleChooser_ListTabPage" height:300px;"> 
							<div class="webformpanel">
								<form id="BatchScheduleChooser_SearchForm" name="BatchScheduleChooser_SearchForm" style="display:inline" action="javascript:aBatchScheduleChooser.doSearch('BatchScheduleChooser_SearchForm')" method="post">
									<div>
									  <table width="100%">
										<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aBatchScheduleChooser.doPage'/>
										<input type='hidden' name='formName' value='BatchScheduleChooser_SearchForm'/>
										
									  <tr>
										<td align="right">
										
											<input type="text" name="name0Cond" size="30" class="webtextfield" value="*<util:message key='ev.prop.batchAction.name'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.batchAction.name'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.batchAction.name'/>*');"/> 
														
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
								<form id="BatchScheduleChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aBatchScheduleChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aBatchScheduleChooser.doSort(this, 'SCHEDULE_ID');" >
														<span ><util:message key='ev.prop.batchSchedule.scheduleId'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aBatchScheduleChooser.doSort(this, 'ACTION_NAME');" >
														<span ><util:message key='ev.prop.batchAction.name'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aBatchScheduleChooser.doSort(this, 'UPD_USER_ID');" >
														<span ><util:message key='ev.prop.batchSchedule.updUserId'/></span>
													</th>	
													<th class="webgridheaderlast" ch="0" onclick="aBatchScheduleChooser.doSort(this, 'UPD_DATIM');" >
														<span ><util:message key='ev.prop.batchSchedule.updDatim'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="BatchScheduleChooser_ListBody"></tbody>
										</table>
										<div id="BatchScheduleChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="BatchScheduleChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
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

