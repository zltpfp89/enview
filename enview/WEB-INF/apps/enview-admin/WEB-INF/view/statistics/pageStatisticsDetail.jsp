
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageStatisticsManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">                                                            <!-- 페이지 사용통계 윗머리를 제외한 ----------------->
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PageStatisticsManager_PageStatisticsTabPage">
				<br style='line-height:5px;'>

					<div id="PageStatisticsManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="PageStatisticsManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
							
							
								<form id="PageStatisticsManager_EditForm" style="display:inline" action="" method="post">                  <!-- 페이지 사용통계 밑에꺼 -->
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="PageStatisticsManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.pageStatistics.title'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_title" name="title" value="<c:out value="${aPageStatisticsVO.title}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.pageStatistics.path'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_path" name="path" value="<c:out value="${aPageStatisticsVO.path}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.hits'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_hits" name="hits" value="<c:out value="${aPageStatisticsVO.hits}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statisticss.maxTime'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_maxTime" name="maxTime" value="<c:out value="${aPageStatisticsVO.maxTime}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.minTime'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_minTime" name="minTime" value="<c:out value="${aPageStatisticsVO.minTime}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.averageTime'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_averageTime" name="averageTime" value="<c:out value="${aPageStatisticsVO.averageTime}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									
									
									
									<!---- 그위에 꺼-------------------------------------------------------------------------------->
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.totalSession'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_totalSession" name="totalSession" value="<c:out value="${aPageStatisticsVO.totalSession}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.totalHits'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_totalHits" name="totalHits" value="<c:out value="${aPageStatisticsVO.totalHits}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.totalMaxTime'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_totalMaxTime" name="totalMaxTime" value="<c:out value="${aPageStatisticsVO.totalMaxTime}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.totalMinTime'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="PageStatisticsManager_totalMinTime" name="totalMinTime" value="<c:out value="${aPageStatisticsVO.totalMinTime}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.statistics.totalAverageTime'/></td>
									
										<td class="webformfield" colspan="3">
											
											<input type="text" id="PageStatisticsManager_totalAverageTime" name="totalAverageTime" value="<c:out value="${aPageStatisticsVO.totalAverageTime}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
									</tr>
									
								</table>
								
								<table style="width:100%;" class="webbuttonpanel">                           <!--  버튼 정의     신규     저장 -->
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aPageStatisticsManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPageStatisticsManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End PageStatisticsManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PageStatisticsManager_PageStatisticsTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PageStatisticsManager_PageStatisticsChooser"></div>

