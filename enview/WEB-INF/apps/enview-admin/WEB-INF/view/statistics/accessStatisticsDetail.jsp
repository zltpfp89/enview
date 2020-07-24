
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/accessStatisticsManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="AccessStatisticsManager_AccessStatisticsTabPage">
				<br style='line-height:5px;'>

					<div id="AccessStatisticsManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="AccessStatisticsManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="AccessStatisticsManager_EditForm" style="display:inline" action="" method="post">
									<input type="hidden" id="AccessStatisticsManager_isCreate">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.currentUser'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="AccessStatisticsManager_currentUser" name="currentUser" value="<c:out value="${aAccessStatisticsVO.currentUser}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.todayUser'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="AccessStatisticsManager_todayUser" name="todayUser" value="<c:out value="${aAccessStatisticsVO.todayUser}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.averageUser'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="AccessStatisticsManager_averageUser" name="averageUser" value="<c:out value="${aAccessStatisticsVO.averageUser}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.accumulateUser'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="AccessStatisticsManager_accumulateUser" name="accumulateUser" value="<c:out value="${aAccessStatisticsVO.accumulateUser}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.registUser'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="AccessStatisticsManager_registUser" name="registUser" value="<c:out value="${aAccessStatisticsVO.registUser}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.secessionUser'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="AccessStatisticsManager_secessionUser" name="secessionUser" value="<c:out value="${aAccessStatisticsVO.secessionUser}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aAccessStatisticsManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aAccessStatisticsManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End AccessStatisticsManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End AccessStatisticsManager_AccessStatisticsTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="AccessStatisticsManager_AccessStatisticsChooser"></div>

