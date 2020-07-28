
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletApplicationManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PortletApplicationManager_PortletApplicationTabPage">
				<br style='line-height:5px;'>

					<div id="PortletApplicationManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="PortletApplicationManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="PortletApplicationManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="PortletApplicationManager_isCreate">
									
									<input type="hidden" id="PortletApplicationManager_appIdentifier" name="appIdentifier">	
									<input type="hidden" id="PortletApplicationManager_checksum" name="checksum">	
									<input type="hidden" id="PortletApplicationManager_description" name="description">	
									<input type="hidden" id="PortletApplicationManager_webAppId" name="webAppId">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletApplicationManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletApplicationManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
						<div id="PortletApplicationManager_ApplicationMetadataTabPage">
						</div>
							
						<div id="PortletApplicationManager_WebApplicationTabPage">
						</div>
							
						<div id="PortletApplicationManager_EnviewServiceTabPage">
						</div>
							
						<div id="PortletApplicationManager_CustomPortletModeTabPage">
						</div>
							
						<div id="PortletApplicationManager_CustomWindowStateTabPage">
						</div>
							
					</div>
					</div> <!-- End PortletApplicationManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PortletApplicationManager_PortletApplicationTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PortletApplicationManager_PortletApplicationChooser"></div>

