
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/sessionDataManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="SessionDataManager_SessionDataTabPage">
				<br style='line-height:5px;'>

					<div id="SessionDataManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="SessionDataManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="SessionDataManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="SessionDataManager_isCreate">
									
									<input type="hidden" id="SessionDataManager_sid" name="sid">	
									<input type="hidden" id="SessionDataManager_userId" name="userId">	
									<input type="hidden" id="SessionDataManager_userDate" name="userDate">	
									<input type="hidden" id="SessionDataManager_creationDate" name="creationDate">	
									<input type="hidden" id="SessionDataManager_modifiedDate" name="modifiedDate">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aSessionDataManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aSessionDataManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End SessionDataManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End SessionDataManager_SessionDataTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="SessionDataManager_SessionDataChooser"></div>

