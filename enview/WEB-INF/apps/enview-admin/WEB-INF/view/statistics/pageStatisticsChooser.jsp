
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageStatisticsManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="PageStatisticsChooser_ListTabPage" style="width:100%; height:300px;"> 
							<div class="webformpanel">
								<form id="PageStatisticsChooser_SearchForm" name="PageStatisticsChooser_SearchForm" style="display:inline" action="javascript:aPageStatisticsChooser.doSearch('PageStatisticsChooser_SearchForm')" method="post">
									<div>
									  <table width="100%">
										<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aPageStatisticsChooser.doPage'/>
										<input type='hidden' name='formName' value='PageStatisticsChooser_SearchForm'/>
										
									  <tr>
										<td align="right">
											<input type="text" name="groupIdCond" size="" class="webtextfield" value="*<util:message key='ev.title.statistics.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.groupId'/>*');"/> 
														
											<input type="text" name="userIdCond" size="" class="webtextfield" value="*<util:message key='ev.prop.pageStatistics.userId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.pageStatistics.userId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.pageStatistics.userId'/>*');"/> 
														
											<input type="text" name="userNameCond" size="" class="webtextfield" value="*<util:message key='ev.prop.pageStatistics.userName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.pageStatistics.userName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.pageStatistics.userName'/>*');"/> 
														
											<input type="text" name="titleCond" size="" class="webtextfield" value="*<util:message key='ev.prop.pageStatistics.title'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.pageStatistics.title'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.pageStatistics.title'/>*');"/> 
														
											<input type="text" name="pathCond" size="" class="webtextfield" value="*<util:message key='ev.prop.pageStatistics.path'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.pageStatistics.path'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.pageStatistics.path'/>*');"/> 
														
											<input type="text" name="startTimeStampCond" class="webtextfield" value="*<util:message key='ev.title.statistics.startTimeStamp'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.startTimeStamp'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.startTimeStamp'/>*');"/>
											<input type="text" name="endTimeStampCond" class="webtextfield" value="*<util:message key='ev.title.statistics.endTimeStamp'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.endTimeStamp'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.endTimeStamp'/>*');"/>
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
								<form id="PageStatisticsChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aPageStatisticsChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aPageStatisticsChooser.doSort(this, 'TITLE');" >
														<span ><util:message key='ev.prop.pageStatistics.title'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aPageStatisticsChooser.doSort(this, 'PATH');" >
														<span ><util:message key='ev.prop.pageStatistics.path'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aPageStatisticsChooser.doSort(this, 'HITS');" >
														<span ><util:message key='ev.title.statistics.hits'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aPageStatisticsChooser.doSort(this, 'MAX_TIME');" >
														<span ><util:message key='ev.title.statistics.maxTime'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aPageStatisticsChooser.doSort(this, 'MIN_TIME');" >
														<span ><util:message key='ev.title.statistics.minTime'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aPageStatisticsChooser.doSort(this, 'AVERAGE_TIME');" >
														<span ><util:message key='ev.title.statistics.averageTime'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="PageStatisticsChooser_ListBody"></tbody>
										</table>
										<div id="PageStatisticsChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="PageStatisticsChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
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

