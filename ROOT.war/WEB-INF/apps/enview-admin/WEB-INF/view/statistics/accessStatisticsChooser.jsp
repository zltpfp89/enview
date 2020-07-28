
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/accessStatisticsManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="AccessStatisticsChooser_ListTabPage" style="width:100%; height:300px;"> 
							<div class="webformpanel">
								<form id="AccessStatisticsChooser_SearchForm" name="AccessStatisticsChooser_SearchForm" style="display:inline" action="javascript:aAccessStatisticsChooser.doSearch('AccessStatisticsChooser_SearchForm')" method="post">
									<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aAccessStatisticsChooser.doPage'/>
										<input type='hidden' name='formName' value='AccessStatisticsChooser_SearchForm'/>
									<div>
									  <table width="100%">
									  <tr>
										<td align="right">
											<input type="text" name="groupIdCond" size="" class="webtextfield" value="*<util:message key='pt.ev.property.groupId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.groupId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.groupId'/>*');"/> 
														
											<input type="text" name="userIdCond" size="" class="webtextfield" value="*<util:message key='pt.ev.property.userId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.userId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.userId'/>*');"/> 
														
											<input type="text" name="userNameCond" size="" class="webtextfield" value="*<util:message key='pt.ev.property.userName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.userName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.userName'/>*');"/> 
														
											<input type="text" name="startTimeStampCond" class="webtextfield" value="*<util:message key='pt.ev.property.startTimeStamp'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.startTimeStamp'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.startTimeStamp'/>*');"/>
											<input type="text" name="endTimeStampCond" class="webtextfield" value="*<util:message key='pt.ev.property.endTimeStamp'/>*" onfocus="whenSrchFocus(this,'*<util:message key='pt.ev.property.endTimeStamp'/>*');" onblur="whenSrchBlur(this,'*<util:message key='pt.ev.property.endTimeStamp'/>*');"/>
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
								<form id="AccessStatisticsChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aAccessStatisticsChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
															
												</tr>
											</thead>
											<tbody id="AccessStatisticsChooser_ListBody"></tbody>
										</table>
										<div id="AccessStatisticsChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="AccessStatisticsChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
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

