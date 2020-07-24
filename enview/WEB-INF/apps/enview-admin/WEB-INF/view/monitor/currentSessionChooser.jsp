
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/currentSessionManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="CurrentSessionChooser_ListTabPage" style="width:100%; height:300px;"> 
							<div class="webformpanel">
								<form id="CurrentSessionChooser_SearchForm" name="CurrentSessionChooser_SearchForm" style="display:inline" action="javascript:aCurrentSessionChooser.doSearch('CurrentSessionChooser_SearchForm')" method="post">
									<div>
									  <table width="100%">
										<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aCurrentSessionChooser.doPage'/>
										<input type='hidden' name='formName' value='CurrentSessionChooser_SearchForm'/>
										
									  <tr>
										<td align="right">
										
											<select name="userIpCond" class='webdropdownlist'>
														<c:forEach items="${userIpList}" var="userIp">
														<option value="<c:out value="${userIp.code}"/>"><c:out value="${userIp.codeName}"/></option>
														</c:forEach>
											</select>
														
											<input type="text" name="userIdCond" size="" class="webtextfield" value="*<util:message key='ev.title.monitor.userId'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.monitor.userId'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.monitor.userId'/>*');"/> 
														
											<input type="text" name="userNameCond" size="" class="webtextfield" value="*<util:message key='ev.title.monitor.userName'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.title.monitor.userName'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.title.monitor.userName'/>*');"/> 
														
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
								<form id="CurrentSessionChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aCurrentSessionChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aCurrentSessionChooser.doSort(this, 'USER_ID');" >
														<span ><util:message key='ev.title.monitor.userId'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aCurrentSessionChooser.doSort(this, 'USER_NAME');" >
														<span ><util:message key='ev.title.monitor.userName'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aCurrentSessionChooser.doSort(this, 'USER_IP');" >
														<span ><util:message key='ev.title.monitor.userIp'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aCurrentSessionChooser.doSort(this, 'USER_AGENT');" >
														<span ><util:message key='ev.title.monitor.userAgent'/></span>
													</th>	
													<th class="webgridheaderlast" ch="0" onclick="aCurrentSessionChooser.doSort(this, 'ELAPSED_TIME');" >
														<span ><util:message key='ev.title.monitor.elapsedTime'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="CurrentSessionChooser_ListBody"></tbody>
										</table>
										<div id="CurrentSessionChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="CurrentSessionChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
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

