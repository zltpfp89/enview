<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userStatisticsManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="UserStatisticsChooser_ListTabPage" style="width:100%; height:300px;"> 
							<div class="webformpanel">
								<form id="UserStatisticsChooser_SearchForm" name="UserStatisticsChooser_SearchForm" style="display:inline" action="javascript:aUserStatisticsChooser.doSearch('UserStatisticsChooser_SearchForm')" method="post">
									<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aUserStatisticsChooser.doPage'/>
										<input type='hidden' name='formName' value='UserStatisticsChooser_SearchForm'/>
										 
										<input type='hidden' id='UserStatisticsChooser_Master_principalId' name='principalId' value=''/>
									<div>
									  <table width="100%">
									  <tr>
										<td align="right">
										
											<input type="text" name="groupIdCond" size="" class="webtextfield" value="*<util:message key='ev.title.statistics.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.groupId'/>*');"/> 
														
											<input type="text" name="userIdCond" size="" class="webtextfield" value="*<util:message key='ev.prop.userStatistics.userId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.userStatistics.userId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.userStatistics.userId'/>*');"/> 
														
											<input type="text" name="userNameCond" size="" class="webtextfield" value="*<util:message key='ev.prop.userStatistics.userName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.userStatistics.userName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.userStatistics.userName'/>*');"/> 
														
											<input type="text" name="userIpCond" size="" class="webtextfield" value="*<util:message key='ev.title.statistics.userIp'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.statistics.userIp'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.statistics.userIp'/>*');"/> 
														
											<select name="statusCond" class='webdropdownlist'>
														<c:forEach items="${statusList}" var="status">
														<option value="<c:out value="${status.code}"/>"><c:out value="${status.codeName}"/></option>
														</c:forEach>
											</select>
														
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
								<form id="UserStatisticsChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aUserStatisticsChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aUserStatisticsChooser.doSort(this, 'ACCESS_BROWSER');" >
														<span ><util:message key='ev.prop.userStatistics.accessBrowser'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserStatisticsChooser.doSort(this, 'USER_IP');" >
														<span ><util:message key='ev.title.statistics.userIp'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserStatisticsChooser.doSort(this, 'ORG_NAME');" >
														<span ><util:message key='ev.prop.userStatistics.orgName'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserStatisticsChooser.doSort(this, 'USER_ID');" >
														<span ><util:message key='ev.prop.userStatistics.userId'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserStatisticsChooser.doSort(this, 'USER_NAME');" >
														<span ><util:message key='ev.prop.userStatistics.userName'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserStatisticsChooser.doSort(this, 'STATUS');" >
														<span ><util:message key='ev.prop.userStatistics.status'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aUserStatisticsChooser.doSort(this, 'TIME_STAMP');" >
														<span ><util:message key='ev.prop.userStatistics.timeStamp'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="UserStatisticsChooser_ListBody"></tbody>
										</table>
										<div id="UserStatisticsChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="UserStatisticsChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
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