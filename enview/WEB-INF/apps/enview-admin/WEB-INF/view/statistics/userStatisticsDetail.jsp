<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userStatisticsManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="UserStatisticsManager_UserStatisticsTabPage">
				<br style='line-height:5px;'>

					<div id="UserStatisticsManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="UserStatisticsManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="UserStatisticsManager_EditForm" style="display:inline" action="" method="post">
									<input type="hidden" id="UserStatisticsManager_isCreate">
									<input type="hidden" id="UserStatisticsManager_principalId" name="principalId">	
									<input type="hidden" id="UserStatisticsManager_orgCd" name="orgCd">	
									<input type="hidden" id="UserStatisticsManager_elapsedTime" name="elapsedTime">	
									<input type="hidden" id="UserStatisticsManager_extraInfo01" name="extraInfo01">	
									<input type="hidden" id="UserStatisticsManager_extraInfo02" name="extraInfo02">	
									<input type="hidden" id="UserStatisticsManager_extraInfo03" name="extraInfo03">	
									<input type="hidden" id="UserStatisticsManager_extraInfo04" name="extraInfo04">	
									<input type="hidden" id="UserStatisticsManager_extraInfo05" name="extraInfo05">	
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserStatisticsManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserStatisticsManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End UserStatisticsManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End UserStatisticsManager_UserStatisticsTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="UserStatisticsManager_UserStatisticsChooser"></div>

